# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'nft/version'

Gem::Specification.new do |spec|
  spec.name        = 'nftables'
  spec.version     = NFT::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['Tobias Schäfer']
  spec.email       = ['github@blackox.org']

  spec.summary     = 'Ruby nftables C-library wrapper.'
  spec.description = <<~DESC
    #{spec.summary}

    Run any nftables command.
  DESC
  spec.homepage = 'https://github.com/tschaefer/ruby-nftables'
  spec.license  = 'GPL-3.0-or-later'

  spec.files                 = Dir['lib/**/*']
  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 3.1'

  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['source_code_uri']       = 'https://github.com/tschaefer/ruby-nftables'
  spec.metadata['bug_tracker_uri']       = 'https://github.com/tschaefer/ruby-nftables/issues'
end
