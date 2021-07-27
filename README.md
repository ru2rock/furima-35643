# DB設計

## users table

| Column                | Type   | Option      |
|-----------------------|--------|-------------|
| nickname              | string | null: false |
| email                 | string | null: false | 
| password              | string | null: false |
| name                  | string | null: false |


null: false, foreign_key: true

### Association

- has_many: items
- has_many: purchases 

## items table

| Column      | Type       | Option            |
|-------------|------------|-------------------|
| title       | string     | null: false       |
| description | text       | null: false       |
| price       | integer    | null: false       |
| user        | references | foreign_key: true |

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
| town         | string     | null: false       |
| plot_number  | string     | null: false       |
| building     | string     |                   |
| phone_number | char(11)   | null: false       |
| item         | references | foreign_key: true |

### Association

- belongs_to: purchase