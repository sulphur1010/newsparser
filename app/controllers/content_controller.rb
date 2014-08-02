class ContentController < ApplicationController

  def index

  end
  def about
  end

  def country
  	render inline: "<%=request.ip%> <%=request.location.country%> Country_id <%=Country.find_by_name(request.location.country).id%>"
  end

  def test
    news=News.first
    @tags=news.create_tags
    render json: @tags
  end

end

