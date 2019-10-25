class Section < ApplicationRecord
  belongs_to :department
  has_many :students, dependent: :destroy

  validates :name, presence: true
  before_save :to_upper
  def to_upper
     self.name = self.name.upcase
  end
end
