# University Option Database

This project is designed to manage and provide information about universities, their degrees, application steps, programs, requirements, and career options. It utilizes Supabase as the backend database solution.

## Project Structure

The project is organized into several directories, each serving a specific purpose:

- **migrations/**: Contains SQL migration files to create the necessary tables in the database.
  - `001_create_universities.sql`: Creates the universities table.
  - `002_create_degrees.sql`: Creates the degrees table.
  - `003_create_application_steps.sql`: Creates the application_steps table.
  - `004_create_programs.sql`: Creates the programs table.
  - `005_create_requirements.sql`: Creates the requirements table.
  - `006_create_career_options.sql`: Creates the career_options table.

- **schema/**: Contains SQL files that define the schema for each table, including data types and constraints.
  - `universities.sql`: Schema definition for the universities table.
  - `degrees.sql`: Schema definition for the degrees table.
  - `application_steps.sql`: Schema definition for the application_steps table.
  - `programs.sql`: Schema definition for the programs table.
  - `requirements.sql`: Schema definition for the requirements table.
  - `career_options.sql`: Schema definition for the career_options table.

- **seed/**: Contains SQL commands to insert sample data into the database for testing purposes.
  - `sample_data.sql`: Sample data for the database tables.

- **functions/**: Contains SQL functions for database operations.
  - `get_university_with_relations.sql`: Function to retrieve university data along with related degrees, application steps, and programs.
  - `search_universities.sql`: Function to search for universities based on specific criteria.

- **supabase/**: Contains configuration settings for connecting to the Supabase database.
  - `config.json`: Configuration file with API keys and project URL.

## Setup Instructions

1. **Clone the Repository**: Clone this repository to your local machine.
2. **Install Supabase CLI**: Ensure you have the Supabase CLI installed to manage your database.
3. **Run Migrations**: Execute the migration files in the `migrations/` directory to create the necessary tables in your Supabase database.
4. **Seed Database**: Run the `seed/sample_data.sql` file to populate the database with sample data.
5. **Configure Supabase**: Update the `supabase/config.json` file with your Supabase project URL and API keys.

## Usage Examples

- To retrieve a university along with its related degrees and application steps, use the `get_university_with_relations.sql` function.
- To search for universities based on specific criteria, utilize the `search_universities.sql` function.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.