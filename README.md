# Barbershop_SQL

The BarberShop database stores information about barbers, clients, services, schedules, feedback, and appointments. It consists of the following tables:

  Barbers

    Id, FirstName, LastName, gender, phone_number, email, birth_date, hire_date, position

  Services

    Id, service_name, price, duration_minutes

  Clients

    Id, FirstName, LastName, phone_number, email
    
  BarberSchedule

    Id, Id_Barber, available_date, available_from, available_to

  Feedback

    Id, Id_Client, Id_Barber, rating, feedback_text, feedback_date
    
  Appointments

    Id, Id_Client, Id_Barber, Id_Service, appointment_date, total_price, Id_Feedback

    
Key Indices

  Barbers: Index on email
  Clients: Index on phone_number
  BarberSchedule: Index on Id, Id_Barber
  Feedback: Index on Id, Id_Client, Id_Barber
  Appointments: Index on Id, Id_Client, Id_Barber, appointment_date, filtered indices for recent dates and good ratings
  
Queries

  Appointments Info: Retrieves details of all appointments with client, barber, and service info.
  Client Feedback: Retrieves feedback about barbers.
  Barber Schedule: Retrieves barber schedules.

The database is optimized with various indices for efficient querying.
