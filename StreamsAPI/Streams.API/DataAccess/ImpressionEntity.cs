using Npgsql;
using Streams.API.Models;

namespace Streams.API.DataAccess
{
    public class ImpressionEntity : BaseEntity
    {
        public ImpressionEntity(IConfiguration configuration)
            : base(configuration)
        {

        }

        public Impressions GetImpressions(int videoId)
        {
            var parameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId },
            };

            var likes = ExecuteQuery(
                "SELECT count(1) likes FROM impressions WHERE video_id = @videoId and liked = true", parameters);

            parameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId },
            };

            var dislikes = ExecuteQuery(
                "SELECT count(1) dislikes FROM impressions WHERE video_id = @videoId and disliked = true", parameters);

            return new Impressions
            {
                Likes = int.Parse(likes.Rows[0]["likes"].ToString()),
                Dislikes = int.Parse(dislikes.Rows[0]["dislikes"].ToString())
            };
        }

        public int LikeAVideo(int videoId, int userId)
        {
            var parameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@userId", Value = userId },
                new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId },
            };

            var affectedRows = ExecuteCommand(
                "INSERT INTO impressions (video_id, viewer_uid, date_time, liked)" +
                " VALUES (@videoId, @userId, now(), true);", parameters);

            return affectedRows;
        }

        public int DislikeAVideo(int videoId, int userId)
        {
            var parameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@userId", Value = userId },
                new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId },
            };

            var deletedRows = ExecuteCommand(
                "DELETE FROM impressions " +
                "WHERE video_id = @videoId AND viewer_uid = @userId and liked = true;", parameters);

            parameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@userId", Value = userId },
                new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId },
            };

            var affectedRows = ExecuteCommand(
                "INSERT INTO impressions (video_id, viewer_uid, date_time, disliked) " +
                "VALUES (@videoId, @userId, now(), true);", parameters);

            return affectedRows;
        }

        public List<Comment> GetComments(int videoId)
        {
            var parameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId },
            };

            var dt = ExecuteQuery(
                "SELECT \n    i.comment, \n    i.date_time, \n    u.name, \n    CONCAT(\n        UPPER(SUBSTRING(u.name, 1, 1)), \n        UPPER(SUBSTRING(u.name, POSITION(' ' IN u.name) + 1, 1))\n    ) AS initials\nFROM impressions i\nJOIN users u ON i.viewer_uid = u.id\nWHERE i.video_id = @videoId\nLIMIT 100", parameters);

            var comments = new List<Comment>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var row = dt.Rows[i];

                var comment = new Comment()
                {
                    UserName = row["name"].ToString(),
                    UserInitials = row["initials"].ToString(),
                    CommentText = row["comment"].ToString(),
                    CreatedAt = Convert.ToDateTime(row["date_time"].ToString())
                };

                comments.Add(comment);
            }

            return comments.OrderByDescending(c => c.CreatedAt).ToList();
        }

        public int PostAComment(int videoId, int userId, string comment)
        {
            var parameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@userId", Value = userId },
                new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId },
                new NpgsqlParameter() { ParameterName = "@comment", Value = comment },
            };

            var affectedRows = ExecuteCommand(
                "INSERT INTO impressions (video_id, viewer_uid, date_time, comment) " +
                "VALUES (@videoId, @userId, now(), @comment);", parameters);

            return affectedRows;
        }

        public int UpdateAComment(int videoId, int userId, string comment)
        {
            var parameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@userId", Value = userId },
                new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId },
                new NpgsqlParameter() { ParameterName = "@comment", Value = comment },
            };

            var affectedRows = ExecuteCommand(
                "UPDATE impressions SET comment = @comment, date_time = now() " +
                "WHERE video_id = @videoId AND viewer_uid = @userId", parameters);

            return affectedRows;
        }

        public int DeleteAComment(int videoId, int userId)
        {
            var parameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@userId", Value = userId },
                new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId },
            };

            var deletedRows = ExecuteCommand(
                "DELETE FROM impressions " +
                "WHERE video_id = @videoId AND viewer_uid = @userId;", parameters);

            return deletedRows;
        }
    }
}
