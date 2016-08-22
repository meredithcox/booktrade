class Post < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :title, presence: true
  validates :subject, presence: true
  validates :email, presence: true 
  validates :author, presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  
  def self.search(search)
    where("title LIKE ? OR author LIKE ? OR isbn LIKE ? OR subject LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
  end
end
