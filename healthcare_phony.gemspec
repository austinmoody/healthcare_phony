# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'healthcare_phony/version'

Gem::Specification.new do |spec|
  spec.name          = 'healthcare_phony'
  spec.version       = HealthcarePhony::VERSION
  spec.authors       = ['Austin Moody']
  spec.email         = ['austin.moody@hey.com']

  spec.summary       = 'A utility to create fake data and files for healthcare integration testing'
  spec.homepage      = 'http://github.com/austinmoody/healthcare_phony'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
    spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.required_ruby_version     = '>= 2.6'
  spec.required_rubygems_version = '>= 2.6.10'

  spec.add_dependency 'faker', '~> 2.13.0'
  spec.add_dependency 'psych', '~> 3.1.0'
  spec.add_dependency 'regexp-examples', '~> 1.5.1'
end
