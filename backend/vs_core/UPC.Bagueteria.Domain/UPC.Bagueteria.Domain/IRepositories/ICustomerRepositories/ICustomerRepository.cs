using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using UPC.Bagueteria.Domain.Models;

namespace UPC.Bagueteria.Domain.IRepositories.ICustomerRepositories
{
    public interface ICustomerRepository : IRepository<Customer>
    {
        Task<EntityResponse> FindByDocument(string idCard);
        Task<EntityResponse> Create(Customer customer);
        Task<EntityResponse> Modify(Customer customer);
    }
}
