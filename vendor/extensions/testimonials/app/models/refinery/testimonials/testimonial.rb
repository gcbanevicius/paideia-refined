module Refinery
  module Testimonials
    class Testimonial < Refinery::Core::BaseModel
      self.table_name = 'refinery_testimonials'

      attr_accessible :program, :year, :name, :institution, :picture_id, :content, :position

      acts_as_indexed :fields => [:program, :year, :name, :institution, :content]

      validates :program, :presence => true, :uniqueness => true

      belongs_to :picture, :class_name => '::Refinery::Image'
    end
  end
end
