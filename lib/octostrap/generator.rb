require 'thor'
require 'pry'

module Octostrap
  class Generator < Thor::Group
    include Thor::Actions


    def self.banner; 'octostrap [OPTIONS] <NAME> [<DIRECTORY>]'; end

    argument :name, default: ""
    argument :path, default: ""
    class_option :gemfile, type: "boolean", default: false, desc: "Whether or not the script should use a Gemfile, defaults to `no-gemfile`", aliases: "-g"
    class_option :dependencies, desc: "comma-separated list of dependencies"
    class_option :command, desc: "What the name of the command/filename should be. Defaults to an underscored version of the script name."


    desc  "Generate a new GitHub script"

    def setup
      unless name[/\w+/]
        Generator.help(shell)
        exit
      end
      @directory = directory
      @filename = [(options[:command] || underscore(name)), 'rb'].join('.')
      @dependencies = options[:dependencies].to_s.split(',').unshift('octokit')
      @git_info = git_info
    end

    def new_script
      template('templates/new_script.tt', "#{@directory}/#{@filename}")
    end

    def new_readme
      template('templates/new_readme.tt', "#{@directory}/README.md")
    end

    def new_gemfile
      if options[:gemfile]
        template('templates/new_gemfile.tt', "#{@directory}/Gemfile")
      end
    end

    private

    def directory
      path[/\w+/] ? path : underscore(name)
    end

    def self.source_root
      File.dirname(__FILE__)
    end

    def underscore(str)
      str.gsub(/\W/, '_').downcase
    end

    def git_info
      if use_git?
        {
          git_path: git_path,
          git_origin_url: git_origin_url
        }
      end
    end

    def use_git?
      system('which git && git rev-parse')
    end

    def git_path
      `git rev-parse --show-prefix`.strip
    end

    def git_origin_url
      `git config --get remote.origin.url`.strip
    end
  end
end
