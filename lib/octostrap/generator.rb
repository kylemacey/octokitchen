require 'thor'
require 'pry'

module Octostrap
  class Generator < Thor::Group
    include Thor::Actions


    def self.banner; 'octostrap [OPTIONS] <NAME>'; end

    argument :name, default: ""
    class_option :gemfile, type: "boolean", default: false, desc: "Whether or not the script should use a Gemfile, defaults to `no-gemfile`"
    class_option :dependencies, desc: "comma-separated list of dependencies", aliases: '-d'


    desc  "Generate a new GitHub script"

    def start
      binding.pry
      unless name[/w+/]
        Generator.help(shell)
        exit
      end
    end

    def new_script
      template('templates/new_script.tt', "#{directory}/#{underscore(name)}.rb")
    end

    def new_readme
      template('templates/new_readme.tt', "#{directory}/README.rb")
    end

    private

    def directory
      underscore(name)
    end

    def self.source_root
      File.dirname(__FILE__)
    end

    def underscore(str)
      str.gsub(/\W/, '_').downcase
    end
  end
end
