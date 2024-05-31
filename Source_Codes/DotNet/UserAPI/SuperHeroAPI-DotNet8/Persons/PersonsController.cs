using Microsoft.AspNetCore.Mvc;
using System;
using System.Data.SqlClient;
using System.Net;

[Route("api/[controller]")]
[ApiController]
public class PersonsController : ControllerBase
{
    private readonly string _connectionString = "Server=localhost;Database=PERSONS;Trusted_Connection=true;TrustServerCertificate=true;";

    [HttpPost]
    public IActionResult Post([FromBody] Person person)
    {
        try
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                string sql = "INSERT INTO Persons (NameSurname, PhoneNumber, Email) VALUES (@Name_Surname, @Phone_Number, @E_mail)";

                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@NameSurname", person.NameSurname);
                    command.Parameters.AddWithValue("@PhoneNumber", person.PhoneNumber);
                    command.Parameters.AddWithValue("@Email", person.Email);

                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        return Ok("Person data received and added to database successfully");
                    }
                    else
                    {
                        return StatusCode((int)HttpStatusCode.InternalServerError, "Failed to add person data to database");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, ex.Message);
        }
    }
}