# encoding: utf-8
# frozen_string_literal: true

require 'bundler'
require 'bundler/setup'
require 'json'
require 'rake/testtask'

Rake::TestTask.new { |t| t.libs << 'test' }

task :optimize_js do
  def cmd(description, command)
    puts description
    puts "  => #{command}"
    system command
    puts
  end

  cmd 'Remove optimize-js repository', 'rm -rf optimize-js-repo'

  cmd 'Cloning optimize-js repository...',
      'git clone --single-branch --depth 1 --no-hardlinks https://github.com/nolanlawson/optimize-js.git optimize-js-repo'

  version = JSON.parse(File.read('optimize-js-repo/package.json'))['version']
  puts "optimize-js version: #{version}"

  Dir.chdir 'optimize-js-repo' do
    cmd 'Installing optimize-js dependencies...', 'npm install'
    cmd 'Installing browserify...',               'npm install browserify'
    cmd 'Installing uglifyjs...',                 'npm install uglifyjs'

    cmd 'Making web-version',
        'node_modules/browserify/bin/cmd.js --standalone optimizeJS lib/index.js -o ../optimize-js.web.js'

    cmd 'Minifying web-version',
        'node_modules/uglifyjs/bin/uglifyjs ../optimize-js.web.js --compress --mangle --output ../optimize-js.web.min.js'
  end

  puts 'Writing version...'
  content = File.read('lib/optimize-js/version.rb')
  content = content.gsub(/JS_VERSION.*/, "JS_VERSION = '#{version}'")
  File.open('lib/optimize-js/version.rb', 'w') { |f| f.write(content) }

  cmd 'Cleaning out...', 'rm -rf optimize-js-repo optimize-js.web.js'
end
