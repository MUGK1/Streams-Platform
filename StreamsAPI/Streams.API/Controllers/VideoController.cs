using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Streams.API.DataAccess;

namespace Streams.API.Controllers
{
    [Authorize]
    [ApiController]
    [Route("/api/[controller]")]
    public class VideoController : ControllerBase
    {
        private readonly VideoEntity entity;

        public VideoController(VideoEntity entity)
        {
            this.entity = entity;
        }

        private int GetUserId()
        {
            var userClaim = User.Claims.FirstOrDefault(c => c.Type == JwtRegisteredClaimNames.Sid);
            return int.Parse(userClaim.Value);
        }

        [HttpGet("{videoId}")]
        public IActionResult GetById(int videoId)
        {
            var userId = GetUserId();
            return Ok(entity.GetVideoById(videoId, userId));
        }

        [HttpGet("get-all-videos")]
        public IActionResult GetVideos()
        {
            return Ok(entity.GetVideos());
        }
   
        [HttpGet("get-genres")]
        public IActionResult GetGenres()
        {
            return Ok(entity.GetGenres());
        }

        [HttpGet("get-video-comments-by-video-id")]
        public IActionResult GetCommentsByID([FromQuery] int videoId)
        {
            return Ok(entity.GetCommentsByID(videoId));
        }

        [HttpGet("get-next-videos")]
        public IActionResult GetNextVideos([FromQuery] int videoID)
        {
            return Ok(entity.GetNextVideos(videoID));
        }

        [HttpGet("get-Channel-videos-by-id")]
        public IActionResult GetChannelVideosById([FromQuery] int channelID)
        {
            return Ok(entity.GetChannelVideosById(channelID));
        }
   
        [HttpGet("get-Videos-by-Genre")]
        public IActionResult GetVideosByGenre([FromQuery] String genre)
        {
            return Ok(entity.GetVideosByGenre(genre.Trim()));
        }
    
        [HttpGet("get-Videos-by-text")]
        public IActionResult GetVideosByText([FromQuery] String text)
        {
            return Ok(entity.GetVideosByText(text.Trim()));
        }

        [HttpGet("get-Most-viewed")]
        public IActionResult GetMostViewed()
        {
            return Ok(entity.GetMostViewed());
        }
    }
}

