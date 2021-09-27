class UserController < ApplicationController
  before_action :authenticate_user!, only: %i(new edit update destroy)
  # 基本的に投稿関係（index意外）はこちらのコントローラを継承してください
  # class Users::HogesController < UserController

  # また、ログインしていない人を弾きたい場合等、user共通処理はここに記述してください
end
