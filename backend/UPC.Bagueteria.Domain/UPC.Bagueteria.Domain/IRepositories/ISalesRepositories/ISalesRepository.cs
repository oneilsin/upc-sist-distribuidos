using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using UPC.Bagueteria.Domain.Models;

namespace UPC.Bagueteria.Domain.IRepositories.ISalesRepositories
{
    public interface ISalesRepository : IRepository<Sales>
    {
        Task<EntityResponse> AddSale(Sales sales);
        Task<EntityResponse> UpdateSale(Sales sales);
        Task<EntityResponse> GetPaymentList();
        Task<EntityResponse> GetSalesPendingList();
        Task<EntityResponse> GetSalesByCustomer(int idCustomer);
        Task<EntityResponse> GetSalesDetailById(int idSales);
    }
}
