using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Streams.API.DataAccess;

namespace Streams.API.Controllers
{
    [Authorize]
    [ApiController]
    [Route("/api/[controller]")]
    public class ChannelController : ControllerBase
    {
        private readonly ChannelEntity entity;
        private readonly VideoEntity entity2;

        public ChannelController(ChannelEntity entity, VideoEntity entity2)
        {
            this.entity = entity;
            this.entity2 = entity2;
        }

        private int GetUserId()
        {
            var userClaim = User.Claims.FirstOrDefault(c => c.Type == JwtRegisteredClaimNames.Sid);
            return int.Parse(userClaim.Value);
        }

        [HttpGet("{ChannelId}")]
        public IActionResult GetById(int ChannelId)
        {
            var userId = GetUserId();
            return Ok(entity.GetChannelById(ChannelId, userId));
        }

        [HttpGet("get-channelVideos-by-id")]
        public IActionResult GetChannelVideosById([FromQuery] int ChannelId)
        {
            return Ok(entity2.GetChannelVideosById(ChannelId));
        }

        [HttpGet("get-unsubscribersLikes")]
        public IActionResult GetUnsubscribersLikes([FromQuery] int ChannelId)
        {
            return Ok(entity.UnsubscribersLikes(ChannelId));
        }

        [HttpGet("get-unsubscribersDisLikes")]
        public IActionResult GetUnsubscribersDisLikes([FromQuery] int ChannelId)
        {
            return Ok(entity.UnsubscribersDisLikes(ChannelId));
        }

        [HttpGet("get-subscribersLikes")]
        public IActionResult GetSubscribersLikes([FromQuery] int ChannelId)
        {
            return Ok(entity.SubscribersLikes(ChannelId));
        }

        [HttpGet("get-subscribersDisLikes")]
        public IActionResult GetSubscribersDisLikes([FromQuery] int ChannelId)
        {
            return Ok(entity.SubscribersDisLikes(ChannelId));
        }

        [HttpGet("GetSubscriptionStatus/{channelId}")]
        public IActionResult GetSubscriptionStatus(int channelId)
        {
            var userId = GetUserId();
            var status = entity.GetSubscriptionStatus(channelId, userId);
            return Ok(new { IsSubscribed = status });
        }

        [HttpPost("Subscribe")]
        public IActionResult Subscribe(int channelId)
        {
            var userId = GetUserId();
            entity.Subsecribe(channelId, userId);
            return Ok();
        }

        [HttpPost("UnSubscribe")]
        public IActionResult UnSubscribe(int channelId)
        {
            var userId = GetUserId();
            entity.UnSubsecribe(channelId, userId);
            return Ok();
        }

        [HttpPost("UploadVideo")]
        public IActionResult UploadVideo(int channelId, string url, string title, string description, string genre, string thumbnail_url, int duration)
        {
            entity2.UploadVideo(channelId, url, title, description, genre, thumbnail_url, duration);
            return Ok();
        }

        [HttpPost("DeleteVideo")]
        public IActionResult DeleteVideo(int videoId)
        {
            entity2.DeleteVideo(videoId);
            return Ok();
        }

    }
}