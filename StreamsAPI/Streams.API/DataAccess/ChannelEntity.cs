using Npgsql;
using Streams.API.Models;

namespace Streams.API.DataAccess
{
    public class ChannelEntity : BaseEntity
    {
        public ChannelEntity(IConfiguration configuration)
            : base(configuration)
        {

        }

        public Channel GetChannelById(int channelId, int userId)
        {

            var parameter = new NpgsqlParameter()
            {
                ParameterName = "@channelId",
                Value = channelId
            };

            var dt = ExecuteQuery(
                "select id, name, description, avatar_url, subscribers_count, created_at, creator_uid" +
                " from channels" +
                " where id = @channelId", new List<NpgsqlParameter>
            {
                parameter
            });

            var parameter2 = new NpgsqlParameter()
            {
                ParameterName = "@channelId",
                Value = channelId
            };

            var views = ExecuteQuery("SELECT count(1) viewsCount " +
            "FROM channels c, videos v, views i " +
            "WHERE c.id = v.channel_id and i.video_id = v.id and c.id = @channelId", new List<NpgsqlParameter>
            {
                parameter2
            });

            var subs_parameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@userId", Value = userId},
                new NpgsqlParameter() { ParameterName = "@channelId", Value = channelId}
            };

            var userSubs = ExecuteQuery(
                "SELECT count(1) count " +
                "FROM subscriptions " +
                "WHERE viewer_uid = @userId and channel_id = @channelId", subs_parameters);

            var subsCount_parameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@channelId", Value = channelId}
            };

            var subscribersCount = ExecuteQuery("SELECT count(1) count " + 
            "From subscriptions " + 
            "WHERE channel_id = @channelId", subsCount_parameters);

            if (dt.Rows.Count != 1)
                throw new Exception("User not found");

            var row = dt.Rows[0];

            var viewRow = views.Rows[0];

            var SubsRow = userSubs.Rows[0];

            var subsCountRow = subscribersCount.Rows[0];

            var channel = new Channel()
            {
                Id = Convert.ToInt32(row["id"].ToString()),
                CreatorId = Convert.ToInt32(row["creator_uid"]),
                Name = row["name"].ToString(),
                Description = row["description"].ToString(),
                AvatarUrl = row["avatar_url"].ToString(),
                SubscribersCount = Convert.ToInt32(subsCountRow["count"].ToString()),
                CreatedAt = Convert.ToDateTime(row["created_at"].ToString()),
                ViewsCount = Convert.ToInt32(viewRow["viewsCount"].ToString()),
                IsOwner = Convert.ToInt32(row["creator_uid"]) == userId,
                IsSubscribed = int.Parse(SubsRow["count"].ToString()) > 0
            };

