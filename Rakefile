# -*- mode: ruby -*-
# vi: set ft=ruby :
#
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_variable_scope')
#TODO http://puppet-lint.com/checks/class_inherits_from_params_class/
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.fail_on_warnings = true

exclude_tests_paths = ['pkg/**/*','vendor/**/*','spec/**/*']
PuppetLint.configuration.ignore_paths = exclude_tests_paths
PuppetSyntax.exclude_paths = exclude_tests_paths

desc 'Run syntax, lint and spec tests'
task :test => [:syntax,:lint,:spec]
