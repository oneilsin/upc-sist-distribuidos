using Autonomus.Library.AdoNet.Asyncs;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UPC.Bagueteria.Domain.IRepositories.IStockRepositories;
using UPC.Bagueteria.Domain.Models;
using UPC.Bagueteria.Domain.Queries.ProductQuerieResult;

namespace UPC.Bagueteria.Infra.Dao.Repositories.StockRepositories
{
    public class StockRepository : Repository<Stock>, IStockRepository
    {
        public StockRepository(AdoContext adoContext) : base(adoContext)
        {
        }

        public async Task<EntityResponse> AddCart(Stock stock, Orders orders)
        {
            EntityResponse objReturn;
            string query = "UspProductAddCart";
            try
            {
                var response = await _adoContext.ExecuteEscalarTransaction(
                query,
                System.Data.CommandType.StoredProcedure,
                new SqlParameter[]
                {
                    new SqlParameter("@ProductID", stock.ProductID),
                    new SqlParameter("@Quantity", stock.Quantity),
                    new SqlParameter("@CustomerID", orders.CustomerID)
                });

                if (response != null)
                {
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = new
                        {
                            StockID = response.ToString(),
                            CustomerID = orders.CustomerID,
                            Amount = orders.Amount
                        }
                    };

                }
                else
                {
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = false,
                        ErrorMessage = "No se ha agregado datos.",
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

        public async Task<EntityResponse> EditCart(Stock stock, Orders orders)
        {
            EntityResponse objReturn;
            string query = "UspProductEditCart";
            try
            {
                var response = await _adoContext.ExecuteNonQueryTransaction(
                query,
                System.Data.CommandType.StoredProcedure,
                new SqlParameter[]
                {
                    new SqlParameter("@StockID", stock.StockID),
                    new SqlParameter("@Quantity", stock.Quantity),
                    new SqlParameter("@OrderID", orders.OrderID)
                });

                if (response > 0)
                {
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = new
                        {
                            StockID = response.ToString(),
                            CustomerID = orders.CustomerID,
                            OrderID = orders.OrderID,
                            Amount = orders.Amount
                        }
                    };

                }
                else
                {
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = false,
                        ErrorMessage = "No se ha agregado datos.",
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

        public async Task<EntityResponse> GetCartByCustomer(string idCustomer)
        {
            EntityResponse objReturn;
            var query = "UspProductSearchCart";
            try
            {
                var response = await _adoContext.ExecuteReader<ProductCart>(
                query,
                System.Data.CommandType.StoredProcedure,
                new SqlParameter("@CustomerID", idCustomer)
                );
                if (response != null)
                {
                    var objStock = new List<ProductCart>();
                    objStock = response.ToList();
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = objStock
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

        public async Task<EntityResponse> GetStockByCategory(string idCategory)
        {
            EntityResponse objReturn;
            string query = @"
                    SELECT sto.ProductID, cat.[Name] AS Category, sto.[Name] AS Producto, pri.Price AS Precio, sto.Stock 
                    FROM VwStock sto 
                    INNER JOIN Category cat ON cat.CategoryID=sto.CategoryID 
                    INNER JOIN Prices pri ON pri.ProductID=sto.ProductID 
                    WHERE cat.CategoryID=@idCategory
                ";
            try
            {
                var response = await _adoContext.ExecuteReader<StockQuery>(
                query,
                System.Data.CommandType.Text,
                new SqlParameter("@idCategory", idCategory)
                );
                if (response != null)
                {
                    var objStock = new List<StockQuery>();
                    objStock = response.ToList();
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = objStock
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
    }
}
