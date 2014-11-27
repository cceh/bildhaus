class CreateStoragePaths < ActiveRecord::Migration
	def change
		create_table :storage_paths do |t|
			t.string :type

			t.string :path

			t.references :version

			t.timestamps
		end
	end
end

# Licensed under the ISC licence, see LICENCE.ISC for details
