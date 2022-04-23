using System;
using System.Collections.Generic;
using System.Text;

namespace UPC.Bagueteria.Domain.Models
{
    public class Sales :BaseSales
    {
        public int SalesID { get; set; }
        public int CustomerID { get; set; }
        public bool Delivery { get; set; }
        public int PaymentID { get; set; }
        public decimal TotalAmount { get; set; }
        public int EmployeeID { get; set; }
        public DateTime DateAttended { get; set; }
        public bool AttendedStatus { get; set; }
    }
}
