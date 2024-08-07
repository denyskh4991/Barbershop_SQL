# Barbershop_SQL

The BarberShop database stores information about barbers, clients, services, schedules, feedback, and appointments and consists of the appropriate tables.
 
  Key Indices
  
    Barbers - index on email
    Clients - index on phone_number
    BarberSchedule - index on Id, Id_Barber
    Feedback - index on Id, Id_Client, Id_Barber
    Appointments - index on Id, Id_Client, Id_Barber, appointment_date, filtered indices for recent dates and good ratings
    
  Queries
  
    Appointments Info - retrieves details of all appointments with client, barber, and service info.
    Client Feedback - retrieves feedback about barbers.
    Barber Schedule - retrieves barber schedules.
  
The database is optimized with various indices for efficient querying.
