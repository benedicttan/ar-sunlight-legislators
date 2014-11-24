class CreateCongressMembers < ActiveRecord::Migration
  def change
    create_table :congress_members do |t|
      t.belongs_to :state
      t.belongs_to :title
      t.belongs_to :party

    # columns_we_need = ["title","firstname","middlename","lastname","party","state","in_office","gender","phone","fax","website","webform","twitter_id","birthdate"]

      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :in_office
      t.string :gender
      t.string :phone
      t.string :fax
      t.string :website
      t.string :webform
      t.string :twitter_id
      t.string :birthdate
      t.timestamps
    end

    create_table :states do |t|
      t.string :name
    end

    create_table :titles do |t|
      t.string :name
    end

    create_table :parties do |t|
      t.string :name
    end

    create_table :tweets do |t|
      t.belongs_to :congress_member
      t.string     :text
      t.integer    :twitter_id
    end

  end

end