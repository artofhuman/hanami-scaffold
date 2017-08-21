require 'hanami/cli'

module Hanami
  module Scaffold
    extend Hanami::CLI::Registry

    class Generate < Hanami::CLI::Command
      ACTIONS = %w(index new create edit show update destroy).freeze

      desc "Generates an actions, views and templates along with specs and a routes."

      argument :app, required: true, desc: "The application name (eg. `web`)", default: 'web'
      argument :controller, required: true, desc: "The controller name (eg. `home`)"

      option :only, type: :array
      option :except, type: :array

      example [
        "hanami-scaffold generate web cars",
        "hanami-scaffold generate web cars --only index new create show",
        "hanami-scaffold generate web cars --except update"
      ]

      def call(app:, controller:, **options)
        actions = if options[:except] && (except = options[:except].split(',')).any?
                    ACTIONS.select { |action| !except.include?(action) }
                  elsif options[:only] && (only = options[:only].split(',')).any?
                    ACTIONS.select { |action| only.include?(action) }
                  else
                    ACTIONS
                  end

        actions.each do |action, method|
          `bundle exec hanami generate action #{app} #{controller}##{action}`
        end
      end
    end

    register 'generate', Generate
  end
end
