class Section < ApplicationRecord
   belongs_to :department
   has_many :students, dependent: :destroy
end
