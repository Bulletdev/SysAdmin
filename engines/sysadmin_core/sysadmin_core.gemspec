# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'sysadmin_core'
  # Load version constant directly to avoid fragile regex on quoting
  require_relative File.expand_path('lib/sysadmin_core/version', __dir__)
  spec.version       = SysadminCore::VERSION
  spec.authors       = ['BulletOnRails']
  spec.email         = ['contato@michaelbullet.com']

  spec.summary       = 'Core engine for SysAdmin app'
  spec.description   = 'Reusable Rails Engine containing core components of SysAdmin.'
  spec.homepage      = 'https://example.com/sysadmin'
  spec.license       = 'MIT'

  spec.files         = Dir['{lib}/**/*', 'README.md']
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 7.2'
end
