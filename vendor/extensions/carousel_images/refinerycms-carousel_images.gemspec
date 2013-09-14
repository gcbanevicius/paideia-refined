# Encoding: UTF-8

Gem::Specification.new do |s|
  s.authors	      = ["Nikitas Tampakis", "Gabriel Banevicius"]
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-carousel_images'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Carousel Images extension for Refinery CMS'
  s.date              = '2013-07-18'
  s.summary           = 'Carousel Images extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0.10'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.10'
end
