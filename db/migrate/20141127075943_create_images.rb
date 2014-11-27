class CreateImages < ActiveRecord::Migration
	def change
		create_table :images do |t|
			t.string :name

			t.references :project

			t.timestamps
		end
	end
end

# Licensed under the ISC licence, see LICENCE.ISC for details
