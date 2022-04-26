import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { ProductService } from 'src/app/services/product.service';
import { SalesService } from 'src/app/services/sales.service';

@Component({
  selector: 'app-sales',
  templateUrl: './sales.component.html',
  styleUrls: ['./sales.component.css']
})
export class SalesComponent implements OnInit {
  count: any;
  detailList: any[] = [];
  saleList: any[] = [];
  userForm = this.fb.group({
    nombres: [''],
    idUsuario: ['']
  });
  constructor(private fb: FormBuilder,
    private readonly salesService: SalesService,
    private readonly productService: ProductService,
    private readonly router: Router) { }

  initUserInfo() {
    var _token = sessionStorage.getItem('token');
    if (_token == null) return;

    var data = JSON.parse(_token);
    this.userForm.patchValue({
      nombres: data.nombres,
      idUsuario: data.idUsuario
    });
  };
  getCustomerSales() {
    var _customerID = this.userForm.get('idUsuario')?.value;
    this.salesService.getSalesByCustomer(Number(_customerID)).subscribe((rest: any) => {
      if (rest.isSuccess) {
        this.saleList = rest.data;
        this.count=rest.data.length;
      }
    });
  };
  getDetails(idSales: Number) {
    this.salesService.getSalesDetail(Number(idSales)).subscribe((rest: any) => {
      if (rest.isSuccess) {
        this.detailList = rest.data;
      }
    });
  }
  showDetails(idSales:Number) {
    this.getDetails(idSales);
  }
  continueShoping() {
    this.router.navigate(["product"]);
  }
  ngOnInit(): void {
    this.initUserInfo();
    this.getCustomerSales();
  }

}
