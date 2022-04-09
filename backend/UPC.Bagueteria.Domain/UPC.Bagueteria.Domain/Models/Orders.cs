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
        public int Delivery { get; set; }
        public decimal DeliveryAmount { get; set; }
        public bool Status { get; set; }
        public int EmployeeID { get; set; }
        public DateTime DateAttended { get; set; }
        public decimal TotalAmount { get; set; }
    }
}
