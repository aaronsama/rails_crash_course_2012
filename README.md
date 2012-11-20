# DEMO 1

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


# DEMO 2