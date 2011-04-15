class ServersController < ApplicationController
  # GET /servers
  # GET /servers.xml
  def index
    @servers = Server.all
    #@category = Category.find(params[:category_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @servers }
    end
  end

  # GET /servers/1
  # GET /servers/1.xml
  def show
    @server = Server.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @server }
    end
  end

  # GET /servers/new
  # GET /servers/new.xml
  def new
    #@server = Server.new
    @category = Category.find(params[:category_id])
    @server = @category.servers.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @server }
    end
  end

  # GET /servers/1/edit
  def edit
    @server = Server.find(params[:id])
  end

  # POST /servers
  # POST /servers.xml
  def create
    #@server = Server.new(params[:server])
    @category = Category.find(params[:category_id])
    @server = @category.servers.build(params[:server])

    respond_to do |format|
      if @server.save
        flash[:notice] = 'Server was successfully created.'
        format.html { redirect_to(@server) }
        format.xml  { render :xml => @server, :status => :created, :location => @server }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @server.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /servers/1
  # PUT /servers/1.xml
  def update
    @server = Server.find(params[:id])

    respond_to do |format|
      if @server.update_attributes(params[:server])
        flash[:notice] = 'Server was successfully updated.'
        format.html { redirect_to(@server) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @server.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.xml
  def destroy
    @server = Server.find(params[:id])
    @server.destroy

    respond_to do |format|
      format.html { redirect_to(servers_url) }
      format.xml  { head :ok }
    end
  end

  def status
    require 'nokogiri'
    require 'open-uri'

    @error = 0
    @status = Hash.new
    @server = Server.find(params[:id])

    # TODO: make flash clean via filter
    flash[:notice] = ''

    begin
        timeout(2) do
            doc = Nokogiri::HTML(open("http://#{@server.name}/server-status"))
            @status["apache"] = doc.css('dt').last.text.split(/\D+/)
        end
    rescue Timeout::Error
            @error = 1
            flash[:notice] = 'Timeout::Error'
    rescue 
        begin
            timeout(2) do
                @status["nginx"] = open("http://#{@server.name}/status"){|f| f.read.split(/\D+/)}[-3,3]
            end
        rescue Timeout::Error
            @error = 1
            flash[:notice] = 'Timeout::Error'
        rescue Exception => exc
            @error = 1
            flash[:notice] = exc.message
        end
    end

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @server }
    end
  end

end
