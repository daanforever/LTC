class HomeController < ApplicationController
  def index
    @categories = Category.all
    @servers = Server.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

end
