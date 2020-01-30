lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'gradescope'
  s.version     = '0.0.2'
  s.date        = '2020-01-20'
  s.summary     = "Gradescope"
  s.description = "A simple minitest plugin to generate JSON reports for gradescope autograder"
  s.authors     = ["Anwar Mamat"]
  s.email       = 'anwar@cs.umd.edu'
  s.files       = ["lib/minitest/gradescope_plugin.rb"]
  s.homepage    =
    'https://rubygems.org/gems/gradescope'
  s.license       = 'MIT'
  s.require_paths = ['lib']
  
  s.add_dependency 'minitest', '~> 5.0'
end
