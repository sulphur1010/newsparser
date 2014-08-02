module ApplicationHelper
  def parent_layout(layout)
    @view_flow.set(:layout, self.output_buffer)
    self.output_buffer = render(:file => layout)
  end

  def isValidUrl(url)
  	regex=/(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  	if regex.match(url)
  		true
  	else
  		false
  	end
  end
  
end
