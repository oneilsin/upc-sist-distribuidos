using Autonomus.Library.AdoNet.Asyncs;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UPC.Bagueteria.Domain.IRepositories.ISecurityRepositories;
using UPC.Bagueteria.Domain.Models;
using UPC.Bagueteria.Domain.Response;

namespace UPC.Bagueteria.Infra.Dao.Repositories.SecurityRepositories
{
    public class LoginRepository : Repository<LoginModel>, ILoginRepository
    {
        public LoginRepository(AdoContext adoContext) : base(adoContext)
        {
        }

        public async Task<EntityResponse> GetLogin(LoginModel login)
        {
            EntityResponse objReturn;

            string sqlQuery = @"
                SELECT
	                CustomerID AS IdUsuario, [Name] AS Nombres, LastName AS Apellidos, 
	                CardID As Documento, Email, [Role], [Address]
                FROM Customer
                WHERE Email = @email AND Password = @password
            ";
            try
            {
                var response = await _adoContext.ExecuteReader<LoginResponse>(sqlQuery,
                System.Data.CommandType.Text,
                new SqlParameter[]
                {
                    new SqlParameter("@email",login.User),
                    new SqlParameter("@password",login.Password)
                });
                if (response != null && response.Count()>0)
                {
                    var objLogin = new LoginResponse();
                    objLogin = response.ToList().FirstOrDefault();
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = objLogin
                    };

                }
                else
                {
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = false,
                        ErrorMessage = "No se ha encontrado datos. Usuario o contraseña inválidos.",
                        Data = null
                    };
                }
            }
            catch (Exception ex)
            {
                objReturn = new EntityResponse()
                {
                    IsSuccess = false,
                    ErrorMessage = ex.Message,
                    Data = null
                };
            }
            return objReturn;
        }
    }
}
