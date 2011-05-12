class ServersController < ApplicationController

  # GET /servers
  # GET /servers.xml
  def index
    @servers = Server.all
    #@category = Category.find(params[:category_id])
    respond_to do |format|
        format.html # show.html.erb
        format.js   { render :layout => false }
        format.xml  { render :xml => @server }
    end
  end

  # GET /servers/1
  # GET /servers/1.xml
  def show
    @server = Server.find(params[:id])
    respond_to do |format|
        format.html # show.html.erb
        format.js   { render :layout => false }
        format.xml  { render :xml => @server }
    end
  end

  # GET /servers/new
  # GET /servers/new.xml
  def new
    @category = Category.find(params[:category_id])
    @server = @category.servers.build
    respond_to do |format|
        format.html # show.html.erb
        format.js   { render :layout => false }
        format.xml  { render :xml => @server }
    end
  end

  # GET /servers/1/edit
  def edit
    @server = Server.find(params[:id])
    respond_to do |format|
        format.html # show.html.erb
        format.js   { render :layout => false }
        format.xml  { render :xml => @server }
    end
  end

  def check
    @category = Category.find(params[:id])
    @server = @category.servers.build(params[:server])
    @status = Hash.new
    try_server_status
    try_status
    try_nginx_status
    respond_to do |format|
        format.html { render :layout => true  }
        format.js   { render :layout => false }
        format.xml  { render :xml => @server, :status => :created, :location => @server }
    end
  end

  # POST /servers
  # POST /servers.xml
  def create
    @category = Category.find(params[:category_id])
    @server = @category.servers.build(params[:server])

    respond_to do |format|
      if @server.save
        flash[:notice] = 'Server was successfully created.'
        format.html { render :layout => true  }
        format.js   { render :layout => false }
        format.xml  { render :xml => @server, :status => :created, :location => @server }
      else
        format.html { render :action => "new" }
        format.js   { render :layout => false }
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
        format.js   { render :layout => false }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js   { render :layout => false }
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
    require 'open-uri'

    @status = Hash.new
    @error = 1
    @server = Server.find(params[:id])
    flash[:notice] = ''

    try_server_status
    try_status
    try_nginx_status

    respond_to do |format|
        format.html # show.html.erb
        format.js   { render :layout => false }
        format.xml  { render :xml => @server }
    end
  end

  def try_server_status
    begin
        timeout(2) do
            require 'nokogiri'
            @error = 0
            flash[:notice] = ''
            doc = Nokogiri::HTML(open("http://#{@server.address}/server-status/"))
            begin
                @status["apache"] = doc.css('dt').last.text.split(/\D+/)
            rescue
                @status["apache"] = doc.xpath("//text()")[12].text.strip.split(/\D+/)
            end
        end
    rescue Timeout::Error
        @error = 1
        flash[:notice] = flash[:notice] + "<b>http://#{@server.address}/server-status/: </b>Timeout::Error<br/>"
    rescue Exception => exc
        @error = 1
        flash[:notice] = flash[:notice] + "<b>http://#{@server.address}/server-status/: </b>" + exc.message + "<br/>"
    end
    return @error
  end

  def try_status
    if @status.empty?
    begin
        timeout(2) do
            @status["nginx"] = open("http://#{@server.address}/status/"){|f| f.read.split(/\D+/)}[-3,3]
            @error = 0
            flash[:notice] = ''
        end
    rescue Timeout::Error
        @error = 1
        flash[:notice] = flash[:notice] + "<b>http://#{@server.address}/status/: </b>Timeout::Error<br/>"
    rescue Exception => exc
        @error = 1
        flash[:notice] = flash[:notice] + "<b>http://#{@server.address}/status/: </b>" + exc.message + "<br/>"
    end
    end
    return @error
  end

  def try_nginx_status
    if @status.empty?
    begin
        timeout(2) do
            @status["nginx"] = open("http://#{@server.address}/nginx_status/"){|f| f.read.split(/\D+/)}[-3,3]
            @error = 0
            flash[:notice] = ''
        end
    rescue Timeout::Error
        @error = 1
        flash[:notice] = flash[:notice] + "<b>http://#{@server.address}/nginx_status/: </b>Timeout::Error<br/>"
    rescue Exception => exc
        @error = 1
        flash[:notice] = flash[:notice] + "<b>http://#{@server.address}/nginx_status/: </b>" + exc.message + "<br/>"
    end
    end
    return @error
  end

  private
  def respond

  end

end
