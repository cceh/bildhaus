class CreateProjects < ActiveRecord::Migration
	def change
		create_table :projects do |t|
			t.string :name

			t.timestamps
		end
	end
end

# Licensed under the ISC licence, see LICENCE.ISC for details
