using System;
using System.Collections.Generic;
using System.Text;
using UPC.Bagueteria.Domain.IRepositories.ISecurityRepositories;
using UPC.Bagueteria.Domain.IRepositories.IStockRepositories;

namespace UPC.Bagueteria.Domain
{
    public interface IUnitOfWork :IDisposable
    {
        ILoginRepository Login { get; }
        IStockRepository Stock { get; }
    }
}
