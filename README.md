# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

*There are two milestones to this API Application, the application will have a React frontend:*

# Building the E-commerce App
* For this API, users should be able to:
- Create, read, update, and delete products.
- Receive form validations when trying to create/edit products.
- Add products to a shopping cart.
- Remove products from a shopping cart.
- Change the quantity of the items in the shopping cart.
- Apply a discount code to the shopping cart.
- Place an order.
- Receive an email confirmation after placing an order.



# Building the Product Feedback App
* For this API, users should be able to:

- Create, read, update, and delete product feedback requests.
- Receive form validations when trying to create/edit feedback requests.
- Sort suggestions by most/least upvotes and most/least comments.
- Filter suggestions by category
Add comments and replies to a product feedback request.
- Upvote product feedback requests

# Building the API
- For name spacing the API, we will be using the versioning strategy. This means that we will be creating a new version of the API every time we make a breaking change. For example, if we want to add a new field to the user model, we will create a new version of the API. This will allow us to maintain backwards compatibility with older versions of the API.
- We will be using the JSON API specification for our API. This means that we will be using the JSON API serializer gem to format our JSON responses. This will allow us to easily add relationships to our API responses.
- We will be using the Devise gem for authentication. This will allow us to easily add authentication to our API.
- We will be generating custom controllers for Devise. This will allow us to customize the behavior of the Devise controllers.
```rails g devise:controllers api/v1/users -c sessions registrations```
