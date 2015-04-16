class LikesController < ApplicationController

  before_action :set_like, only: :destroy

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(like_params)
    @like.user = current_user

    respond_to do |format|
      if @like.save
        format.js
      else
        # TODO: tratar erros na requisicao
        format.js
      end
    end
  end

  # DELETE /like/1
  # DELETE /like/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def set_like
      @like = Like.find(like_params[:id])
    end

    def like_params
      params.permit(:likeable_type, :likeable_id, :id)
    end
end
