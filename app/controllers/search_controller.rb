class SearchController < ApplicationController

  def edit
    @genres = Genre.all
  end


  def search
    @value = params["search"]["value"]         #データを代入
    @how = params["search"]["how"]             #データを代入
    @articles = search_for(@how, @value)          #def search_forを実行(引数に検索ワードと検索方法)
  end

  def filter
    @articles = Article.where(genre_id: params["search"]["genre"])
    render action: :search
  end

  private

  def match(value)
    #.orを使用することで、valueに一致するカラムのデータをnameカラムとgenre_idカラムから探してきます。
    user_ids = User.where("name", value).pluck('id')
    Article.where(user_id: user_ids)
  end

  def forward(value)                              #forward以降は投稿検索の定義しかしてません。
    user_ids = User.where("name LIKE ?", "#{value}%").pluck('id')
    Article.where(user_id: user_ids)
  end

  def backward(value)
    user_ids = User.where("name LIKE ?", "%#{value}").pluck('id')
    Article.where(user_id: user_ids)
  end

  def partical(value)
    user_ids = User.where("name LIKE ?", "%#{value}%").pluck('id')
    Article.where(user_id: user_ids)
  end


  def search_for(how, value)
    case how                     #引数のhowと一致する処理に進むように定義しています。
    when 'match'                 #ジャンル検索の場合はmatchで固定してるので、必ず'match'の処理に進みます。
      match(value)
    when 'forward'
      forward(value)
    when 'backward'
      backward(value)
    when 'partical'
      partical(value)
    end
  end



  # def search
  #   # @articles = @genre.articles
  #   @model = params["search"]["model"]             #選択したmodelを@modelに代入
  #   @value = params["search"]["value"]             #検索にかけた文字列valueを@valueに代入
  #   @how = params["search"]["how"]                 #選択した検索方法howを@howに代入
  #   @datas = search_for(@how, @model, @value)      #search_forの引数にインスタンス変数を定義
  # end                                              #@datasに最終的な検索結果が入る

  # private

  # def match(model, value)                     #def search_forでhowがmatchだった場合の処理
  #   if model == 'user'                        #modelがuserの場合の処理
  #     User.where(name: value)                 #whereでvalueと完全一致するnameを探す
  #   elsif model == 'genre'
  #     Genre.where(name: value)
  #   elsif model == 'season'
  #     Tag.where(name: value)
  #   end
  # end

  # def forward(model, value)
  #   if model == 'user'
  #     User.where("name LIKE ?", "#{value}%")     #前方一致    モデル名.where("カラム名 LIKE ?", "値%")
  #   elsif model == 'genre'
  #     Genre.where("name LIKE ?", "#{value}%")
  #   elsif model == 'tag'
  #     Tag.where("name LIKE ?", "#{value}%")
  #   end
  # end

  # def backward(model, value)
  #   if model == 'user'
  #     User.where("name LIKE ?", "%#{value}")     #後方一致    モデル名.where("カラム名 LIKE ?", "%値")
  #   elsif model == 'genre'
  #     Genre.where("name LIKE ?", "%#{value}")
  #   elsif model == 'tag'
  #     Tag.where("name LIKE ?", "%#{value}")
  #   end
  # end

  # def partical(model, value)
  #   if model == 'user'
  #     User.where("name LIKE ?", "%#{value}%")    #部分一致    モデル名.where("カラム名 LIKE ?", "%値%")
  #   elsif model == 'genre'
  #     Genre.where("name LIKE ?", "%#{value}%")
  #   elsif model == 'season'
  #     Tag.where("name LIKE ?", "%#{value}%")
  #   end
  # end

  # def search_for(how, model, value)       #searchアクションで定義した情報が引数に入っている
  #   case how                              #検索方法のhowの中身がどれなのかwhenの条件分岐の中から探す処理
  #   when 'match'
  #     match(model, value)                 #検索方法の引数に(model, value)を定義している
  #   when 'forward'                        #例えばhowがmatchの場合は def match の処理に進む
  #     forward(model, value)
  #   when 'backward'
  #     backward(model, value)
  #   when 'partical'
  #     partical(model, value)
  #   end
  # end

end
