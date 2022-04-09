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

        public async Task<EntityResponse> GetStockByCategory(string idCategory)
        {
            EntityResponse objReturn;
            string query = "SELECT sto.ProductID, cat.[Name] AS Category, sto.[Name] AS Producto, pri.Price AS Precio, sto.Stock " +
                        "FROM VwStock sto " +
                        "INNER JOIN Category cat ON cat.CategoryID=sto.CategoryID " +
                        "INNER JOIN Prices pri ON pri.ProductID=sto.ProductID " +
                        "WHERE cat.CategoryID=@idCategory";
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
