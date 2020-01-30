# minitest/gradescope_plugin.rb:

require 'yaml'
require 'json'

module Minitest
    # Override the reporter so we can suppress stdout and convert results to JSON, which is
    # required by the Gradescope Autograder
    class Gradescope < AbstractReporter
        attr_accessor :results

        def initialize options
            self.results = []
            # Read the tests.yml to get the information about the tests
            @tests = YAML.load(File.read("/autograder/source/src/tests.yml"))

            puts @tests.inspect
        end

        def record result
            self.results << result
        end

        def report
            # Build the results data
            json = {}

            # Add global info if it was supplied in the YAML file
            json["execution_time"] = @tests["execution_time"] unless @tests["execution_time"].nil?
            json["stdout_visibility"] = "visible" if @tests["stdout_visibility"]
            json["tests"] = []

            # Add all of the tests results
            self.results.each do |result|
                test = {}

                # Check whether it was a public or secret test
                if @tests["public_tests"].include? result.name then
                    test["visibility"] = "visible"
                    test["max_score"] = @tests["public_tests"][result.name]
                    test["score"] = if result.passed? then @tests["public_tests"][result.name] else 0 end
                    test["name"] = result.name
                elsif @tests["secret_tests"].include? result.name then
                    test["visibility"] = @tests["secret_test_visibility"] || "hidden"
                    test["max_score"] = @tests["secret_tests"][result.name]
                    test["score"] = if result.passed? then @tests["secret_tests"][result.name] else 0 end
                    test["name"] = result.name
                else
                    raise "Unknown test: #{result.name}"
                end

                json["tests"] << test
            end

            File.write("results.json", JSON.generate(json))
        end
    end

    # Adds the --gradescope CLI flag
    def self.plugin_gradescope_options(opts, options)
        opts.on "--gradescope", "Report results to gradescope in JSON format" do
            options[:json] = true
        end
    end

    # Replace the normal reporter with an instance of this class if the --gradescope flag was
    # supplied at runtime
    def self.plugin_gradescope_init(options)
        self.reporter << Gradescope.new(options) if options[:json]
    end
end
