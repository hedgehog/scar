require 'rubygems'
require 'extlib'
require 'pathname'
require 'fileutils'
require 'nanoc3'
dir = File.expand_path(File.dirname(__FILE__))
require dir / '../lib/scar/site_utils.rb'

include SiteUtils

namespace :site do

  task :set_pwd do
     @website_path = Pathname.new(Dir.pwd) / 'website' 
  end

	task :clean => [:set_pwd] do
		output = @website_path / 'output'
		puts "Deleting all files in output dir... #{output}"
		output.rmtree if File.exist?(output)
		(output / 'data').mkpath
	end

	task :update do
		FileUtils.chdir @website_path do
      Kernel.system("nanoc3 co")
    end
	end

	task :run => [:copy_resources] do
		FileUtils.chdir @website_path do
      Kernel.system "nanoc3 aco -s thin"
    end
	end

	task :rebuild => [:clean, :update] do
	end

	task :tags => [:set_pwd] do
		site = Nanoc3::Site.new('.')
		site.load_data
		dir = @website_path / 'content/tags'
		dir.rmtree if dir.exist?
		dir.mkpath
		tags = {}
		# Collect tag and page data
		site.items.each do |p|
			next unless p.attributes[:tags]
			p.attributes[:tags].each do |t|
				if tags[t]
					tags[t] = tags[t]+1
				else
					tags[t] = 1
				end
			end
		end
		# Write pages
		tags.each_pair do |k, v|
			write_tag_page dir, k, v
			write_tag_feed_page dir, k, 'RSS'
			write_tag_feed_page dir, k, 'Atom'
		end
	end

	task :archives => [:set_pwd] do
		site = Nanoc3::Site.new('.')
		site.load_data
		dir = @website_path / 'content/archives'
		dir.rmtree if dir.exist?
		dir.mkpath
		m_articles = []
		index = -1
		current_month = ""
		# Collect month and page data
		articles = site.items.select{|p| p.attributes[:date] && p.attributes[:type] == 'article'}.sort{|a, b| a.attributes[:date] <=> b.attributes[:date]}.reverse
		articles.each do |a|
			month = a.attributes[:date].strftime("%B %Y")
			if current_month != month then
				# new month
				m_articles << [month, [a]]
				index = index + 1
				current_month = month
			else
				# same month
				m_articles[index][1] << a
			end
		end
		# Write pages
		m_articles.each do |m|
			write_archive_page dir, m[0], m[1].length
		end
	end

	task :article, [:name] => [:set_pwd] do |t, args|
		raise RuntimeError, "Name not specified" unless args[:name]
		raise RuntimeError, "Article name can only contain letters, numbers and dashes" unless args[:name].match /^[a-zA-Z0-9-]+$/
		meta = {}
		meta[:permalink] = args[:name]
		meta[:title] = ""
		meta[:tags] = []
		meta[:date] = Time.now
		meta[:toc] = true
		meta[:type] = 'article'
		file = @website_path/"content/articles/#{meta[:permalink]}.textile"
		raise "File '#{file}' already exists!" if file.exist?
		write_item file, meta, ''
	end

	task :page, [:name] => [:set_pwd] do |t, args|
		raise RuntimeError, "Name not specified" unless args[:name]
		raise RuntimeError, "Page name can only contain letters, numbers and dashes" unless args[:name].match /^[a-zA-Z0-9-]+$/
		meta = {}
		meta[:permalink] = args[:name]
		meta[:title] = ""
		meta[:type] = 'page'
		file = @website_path/"content/#{meta[:permalink]}.textile"
		raise "File '#{file}' already exists!" if file.exist?
		write_item file, meta, ''
	end

	task :project, [:name] => [:set_pwd] do |t, args|
		raise RuntimeError, "Name not specified" unless args[:name]
		raise RuntimeError, "Project name can only contain letters, numbers and dashes" unless args[:name].match /^[a-zA-Z0-9-]+$/
		meta = {}
		meta[:permalink] = args[:name]
		meta[:title] = ""
		meta[:github] = args[:name]
		meta[:status] = "Active"
		meta[:version] = "0.1.0"
		meta[:type] = 'project'
		meta[:links] = [{"Documentation" => "http://#{args[:name]}.rubyforge.org"},
										{"Download" => "http://rubyforge.org/projects/#{args[:name]}"},
										{"Source" => "http://github.com/h3rald/#{args[:name]}/tree/master"},
										{"Tracking" => "http://github.com/h3rald/#{args[:name]}/issues"}]
		contents = %{
<%= render 'project_data', :tag => '#{args[:name]}' %>

h3. Installation

h3. Usage

<%= render 'project_updates', :tag => '#{args[:name]}' %>
		}
		file = @website_path/"content/#{meta[:permalink]}.textile"
		raise "File '#{file}' already exists!" if file.exist?
		write_item file, meta, contents
	end

	task :copy_resources => [:set_pwd] do
		pwd = @website_path
		copy_f = lambda do |src|
			if src.file? then
				rel_path = src.relative_path_from(pwd/'resources').to_s
				dst = Pathname.new(pwd/"output/#{rel_path}")
				if !dst.exist? || dst.exist? && !FileUtils.cmp(dst.to_s, src.to_s) then
					dst.parent.mkpath
					FileUtils.cp src.to_s, dst.to_s
					puts "Copied '#{src}'."
				end
			end
		end
		file_dirs = [Pathname.new(pwd/'resources/images'),
			Pathname.new(pwd/'resources/js'),
			Pathname.new(pwd/'resources/img'),
			Pathname.new(pwd/'resources/files'),
			Pathname.new(pwd/'resources/css')]
		files = [pwd/'resources/.htaccess', pwd/'resources/robots.txt',  pwd/'resources/favicon.ico']
		files.each { |f| copy_f.call f }
		file_dirs.each do |d|
			d.find do |src|
				copy_f.call src
			end
		end
	end
  # Hat-tip to Dr Nic's sake tasks for the migration code
  namespace 'github' do
    desc "Creates the gh-pages branch, and links to it as 'website' as submodule"
    task :setup do
      tmpid = Time.now.gmtime.to_s.gsub(/ |:/,'')
      pre_tag="pre-gh-pages-migration-tag-#{tmpid}"
      current_branch = Kernel.`('git branch | grep "^*" | sed -e "s/* //"').strip
      repo = Kernel.`('git config --list | grep "^remote.origin.url" | sed -e "s/remote.origin.url=//"').strip
      puts "Assume you have created the gh-pages branch via github's web pages"
      puts "Append text 'My GitHub Page' to index.html"
      puts "Working in #{current_branch} branch of #{repo}:"
      commands = <<-CMD.gsub(/^ /, '')
      git tag #{pre_tag}
      git fetch #{repo}
      git checkout --track -b gh-pages #{repo}/gh-pages
      echo "My GitHub Page" >> index.html
      git add .
      git commit -a -m 'First gh-pages commit'
      git push #{repo} gh-pages
      git checkout #{current_branch}
      git submodule add #{repo} ./gh-pages

      git symbolic-ref HEAD refs/heads/gh-pages

      git checkout #{current_branch}
      git submodule add -b gh-pages #{repo} gh-pages
      git commit -a -m "website -> gh-pages folder"
      git push
      CMD
      commands.split(/\n/).each { |cmd| Kernel.`(cmd) }
    end
  end
  namespace 'github' do
    desc "Migrates an existing website folder into a gh-pages branch, and links back as submodule"
    task :migrate do
      tmpid = Time.now.gmtime.to_s.gsub(/ |:/,'')
      current_branch = Kernel.`('git branch | grep "^*" | sed -e "s/* //"').strip
      pre_branch="pre-gh-pages-migration-branch-#{tmpid}"
      pre_tag="pre-gh-pages-migration-tag-#{tmpid}"
      repo = Kernel.`('git config --list | grep "^remote.origin.url" | sed -e "s/remote.origin.url=//"').strip
      website_folder = ENV['WEBSITE_PATH'] || 'website/output'
      tmp_folder = "/tmp/gh-pages-website-#{tmpid}"
      puts "Moving #{website_folder} folder to branch gh-pages."
      puts "Working in #{current_branch} branch of #{repo}:"
      gitstatus=Kernel.send(:`,'git status')
      dirty = gitstatus =~ /nothing to commit (working directory clean)/i
      if dirty
        gstash = "git stash save 'Uncommited changes stashed pre gh-pages migration: #{tmpid}'"
        stashed=true
        Kernel.send(:`,gstash)
        gitstatus=Kernel.send(:`,'git status')
        dirty = gitstatus =~ /nothing to commit (working directory clean)/i
      end
      raise RuntimeError.new("The git working directory is still not clean.") if dirty
      commands = <<-CMD.gsub(/^ /, '')
      git tag #{pre_tag}
      mv #{website_folder} #{tmp_folder}
      git branch -m #{current_branch} #{pre_branch}
      cp .git/index .git/index-#{tmpid}
      git commit -a -m "temporarily removing #{website_folder} whilst moving to branch gh-pages"
      git symbolic-ref HEAD refs/heads/gh-pages
      rm .git/index
      git clean -fd
      cp -R #{tmp_folder}/* .
      git add .
      git commit -a -m 'Import original #{website_folder} folder copied out of #{current_branch} branch'
      git push #{repo} gh-pages
      git checkout #{pre_branch}
      git submodule add -b gh-pages #{repo} #{website_folder}
      git commit -a -m "migrated folder #{website_folder} -> branch gh-pages, and replaced with submodule link"
      git push #{repo} gh-pages
      git branch -m #{pre_branch} #{current_branch}
      CMD
      commands.split(/\n/).each do |cmd|
        puts "Executing: #{cmd}"
        # Kernel.`(cmd)
        unless $? == 0
          puts "To reset: 1) Look for the branch crazyexperiment"
          puts "git branch -a"
          puts "To reset: 2) if there is a branch crazyexperiment"
          puts "git checkout crazyexperiment"
          puts "To reset: 3) if there is no master branch"
          puts "git checkout -b master"
          puts "To reset: 4) Once satisfied everything is as you started"
          puts "git branch -D crazyexperiment"
          raise RuntimeError.new("Somthing went wrong.")
        end
      end
      Kernel.send(:`, 'git stash apply stash@{0}') if stashed
      gitstatus=Kernel.send(:`,'git status')
      puts gitstatus
    end
  end

end
