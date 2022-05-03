using System;
using System.Collections.Generic;
using System.Text;

namespace UPC.Bagueteria.Domain.Queries.SalesQuerieResult
{
    public class SalesPendingQuery
    {
        public int SalesID { get; set; }
        public string Customer { get; set; }
        public bool Delivery { get; set; }
        public string Payment { get; set; }
        public decimal TotalAmount { get; set; }
        public string Address { get; set; }
        public string Referece { get; set; }
    }
}
