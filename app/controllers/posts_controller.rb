# frozen_string_literal: true

# Handles viewing, updating and deleting Posts
#
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :ensure_frame_response, only: %i[new edit]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend('posts',
            partial: 'posts/post', locals: { post: @post })
        end
        format.html do
          redirect_to post_url(@post), notice: 'Post was successfully created.'
        end
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    respond_to do |format|
      if @post.update(post_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@post,
            partial: 'posts/post', locals: { post: @post })
        end
        format.html do
          redirect_to post_url(@post), notice: 'Post was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html do
        redirect_to posts_url, notice: 'Post was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body)
  end

  # Callback respond only to a turbo_frame
  def ensure_frame_response
    return unless Rails.env.development?

    redirect_to root_path unless turbo_frame_request?
  end
end
