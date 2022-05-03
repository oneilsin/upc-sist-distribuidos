using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Text;

namespace UPC.Bagueteria.Infra.Dao.Context
{
    internal class SqlBasePath
    {
        public IConfigurationRoot Configuration { get; set; }
        public String GetStringSqlConnection(bool open = true)
        {
            IConfigurationBuilder builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json");
            Configuration = builder.Build();
            string cs = Configuration["Logging:AppSettings:SqlServerConnection"];
            var csb = new SqlConnectionStringBuilder(cs) { };
            return csb.ConnectionString;
        }

    }
}
