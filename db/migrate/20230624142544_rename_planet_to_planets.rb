class RenamePlanetToPlanets < ActiveRecord::Migration[7.0]
  def change
    rename_table 'Planet', 'Planets'
  end
end
