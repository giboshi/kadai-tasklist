class Tasklist2sController < ApplicationController
    def index
        @tasklists = Tasklist2.all
    end
    
    def show
        @tasklist = Tasklist2.find(params[:id])
    end
    
    def new
        @tasklist = Tasklist2.new
    end
    
    def create
        @tasklist = Tasklist2.new(tasklist_params)
        if @tasklist.save
            flash[:success] = 'Taskが正常に投稿されました'
            redirect_to @tasklist
        else
            flash.now[:danger] = 'Taskが正常に投稿されませんでした'
            render :new
        end
    end
    
    def edit
        @tasklist = Tasklist2.find(params[:id])
    end
    
    def update
        @tasklist = Tasklist2.find(params[:id])
        if @tasklist.update(tasklist_params)
            flash[:success] = 'Taskが正常に投稿されました'
            redirect_to @tasklist
        else
            flash.now[:danger] = 'Taskが正常に投稿されませんでした'
            render :edit
        end
        
    end
    
    def destroy
        @tasklist = Tasklist2.find(params[:id])
        @tasklist.destroy
        
        flash[:success] = 'Taskが正常に削除されました'
        redirect_to tasklist2s_url
    end
end

def tasklist_params
    params.require(:tasklist2).permit(:content)
end