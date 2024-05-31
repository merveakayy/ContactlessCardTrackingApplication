using Microsoft.AspNetCore.Components.Web.Virtualization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using UserAPI.Data;
using UserAPI.Entities;

namespace UserAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly DataContext _context;

        public UserController(DataContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<List<User>>> GetAllUsers()
        {
            var users = await _context.Users.ToListAsync();
            return Ok(users);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<User>> GetUser(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
                return NotFound("User not found.");

            return Ok(user);
        }

        [HttpPost]
        public async Task<ActionResult<List<User>>> AddUser(User user)
        {
            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return Ok(await _context.Users.ToListAsync());
        }

        [HttpPut]
        public async Task<ActionResult<List<User>>> UpdateUser(User updatedUser)
        {
            var dbUser = await _context.Users.FindAsync(updatedUser.Id);
            if (dbUser == null)
                return NotFound("User not found.");

            dbUser.Name = updatedUser.Name;
            dbUser.FirstName = updatedUser.FirstName;
            dbUser.LastName = updatedUser.LastName;
            dbUser.Place = updatedUser.Place;
            dbUser.Beacons = updatedUser.Beacons;
            dbUser.MobilePushAddress = updatedUser.MobilePushAddress;
            dbUser.LastNotificationTime = updatedUser.LastNotificationTime;

            await _context.SaveChangesAsync();

            return Ok(await _context.Users.ToListAsync());
        }

        [HttpDelete]
        public async Task<ActionResult<List<User>>> DeleteUser(int id)
        {
            var dbUser = await _context.Users.FindAsync(id);
            if (dbUser == null)
                return NotFound("User not found.");

            _context.Users.Remove(dbUser);
            await _context.SaveChangesAsync();

            return Ok(await _context.Users.ToListAsync());
        }

        [HttpPost("Notify/{userId}")]
        public async Task<ActionResult> NotifyUser(int userId)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
                return NotFound("User not found.");

            user.LastNotificationTime = DateTime.UtcNow;
            await _context.SaveChangesAsync();

            // Zamanlayıcıyı başlat
            BackgroundJob.Schedule(() => CheckUserActivity(userId), TimeSpan.FromMinutes(10));

            return Ok();
        }

        public async Task CheckUserActivity(int userId)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
                return;

            // Kullanıcı son 10 dakika içinde giriş yapmadıysa favori kişiyi ara
            if (user.LastNotificationTime.HasValue &&
                user.LastNotificationTime.Value.AddMinutes(10) <= DateTime.UtcNow)
            {
                CallFavoriteContact(user);
            }
        }

        /*private void CallFavoriteContact(User user)
        {
            // Örneğin, burada favori kişiyi arama işlemi yapılabilir
            Console.WriteLine($"Calling favorite contact for user {user.Name}...");
        }*/
    }
}