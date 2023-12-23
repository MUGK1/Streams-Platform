namespace Streams.API.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public DateTime DateOfBirth { get; set; }
        public bool IsCreator { get; set; }
        public string Country { get; set; }
    }
}
