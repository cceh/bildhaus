require 'sinatra/activerecord'

module Bildhaus
	class Project < ActiveRecord::Base
		has_many :images
	end

	class Image < ActiveRecord::Base
		belongs_to :project

		has_many :versions
	end

	class Version < ActiveRecord::Base
		belongs_to :image

		has_one :storage_path
	end

	class StoragePath < ActiveRecord::Base
		belongs_to :version
	end

	class LocalStoragePath < StoragePath
		def serve(app, options)
			app.send_file(self.path, options)
		end
	end

	class HTTPStoragePath < StoragePath
		def serve(app, options)
			# TODO: support HTTP redirects
			raise "TODO: support HTTP redirects"
		end
	end
end

# Licensed under the ISC licence, see LICENCE.ISC for details
