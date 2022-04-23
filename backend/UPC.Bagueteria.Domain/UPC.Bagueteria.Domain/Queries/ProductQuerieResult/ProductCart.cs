using System;
using System.Collections.Generic;
using System.Text;

namespace UPC.Bagueteria.Domain.Queries.ProductQuerieResult
{
    public class ProductCart
    {
        public int OrderID { get; set; }
        public int StockID { get; set; }
        public string Product { get; set; }
        public decimal UnitPrice { get; set; }
        public int Quantity { get; set; }
        public decimal Amount { get; set; }
    }
}
