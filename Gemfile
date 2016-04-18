source 'https://rubygems.org'

require 'json'
require 'open-uri'
versions = JSON.parse(open('https://pages.github.com/versions.json').read)

gem 'github-pages', versions['github-pages']
gem 'rouge', versions['rouge']
gem 'kramdown', versions['kramdown']
gem 'jekyll', versions['jekyll']
