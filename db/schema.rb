require File.expand_path("../config/database.rb", File.dirname(__FILE__))

class Schema < Database::Schema
  schema "User", {
    id: {
      type: "integer",
      null: false,
      primary_key: true,
    },
    email: {
      type: "text",
      null: false,
      unique: true,
    },
    first_name: {
      type: "text",
    },
    last_name: {
      type: "text",
    },
    password: {
      type: "text",
      null: false,
    },
  }

  schema "Todo", {
    id: {
      type: "integer",
      null: false,
      primary_key: true,
    },
    title: {
      type: "text",
    },
    due_to: {
      type: "text",
    },
    priority: {
      type: "text",
    },
    status: {
      type: "text",
    },
    user_id: {
      type: "integer",
      null: false,
      foreign_key: true,
      reference: "user",
    },
  # relations: {

  # }
  }
end
