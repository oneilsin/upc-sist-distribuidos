import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-payment-ext',
  templateUrl: './payment-ext.component.html',
  styleUrls: ['./payment-ext.component.css']
})
export class PaymentExtComponent implements OnInit {

  constructor(private router: Router) { }

  myShopping(){
   // this.router.navigate(['sales']);
    window.location.href = "/sales";
  }

  ngOnInit(): void {
  }

}
