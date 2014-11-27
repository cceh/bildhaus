lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bildhaus'

run Bildhaus::App

# Licensed under the ISC licence, see LICENCE.ISC for details
