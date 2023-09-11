pageextension 50701 "Ciellos_CustomerCard" extends "Customer Card"
{
    layout
    {
        addbefore("Balance (LCY)")
        {
            field("Ciellos_Open Cust. Ord. Amount"; Rec."Ciellos_Cust. Ord. Open")
            {
                trigger OnDrillDown()
                begin
                    Rec.CustomerOrdersOpen();
                end;
            }
            field("Ciellos_Cust. Ord. Posted"; Rec."Ciellos_Cust. Ord. Posted")
            {
                trigger OnDrillDown()
                begin
                    Rec.PostedCustomerOrders();
                    ;
                end;
            }
            field("Ciellos_Cust. Order Amt"; Rec."Ciellos_Cust. Order Amt")
            {
                trigger OnDrillDown()
                begin
                    Rec.CustomerOrderLinePage();
                    ;
                end;
            }
            field("Ciellos_Cust. Payment Amt"; Rec."Ciellos_Cust. Payment Amt")
            {
                trigger OnDrillDown()
                begin
                    Rec.CustomerOrderPaymentPage();
                    ;
                end;
            }
        }
        moveafter(Name; Blocked)
        moveafter(Blocked; "Credit Limit (LCY)")
        moveafter(MobilePhoneNo; "Home Page")

        modify(Blocked)
        {
            Caption = 'Modified Blocked';
        }
        modify("Credit Limit (LCY)")
        {
            Caption = 'Modified Credit Limit';
        }
        modify("Home Page")
        {
            Caption = 'Modified Home Page';
        }
    }
}
