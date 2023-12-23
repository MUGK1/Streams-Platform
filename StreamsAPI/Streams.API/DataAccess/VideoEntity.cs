using Npgsql;
using Streams.API.Models;
using System.Collections.Generic;

namespace Streams.API.DataAccess
{
	public class VideoEntity : BaseEntity
	{
		public VideoEntity(IConfiguration configuration)
			: base(configuration)
		{

		}

		public Video GetVideoById(int videoId, int userId)
		{
			var parameters = new List<NpgsqlParameter>
				{
					new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId},
					new NpgsqlParameter() { ParameterName = "@userId", Value = userId}
				};

			try
			{
				ExecuteCommand(
					"INSERT INTO views (video_id, viewer_uid) " +
					"VALUES (@videoId, @userId)", parameters);

				parameters = new List<NpgsqlParameter>
				{
					new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId}
				};
			}
			catch
			{

			}

			parameters = new List<NpgsqlParameter>
			{
				new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId},
				new NpgsqlParameter() { ParameterName = "@userId", Value = userId}
			};

			var dt = ExecuteQuery(
				"SELECT v.id, v.title, v.description, v.genre, v.duration_sec, v.published_at, v.url, v.thumbnail_url," +
				" channel_id, c.name channel_name, c.avatar_url, (select count(1) from views where video_id = v.id) views_count" +
				" FROM videos v, channels c" +
				" WHERE v.channel_id = c.id and v.id = @videoId", parameters);

			if (dt.Rows.Count != 1)
				throw new Exception("Video not found");

			var row = dt.Rows[0];

			var channelId = int.Parse(row["channel_id"].ToString());

			var userSubs_parameters = new List<NpgsqlParameter>
			{
				new NpgsqlParameter() { ParameterName = "@channelId", Value = channelId},
				new NpgsqlParameter() { ParameterName = "@userId", Value = userId}
			};

			var userSubs = ExecuteQuery(
				"SELECT count(1) " +
				"FROM subscriptions " +
				"WHERE channel_id = @channelId and viewer_uid = @userId", userSubs_parameters);

			var subs_parameters = new List<NpgsqlParameter>
			{
				new NpgsqlParameter() { ParameterName = "@channelId", Value = channelId},
			};

			var videoSubs = ExecuteQuery(
				"SELECT count(1) " +
				"FROM subscriptions " +
				"WHERE channel_id = @channelId", subs_parameters);

			var video = new Video()
			{
				Id = int.Parse(row["id"].ToString()),
				Title = row["title"].ToString(),
				Url = row["url"].ToString(),
				Description = row["description"].ToString(),
				Genre = row["genre"].ToString(),
				PublishedAt = DateTime.Parse(row["published_at"].ToString()),
				ChannelId = int.Parse(row["channel_id"].ToString()),
				ChannelName = row["channel_name"].ToString(),
				AvatarUrl = row["avatar_url"].ToString(),
				ViewsCount = int.Parse(row["views_count"].ToString()),
				IsSubscribed = int.Parse(userSubs.Rows[0]["count"].ToString()) > 0,
				SubscriptionsCount = int.Parse(videoSubs.Rows[0]["count"].ToString())
			};

			return video;
		}

		public List<Video> GetVideos()
		{
			var dt = ExecuteQuery(
				"SELECT v.id, v.title, v.description, v.genre, v.duration_sec, v.published_at, v.url, v.thumbnail_url," +
				" channel_id, c.name channel_name, c.avatar_url, (select count(1) from views where video_id = v.id) views_count" +
				" FROM videos v join channels c" +
				" on v.channel_id = c.id", new List<NpgsqlParameter>());

			var videos = new List<Video>();
			for (int i = 0; i < dt.Rows.Count; i++)
			{
				var row = dt.Rows[i];

				var video = new Video()
				{
					Id = int.Parse(row["id"].ToString()),
					Title = row["title"].ToString(),
					Url = row["url"].ToString(),
					Description = row["description"].ToString(),
					Genre = row["genre"].ToString(),
					PublishedAt = DateTime.Parse(row["published_at"].ToString()),
					ChannelId = int.Parse(row["channel_id"].ToString()),
					ChannelName = row["channel_name"].ToString(),
					AvatarUrl = row["avatar_url"].ToString(),
					ViewsCount = int.Parse(row["views_count"].ToString()),
				};
				videos.Add(video);
			}
			Shuffle(videos);
			return videos;
		}

		public List<Video> GetChannelVideosById(int channelId)
		{
			var parameters = new List<NpgsqlParameter>
			{
				new NpgsqlParameter(){ParameterName = "@channelId", Value = channelId}
			};
			var dt = ExecuteQuery(
				"SELECT v.id, v.title, v.description, v.genre, v.duration_sec, v.published_at, v.url, v.thumbnail_url, " +
				"channel_id, c.name channel_name, c.avatar_url, (select count(1) from views where video_id = v.id) views_count" +
				" FROM videos v join channels c on v.channel_id = c.id where v.channel_id=@channelId  ", parameters);


			var channelVideos = new List<Video>();
			for (int i = 0; i < dt.Rows.Count; i++)
			{
				var row = dt.Rows[i];

				var video = new Video()
				{
					Id = int.Parse(row["id"].ToString()),
					Title = row["title"].ToString(),
					Url = row["url"].ToString(),
					Description = row["description"].ToString(),
					Genre = row["genre"].ToString(),
					PublishedAt = DateTime.Parse(row["published_at"].ToString()),
					ChannelId = int.Parse(row["channel_id"].ToString()),
					ChannelName = row["channel_name"].ToString(),
					AvatarUrl = row["avatar_url"].ToString(),
					ViewsCount = int.Parse(row["views_count"].ToString()),
				};
				channelVideos.Add(video);

			}
			return channelVideos;
		}


		public List<String> GetGenres()
		{
			var dt = ExecuteQuery(
				"SELECT DISTINCT genre FROM videos LIMIT 10", new List<NpgsqlParameter>());


			var genre = new List<String>();
			for (int i = 0; i < dt.Rows.Count; i++)
			{
				var row = dt.Rows[i];
				genre.Add(row["genre"].ToString());
			}
			return genre;
		}


		public List<String> GetCommentsByID(int VideoID)
		{
			var parameters = new List<NpgsqlParameter>
			{
				new NpgsqlParameter() {ParameterName = "@id", Value = VideoID}
			};
			var dt = ExecuteQuery(
				"SELECT i.comment FROM impressions i JOIN videos v ON i.video_id = v.id WHERE i.video_id = @id ", parameters);


			var Comments = new List<String>();

			for (int i = 0; i < dt.Rows.Count; i++)
			{
				var row = dt.Rows[i];
				Comments.Add(row["Comment"].ToString());
			}
			return Comments;
		}

		public List<Video> GetNextVideos(int VideoID)
		{
			var parameters = new List<NpgsqlParameter>
			{
				new NpgsqlParameter() {ParameterName = "@id", Value = VideoID},
			};

			var dt = ExecuteQuery(
				"SELECT v.id, v.title, v.description, v.genre, v.duration_sec, v.published_at, v.url, v.thumbnail_url, channel_id, c.name channel_name, c.avatar_url, (select count(1) from views where video_id = v.id) views_count "
				+ " FROM videos v join channels c on v.channel_id = c.id WHERE v.id<>@id  ORDER BY published_at DESC limit 5", parameters);

			var videos = new List<Video>();
			for (int i = 0; i < dt.Rows.Count; i++)
			{
				var row = dt.Rows[i];

				var video = new Video()
				{
					Id = int.Parse(row["id"].ToString()),
					Title = row["title"].ToString(),
					Url = row["url"].ToString(),
					Description = row["description"].ToString(),
					Genre = row["genre"].ToString(),
					PublishedAt = DateTime.Parse(row["published_at"].ToString()),
					ChannelId = int.Parse(row["channel_id"].ToString()),
					ChannelName = row["channel_name"].ToString(),
					AvatarUrl = row["avatar_url"].ToString(),
					ViewsCount = int.Parse(row["views_count"].ToString()),
				};
				videos.Add(video);
			}
            Shuffle(videos);
            return videos;
		}

		public List<Video> GetVideosByGenre(String genre)
		{
			var parameters = new List<NpgsqlParameter>
			{
				new NpgsqlParameter(){ParameterName = "@genre", Value = "%"+genre+"%"}
			};
			var dt = ExecuteQuery(
				"SELECT v.id, v.title, v.description, v.genre, v.duration_sec, v.published_at, v.url, v.thumbnail_url, " +
				"channel_id, c.name channel_name, c.avatar_url, (select count(1) from views where video_id = v.id) views_count" +
				" FROM videos v join channels c on v.channel_id = c.id where v.genre ILIKE @genre ", parameters);


			var videos = new List<Video>();
			for (int i = 0; i < dt.Rows.Count; i++)
			{
				var row = dt.Rows[i];

				var video = new Video()
				{
					Id = int.Parse(row["id"].ToString()),
					Title = row["title"].ToString(),
					Url = row["url"].ToString(),
					Description = row["description"].ToString(),
					Genre = row["genre"].ToString(),
					PublishedAt = DateTime.Parse(row["published_at"].ToString()),
					ChannelId = int.Parse(row["channel_id"].ToString()),
					ChannelName = row["channel_name"].ToString(),
					AvatarUrl = row["avatar_url"].ToString(),
					ViewsCount = int.Parse(row["views_count"].ToString()),
				};
				videos.Add(video);
			}

			return videos;
		}


		public List<Video> GetVideosByText(String Text)
		{
			var parameters = new List<NpgsqlParameter>
			{
				new NpgsqlParameter(){ParameterName = "@Text", Value = "%"+Text+"%"}
			};
			var dt = ExecuteQuery(
				"SELECT v.id, v.title, v.description, v.genre, v.duration_sec, v.published_at, v.url, v.thumbnail_url, " +
				"channel_id, c.name channel_name, c.avatar_url, (select count(1) from views where video_id = v.id) views_count" +
				" FROM videos v join channels c on v.channel_id = c.id WHERE (v.genre ILIKE @Text) OR (c.name ILIKE @Text) OR (v.description ILIKE @Text)", parameters);


			var videos = new List<Video>();
			for (int i = 0; i < dt.Rows.Count; i++)
			{
				var row = dt.Rows[i];

				var video = new Video()
				{
					Id = int.Parse(row["id"].ToString()),
					Title = row["title"].ToString(),
					Url = row["url"].ToString(),
					Description = row["description"].ToString(),
					Genre = row["genre"].ToString(),
					PublishedAt = DateTime.Parse(row["published_at"].ToString()),
					ChannelId = int.Parse(row["channel_id"].ToString()),
					ChannelName = row["channel_name"].ToString(),
					AvatarUrl = row["avatar_url"].ToString(),
					ViewsCount = int.Parse(row["views_count"].ToString()),
				};
				videos.Add(video);
			}

			return videos;
		}



		public void UploadVideo(int channelId, string url, string title, string description, string genre, string thumbnail_url, int duration)
		{
			var parameter = new List<NpgsqlParameter> {
				new NpgsqlParameter() { ParameterName = "@channelId", Value = channelId },
				new NpgsqlParameter() { ParameterName = "@url", Value = url },
				new NpgsqlParameter() { ParameterName = "@title", Value = title },
				new NpgsqlParameter() { ParameterName = "@description", Value = description },
				new NpgsqlParameter() { ParameterName = "@genre", Value = genre },
				new NpgsqlParameter() { ParameterName = "@thumbnail_url", Value = thumbnail_url },
				new NpgsqlParameter() { ParameterName = "@durationSec", Value = duration },
			};

			var UploadVideo = ExecuteCommand("INSERT INTO videos (url, title, description, genre, published_at, channel_id, thumbnail_url, duration_sec) " +
			"VALUES (@url, @title, @description, @genre, now(), @channelId, @thumbnail_url, @durationSec)", parameter);
		}

		public void DeleteVideo(int videoId)
		{
			var parameter = new List<NpgsqlParameter> {
				new NpgsqlParameter() { ParameterName = "@videoId", Value = videoId },
			};

			var UploadVideo = ExecuteCommand("DELETE from videos v where v.id = @videoId", parameter);
		}

		public Video GetMostViewed()
		{
			var parameter = new List<NpgsqlParameter>
			{

			};

			var dt = ExecuteQuery(
				"SELECT v.id, v.title, v.description, v.genre, v.duration_sec, v.published_at, v.url, v.thumbnail_url, channel_id, " +
				"c.name channel_name, c.avatar_url, (select count(1) from views where video_id = v.id) views_count " +
				"FROM videos v join channels c on v.channel_id = c.id JOIN " +
				"(SELECT video_id, COUNT(*) as total_views FROM views GROUP BY video_id ORDER BY total_views DESC LIMIT 1) AS most_viewed " +
				"ON v.id = most_viewed.video_id", parameter
			);

			if (dt.Rows.Count != 1)
				throw new Exception("Video not found");

			var row = dt.Rows[0];

			var video = new Video()
			{
				Id = int.Parse(row["id"].ToString()),
				Title = row["title"].ToString(),
				Url = row["url"].ToString(),
				Description = row["description"].ToString(),
				Genre = row["genre"].ToString(),
				PublishedAt = DateTime.Parse(row["published_at"].ToString()),
				ChannelId = int.Parse(row["channel_id"].ToString()),
				ChannelName = row["channel_name"].ToString(),
				AvatarUrl = row["avatar_url"].ToString(),
				ViewsCount = int.Parse(row["views_count"].ToString()),
			};

			return video;
		}

		static void Shuffle<T>(List<T> list)
		{
			Random random = new Random();

			int n = list.Count;
			while (n > 1)
			{
				n--;
				int k = random.Next(n + 1);
				T value = list[k];
				list[k] = list[n];
				list[n] = value;
			}
		}

	}
}
