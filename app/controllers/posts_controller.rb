class PostsController < ApplicationController
  # [:room, :new ...]みたいに増やせるよ
  before_action :authenticate_user, {except: [:room, :name, :search, :mov_room]}
  
  def room
    @post = Post.find_by(room_number: params[:id])
  end
  
  def new
    @post = Post.new
  end

  def room_edit
    @post = Post.find_by(room_number: params[:id])
  end

  def edit_row
    @post = Post.find_by(room_number: params[:id])
    i = params[:row].to_i
    if (params[:score_a].to_i + params[:score_b].to_i + params[:score_c].to_i + params[:score_d].to_i) == 100000
      scArray_a = @post.score_a.split(',')
      scArray_b = @post.score_b.split(',')
      scArray_c = @post.score_c.split(',')
      scArray_d = @post.score_d.split(',')
      
      scArray_a[i] = params[:score_a]
      scArray_b[i] = params[:score_b]
      scArray_c[i] = params[:score_c]
      scArray_d[i] = params[:score_d]
      @post.score_a = scArray_a.join(',')
      @post.score_b = scArray_b.join(',')
      @post.score_c = scArray_c.join(',')
      @post.score_d = scArray_d.join(',')
      

      priorityArray3 = @post.priority3.split(',')
      priorityArray2 = @post.priority2.split(',')
      priorityArray1 = @post.priority1.split(',')
      # 優先度3=東 a=0,b=1,c=2,d=3
      if params[:ton] == "tonA"
        priorityArray3[i] = "0"
      elsif params[:ton] == "tonB"
        priorityArray3[i] = "1"
      elsif params[:ton] == "tonC"
        priorityArray3[i] = "2"
      elsif params[:ton] == "tonD"
        priorityArray3[i] = "3"
      end
      # 優先度2=南 a=0,b=1,c=2,d=3
      if params[:nan] == "nanA"
        priorityArray2[i] = "0"
      elsif params[:nan] == "nanB"
        priorityArray2[i] = "1"
      elsif params[:nan] == "nanC"
        priorityArray2[i] = "2"
      elsif params[:nan] == "nanD"
        priorityArray2[i] = "3"
      end
      # 優先度1=西 a=0,b=1,c=2,d=3
      if params[:sya] == "syaA"
        priorityArray1[i] = "0"
      elsif params[:sya] == "syaB"
        priorityArray1[i] = "1"
      elsif params[:sya] == "syaC"
        priorityArray1[i] = "2"
      elsif params[:sya] == "syaD"
        priorityArray1[i] = "3"
      end
      @post.priority3 = priorityArray3.join(',')
      @post.priority2 = priorityArray2.join(',')
      @post.priority1 = priorityArray1.join(',')

      if @post.save
        flash[:notice] = "テーブルを更新しました"
        redirect_to("/room/#{@post.room_number}")
      else
        flash[:notice] = "テーブルの更新に失敗しました"
        redirect_to("/room/#{@post.room_number}/#{i}")
      end
    else
      flash[:notice] = "4人の点数の合計値が100000になるように、値を入力して下さい"
      redirect_to("/room/#{@post.room_number}/#{i}")
    end
  end
  
  def create
    @post = Post.new(
      room_number: params[:room_number],
      matches: "0",
      matches_a: "0",
      matches_b: "0",
      matches_c: "0",
      matches_d: "0",
      priority3: "",
      priority2: "",
      priority1: "",    
      uma: params[:uma],
      rate: params[:rate],
      buck: params[:buck],
      hako: "",
      tobi: "",
      yakitori: "",
      yakuman: "",
      finish: "false",
      rule: "",
      name_a: @current_user.name,
    )
    if @post.save
      flash[:notice] = "ルームを作成しました"
      redirect_to("/room/#{@post.room_number}")
    else
      render("posts/new")
    end
  end

  def name
    @post = Post.find_by(room_number: params[:number])
    @post.name_b = params[:name_b] if params[:name_b] != nil and params[:name_b] != ""
    @post.name_c = params[:name_c] if params[:name_c] != nil and params[:name_b] != ""
    @post.name_d = params[:name_d] if params[:name_d] != nil and params[:name_b] != ""

    # aのスコア格納
    if params[:score_a] != nil and params[:score_a] != "" and @post.score_a != nil
      @post.score_a = @post.score_a << "," << params[:score_a]
      @post.matches_a += 1
    elsif params[:score_a] != "" and params[:score_a] != nil
      @post.score_a = params[:score_a]
      @post.matches_a += 1
    end
    # bのスコア格納
    if params[:score_b] != nil and params[:score_b] != "" and @post.score_b != nil
      @post.score_b = @post.score_b << "," << params[:score_b]
      @post.matches_b += 1
    elsif params[:score_b] != "" and params[:score_b] != nil
      @post.score_b = params[:score_b]
      @post.matches_b += 1
    end
    # cのスコア格納
    if params[:score_c] != nil and params[:score_c] != "" and @post.score_c != nil
      @post.score_c = @post.score_c << "," << params[:score_c]
      @post.matches_c += 1
    elsif params[:score_c] != "" and params[:score_c] != nil
      @post.score_c = params[:score_c]
      @post.matches_c += 1
    end
    # dのスコア格納
    if params[:score_d] != nil and params[:score_d] != "" and @post.score_d != nil
      @post.score_d = @post.score_d << "," << params[:score_d]
      @post.matches_d += 1
    elsif params[:score_d] != "" and params[:score_d] != nil
      @post.score_d = params[:score_d]
      @post.matches_d += 1
    end

    scArray_a = @post.score_a.split(',') if @post.score_a != nil
    scArray_b = @post.score_b.split(',') if @post.score_b != nil
    scArray_c = @post.score_c.split(',') if @post.score_c != nil
    scArray_d = @post.score_d.split(',') if @post.score_d != nil
    beforeMatches = @post.matches
    # 全プレイヤーの値が入力されていた場合@post.matchesに1を足す(次の行へいく) && 3プレイヤーのデータが格納されていた場合、自動で補完し@post.matchesに1を足す
    if @post.matches_a == @post.matches_b and @post.matches_a == @post.matches_c and @post.matches_a == @post.matches_d and @post.matches_a > @post.matches
      # 全て入力されている
      @post.matches += 1
    elsif @post.matches_b > @post.matches and @post.matches_b == @post.matches_c and @post.matches_b == @post.matches_d and @post.matches_b != @post.matches_a
      # aが未入力
      if @post.matches_a == 0
        @post.score_a = (100000 - scArray_b[@post.matches].to_i - scArray_c[@post.matches].to_i - scArray_d[@post.matches].to_i).to_s
      else
        @post.score_a = @post.score_a << "," << (100000 - scArray_b[@post.matches].to_i - scArray_c[@post.matches].to_i - scArray_d[@post.matches].to_i).to_s
      end
      @post.matches_a += 1
      @post.matches += 1
    elsif @post.matches_a > @post.matches and @post.matches_a == @post.matches_c and @post.matches_a == @post.matches_d and @post.matches_a != @post.matches_b
      # bが未入力
      if @post.matches_b == 0
        @post.score_b = (100000 - scArray_a[@post.matches].to_i - scArray_c[@post.matches].to_i - scArray_d[@post.matches].to_i).to_s
      else
        @post.score_b = @post.score_b << "," << (100000 - scArray_a[@post.matches].to_i - scArray_c[@post.matches].to_i - scArray_d[@post.matches].to_i).to_s
      end
      @post.matches_b += 1
      @post.matches += 1
    elsif @post.matches_a > @post.matches and @post.matches_a == @post.matches_b and @post.matches_a == @post.matches_d and @post.matches_a != @post.matches_c
      # cが未入力
      if @post.matches_c == 0
        @post.score_c = (100000 - scArray_a[@post.matches].to_i - scArray_b[@post.matches].to_i - scArray_d[@post.matches].to_i).to_s
      else
        @post.score_c = @post.score_c << "," << (100000 - scArray_a[@post.matches].to_i - scArray_b[@post.matches].to_i - scArray_d[@post.matches].to_i).to_s
      end
      @post.matches_c += 1
      @post.matches += 1
    elsif @post.matches_a > @post.matches and @post.matches_a == @post.matches_b and @post.matches_a == @post.matches_c and @post.matches_a != @post.matches_d
      # dが未入力
      if @post.matches_d == 0
        @post.score_d = (100000 - scArray_a[@post.matches].to_i - scArray_b[@post.matches].to_i - scArray_c[@post.matches].to_i).to_s
      else
        @post.score_d = @post.score_d << "," << (100000 - scArray_a[@post.matches].to_i - scArray_b[@post.matches].to_i - scArray_c[@post.matches].to_i).to_s
      end
      @post.matches_d += 1
      @post.matches += 1
    end

    # @post.matches が更新されている場合のみ東西南を反映
    if beforeMatches != @post.matches
      # 優先度3=東 a=0,b=1,c=2,d=3
      if params[:ton] == "tonA"
        if @post.priority3 == ""
          @post.priority3 = "0"
        else
          @post.priority3 = @post.priority3 << ",0"
        end
      elsif params[:ton] == "tonB"
        if @post.priority3 == ""
          @post.priority3 = "1"
        else
          @post.priority3 = @post.priority3 << ",1"
        end
      elsif params[:ton] == "tonC"
        if @post.priority3 == ""
          @post.priority3 = "2"
        else
          @post.priority3 = @post.priority3 << ",2"
        end
      elsif params[:ton] == "tonD"
        if @post.priority3 == ""
          @post.priority3 = "3"
        else
          @post.priority3 = @post.priority3 << ",3"
        end
      end

      # 優先度2=南 a=0,b=1,c=2,d=3
      if params[:nan] == "nanA"
        if @post.priority2 == ""
          @post.priority2 = "0"
        else
          @post.priority2 = @post.priority2 << ",0"
        end
      elsif params[:nan] == "nanB"
        if @post.priority2 == ""
          @post.priority2 = "1"
        else
          @post.priority2 = @post.priority2 << ",1"
        end
      elsif params[:nan] == "nanC"
        if @post.priority2 == ""
          @post.priority2 = "2"
        else
          @post.priority2 = @post.priority2 << ",2"
        end
      elsif params[:nan] == "nanD"
        if @post.priority2 == ""
          @post.priority2 = "3"
        else
          @post.priority2 = @post.priority2 << ",3"
        end
      end

      # 優先度1=西 a=0,b=1,c=2,d=3
      if params[:sya] == "syaA"
        if @post.priority1 == ""
          @post.priority1 = "0"
        else
          @post.priority1 = @post.priority1 << ",0"
        end
      elsif params[:sya] == "syaB"
        if @post.priority1 == ""
          @post.priority1 = "1"
        else
          @post.priority1 = @post.priority1 << ",1"
        end
      elsif params[:sya] == "syaC"
        if @post.priority1 == ""
          @post.priority1 = "2"
        else
          @post.priority1 = @post.priority1 << ",2"
        end
      elsif params[:sya] == "syaD"
        if @post.priority1 == ""
          @post.priority1 = "3"
        else
          @post.priority1 = @post.priority1 << ",3"
        end
      end
    end

    if @post.save
      flash[:notice] = "テーブルを更新しました"
      redirect_to("/room/#{@post.room_number}")
    else
      render("posts/edit")
    end
  end

  def search

  end

  def mov_room
    @post = Post.find_by(room_number: params[:room_number])
    if @post != nil
      redirect_to("/room/#{params[:room_number]}")
    else
      flash[:notice] = "そのルーム番号のルームは作成されていません"
      redirect_to("/room/search")
    end
  end

  def join
    @post = Post.find_by(room_number: params[:room_number])
    if params[:place] == "b"
      @post.name_b = @current_user.name
    elsif params[:place] == "c"
      @post.name_c = @current_user.name
    elsif params[:place] == "d"
      @post.name_d = @current_user.name
    end
    if @post.save
      flash[:notice] = "参加しました"
      redirect_to("/room/#{@post.room_number}")
    else
      flash[:notice] = "参加に失敗しました"
      redirect_to("/room/#{@post.room_number}")
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "削除しました"
    redirect_to("/posts/index")
  end
  
end
