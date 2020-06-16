#!/usr/bin/env ruby

require 'yaml'

class Classifier
  attr_accessor :config

  def initialize(config_file)
    load_config config_file
  end

  def load_config(config_file)
    @config = YAML.load_file(config_file)
  end

  def process_host(hostname)
    host = hostname
    role = @config['role_mappings'][host]
    response = {'classes' => ["role::#{role}"]}
    puts response.to_yaml
  end
end

path = File.dirname(__FILE__)

classifier = Classifier.new "#{path}/nodes.yaml"
classifier.process_host ARGV[0]

