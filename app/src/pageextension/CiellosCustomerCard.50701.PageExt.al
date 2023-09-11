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
                    Rec.OpenCustomerOrderLines();
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
