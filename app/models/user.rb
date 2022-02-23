class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save {email.downcase!}
  
  # enum roles: [:Customer, :Admin, :SuperAdmin]

  

  # validates :username, presence:true,uniqueness:true, length: { maximum: 50 }
  validates :email, presence:true,uniqueness:true, length: { maximum: 255}

  validates :password, presence:true, length: { minimum: 6 }
                    

  # validates :role, inclusion: { in: roles }

  


 
  # def admin?
  #   self.role == 'Admin'
  # end

  # def superadmin?
  #   self.role == 'SuperAdmin'
  # end
end
