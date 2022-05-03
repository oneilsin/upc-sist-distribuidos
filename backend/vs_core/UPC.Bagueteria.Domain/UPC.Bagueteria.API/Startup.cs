using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.OpenApi.Models;
using UPC.Bagueteria.API.Configs;
using UPC.Bagueteria.API.Exceptions;
using UPC.Bagueteria.API.Infraestructure;
using DBEntity = UPC.Bagueteria.Infra.Dao.Context;
namespace UPC.Bagueteria.API
{
    public class Startup
    {
      
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            // TODO: Configuration Section
            var Section = Configuration.GetSection("ConfigSettings");
            var SectionGet = Section.Get<DBEntity.ConfigSettings>();

            services.Configure<DBEntity.ConfigSettings>(Section);
            DBEntity.ConfigSettings config = SectionGet;// Section.Get<DBEntity.ConfigSettings>();
            AppSettingsProvider.config = config;

            services.AddCors(o => o.AddPolicy("MyPolicy", builder =>
            {
                builder.AllowAnyOrigin()
                       .AllowAnyMethod()
                       .AllowAnyHeader()
                      ;
            }));


            services.AddAuthentication("Bearer")
              .AddJwtBearer("Bearer", options =>
              {
                  options.Authority = AppSettingsProvider.config.UrlBaseIdentityServer;
                  options.RequireHttpsMetadata = false;
                  options.RefreshOnIssuerKeyNotFound = true;
                  options.Audience = "API-APP-UPC";
              });


            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc(
                    name: AppSettingsProvider.config.Version,
                    new OpenApiInfo
                    {
                        Title = AppSettingsProvider.config.ApplicationName,
                        Version = AppSettingsProvider.config.Version,
                        Contact = new OpenApiContact()
                        {
                            Name = AppSettingsProvider.config.OrganizationName,
                            Url = new System.Uri("https://www.upc.edu.pe/"),
                            Email = "u201824041@upc.edu.pe",
                        },
                        Description = AppSettingsProvider.config.ApplicationDescription,

                        License = new OpenApiLicense() { Name = AppSettingsProvider.config.OrganizationName, Url = new System.Uri("https://www.upc.edu.pe/") },
                        TermsOfService = new System.Uri("https://www.upc.edu.pe/")
                    });

                c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
                {
                    Description = @"Esta api usa Authorization  basada en JWT.-  
                      Ingrese 'Bearer' [space] y luego el token de autenticación.
                      Ejemplo: 'Bearer HJNX4354X...'",
                    Name = "Authorization",
                    In = ParameterLocation.Header,
                    Type = SecuritySchemeType.ApiKey,
                    Scheme = "Bearer"
                });

                c.AddSecurityRequirement(new OpenApiSecurityRequirement()
                  {
                    {
                      new OpenApiSecurityScheme
                      {
                        Reference = new OpenApiReference
                          {
                            Type = ReferenceType.SecurityScheme,
                            Id = "Bearer"
                          },
                          Scheme = "oauth2",
                          Name = "Bearer",
                          In = ParameterLocation.Header,

                        },
                        new List<string>()
                      }
                    });
            });


            //TODO: Registrar las interfaces para Inyección de Dependencias
            services.AddTransient<HttpClientAuthorizationDelegatingHandler>();
            services.AddTransient<IHttpContextAccessor, HttpContextAccessor>();


            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }


            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                string url = $"{AppSettingsProvider.config.Version}/swagger.json";
                string name = $"{AppSettingsProvider.config.ApplicationName}";
                c.SwaggerEndpoint(url, name);
            });

            app.UseHttpsRedirection();
            app.UseRouting();


            app.UseAuthentication();
            app.UseAuthorization();


            app.UseCors("MyPolicy");
            app.UseMiddleware(typeof(ErrorHandlingMiddleware));
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
