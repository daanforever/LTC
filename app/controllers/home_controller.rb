class HomeController < ApplicationController
  def index
    @categories = Category.all
        if @categories.empty? 
            Category.new(:name => "Welcome").save
            @categories = Category.all
        end
    @servers = Server.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

end
