using System;
using System.Collections.Generic;
using System.Text;

namespace UPC.Bagueteria.Domain.Queries.ProductQuerieResult
{
    public class StockQuery
    {
        public string ProductID { get; set; }
        public string Category { get; set; }
        public string Producto { get; set; }
        public string Description { get; set; }
        public string Photo { get; set; }
        public decimal Precio { get; set; }
        public int Stock { get; set; }
    }
}
