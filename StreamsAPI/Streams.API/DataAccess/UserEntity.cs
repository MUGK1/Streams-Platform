using System.Security.Cryptography;
using System.Text;
using Npgsql;
using Streams.API.Models;

namespace Streams.API.DataAccess
{
    public class UserEntity : BaseEntity
    {
        public UserEntity(IConfiguration configuration)
            : base(configuration)
        {

        }

        public int CreateUser(CreateUserModel input)
        {
            var userParameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@name", Value = input.Name },
                new NpgsqlParameter() { ParameterName = "@email", Value = input.Email },
                new NpgsqlParameter() { ParameterName = "@password", Value = ComputeSha256Hash(input.Password) }
            };

            ExecuteCommand(
                "INSERT INTO users (name, email, password, created_at)" +
                " VALUES (@name, @email, @password, CURRENT_DATE);", userParameters);

            userParameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@email", Value = input.Email },
            };

            var dt = ExecuteQuery(
                "SELECT * FROM users " +
                "WHERE email = @email", userParameters);

            var id = int.Parse(dt.Rows[0]["id"].ToString());

            userParameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@id", Value = id },
                new NpgsqlParameter() { ParameterName = "@dob", Value = input.DateOfBirth },
            };

            var affectedRows = ExecuteCommand(
                "INSERT INTO viewers (user_id, date_of_birth)" +
                " VALUES (@id, @dob);", userParameters);

            if (input.IsCreator)
            {
                userParameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@id", Value = id },
                new NpgsqlParameter() { ParameterName = "@country", Value = input.Country },
            };

                ExecuteCommand(
                    "INSERT INTO creators (user_id, country)" +
                    " VALUES (@id, @country);", userParameters);
            }

            return affectedRows;
        }

        public User GetUserInfo(int userId)
        {
            var userParameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@id", Value = userId },
            };

            var dt = ExecuteQuery(
                "SELECT u.*, c.user_id, c.country, v.date_of_birth FROM users u left outer join creators c on u.id = c.user_id left outer join viewers v on u.id = v.user_id " +
                "WHERE u.id = @id", userParameters);

            var row = dt.Rows[0];

            var user = new User()
            {
                Id = int.Parse(row["id"].ToString()),
                Name = row["name"].ToString(),
                Email = row["email"].ToString(),
                //DateOfBirth = DateTime.Parse(row["date_of_birth"].ToString()),
                IsCreator = !string.IsNullOrEmpty(row["country"].ToString()),
                Country = row["country"].ToString(),
            };

            return user;
        }

        public User GetUserByEmail(string email)
        {
            var userParameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@email", Value = email },
            };

            var dt = ExecuteQuery(
                "SELECT u.*, c.user_id, c.country, v.date_of_birth FROM users u left outer join creators c on u.id = c.user_id left outer join viewers v on u.id = v.user_id " +
                "WHERE u.email = @email", userParameters);

            var row = dt.Rows[0];

            var user = new User()
            {
                Id = int.Parse(row["id"].ToString()),
                Name = row["name"].ToString(),
                Email = row["email"].ToString(),
                //DateOfBirth = DateTime.Parse(row["date_of_birth"].ToString()),
                IsCreator = !string.IsNullOrEmpty(row["country"].ToString()),
                Country = row["country"].ToString(),
            };

            return user;
        }

        public bool Authenticate(string email, string password)
        {
            var userParameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@email", Value = email },
                new NpgsqlParameter() { ParameterName = "@password", Value = ComputeSha256Hash(password) },
            };

            var dt = ExecuteQuery(
                "SELECT 1 FROM users " +
                "WHERE email = @email AND password = @password", userParameters);

            return dt.Rows.Count > 0;
        }

        public static string ComputeSha256Hash(string rawData)
        {
            using SHA256 sha256Hash = SHA256.Create();
            byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));
            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < bytes.Length; i++)
            {
                builder.Append(bytes[i].ToString("x2"));
            }
            return builder.ToString();
        }
    }
}
