using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace UPC.Bagueteria.Domain.Models
{
    public class Orders : BaseSales
    {
        [Key]
        public int OrderID { get; set; }
        public int StockID { get; set; }
        public int CustomerID { get; set; }
        public decimal Amount { get; set; }
        public bool StatusCart { get; set; }
        public int SalesID { get; set; }
    }
}
