namespace UPC.Bagueteria.API.Models.ProductModels
{
    public class ProductAddCartModel
    {
        public int ProductID { get; set; }
        public int Quantity { get; set; }
        public int CustomerID { get; set; }
    }
}
