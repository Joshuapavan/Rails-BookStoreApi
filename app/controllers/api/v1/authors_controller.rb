class Api::V1::AuthorsController < ApplicationController
  before_action :set_author, only: [ :show, :update, :destroy ]

  # GET /authors
  def index
    @authors = Author.all

    render json:{
      message: "Successfully rendered all the authors.",
      authors: @authors
    }, status: :ok
  end

  # GET /authors/1
  def show
    render json:{
      message: "Successfully rendered author with id #{params[:id]}",
      author: @author
    }, status: :ok
  end

  # POST /authors
  def create
    @author = Author.new(author_params)

    if @author.save
      render json:{
        message: "Created an author with id #{@author.id}",
        author: @author
      }, status: :created
    else
      render json:{
        message: "Error while creating author",
        error: @author.errors
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /authors/1
  def update
    if @author.update(author_params)
      render json: {
        message: "Updated author.",
        author: @author
      }, status: :ok
    else
      render json:{
        message: "Error while updating the author",
        error: @author.errors,
        author: @author
      }, status: :unprocessable_entity
    end
  end

  # DELETE /authors/1
  def destroy
    if @author.destroy!
      render json:{
        message: "Deleted author with id #{params[:id]}"
      }, status: :ok
    else
      render json:{
        message: "Unable to delete the author."
        error: @author.errors
      }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:first_name, :last_name, :age)
    end
end
