module Refinery
  module StaffMembers
    class StaffMember < Refinery::Core::BaseModel
      self.table_name = 'refinery_staff_members'

      attr_accessible :name, :title, :thumbnail_id, :image_id, :bio, :position

      acts_as_indexed :fields => [:name, :title, :bio]

      validates :name, :presence => true, :uniqueness => true

      belongs_to :thumbnail, :class_name => '::Refinery::Image'

      belongs_to :image, :class_name => '::Refinery::Image'
    end
  end
end
