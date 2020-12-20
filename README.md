# README
<!--null: false	カラムが空の状態では保存できない-->
<!--unique: true	一意性のみ許可（同じ値は保存できない）-->
<!--foreign_key: true	外部キーを設定（別テーブルのカラムを参照する）-->



## users　テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birthday           | date    | null: false               |

<!--誕生日カラムはdate型-->

### Association
- has_many :items
- has_many :purchases


## items　テーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| name             | string     | null: false       |
| introduction     | text       | null: false       |
| category_id      | integer    | null: false       |
| status_id        | integer    | null: false       |
| postage_id       | integer    | null: false       |
| prefecture_id    | integer    | null: false       |
| days_to_ship_id  | integer    | null: false       |
| price            | integer    | null: false       |
| user             | references | foreign_key: true |

<!--都道府県と配送元地域を別々に分けず同じものとして管理-->

### Association
- belongs_to :user
- has_one :purchase



## purchases　テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| user    | references | foreign_key: true |
| product | references | foreign_key: true |

<!--references型にするときは_idは自動付与のため記述なし-->

### Association
- belongs_to :user
- belongs_to :item
- has_one :destination



## destinations　テーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| post_code     | string     | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| address       | string     | null: false       |
| building_name | string     |                   |
| phone_number  | string     | null: false       |
| user          | references | foreign_key: true |

<!--郵便番号にはハイフンがいるのでstring型に-->
<!--都道府県はactive_hashのためinteger型に-->
<!--建物名は任意のため制約必要なし-->
<!--電話番号をinteger型で保存すると先頭の0が省略されてしまう為string型にする-->

### Association
- belongs_to :purchase