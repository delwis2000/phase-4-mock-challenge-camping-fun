class ActivitiesController < ApplicationController

     #GET#
     def index
        activities = Activity.all  
        render json: activities, statut: :ok
     end

    # def show
    #     activity = Activity.find_by(id:params[:id])
    #     if activity
    #         render json: activity
    #     else     
    #         render json: {error: "Activity not found"}, status: :not_found
    #     end
    # end

    #DELETE
    def destroy
    activity = Activity.find_by!(id: params[:id])
    if activity 
      activity.destroy
      head :no_content #alternative => render json: {}, status: :no content
    else
      render json: { error: "Activity not found" }, status: :not_found

    end
    end
    # private, we need to do the params 
    private
    def activity_params
    params.permit(:name, :difficulty)
    end
end
