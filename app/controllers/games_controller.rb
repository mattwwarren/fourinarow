class GamesController < ApplicationController
  # GET /games
  # GET /games.json
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # GET /games/1/join
  def join
    @game = Game.find(params[:id])
    current_session = request.session_options[:id]
    if check_session(@game.ponesession, current_session)
      unjoinable = true
    elsif @game.ptwosession.nil?
      joinable = true
    else
      @game.ptwosession = request.session_options[:id]
    end

    respond_to do |format|
      if unjoinable
        format.html { redirect_to @game, :notice => 'You cannot join the same user to a game!' }
        format.json { head :no_content }
      elsif ! joinable
        format.html { redirect_to @game, :notice => "A user already joined this game.  Perhaps you want to start your own?" }
        format.json { head :no_content }
      elsif @game.update_attributes(params[:game])
        format.html { redirect_to @game, :notice => 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "join" }
        format.json { render :json => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new({:board => [[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0]] }.merge(params[:game]))
    @game.ponesession = request.session_options[:id]

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, :notice => 'Game was successfully created.' }
        format.json { render :json => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.json { render :json => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, :notice => 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  # POST /games/1
  # POST /games/1.json
  def droppiece
   @game = Game.find(params[:id])
   @game.board[params[:row].to_i][params[:column].to_i] = params[:column].to_i

   respond_to do |format|
      @game.update_attributes(params[:board])
      format.html { redirect_to @game }
      format.json { head :no_content } 
    end
  end

  def check_session(current_session, stored_session)
    current_session == stored_session
  end
end
