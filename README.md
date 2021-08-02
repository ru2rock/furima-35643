# DB設計

## users table

| Column                | Type    | Option                    |
|-----------------------|---------|---------------------------|
| nickname              | string  | null: false               |
| email                 | string  | null: false, unique: true | 
| encrypted_password    | string  | null: false               |
| first_name            | string  | null: false               |
| last_name             | string  | null: false               |
| first_name_kana       | string  | null: false               |
| last_name _kana       | string  | null: false               |
| birthday              | date    | null: false               |


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
| prefecture_id    | integer    | null: false       |
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
- belongs_to: item

## addresses table

| Column    -   | Type       | Option            |
|---------------|------------|-------------------|
| postal_code   | string     | null: false       |
| prefecture_id | integer    | null: false       |
| town          | string     | null: false       |
| plot_number   | string     | null: false       |
| building      | string     |                   |
| phone_number  | string     | null: false       |
| purchase      | references | foreign_key: true |

### Association

- belongs_to: purchase