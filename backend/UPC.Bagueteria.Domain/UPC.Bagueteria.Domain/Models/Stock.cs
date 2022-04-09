using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace UPC.Bagueteria.Domain.Models
{
    public class Stock : BaseSales
	{
		[Key]
		public int StockID { get; set; }
		public int ProductID { get; set; }
		public int Quantity { get; set; }
		public int Movement { get; set; }
	}
}
