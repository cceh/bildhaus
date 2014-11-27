lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

$rack_root_dir = File.dirname(__FILE__)

require 'bildhaus'

run Bildhaus::App

# Licensed under the ISC licence, see LICENCE.ISC for details
