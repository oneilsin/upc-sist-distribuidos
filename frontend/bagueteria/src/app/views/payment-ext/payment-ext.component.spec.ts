import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PaymentExtComponent } from './payment-ext.component';

describe('PaymentExtComponent', () => {
  let component: PaymentExtComponent;
  let fixture: ComponentFixture<PaymentExtComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PaymentExtComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PaymentExtComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
