using System;
using System.Collections.Generic;
using System.Text;

namespace UPC.Bagueteria.Domain.Queries.SalesQuerieResult
{
    public class SalesLogQuery
    {
        public int SalesID { get; set; }
        public DateTime Date { get; set; }
        public bool Delivery { get; set; }
        public string Payment { get; set; }
        public decimal TotalAmount { get; set; }
        public bool AttendedStatus { get; set; }
    }
}
