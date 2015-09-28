class User < ActiveRecord::Base
    before_save{self.email = email.downcase}
    validates :name,presence: true,length: {maximum:50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,length: {maximum:255},
                      format:{with: VALID_EMAIL_REGEX},
                      uniqueness:{case_sensitive: false}
    
    validates :region,length: {maximum:255}
    validates :profile,length: {maximum:255}
    
    has_secure_password
    
    has_many :microposts
    
    has_many :following_relationships,class_name: "Relationship",
                                     foreign_key: "follower_id",
                                     dependent: :destroy

    has_many :following_users,through: :following_relationships,source: :followed
    
    has_many :follower_relationships,class_name: "Relationship",
                                     foreign_key: "followed_id",
                                     dependent: :destroy
    
    has_many :follower_users, through: :follower_relationships,source: :follower
    
    has_many :favorites_relationships, class_name:  "Favorite",
                                     foreign_key: "user_id",
                                     dependent: :destroy
    has_many :favorites_users, through: :favorites_relationships, source: :micropost
    
    def follow(other_user)
        following_relationships.create(followed_id: other_user.id)
    end
    
    def unfollow(other_user)
        following_relationships.find_by(followed_id: other_user.id).destroy
    end
    
    def following?(other_user)
        following_users.include?(other_user)
    end
    
    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end
    
    def create_favorite(micropost)
        favorites_relationships.create(micropost_id: micropost.id)
    end
    
    def delete_favorite(micropost)
        favorites_relationships.find_by(micropost_id: micropost.micropost_id).destroy
    end
    
    def favorite?(micropost)
        favorites_users.include?(micropost)
    end
end
