using Autonomus.Library.AdoNet.Asyncs;
using System;
using System.Collections.Generic;
using System.Text;
using UPC.Bagueteria.Domain;
using UPC.Bagueteria.Domain.IRepositories.ICustomerRepositories;
using UPC.Bagueteria.Domain.IRepositories.ISalesRepositories;
using UPC.Bagueteria.Domain.IRepositories.ISecurityRepositories;
using UPC.Bagueteria.Domain.IRepositories.IStockRepositories;
using UPC.Bagueteria.Infra.Dao.Context;
using UPC.Bagueteria.Infra.Dao.Repositories.CustomerRepositories;
using UPC.Bagueteria.Infra.Dao.Repositories.SalesRepositories;
using UPC.Bagueteria.Infra.Dao.Repositories.SecurityRepositories;
using UPC.Bagueteria.Infra.Dao.Repositories.StockRepositories;

namespace UPC.Bagueteria.Infra.Dao
{
    public class UnitOfWork : IUnitOfWork
    {
        protected readonly AdoContext _adoContext;
        protected readonly string _url;
        public UnitOfWork()
        {
            _url = new SqlBasePath().GetStringSqlConnection();
            _adoContext = new AdoContext(_url);

            Login = new LoginRepository(_adoContext);
            Stock = new StockRepository(_adoContext);
            Customer = new CustomerRepository(_adoContext);
            Sales = new SalesRepository(_adoContext);
        }

        public ILoginRepository Login { get; private set; }
        public IStockRepository Stock { get; private set; }
        public ICustomerRepository Customer { get; private set; }
        public ISalesRepository Sales { get; private set; }

        public void Dispose()
        {
            _adoContext.Dispose();
        }
    }
}
