# -*- mode: ruby -*-
# vi: set ft=ruby :
#
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

exclude_tests_paths = ['pkg/**/*','vendor/**/*','spec/**/*']
PuppetLint.configuration.ignore_paths = exclude_tests_paths
PuppetLint.configuration.fail_on_warnings = true
PuppetSyntax.exclude_paths = exclude_tests_paths

desc 'Run syntax, lint and spec tests'
task :test => [:syntax,:lint,:spec]
