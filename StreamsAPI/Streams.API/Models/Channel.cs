namespace Streams.API.Models
{
    public class Channel
    {
        public int Id { get; set; }
        public int CreatorId {get; set;}
        public string Name { get; set; }
        public string Description { get; set; }
        public string AvatarUrl {get; set;}
        public int SubscribersCount {get; set;}
        public DateTime CreatedAt { get; set; }
        public int ViewsCount { get; set; }
        public bool IsOwner { get; set; }
        public bool IsSubscribed { get; set; }
    }
}