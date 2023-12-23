namespace Streams.API.Models
{
    public class Comment
    {
        public string UserName { get; set; }
        public string UserInitials { get; set; }
        public string CommentText { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
