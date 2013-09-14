module Refinery
  module CarouselImages
    class CarouselImage < Refinery::Core::BaseModel
      self.table_name = 'refinery_carousel_images'

      attr_accessible :title, :image_id, :caption, :link, :position

      acts_as_indexed :fields => [:title, :caption, :link]

      validates :title, :presence => true, :uniqueness => true

      belongs_to :image, :class_name => '::Refinery::Image'
    end
  end
end
