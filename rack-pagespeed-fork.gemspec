# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: rack-pagespeed-fork 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rack-pagespeed-fork"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Will Jordan", "Julio Cesar Ody"]
  s.date = "2014-10-09"
  s.description = "Web page speed optimizations at the Rack level - fork"
  s.email = "will@code.org"
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/rack-pagespeed.rb",
    "lib/rack/pagespeed.rb",
    "lib/rack/pagespeed/config.rb",
    "lib/rack/pagespeed/filters/all.rb",
    "lib/rack/pagespeed/filters/base.rb",
    "lib/rack/pagespeed/filters/combine_css.rb",
    "lib/rack/pagespeed/filters/combine_javascripts.rb",
    "lib/rack/pagespeed/filters/inline_css.rb",
    "lib/rack/pagespeed/filters/inline_images.rb",
    "lib/rack/pagespeed/filters/inline_javascripts.rb",
    "lib/rack/pagespeed/filters/minify_css.rb",
    "lib/rack/pagespeed/filters/minify_javascripts.rb",
    "lib/rack/pagespeed/store/disk.rb",
    "lib/rack/pagespeed/store/memcached.rb",
    "lib/rack/pagespeed/store/redis.rb",
    "rack-pagespeed-fork.gemspec",
    "spec/config_spec.rb",
    "spec/filters/combine_css_spec.rb",
    "spec/filters/combine_javascripts_spec.rb",
    "spec/filters/filter_spec.rb",
    "spec/filters/inline_css_spec.rb",
    "spec/filters/inline_images_spec.rb",
    "spec/filters/inline_javascript_spec.rb",
    "spec/filters/minify_javascript_spec.rb",
    "spec/fixtures/all-small-dog-breeds.jpg",
    "spec/fixtures/complex.html",
    "spec/fixtures/foo.js",
    "spec/fixtures/hh-reset.css",
    "spec/fixtures/huge.css",
    "spec/fixtures/iphone.css",
    "spec/fixtures/jquery-1.4.1.min.js",
    "spec/fixtures/medialess1.css",
    "spec/fixtures/medialess2.css",
    "spec/fixtures/mock_store.rb",
    "spec/fixtures/mylib.js",
    "spec/fixtures/noexternalcss.html",
    "spec/fixtures/noscripts.html",
    "spec/fixtures/ohno.js",
    "spec/fixtures/reset.css",
    "spec/fixtures/screen.css",
    "spec/fixtures/styles.html",
    "spec/pagespeed_spec.rb",
    "spec/spec_helper.rb",
    "spec/store/disk_spec.rb",
    "spec/store/memcached_spec.rb",
    "spec/store/redis_spec.rb"
  ]
  s.homepage = "http://github.com/wjordan/rack-pagespeed"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.2"
  s.summary = "Web page speed optimizations at the Rack level - fork"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<jsmin>, [">= 0"])
      s.add_runtime_dependency(%q<mime-types>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<rspec>, ["= 2.6.0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<jsmin>, [">= 0"])
      s.add_dependency(%q<mime-types>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<rspec>, ["= 2.6.0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<jsmin>, [">= 0"])
    s.add_dependency(%q<mime-types>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<rspec>, ["= 2.6.0"])
  end
end

