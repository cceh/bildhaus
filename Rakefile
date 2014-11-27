lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'sinatra/activerecord/rake'

namespace :db do
	task :load_config do
		require 'bildhaus'
	end
end

# Licensed under the ISC licence, see LICENCE.ISC for details
