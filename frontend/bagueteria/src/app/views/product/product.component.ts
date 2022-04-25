import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ProductService } from 'src/app/services/product.service';


@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})
export class ProductComponent implements OnInit {
  productList: any[] = [];

  productForm = this.fb.group({
    productID: ['',[Validators.required, Validators.minLength(1)]],
    quantity:['1', [Validators.required, Validators.min(1)]],
    customerID:['',[Validators.required, Validators.minLength(1)]]
  })
  constructor(private readonly productService: ProductService,
    private fb: FormBuilder,
    private readonly router : Router,
    private activateRoute: ActivatedRoute) { }


  
  getProductByCategory(id: number){
    this.productService.getProductByCategory(id).subscribe((rest:any)=>{
//     console.log(rest.data);
     this.productList = rest.data;
   });
  };  

  addItemToCart(idProduct: number){
    let _token = sessionStorage.getItem("token");
    if(_token!=null){
      var data = JSON.parse(_token);

      this.productForm.patchValue({
        productID:Number(idProduct),
        customerID:Number(data.idUsuario)
      });

      if(this.productForm.valid){
        this.productService.addToCart(this.productForm.value).subscribe((r:any)=>{
          if(r.isSuccess){
            this.countCart(r.data.customerID);
          }
        });
       // console.log(this.productForm.value);
      }      
      //console.log(this.productForm.valid);      
    }else{
      //console.log("abrir Login")
      this.router.navigate(["login"]);
      
    }
  }

  countCart(idCustomer: Number) {
    var _cartCount = 0;
    this.productService.getCartItems(Number(idCustomer)).subscribe((rs: any) => {
      if (rs.isSuccess) {
        _cartCount = rs.data.length;
        sessionStorage.setItem('cart', String(_cartCount));
        //console.log(rs.data.length);
      }
    });   
  }
  ngOnInit(): void {
    this.getProductByCategory(2);
  

  }
}
