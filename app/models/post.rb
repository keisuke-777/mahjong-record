class Post < ApplicationRecord
    validates :room_number, {presence: true, uniqueness: true}
    validates :matches, {presence: true}
    validates :name_a, {presence: true}
end