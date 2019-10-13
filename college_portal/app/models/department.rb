class Department < ApplicationRecord
   has_many :sections, dependent: :destroy
   has_many :students, dependent: :destroy
end
