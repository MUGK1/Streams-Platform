using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Streams.API.DataAccess;
using System.IdentityModel.Tokens.Jwt;

namespace Streams.API.Controllers
{
    [Authorize]
    [ApiController]
    [Route("/api/[controller]")]
    public class ImpressionController : ControllerBase
    {
        private readonly ImpressionEntity _impressionEntity;

        public ImpressionController(ImpressionEntity impressionEntity)
        {
            _impressionEntity = impressionEntity;
        }

        private int GetUserId()
        {
            var userClaim = User.Claims.FirstOrDefault(c => c.Type == JwtRegisteredClaimNames.Sid);
            return int.Parse(userClaim.Value);
        }

        [HttpGet("get-impressions/{videoId}")]
        public IActionResult GetImpressions(int videoId)
        {
            var result = _impressionEntity.GetImpressions(videoId);
            return Ok(result);
        }

        [HttpPost("like")]
        public IActionResult LikeVideo(int videoId)
        {
            var userId = GetUserId();
            var result = _impressionEntity.LikeAVideo(videoId, userId);
            return Ok(result);
        }

        [HttpPost("dislike")]
        public IActionResult DislikeVideo(int videoId)
        {
            var userId = GetUserId();
            var result = _impressionEntity.DislikeAVideo(videoId, userId);
            return Ok(result);
        }

        [HttpGet("comments/{videoId}")]
        public IActionResult GetAllComments(int videoId)
        {
            var result = _impressionEntity.GetComments(videoId);
            return Ok(result);
        }

        [HttpPost("comments/{videoId}")]
        public IActionResult PostComment(int videoId, [FromForm] string comment)
        {
            var userId = GetUserId();
            var result = _impressionEntity.PostAComment(videoId, userId, comment);
            return Ok(_impressionEntity.GetComments(videoId));
        }

        [HttpPut("comments/{videoId}")]
        public IActionResult UpdateComment(int videoId, string comment)
        {
            var userId = GetUserId();
            var result = _impressionEntity.UpdateAComment(videoId, userId, comment);
            return Ok(result);
        }

        [HttpDelete("comments/{videoId}")]
        public IActionResult DeleteComment(int videoId)
        {
            var userId = GetUserId();
            var result = _impressionEntity.DeleteAComment(videoId, userId);
            return Ok(result);
        }
    }
}
