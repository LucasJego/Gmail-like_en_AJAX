class TasksController < ApplicationController
before_action :authenticate_user!
  def new
    @categories = Category.all
  end

  def create
    @task = Task.new(task_params)
    @category = Category.find(category_params)
    @task.category = @category

    #if @task.save
    #  redirect_to root_path
    #  flash[:notice] = "Task created"
    #else
    #  redirect_to root_path
    #  flash[:notice] = "Please try again"
    #end

    
    # Si la nouvelle tâche est sauvegardée avec succès dans la BDD
    if @task.save
      # On affiche un message de réussite
      flash[:notice] = "Task created"
      # Réponse en fonction de si on est en HTML ou JS. "respond_to" permet d'aiguiller en fonction du format.
      respond_to do |format|
        # Si on est en HTML, on recharge la page (comme d'habitude)
        format.html {redirect_to root_path}
        # Si on est en JS, on ne met rien dans les '{}'. Rails sait qu'il doit exécuter le fichier "create.js.erb" qu'il cherchera dans le dossier "app/views/tasks"
        format.js { }
      end
    else
      flash[:notice] = "Please try again"
    end

    # Pour l'AJAX :
    # L'instruction 'respond_to' redirige vers un fichier
    # JS (on ne précise pas de quel fichier il s'agit, puisque
    # Rails sait automatiquement qu'il doit aller chercher
    # le fichier 'app/views/tasks/create.js.erb')
    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js { }
    end

  end

  def edit
    @task = Task.find(params[:id])
    @categories = Category.all

  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to tasks_path
    flash[:notice] = "Task edited"
  end

  def index
    @tasks = Task.all
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    # Une fois que la tâche est supprimée, l'appli renvoie sur la page d'accueil (root_path)
    redirect_to root_path


    # Pour utiliser AJAX :
    if @task.destroy
      # Affichage d'un message de succès
      flash[:notice] = "Tâche supprimée"

      respond_to do |format|
        format.html { redirect_to root_path }
        # Si on est en JS, on ne met rien dans les '{}'. Rails sait qu'il doit exécuter le fichier "destroy.js.erb" qu'il cherchera dans le dossier "app/views/tasks"
        format.js { }
      end
    else
      # Affichage d'un message d'erreur
      flash[:notice] = "La tâche n'a pas pu être supprimée."
    end
  end


  private

  def task_params
    params.permit(:title, :deadline, :description)
  end

  def category_params
    params.require(:Category)
  end

end
