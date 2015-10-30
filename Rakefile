# encoding: utf-8

require 'rubygems'

begin
  require 'bundler/setup'
rescue LoadError => e
  abort e.message
end

require 'rake'


require 'rubygems/tasks'
Gem::Tasks.new

require 'rdoc/task'
RDoc::Task.new
task :doc => :rdoc

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :test    => :spec
task :default => :spec

# Building RB parsers from treetop files

TREETOP_EXT = ".treetop"
RB_EXT = ".rb"

parser_treetop_files = Rake::FileList["lib/**/*#{TREETOP_EXT}"]
parser_rb_files = parser_treetop_files.ext(RB_EXT)

task :parsers => parser_rb_files
task :spec => :parsers

rule RB_EXT => TREETOP_EXT do |t|
  puts "#{t.source} -> #{t.name}"
  `tt -f #{t.source}`
end
