# minitest/gradescope_plugin.rb:

module Minitest
  class Gradescope < AbstractReporter
    attr_accessor :results

    def initialize options
      self.results = []
      @scores = {}
      @path = ENV['GRADESCOPE_PATH']
      if @path.nil? then
        @path="/autograder/source/"
      end
      File.foreach(@path + "/src/score.txt") { |line|
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
      File.open(@path+"/src/results.json", "w") { |f|
        f.write "{\n"
        #f.write "\"output\":\"Public test results:\",\n"
        #f.write "\"visibility\":\"visible\",\n" 
        #f.write"\"stdout_visibility\":\"visible\",\n"
        #f.write "\"extra_data\":\"Extra data\",\n" 
        f.write "\"tests\":[\n"
        self.results.each { |x|
          f.write "{\n"
          if x.failure.nil? then
            f.write "\"score\":#{@scores[x.name]},\n"
            f.write "\"output\":\"score:#{@scores[x.name]}\",\n"
          else
            f.write "\"score\":0,\n"
            f.write "\"output\":\"score:0\",\n"
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
