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


# def rb_fname fname
#   basename = File.basename(fname, File.extname(fname))
#   dirname = File.dirname(fname)
#   "#{dirname}/#{basename}.rb"
# end

# task :build_parsers do
#   wd = Dir.pwd
#   Dir.chdir "lib/musicality/notation/parsing"
#   parser_files = Dir.glob(["**/*.treetop","**/*.tt"])
  
#   if parser_files.empty?
#     puts "No parsers found"
#     return
#   end

#   build_list = parser_files.select do |fname|
#     rb_name = rb_fname(fname)
#     !File.exists?(rb_name) || (File.mtime(fname) > File.mtime(rb_name))
#   end
  
#   if build_list.any?
#     puts "building parsers:"
#     build_list.each do |fname|
#       puts "  #{fname} -> #{rb_fname(fname)}"
#       `tt -f #{fname}`
#     end
#   else
#     puts "Parsers are up-to-date"
#   end
#   Dir.chdir wd
# end
# task :spec => :build_parsers