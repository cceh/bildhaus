require 'better_errors'
require 'sinatra/reloader'
require 'sinatra/respond_with'
require 'sinatra/base'

require 'bildhaus/models'

class Bildhaus::App < Sinatra::Base
	configure :development do
		set :root, $rack_root_dir

		register Sinatra::RespondWith
		register Sinatra::Reloader

		use BetterErrors::Middleware
		BetterErrors.application_root = __dir__
		use ActiveRecord::ConnectionAdapters::ConnectionManagement
	end

	# /project => Übersicht der Projekte;

	# /project/guillelmus/ => Übersicht des Projekt;
	get '/project/:project_name' do
		project_name = params[:project_name]

		project = Bildhaus::Project.find_by_name!(project_name)

		data = {
			:title => project.name,
			:project => project,
		}

		respond_with :project, data
	end

	# /project/guillelmus/image/ => Übersicht der Bilder;

	# /project/guillelmus/image/B_1r => Übersicht des Bild "B_1r";
	get '/project/:project_name/image/:image_name' do
		project_name = params[:project_name]
		image_name = params[:image_name]

		project = Bildhaus::Project.find_by_name!(project_name)
		image = project.images.find_by_name!(image_name)

		data = {
			:title => image.name,
			:image => image,
		}

		respond_with :image, data
	end

	# /project/guillelmus/image/B_1r/metadata => Metadata für "B_1r";
	# /project/guillelmus/image/B_1r/original => Originaldatei für "B_1r";

	# /project/guillelmus/image/B_1r/v/max.jpg => generiert "max.jpg" für "B_1r" (mit 'Content-Type: image/jpeg'), 'v' für 'view';
	get '/project/:project_name/image/:image_name/v/:version_name' do
		project_name = params[:project_name]
		image_name = params[:image_name]
		version_name = params[:version_name]

		project = Bildhaus::Project.find_by_name!(project_name)
		image = project.images.find_by_name!(image_name)
		version = image.versions.find_by_name!(version_name)
		storage_path = version.storage_path

		options = {}
		options[:filename] = "#{project_name}--#{image_name}--#{version_name}"

		storage_path.serve(self, options)
	end

	error ActiveRecord::RecordNotFound do
		# TODO: report wrong parameters
		"Some parameters are wrong"
	end
end

# Licensed under the ISC licence, see LICENCE.ISC for details
