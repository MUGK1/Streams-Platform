using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Streams.API.DataAccess;
using Streams.API.Models;

namespace Streams.API.Controllers
{
    [ApiController]
    [Route("/api/[controller]")]
    public class AuthenticationController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly UserEntity entity;

        public AuthenticationController(IConfiguration configuration, UserEntity entity)
        {
            _configuration = configuration;
            this.entity = entity;
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginModel input)
        {
            bool isValidUser = entity.Authenticate(input.Email, input.Password);

            if (isValidUser)
            {
                var token = GenerateJWTToken(entity.GetUserByEmail(input.Email));
                return Ok(new { Token = token });
            }

            return Unauthorized("Invalid Credentials");
        }

        private string GenerateJWTToken(User user)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sid, user.Id.ToString()),
                new Claim(JwtRegisteredClaimNames.Sub, user.Name),
                new Claim(JwtRegisteredClaimNames.Email, user.Email),
            };

            var token = new JwtSecurityToken(
                issuer: _configuration["Jwt:Issuer"],
                audience: _configuration["Jwt:Audience"],
                claims: claims,
                expires: DateTime.Now.AddHours(6),
                signingCredentials: credentials
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        [HttpPost("signup")]
        public IActionResult Signup([FromBody] CreateUserModel input)
        {
            return Ok(entity.CreateUser(input));
        }
    }
}
