class CreateSettingsPaths < ActiveRecord::Migration
  def self.up
    create_table :settings_paths do |t|
      t.string :path

      t.timestamps
    end
  end

  def self.down
    drop_table :settings_paths
  end
end
