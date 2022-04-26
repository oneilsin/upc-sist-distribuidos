import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { ProductService } from 'src/app/services/product.service';
import { SalesService } from 'src/app/services/sales.service';


@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent implements OnInit {
  cartList: any[] = [];
  payList: any[] = [];
  total: any;
  isAddress: any;
  userForm = this.fb.group({
    nombres: [''],
    idUsuario: [''],
    address: ['']
  });

  saleForm = this.fb.group({
    customerID: ['', [Validators.required, Validators.minLength(1)]],
    delivery: [false, [Validators.required]],
    paymentID: ['', [Validators.required, Validators.minLength(1)]]
  })


  productForm = this.fb.group({
    orderID: ['', [Validators.required, Validators.minLength(1)]],
    quantity: [1, [Validators.required, Validators.min(1)]],
    stockID: ['', [Validators.required, Validators.minLength(1)]]
  })

  constructor(private fb: FormBuilder,
    private readonly productService: ProductService,
    private readonly salesService: SalesService,
    private readonly router: Router) { }


  getCartItems() {
    var _customerID = this.userForm.get('idUsuario')?.value;
    this.productService.getCartItems(Number(_customerID)).subscribe((rest: any) => {
      if (rest.isSuccess) {
        this.cartList = rest.data;
        this.total = 0.00;
        this.cartList.forEach(e => {
          this.total += e.amount;
        })
        //        console.log(rest);
        //      console.log(rest.data.orderID);
      }
    });
  };

  initUserInfo() {
    var _token = sessionStorage.getItem('token');
    if (_token == null) return;

    var data = JSON.parse(_token);
    this.userForm.patchValue({
      nombres: data.nombres,
      idUsuario: data.idUsuario,
      address: data.address
    });
    this.isAddress = this.userForm.get('address')?.value.length < 5 ? false : true;
  };

  editItemOnCart(orderID: number, stockID: number) {//, quantity: number) {
    this.productForm.patchValue({
      //quantity: quantity,
      stockID: stockID,
      orderID: orderID,
    });

    // console.log(this.productForm.value);

    if (this.productForm.valid) {
      this.productService.editToCart(this.productForm.value).subscribe((rest: any) => {
        if (rest.isSuccess) {
          this.getCartItems();
        }
      });
    }
  }

  getPayment() {
    this.salesService.getPayment().subscribe((rest: any) => {
      if (rest.isSuccess) {
        this.payList = rest.data;
        // console.log(rest.data);
      }
    });
  }

  // searchAddress(){
  //   var _address = this.userForm.get('address')?.value;
  //   if(_address.length<5){
  //     alert("Ustes ha seleccionado el servicio de Delivery, y no tenemos su dirección de domicilio. Por favor, actualizar datos.")
  //     this.router.navigate(['profile']);
  //   }
  // }

  shippingAll() {
    this.saleForm.patchValue({
      customerID: Number(this.userForm.get('idUsuario')?.value)
    });
    //Validar si selecciona Delivery
    if (this.saleForm.get('delivery')?.value) {
      if (!this.isAddress) {
        alert("Ustes ha seleccionado el servicio de Delivery, y no tenemos su dirección de domicilio. Por favor, actualizar datos.")        
        this.router.navigate(['profile']);
        return;
      }
    }
    //Validamos tipo de pago
    var _tpay = this.saleForm.get('paymentID')?.value;
    if (_tpay == 7 || _tpay == 8) {//Pasarella : API
      if (this.saleForm.valid) {
        //confirm("¿Desea finalizar la compra, esto cerrará la canastilla?.");
        this.salesService.createSale(this.saleForm.value).subscribe((rest: any) => {
          if (rest.isSuccess) {
            this.getCartItems();
            this.countCart();
            //console.log(rest);
            this.router.navigate(['payment_ext']);
          }
        });
      }
    }/* else if (_tpay == 4 || _tpay == 5 || _tpay == 6) {
      if (this.saleForm.valid) {
       // confirm("¿Desea finalizar la compra, esto cerrará la canastilla?.");
        this.salesService.createSale(this.saleForm.value).subscribe((rest: any) => {
          if (rest.isSuccess) {
            this.getCartItems();
            this.countCart();
            //console.log(rest);
            this.router.navigate(['payment']);
          }
        });
      }
    } */else {      
      // Pago contra-entrega
      if (this.saleForm.valid) {
        confirm("¿Desea finalizar la compra, esto cerrará la canastilla?.");
        this.salesService.createSale(this.saleForm.value).subscribe((rest: any) => {
          if (rest.isSuccess) {
            this.getCartItems();
            this.countCart();
            //console.log(rest);
            window.location.href = "/sales";
            //this.router.navigate(['sales']);
          }
        });
      }
    }
  }

  continueShoping() {
    this.router.navigate(["product"]);
  }
  gotoSales() {
    this.router.navigate(["sales"]);
  }

  countCart() {
    var _customerID = this.userForm.get('idUsuario')?.value;
    var _cartCount = 0;
    this.productService.getCartItems(Number(_customerID)).subscribe((rs: any) => {
      if (rs.isSuccess) {
        _cartCount = rs.data.length;
        sessionStorage.setItem('cart', String(_cartCount));
        //console.log(rs.data.length);

      }
    });
  }


  ngOnInit(): void {
    this.initUserInfo();
    this.getCartItems();
    this.getPayment();
  }

}
