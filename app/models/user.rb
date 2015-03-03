class User < ActiveRecord::Base
  attr_accessor :name, :provider, :uid


  def self.from_omniauth(auth)
    # puts "THIS IS THE AUTH"
    # puts auth.slice("provider", "uid")
    # puts "THIS IS NOT THE FIRST"
    # puts where(auth.slice("provider", "uid"))
    # where(auth.slice(:provider, :uid)).first || create_from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider 
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.save
    end
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      # user.name = auth["info"]["nickname"]
    end
  end
end
