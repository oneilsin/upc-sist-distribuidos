namespace UPC.Bagueteria.API.Models
{
    public class StockCategoryViewModel
    {
        public string ProductID { get; set; }
        public string Producto { get; set; }
        public string Description { get; set; }
        public string Photo { get; set; }
        public decimal Precio { get; set; }
        public int Stock { get; set; }
    }
}
