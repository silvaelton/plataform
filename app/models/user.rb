class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthableasd
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :account, polymorphic: true 

  validates :username, presence: true

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def staff?
    (self.account_type == "Person::Staff")
  end

  def concourse_candidate?
    (self.account_type == "Concourse::Candidate")
  end


end
