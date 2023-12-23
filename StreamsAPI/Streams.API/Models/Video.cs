namespace Streams.API.Models
{
    public class Video
    {
        public int Id { get; set; }
        public string Url { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Genre { get; set; }
        public DateTime PublishedAt { get; set; }
        public int ChannelId { get; set; }
        public string ChannelName { get; set; }
        public string AvatarUrl { get; set; }
        public int ViewsCount { get; set; }
        public bool IsSubscribed { get; set; }
        public int SubscriptionsCount { get; set; }
    }
}
