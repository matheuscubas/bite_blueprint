# Restaurant Management API

[![Ruby Version](https://img.shields.io/badge/Ruby-3.4.2-red.svg)](https://www.ruby-lang.org/)
[![Rails Version](https://img.shields.io/badge/Rails-8.0.2-blue.svg)](https://rubyonrails.org/)

A RESTful API for managing restaurants with nested menus and menu items.

## Features

- 🏗️ **Hierarchical Data Structure**
    - Restaurants → Menus → Menu Items
- 🔍 **Comprehensive Querying**
    - Get all restaurants with nested menus/items
    - Get specific menus with their items
- ✨ **Batch Creation**
    - Create multiple restaurants with nested data in one request
- 📊 **Consistent JSON Representation**
    - Custom representers for standardized output

## API Endpoints

### Restaurants

| Method | Endpoint                 | Description                           |
|--------|--------------------------|---------------------------------------|
| GET    | `/api/v1/restaurant`     | List all restaurants with menus       |
| GET    | `/api/v1/restaurant/:id` | Get specific restaurant               |
| POST   | `/api/v1/restaurant`     | Create restaurant(s) with nested data |

### Menus

| Method | Endpoint           | Description                  |
|--------|--------------------|------------------------------|
| GET    | `/api/v1/menu`     | List all menus with items    |
| GET    | `/api/v1/menu/:id` | Get specific menu with items |

## Request/Response Examples

**Get All Restaurants:**

```http
GET /api/v1/restaurant

Response:
[
  {
    "id": 1,
    "name": "Gourmet Spot",
    "menus": [
      {
        "id": 1,
        "name": "Dinner",
        "menu_items": [
          {
            "id": 1,
            "name": "Filet Mignon",
            "price": 42.99
          }
        ]
      }
    ]
  }
]
```

**Create Restaurant:**

```http
POST /api/v1/restaurant
Content-Type: application/json

{
  "restaurants": [
    {
      "name": "New Bistro",
      "menus": [
        {
          "name": "Lunch",
          "menu_items": [
            {
              "name": "Salad",
              "price": 12.50
            }
          ]
        }
      ]
    }
  ]
}
```

**Get Specific Menu:**

```http
GET /api/v1/menu/1

Response:
{
  "id": 1,
  "name": "Lunch",
  "menu_items": [
    {
      "id": 1,
      "name": "Salad",
      "price": 12.50
    }
  ]
}
```

## Error Responses

**Not Found:**

```json
{
  "error": "No menu found please try again later"
}
```

**Validation Error:**

```json
{
  "error": ["Name can't be blank"],
  "message": "Restaurant details..."
}
```

## Development Setup

1. **Clone the repository**
    ```bash
    git clone git@github.com:matheuscubas/bite_blueprint.git
    cd bite_blueprint
    ```
2. **Install dependencies**
    ```bash
    bundle install 
    ```
3. **Database setup**
    ```bash
    rails db:create
    rails db:migrate 
    ```
4. **Run the server**
    ```bash
   rails s
    ```

## Testing

Run the test suite:

```bash
rails test
```

### Test coverage includes:

- Controller endpoints
- Model validations
- Service layer logic
- Error handling

## Architecture

    ```
    app/
    ├── controllers/
    │   ├── api/v1/
    │   │   ├── restaurant_controller.rb
    │   │   └── menu_controller.rb
    ├── models/
    │   ├── restaurant.rb
    │   ├── menu.rb
    │   └── menu_item.rb
    ├── services/
    │   └── create_restaurant_service.rb
    └── representers/
    ├── restaurant_representer.rb
    ├── menu_representer.rb
    └── menu_item_representer.rb
    ```
