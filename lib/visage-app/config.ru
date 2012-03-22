#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
require 'pathname'

@root = Pathname.new(File.dirname(__FILE__)).parent.parent.expand_path
$:.unshift(@root.to_s)

$0 = "visage"

require 'lib/visage-app'
use Visage::Profiles
use Visage::Builder
use Visage::JSON
use Visage::Meta
run Sinatra::Base
