namespace UPC.Bagueteria.API.Models.SalesModels
{
    public class SaleCreateModel
    {
        public int CustomerID { get; set; }
        public bool Delivery { get; set; }
        public int PaymentID { get; set; }
    }
}
