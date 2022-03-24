Gem::Specification.new do |s|
  s.name = 'postgresql-lambda'
  s.version = "#{File.read('VERSION').strip}.#{File.read('BUILD').strip}"
  s.authors = ['Ryan Grush']
  s.license = "MIT"
  s.email = ['ryan.grush@dadesystems.com']
  s.homepage = 'https://github.com/ryangrush/postgresql-lambda'
  s.rdoc_options = ['--charset=UTF-8']
  s.summary = 'Precompiled POSTGRESQL gem for AWS Lambda.'
  s.metadata = {
    'bug_tracker_uri'   => "#{s.homepage}/issues",
    'changelog_uri'     => "#{s.homepage}/releases/tag/#{s.version}",
    'homepage_uri'      => s.homepage,
    'source_code_uri'   => "#{s.homepage}/tree/#{s.version}",
  }
  s.required_ruby_version = '>= 2.7.2'
  s.files = Dir.glob('./**/*')
end
