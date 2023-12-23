using System.Data;
using Npgsql;

namespace Streams.API.DataAccess
{
    public class BaseEntity
    {
        private readonly IConfiguration configuration;

        public BaseEntity(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public int ExecuteCommand(string sql, List<NpgsqlParameter> parameters) // Insert/update/delete
        {
            using var conn = new NpgsqlConnection(configuration.GetConnectionString("GoogleCloudSQLDb"));
            conn.Open();

            using var cmd = new NpgsqlCommand(sql, conn);
            cmd.Parameters.AddRange(parameters.ToArray());
            int rowsAffected = cmd.ExecuteNonQuery();

            conn.Close();

            return rowsAffected;
        }

        public DataTable ExecuteQuery(string sql, List<NpgsqlParameter> parameters)
        {
            int retryCount = 0;
            var dt = new DataTable();
            using var conn = new NpgsqlConnection(configuration.GetConnectionString("GoogleCloudSQLDb"));
            using var cmd = new NpgsqlCommand(sql, conn);
            cmd.Parameters.AddRange(parameters.ToArray());

            while (retryCount <= 5)
            {
                try
                {
                    if (conn.State != ConnectionState.Open)
                        conn.Open();
                    using var reader = cmd.ExecuteReader();
                    dt.Load(reader);
                    conn.Close();

                    break;
                }
                catch (NpgsqlException ex)
                {
                    Console.WriteLine($"Attempt {retryCount + 1} failed: {ex.Message}");

                    if (retryCount < 5)
                    {
                        Console.WriteLine($"Retrying in {25} ms...");
                        Thread.Sleep(25);
                    }
                    else
                    {
                        Console.WriteLine("Maximum retry attempts reached. Query failed.");
                    }
                }

                retryCount++;
            }

            return dt;
        }

    }
}
