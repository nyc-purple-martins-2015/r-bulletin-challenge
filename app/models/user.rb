class User < ActiveRecord::Base
  #has_secure_password
  has_many :authorizations
  has_many :messages
  has_many :conversations

  #validates :username, :email, presence: true, uniqueness: true

  def add_provider(auth_hash)
  # Check if the provider already exists, so we don't add it twice
  unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    User.find_or_create(username: auth_hash[:screen_name])
  end
end
