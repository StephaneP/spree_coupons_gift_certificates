# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree/coupons_gift_certificates/version"

Gem::Specification.new do |s|
  s.name        = "spree_coupons_gift_certificates"
  s.version     = CouponsGiftCertificates::VERSION
  s.authors     = ["Stephane Paul"]
  s.email       = ["stephane@godynamo.com"]
  s.homepage    = "http://godynamo.com"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "spree_coupons_gift_certificates"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
