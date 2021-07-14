require_relative "../authentication_test"
require_relative File.expand_path("../../../lib/generators/authentication/install_generator", __FILE__)


class Authentication::InstallGeneratorTest < ::Rails::Generators::TestCase
  tests Authentication::InstallGenerator
  setup :prepare_destination
end