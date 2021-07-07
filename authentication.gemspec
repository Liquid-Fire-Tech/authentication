require_relative 'lib/authentication/version'

Gem::Specification.new do |spec|
  spec.name        = 'authentication'
  spec.version     = Authentication::VERSION
  spec.authors     = ['Sanchit Samuel']
  spec.email       = ['sanchit.samuel@live.com']
  spec.homepage    = 'https://github.com/Liquid-Fire-Tech/user-authentication'
  spec.summary     = 'User authentication system based on devise with OTP support.'
  spec.description = 'User authentication system based on devise with OTP support.'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Liquid-Fire-Tech/user-authentication'
  spec.metadata['changelog_uri'] = 'https://github.com/Liquid-Fire-Tech/user-authentication'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'devise', '~> 4.8.0'
  spec.add_dependency 'rails', '~> 6.1.4'
end
