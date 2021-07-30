# DB設計

## users table

| Column                | Type    | Option       |
|-----------------------|---------|--------------|
| nickname              | string  | null: false  |
| email                 | string  | unique: true | 
| encrypted_password    | string  | null: false  |
| first_name            | string  | null: false  |
| last_name             | string  | null: false  |
| first_name_kana       | string  | null: false  |
| last_name _kana       | string  | null: false  |
| birthday              | integer | null: false  |


### Association

- has_many: items
- has_many: purchases 

## items table

| Column           | Type       | Option            |
|------------------|------------|-------------------|
| title            | string     | null: false       |
| description      | text       | null: false       |
| category_id      | integer    | null: false       |
| item_status_id   | integer    | null: false       |
| deliver_fee_id   | integer    | null: false       |
| sender_region_id | integer    | null: false       |
| delivery_days_id | integer    | null: false       |
| price            | integer    | null: false       |
| user             | references | foreign_key: true |

### Association

- has_one: purchase
- belongs_to: user


## purchases table

| Column  | Type       | Option            |
|---------|------------|-------------------|
| user    | references | foreign_key: true |
| item    | references | foreign_key: true |


### Association

- has_one: address
- belongs_to: user

## addresses table

| Column       | Type       | Option            |
|--------------|------------|-------------------|
| postal_code  | char(8)    | null: false       |
| prefecture   | integer    | null: false       |
| town         | string     | null: false       |
| plot_number  | string     | null: false       |
| building     | string     |                   |
| phone_number | char(11)   | null: false       |
| item         | references | foreign_key: true |

### Association

- belongs_to: purchase