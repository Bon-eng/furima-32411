class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
#データ型がBLOB型もしくはtext型はdefault値を設定不可のため、""も外す
#⬆️むしろ全部default値の設定しなくていい。元から入ってるから二重でエラー出る
      t.string     :name,            null: false
      t.text       :introduction,    null: false
      t.integer    :category_id,     null: false
      t.integer    :status_id,       null: false
      t.integer    :postage_id,      null: false
      t.integer    :prefecture_id,   null: false
      t.integer    :days_to_ship_id, null: false
      t.integer    :price,           null: false
      t.references :user,            foreign_key: true
      t.timestamps
    end
  end
end
