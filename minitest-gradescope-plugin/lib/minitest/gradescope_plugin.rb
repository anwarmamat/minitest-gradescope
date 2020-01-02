# minitest/gradescope_plugin.rb:

module Minitest
  class Gradescope < AbstractReporter
    attr_accessor :results

    def initialize options
      self.results = []
      @scores = {}
      File.foreach("/autograder/source/src/score.txt") { |line|
        if not (line.start_with?("#")) then  
          words = line.chomp.split
          @scores[words[0]] = words[1]
        end
      }
    end

    def record result
      self.results << result
    end

    def report
      File.open("results.json", "w") { |f|
        f.write "{\n \"tests\": [\n"
        self.results.each { |x|
          f.write "{\n"
          if x.failure.nil? then
            f.write "\"score\":0,\n"
          else
            f.write "\"score\":#{@scores[x.name]},\n"
          end
          f.write "\"name\":\"#{x.name}\"\n"
          #f.write "Failure:#{x.failure.inspect}"
          f.write "},\n"
        }
        f.write "{}\n]\n}\n"
      }
    end
  end

  def self.plugin_gradescope_options(opts, options)
    opts.on "--gradescope", "Report results to gradescope in JSON format" do
      options[:json] = true
    end
  end

  def self.plugin_gradescope_init(options)
    self.reporter << Gradescope.new(options) if options[:json]
  end

end
