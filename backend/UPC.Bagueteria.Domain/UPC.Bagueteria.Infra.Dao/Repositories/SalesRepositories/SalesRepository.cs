using Autonomus.Library.AdoNet.Asyncs;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UPC.Bagueteria.Domain.IRepositories.ISalesRepositories;
using UPC.Bagueteria.Domain.Models;
using UPC.Bagueteria.Domain.Queries.ProductQuerieResult;
using UPC.Bagueteria.Domain.Queries.SalesQuerieResult;

namespace UPC.Bagueteria.Infra.Dao.Repositories.SalesRepositories
{
    public class SalesRepository : Repository<Sales>, ISalesRepository
    {
        public SalesRepository(AdoContext adoContext) : base(adoContext)
        {
        }

        public async Task<EntityResponse> AddSale(Sales sales)
        {
            EntityResponse objReturn;
            string query = "UspSalesCreate";
            try
            {
                var response = await _adoContext.ExecuteEscalarTransaction(
                query,
                System.Data.CommandType.StoredProcedure,
                new SqlParameter[]
                {
                    new SqlParameter("@CustomerID", sales.CustomerID),
                    new SqlParameter("@Delivery", sales.Delivery),
                    new SqlParameter("@PaymentID", sales.PaymentID)
                });

                if (response != null)
                {
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = new
                        {
                            SalesID = response.ToString(),
                            CustomerID = sales.CustomerID,
                            TotalAmount = sales.TotalAmount
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

        public async Task<EntityResponse> GetPaymentList()
        {
            EntityResponse objReturn;
            string query = @"
                    SELECT PaymentID,[Description] FROM Payment WHERE Deleted=0;
                ";
            try
            {
                var response = await _adoContext.ExecuteReader<Payment>(
                query,
                System.Data.CommandType.Text
                );
                if (response != null)
                {
                    var objPay = new List<Payment>();
                    objPay = response.ToList();
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = objPay
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

        public async Task<EntityResponse> GetSalesByCustomer(int idCustomer)
        {
            EntityResponse objReturn;
            string query = @"
                    SELECT 
	                    sl.SalesID,	sl.[Date], sl.Delivery,py.[Description] AS Payment,
	                    sl.TotalAmount, sl.AttendedStatus
                    FROM Sales sl
                    INNER JOIN Payment py ON py.PaymentID=sl.PaymentID
                    WHERE sl.CustomerID=@CustomerID
            ";
            try
            {
                var response = await _adoContext.ExecuteReader<SalesLogQuery>(
                query,
                System.Data.CommandType.Text,
                new SqlParameter("@CustomerID", idCustomer)
                );
                if (response != null)
                {
                    var objSales = new List<SalesLogQuery>();
                    objSales = response.ToList();
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = objSales
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

        public async Task<EntityResponse> GetSalesDetailById(int idSales)
        {
            EntityResponse objReturn;
            string query = @"
                SELECT o.OrderID,
		            o.StockID,
		            p.[Name] AS Product,
		            pc.Price AS UnitPrice,
		            s.Quantity,
		            o.Amount,
		            p.ImageName AS Photo,
		            o.SalesID
	            FROM Orders o
	            INNER JOIN Stock s ON s.StockID=o.StockID
	            INNER JOIN Product p ON p.ProductID=s.ProductID
	            INNER JOIN Prices pc ON pc.ProductID=p.ProductID
	            WHERE o.SalesID=@SalesID
            ";
            try
            {
                var response = await _adoContext.ExecuteReader<ProductCart>(
                query,
                System.Data.CommandType.Text,
                 new SqlParameter("@SalesID", idSales)
                );
                if (response != null)
                {
                    var objCart = new List<ProductCart>();
                    objCart = response.ToList();
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = objCart
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

        public async Task<EntityResponse> GetSalesPendingList()
        {
            EntityResponse objReturn;
            string query = @"
                        SELECT s.SalesID,
	                        c.[Name]+' '+c.LastName AS Customer,
	                        s.Delivery,
	                        p.[Description] AS Payment,
	                        s.TotalAmount
                        FROM Sales s
                        INNER JOIN Customer c ON c.CustomerID=s.CustomerID
                        INNER JOIN Payment p ON p.PaymentID=s.PaymentID
                        WHERE AttendedStatus=0
                ";
            try
            {
                var response = await _adoContext.ExecuteReader<SalesPendingQuery>(
                query,
                System.Data.CommandType.Text
                );
                if (response != null)
                {
                    var objPending = new List<SalesPendingQuery>();
                    objPending = response.ToList();
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = objPending
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

        public async Task<EntityResponse> UpdateSale(Sales sales)
        {
            EntityResponse objReturn;
            string query = @"
                            UPDATE Sales
                            SET EmployeeID=@EmployeeID,
	                            DateAttended=GETDATE(),
	                            AttendedStatus=@AttendedStatus
                            WHERE SalesID=@SalesID
                        ";
            try
            {
                var response = await _adoContext.ExecuteNonQueryTransaction(
                query,
                System.Data.CommandType.Text,
                new SqlParameter[]
                {
                    new SqlParameter("@EmployeeID", sales.EmployeeID),
                    new SqlParameter("@AttendedStatus", sales.AttendedStatus),
                    new SqlParameter("@SalesID", sales.SalesID)
                });

                if (response > 0)
                {
                    objReturn = new EntityResponse()
                    {
                        IsSuccess = true,
                        Data = new
                        {
                            SalesID = sales.SalesID,
                            EmployeeID = sales.EmployeeID,
                            AttendedStatus = sales.AttendedStatus
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
    }
}
