using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Streams.API.DataAccess;

namespace Streams.API.Controllers
{
    [Authorize]
    [ApiController]
    [Route("/api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly UserEntity entity;
        private readonly ChannelEntity channelEntity;

        public UserController(UserEntity entity, ChannelEntity channelEntity)
        {
            this.entity = entity;
            this.channelEntity = channelEntity;
        }

        [HttpGet("get-user-info")]
        public IActionResult GetUserInfo()
        {
            var userClaim = User.Claims.FirstOrDefault(c => c.Type == JwtRegisteredClaimNames.Sid);
            var userId = int.Parse(userClaim.Value);
            return Ok(entity.GetUserInfo(userId));
        }

        [HttpGet("get-user-channels")]
        public IActionResult GetUserChannels()
        {
            var userClaim = User.Claims.FirstOrDefault(c => c.Type == JwtRegisteredClaimNames.Sid);
            var userId = int.Parse(userClaim.Value);
            return Ok(channelEntity.GetUserChannels(userId));
        }
    }
}