            return channel;
        }

        public List<Channel> GetUserChannels(int userId)
        {

            var parameter = new NpgsqlParameter()
            {
                ParameterName = "@userId",
                Value = userId
            };

            var dt = ExecuteQuery(
                "SELECT * " +
                "FROM channels " +
                "WHERE creator_uid = @userId", new List<NpgsqlParameter>
            {
                parameter
            });

            var channels = new List<Channel>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var row = dt.Rows[i];

                var channel = new Channel()
                {
                    Id = Convert.ToInt32(row["id"].ToString()),
                    CreatorId = Convert.ToInt32(row["creator_uid"]),
                    Name = row["name"].ToString(),
                    Description = row["description"].ToString(),
                    AvatarUrl = row["avatar_url"].ToString(),
                    SubscribersCount = Convert.ToInt32(row["subscribers_count"].ToString()),
                    CreatedAt = Convert.ToDateTime(row["created_at"].ToString())
                };

                channels.Add(channel);
            }

            return channels;
        }

        public bool GetSubscriptionStatus(int channelId, int userId)
        {
            var subs_parameters = new List<NpgsqlParameter>
            {
                new NpgsqlParameter() { ParameterName = "@userId", Value = userId},
                new NpgsqlParameter() { ParameterName = "@channelId", Value = channelId}
            };

            var userSubs = ExecuteQuery(
                "SELECT count(1) count " +
                "FROM subscriptions " +
                "WHERE viewer_uid = @userId and channel_id = @channelId", subs_parameters);

            return int.Parse(userSubs.Rows[0]["count"].ToString()) > 0;
        }

        public void Subsecribe(int channelId, int userId)
        {
            var parameter = new List<NpgsqlParameter> {
                new NpgsqlParameter() { ParameterName = "@userId", Value = userId },
                new NpgsqlParameter() { ParameterName = "@channelId", Value = channelId },
            };

            var Subsecribe = ExecuteCommand(
                "INSERT INTO subscriptions (channel_id, viewer_uid) VALUES (@channelId, @userId)", parameter);

        }

        public void UnSubsecribe(int channelId, int userId)
        {
            var parameter = new List<NpgsqlParameter> {
                new NpgsqlParameter() { ParameterName = "@userId", Value = userId },
                new NpgsqlParameter() { ParameterName = "@channelId", Value = channelId },
            };

            var UnSubsecribe = ExecuteCommand(
                "DELETE FROM subscriptions WHERE channel_id = @channelId AND viewer_uid = @userId;", parameter);
        }

        public string UnsubscribersLikes(int channelId)
        {
            var parameter = new List<NpgsqlParameter> {
                new NpgsqlParameter() { ParameterName = "@channelId", Value = channelId },
            };

            var dt = ExecuteQuery(
                "SELECT count(1) " +
                "FROM " +
                "impressions i, " +
                "videos v, " +
                "channels c " +
                "WHERE " +
                "i.video_id = v.id " +
                "AND v.channel_id = c.id " +
                "AND c.id = @channelId " +
                "AND i.liked = true " +
                "AND NOT EXISTS ( " +
                "SELECT 1 " +
                "FROM subscriptions " +
                "WHERE " +
                "channel_id = c.id " +
                "AND viewer_uid = i.viewer_uid)", parameter);


            if (dt.Rows.Count != 1)
                throw new Exception("Channel's Likes Not Found");

            var row = dt.Rows[0];
            var num = row["count"].ToString();

            if (num == null)
            {
                throw new Exception("No Likes Available");
            }

            return num;
        }

        public string UnsubscribersDisLikes(int channelId)
        {
            var parameter = new List<NpgsqlParameter> {
                new NpgsqlParameter() { ParameterName = "@channelId", Value = channelId },
            };

            var dt = ExecuteQuery(
                "SELECT count(1) " +
                "FROM " +
                "impressions i, " +
                "videos v, " +
                "channels c " +
                "WHERE " +
                "i.video_id = v.id " +
                "AND v.channel_id = c.id " +
                "AND c.id = @channelId " +
                "AND i.disliked = true " +
                "AND NOT EXISTS ( " +
                "SELECT 1 " +
                "FROM subscriptions " +
                "WHERE " +
                "channel_id = c.id " +
                "AND viewer_uid = i.viewer_uid)", parameter);


            if (dt.Rows.Count != 1)
                throw new Exception("Channel's DisLikes Not Found");

            var row = dt.Rows[0];
            var num = row["count"].ToString();

            if (num == null)
            {
                throw new Exception("No Likes Available");
            }

            return num;
        }

        public string SubscribersLikes(int channelId)
        {
            var parameter = new List<NpgsqlParameter> {
                new NpgsqlParameter() { ParameterName = "@channelId", Value = channelId },
            };

            var dt = ExecuteQuery(
                "SELECT count(1) " +
                "FROM " +
                "impressions i, " +
                "videos v, " +
                "channels c " +
                "WHERE " +
                "i.video_id = v.id " +
                "AND v.channel_id = c.id " +
                "AND c.id = @channelId " +
                "AND i.liked = true " +
                "AND EXISTS ( " +
                "SELECT 1 " +
                "FROM subscriptions " +
                "WHERE " +
                "channel_id = c.id " +
                "AND viewer_uid = i.viewer_uid)", parameter);


            if (dt.Rows.Count != 1)
                throw new Exception("Channel's Likes Not Found");

            var row = dt.Rows[0];
            var num = row["count"].ToString();

            if (num == null)
            {
                throw new Exception("No Likes Available");
            }

            return num;
        }

        public string SubscribersDisLikes(int channelId)
        {
            var parameter = new List<NpgsqlParameter> {
                new NpgsqlParameter() { ParameterName = "@channelId", Value = channelId },
            };

            var dt = ExecuteQuery(
                "SELECT count(1) " +
                "FROM " +
                "impressions i, " +
                "videos v, " +
                "channels c " +
                "WHERE " +
                "i.video_id = v.id " +
                "AND v.channel_id = c.id " +
                "AND c.id = @channelId " +
                "AND i.disliked = true " +
                "AND EXISTS ( " +
                "SELECT 1 " +
                "FROM subscriptions " +
                "WHERE " +
                "channel_id = c.id " +
                "AND viewer_uid = i.viewer_uid)", parameter);


            if (dt.Rows.Count != 1)
                throw new Exception("Channel's Likes Not Found");

            var row = dt.Rows[0];
            var num = row["count"].ToString();

            if (num == null)
            {
                throw new Exception("No Likes Available");
            }

            return num;
        }
    }
}
