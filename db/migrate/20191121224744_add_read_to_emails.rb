class AddReadToEmails < ActiveRecord::Migration[5.2]
  # On rajoute l'attribut 'read' (booléen) à la table 'emails'
  def change
    add_column :emails, :read, :boolean
  end
end
