class CreateVersions < ActiveRecord::Migration
	def change
		create_table :versions do |t|
			t.string :name

			t.references :image

			t.timestamps
		end
	end
end

# Licensed under the ISC licence, see LICENCE.ISC for details
