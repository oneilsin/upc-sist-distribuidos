using Autonomus.Library.AdoNet.Asyncs;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UPC.Bagueteria.Domain.IRepositories.ICustomerRepositories;
using UPC.Bagueteria.Domain.Models;

namespace UPC.Bagueteria.Infra.Dao.Repositories.CustomerRepositories
{
    public class CustomerRepository : Repository<Customer>, ICustomerRepository
    {
        public CustomerRepository(AdoContext adoContext) : base(adoContext)
        {
        }

        public async Task<EntityResponse> Create(Customer customer)
        {
            EntityResponse objReturn;
            var query = "UspCustomerCreate";
            try
            {
                var response = await _adoContext.ExecuteEscalar(
                query,
                System.Data.CommandType.StoredProcedure,
                new SqlParameter[]
                {
                    new SqlParameter("@Name", customer.Name),
                    new SqlParameter("@Password", customer.Password),
                    new SqlParameter("@Email", customer.Email)
                });
                var _retId = response.ToString();
                if (_retId.Length > 0)
                {
                    var objCustomer = await _adoContext.SelectByKey<Customer>(_retId);
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = new
                        {
                            IdUsuario = objCustomer.CustomerID,
                            Nombres = objCustomer.Name,
                            Apellidos = objCustomer.LastName,
                            Documento = objCustomer.CardID,
                            Email = objCustomer.Email,
                            Role = objCustomer.Role                           
                        }
                    };

                }
                else
                {
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = false,
                        ErrorMessage = "No se ha insertado datos.",
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

        public async Task<EntityResponse> FindByDocument(string idCard)
        {
            EntityResponse objReturn;
            var query = "SELECT * FROM Customer WHERE CardID=@idCard";
            try
            {
                var response = await _adoContext.ExecuteReader<Customer>(
                query,
                System.Data.CommandType.Text,
                new SqlParameter("@idCard", idCard)
                );
                if (response != null)
                {
                    var objCustomer = new List<Customer>();
                    objCustomer = response.ToList();
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = objCustomer
                    };

                }
                else
                {
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = false,
                        ErrorMessage = "No se ha encontrado datos.",
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

        public async Task<EntityResponse> Modify(Customer customer)
        {
            EntityResponse objReturn;
            var query = @"UPDATE Customer
                        SET [Name]=@Name, LastName=@LastName, CardID=@CardID,
	                        Bithday=@Bithday, Gender=@Gender, [Password]=@Password,
                            [Address]=@Address, Referece=@Referece
                        OUTPUT inserted.CustomerID
                        WHERE CustomerID=@Id;";
            try
            {
                var response = await _adoContext.ExecuteEscalar(
                query,
                System.Data.CommandType.Text,
                new SqlParameter[]
                {
                    new SqlParameter("@Name", customer.Name),
                    new SqlParameter("@LastName", customer.LastName),
                    new SqlParameter("@CardID", customer.CardID),
                    new SqlParameter("@Bithday", customer.Bithday),
                    new SqlParameter("@Gender", customer.Gender),
                    new SqlParameter("@Password", customer.Password),
                    new SqlParameter("@Address", customer.Address),
                    new SqlParameter("@Referece", customer.Referece),
                    new SqlParameter("@Id", customer.CustomerID)
                });
                var _retId = response.ToString();
                if (_retId.Length > 0)
                {
                    var objCustomer = await _adoContext.SelectByKey<Customer>(_retId);
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = new
                        {
                            IdUsuario = objCustomer.CustomerID,
                            Nombres = objCustomer.Name,
                            Apellidos = objCustomer.LastName,
                            Documento = objCustomer.CardID,
                            Email = objCustomer.Email,
                            Role = objCustomer.Role
                        }
                    };

                }
                else
                {
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = false,
                        ErrorMessage = "No se ha modificado los datos.",
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

