class User < ApplicationRecord
    #presence 空値を許さない   uniqueness 重複を許さない
    validates :name, {presence: true, uniqueness: true}
    validates :email, {presence: true, uniqueness: true}
    validates :password, {presence: true}
end
