class NewsController < ApplicationController
  def index

    @title="Latest News"
  	news= News.all
    par=params[:search]
    if(par)
     if(par[:city])
      news=News.find(:all,:conditions=>{:city_id=>par[:city]})

     end
      if(par[:category])
      
      news=News.find(:all,:conditions=>{:category_id=>par[:category]})

     end
   end

  @news=news
  end

  def search

  end

  def tag

      tag=params[:tag]
      par=params[:search]
      tag=Tag.find_by_name(tag)
      @title="#{tag.name} News"

      news=tag.news
       if(par)
        if(par[:city])
         news=News.find(:all,:conditions=>{:city_id=>par[:city]})

         end
         if(par[:category])
          
         news=News.find(:all,:conditions=>{:category_id=>par[:category]})

        end
      end
      @news=news
     render "index.html.erb"


  end

  def city

    id=params[:id]
    conditions={:city_id=>id}
    city=City.find(id)
    @title="#{city.name} News"

    par=params[:search]
    if(par)
      if(par[:category])
        conditions[:category_id]=par[:category]

      end
    end

    @news=News.find(:all,:conditions=>conditions)
    render "index.html.erb"

  end
  def category
    id=params[:id]
    conditions={:category_id=>id}
    category=Category.find(id)
    @title="#{category.name} News"

    par=params[:search]
    if(par)
      if(par[:category])
        conditions[:city_id]=par[:city]

      end
    end

    @news=News.find(:all,:conditions=>conditions)
    render "index.html.erb"

  end
end