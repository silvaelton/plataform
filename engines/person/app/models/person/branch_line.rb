module Person
  class BranchLine < ActiveRecord::Base
    validates_presence_of :name, :code
    validates :name, :code, uniqueness: true

    has_many :user
  end
end
