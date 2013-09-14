# Open the Refinery::Page model for manipulation
Refinery::Page.class_eval do

  # Whitelist the :link_id parameter for form submission
  attr_accessible :link_id

  # Add an association to the Refinery::Image class, so we
  # can take advantage of the magic that the class provides
  belongs_to :link, :class_name => '::Refinery::Image'

end
