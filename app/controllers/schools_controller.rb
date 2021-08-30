class SchoolsController < ApplicationController
  def show
    @school = School.find(params[:id])
  end
  
  def edit
    @school = School.find(params[:id])
  end
  
  def update
    school = School.find(params[:id])
    school.update(update_params) if current_school.id == school.id
    redirect_to action: :show, id: school.id
  end
  
  private
  def update_params
    params.require(:school).permit(:name, :seats)
  end
end
