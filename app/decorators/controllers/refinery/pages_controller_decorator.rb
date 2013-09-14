Refinery::PagesController.class_eval do
    # your controller logic goes here
    before_filter :sort_image_names, :only => [:show]

    protected

	def sort_image_names
	  if ( /photo_gallery_child/ =~ @page.view_template)
	  ## make sure that the images start with the respective year,
	  ##   then this logic will populate the correct subdivisions	    

	    @images_2013 = Array.new
	    @page.images.each do |image|
	      if (/^2013/) =~ image.image_name
	        @images_2013 << image
	      end
	    end
	    
	    @images_2012 = Array.new
	    @page.images.each do |image|
	      if (/^2012/) =~ image.image_name
	        @images_2012 << image
	      end
	    end
	    
	    @images_2011 = Array.new
	    @page.images.each do |image|
	      if (/^2011/) =~ image.image_name
	        @images_2011 << image
	      end
	    end

	  end
	end    

  end

