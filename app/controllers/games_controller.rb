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
    @game.ptwosession = request.session_options[:id]

    respond_to do |format|
      if @game.update_attributes(params[:game])
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

   _row = 0
   while @game.board[_row][params[:column].to_i] == 0
      _row += 1
      if _row == 6
         break
      end
   end
   @game.board[_row - 1][params[:column].to_i] = params[:player].to_i

   respond_to do |format|
      if _lookForWinner(_row, params[:column].to_i, params[:player].to_i)
        print "WINNER"
      end
      @game.update_attributes(params[:board])
      format.html { redirect_to @game }
      format.json { head :no_content } 
  end
end

   def _lookForWinner(_row, _col, _player)
      # Check four in a  row
      if _lookForRowWin(_row, _col, _player)
         return true
      # Check four in a column
      #elsif _lookForColWin(_row, _col, _player) 
      # Check four in left-right diagonal
      #elsif _lookForDiagWin(_row, _col, _player)
      else
         return false
      end
   end
   
   def _lookForRowWin(_row, _col, _player)
      _totalInRow = [7]
      _i = 0
      while _i <= 6
         _totalInRow[_i] = @game.board[_row][_i]
         _i += 1
      end
print _totalInRow
#There is something wrong in this part heoure..but some of it works 
      _j = 0
      _count = 0
      while _j <= 6
         if _totalInRow[_j] == _player
            _count += 1
         end
         if _count > 4
            return true
         end 
         _j += 1
      end
      return false
   end
end
