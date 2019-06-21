class HomeController < ApplicationController
  before_action :forbid_login_user, {only: [:top]}

  def top
    # @users = User.all
    # ↑で渡したusersを <% @users.each do |user| %> で呼び出せばhtmlでも使える
    # 参考:Ruby 学習コース Ⅱ 「each文」→ https://prog-8.com/ruby/study/2/3#/7
  end

  def login
  end

  def create    
  end

  def about
  end

end
