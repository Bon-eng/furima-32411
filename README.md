# README
<!--null: false	カラムが空の状態では保存できない-->
<!--unique: true	一意性のみ許可（同じ値は保存できない）-->
<!--foreign_key: true	外部キーを設定（別テーブルのカラムを参照する）-->



## users　テーブル

| Column          | Type    | Options      |
| --------------- | ------- | ------------ |
| nickname        | string  | null: false  |
| email           | string  | unique: true |
| password        | string  | null: false  |
| last_name       | string  | null: false  |
| first_name      | string  | null: false  |
| last_name_kana  | string  | null: false  |
| first_name_kana | string  | null: false  |
| birthday        | integer | null: false  |


### Association
- has_many :items
- has_many :purchases


## items　テーブル

| Column       | Type       | Options           |
| ------------ | ---------- | ----------------- |
| products     | text       | null: false       |
| introduction | text       | null: false       |
| category     | string     | null: false       |
| status       | string     | null: false       |
| postage      | string     | null: false       |
| days_to_ship | string     | null: false       |
| price        | integer    | null: false       |
| user_id      | references | foreign_key: true |


### Association
- belongs_to :user
- has_one :purchase
- has_one :destination



## purchases　テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| user_id    | references | foreign_key: true |
| product_id | references | foreign_key: true |


### Association
- belongs_to :user
- belongs_to :item
- has_one :destination



## destinations　テーブル

| Column        | Type    | Options     |
| ------------- | ------- | ----------- |
| post_code     | integer | null: false |
| prefecture    | string  | null: false |
| city          | string  | null: false |
| address       | string  | null: false |
| building_name | string  | null: false |
| phone_number  | integer | null: false |


### Association
- belongs_to :item
- belongs_to :purchase