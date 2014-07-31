 class TopicPolicy < ApplicationPolicy
 
   def index?
     true
   end
 
   def create?
#      user.present? && user.role?(:admin)
     true
   end
 
   def update?
     create?
   end
 end
