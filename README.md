# DEMO 1: ict4g_places

1. Create an application

```
rails new ict4g_places
```

2. Scaffold

```
rails generate scaffold Place name:string mark:integer latitude:float longitude:float
```

3. Explanation: migration

```
rake db:migrate
```

4. Start the server

```
rails server
```

* Explanation: routes
* Explanation: controller
* Explanation: model

* Explanation: console

```
rails console
```

## Hacking the model (add validation):

```ruby
# app/model/place.rb
# ...
MARKS = (1..5)
validates :name, :presence = true
validates :mark, :presence => true, :inclusion => MARKS
```

## Hacking the controller (add search):

```ruby
# app/controller/places_controller.rb
# ...
search = params[:search_term]
  if search
    @places = Place.where("name LIKE ?", "%#{search}%")
  else
    @places = Place.all
end
```

* REFACTORING

```ruby
# app/models/place.rb

def self.search(search_term)
  if search_term.blank? # nil or ""
    self.all
  else
    self.where("name LIKE ?", "%#{search_term}%")
  end
end
```

```erb
# app/views/places/index.html.erb
# ...
<%= form_tag places_url, :method => :get do %>
  <%= text_field_tag :search_term, params[:search_term]  %>
  <%= submit_tag "Search" %>
<% end %>
```

## Hacking the views (add fancy css + rails_helper):

* set a good root page

```
rm public/index.html
```

```ruby
# config/routes.rb
root :to => 'places#index'
```

* Add a custom css

  * Load fancy css (see https://gist.github.com/4130176) or...
  * Twitter Bootstrap

```ruby
# Gemfile
# ...
gem 'twitter-bootstrap-rails'
```

```
rm app/assets/stylesheets/scaffold.css.scss
# edit application.html
rails g bootstrap:install
rails g bootstrap:layout application fixed
rails g bootstrap:themed places
```

```css
body { padding-top: 60px; }
```

* Explain: partial

* Form_helper: Add a select_tag for marks

```erb
# app/views/books/_form.html.erb
<%= f.select :mark, Book::MARKS %>
```

* An alternative: create radio buttons:

```erb
<% Place::MARKS.each do |m| %>
  <%= f.label m.to_s %>
  <%= f.radio_button :mark, m %>
<% end %>
```

* Place has_many comment

```
rails g scaffold comment title:string content:text
```

```
rm app/assets/stylesheets/scaffold.css.scss
```

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

```
rake db:migrate
```

```
rails g bootstrap:themed comments
```

```erb
# app/views/places/index.html.erb
# ...
<%= link_to "Add a comment", new_comment_url(:place_id => place.id) %>
```

```ruby
# app/controller/comments_controller.rb
# ...
def new
  @place = Place.find(params[:place_id])
  @comment = @place.comments.new

  respond_to do |format|
    format.html # new.html.erb
    format.json { render json: @comment }
  end
end

#...
def edit
  @comment = Comment.find(params[:id])
  @place = @comment.place
end

#...
def create
  @place = Place.find(params[:comment][:place_id])
  @comment = @place.comments.new(params[:comment])

  respond_to do |format|
    if @comment.save
      format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
      format.json { render json: @comment, status: :created, location: @comment }
    else
      format.html { render action: "new" }
      format.json { render json: @comment.errors, status: :unprocessable_entity }
    end
end
```


```ruby
# app/model/comment.rb
attr_accessible :content, :title, :place_id
```

```erb
# app/views/comments/_form.html.erb
<%= f.hidden_field :place_id, :value => @place.id %>
```


```html+erb
# app/views/place/show.html.erb
<hr/>
<h3>This place has <%= @place.comments.size %> comments</h3>
<% @place.comments.each do |comment| %>
  <b><%= comment.title %></b>
  <%= comment.content %>
  <hr/>
<% end %>

