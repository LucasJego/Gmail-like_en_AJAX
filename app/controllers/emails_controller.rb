class EmailsController < ApplicationController
  def index
  	@emails = Email.all
  end

  # Lorsque l'utilisateur clique sur le bouton "Créer un email" de la view "emails/index.html.erb", Rails éxécute la méthode "create" du controller "emails_controller".

  def create

  	# Création de l'email via Faker
  	@email = Email.new(object: Faker::Book.title,
											body: Faker::Book.title)
    
    # Si l'email a bien été sauvegardé,
  	if @email.save
  		# Un message s'affiche pour confirmer la création de l'email
  		flash[:notice] = "L'email a bien été créé."

  		respond_to do |format|
  			format.html { redirect_to root_path }
  			format.js { }
  		end

  	else
  		# Si l'email n'a pas pu être sauvegardé dans la BDD, un message d'erreur s'affiche
  		flash[:notice] = "Erreur. L'email n'a pas pu être créé."
  		# L'utilisateur est redirigé vers la page d'affichage des emails.
  		redirect_to root_path
  	end

  end


  def show
    @email = Email.find(params[:id])

    respond_to do |format|
    	format.html {redirect_to email_path(@email)}
    	format.js { }
    end
  end


  def destroy
    @email = Email.find(params[:id])


    @email.destroy

    respond_to do |format|
    	format.html { redirect_to root_path }
      format.js { }
    end
    

  end

end
