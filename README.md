# DEMO 1: ict4g_places

        rails new unitn_places
        rails g scaffold user username:string name:string email:string
        rails g scaffold place name:string latitude:float longitude:float mark:integer
        rails g scaffold comment title:string content:text

* Place has_many comment


```ruby
# app/models/comment.rb
# ...
belongs_to :place
```

```ruby
# app/models/place.rb
# ...
has_many :comments
```

```ruby
# db/xxxx_create_comments.rb
# ...
t.integer :place_id
```

* Many to many between places and users

        app/models/place.rb
        ...
        has_and_belongs_to_many :users

        app/models/user.rb
        ...
        has_and_belongs_to_many :places

        db/migrate/xxxx_add_many_to_many_between_users_and_places.rb

        def change
          create_table :places_users, :id => false do |t|
            t.integer :place_id
            t.integer :user_id

            t.timestamps
          end
        end

        rake db:migrate

* adds authentication

        rails g migration adds_data_for_authentication_to user

        ...
        def up
          add_column :users, :crypted_password,  :string
          add_column :users, :password_salt,     :string
          add_column :users, :persistence_token, :string
        end

        def down
          remove_column :users, :crypted_password
          remove_column :users, :password_salt
          remove_column :users, :persistence_token
        end


        app/models/user_session.rb

        app/controller/user_sessions_controller.rb

        app/controller/application_controller.rb

        app/controller/users_controller.rb


NB. Radio buttons

    <% Place::MARKS.each do |m| %>
      <%= f.label m.to_s %>
      <%= f.radio_button :mark, m %>
    <% end %>



# DEMO 2: Books (not convered in the course)

1. Create an application

        rails new book_archive
        tree

2. Scaffold

        rails generate scaffold Book title:string description:text mark:integer
        tree

3. Explanation: migration

        rake db:migrate

4. Start the server

        rails server

* Explanation: routes
* Explanation: controller
* Explanation: model

* Explanation: console

        rails console


## Hacking the model (add validation):

        app/model/books.rb
        ...
        validates :title, :mark, :presence = true
        validates :mark, :presence => true, :inclusion => 1..5

## Hacking the controller (add search):

        app/controller/books_controller.rb
        ...
        search = params[:search_term]
        if params[:search_term]
          @books = Book.where("title LIKE ?", "%#{search}%")
        else
          @books = Book.all
        end

* REFACTORING

        app/models/book.rb
        def self.search(search_term)
          if search_term
            Book.where("title LIKE ?", "%#{search_term}%")
          else
            Book.all
          end
        end

        app/views/books/index.html.erb
        ...
        <%= form_tag books_url, :method => :get do %>
          <%= text_field_tag :search_term, params[:search_term]  %>
          <%= submit_tag "Search" %>
        <% end %>

## Hacking the views (add fancy css + rails_helper):

* set a good root page

        rm public/index.html

        config/routes.rb
        root :to => 'books#index'

* Add a custom css

  * Explain assets pipeline
  * Explain how to load custom css
  * Load fancy css

* Explain: partial

* Add a select_tag for marks

        app/views/books/_form.html.erb
        <%= f.select :mark, Book::MARKS %>

* REFACTORING

        app/model/book.rb
        MARKS = (1..5)

        validates :mark, :presence => true, :inclusion => MARKS

