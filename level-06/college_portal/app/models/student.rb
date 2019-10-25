class Student < ApplicationRecord
   belongs_to :department
   belongs_to :section
end
