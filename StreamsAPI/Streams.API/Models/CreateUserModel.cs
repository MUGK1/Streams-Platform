namespace Streams.API.Models
{
    public class CreateUserModel
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public DateTime DateOfBirth { get; set; }
        public bool IsCreator { get; set; }
        public string Country { get; set; }
    }
}

