class StoriesController < ApplicationController

    def index
        stories = Story.all
        render json: stories
    end

    def show
        if (story = Story.find_by(title: params[:title]))
            render json: story
        else
            render json: {message: "Story not found"}
        end
    end



    private 

    def story_params 

    end

end
