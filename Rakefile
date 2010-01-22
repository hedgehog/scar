require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "scar"
    gem.summary = %Q{TODO: one-line summary of your gem}
    gem.description = %Q{TODO: longer description of your gem}
    gem.email = "hedgehogshiatus@gmail.com"
    gem.homepage = "http://github.com/hedgehog/scar"
    gem.authors = ["Hedgehog"]
    gem.add_dependency 'yard',  '~> 0.5.2'
#    gem.add_dependency 'addressable', '~> 2.1'
    gem.add_development_dependency 'extlib', '~> 0.9.14'
#    gem.add_development_dependency 'addressable'
    gem.add_development_dependency 'sinatra', '~> 0.9.4'
    gem.add_development_dependency 'rack', '~> 1.1'
    gem.add_development_dependency 'rack-test', '~> 0.5.3'
    gem.add_development_dependency 'fakeweb', '~> 1.2.8'
    gem.add_development_dependency 'rspec', '~> 1.2.9'
    gem.add_development_dependency 'yard-rspec', '~> 0.1'
    gem.add_development_dependency 'cucumber',  '~> 0.6.2'
    gem.add_development_dependency 'webrat',  '~> 0.6.0'
    gem.add_development_dependency 'mechanize', '~> 0.9.3'
    gem.add_development_dependency 'nokogiri', '~> 1.4.1'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)

  task :features => :check_dependencies
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :spec
Dir['tasks/**/*.rake'].each { |t| load t }

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
