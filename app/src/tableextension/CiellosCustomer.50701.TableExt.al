tableextension 50701 "Ciellos_Customer" extends Customer
{
    fields
    {
        field(50700; "Ciellos_Cust. Ord. Open"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Customer Orders Open';
            CalcFormula = Count("Ciellos_Customer Order Header" WHERE("Sell to Customer No." = FIELD("No.")));
            Editable = false;

        }
        field(50701; "Ciellos_Cust. Ord. Posted"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Posted Customer Orders';
            CalcFormula = Count("Ciellos_Posted Cus_Ord Head." WHERE("Sell to Customer No." = FIELD("No.")));
            Editable = false;

        }
        field(50702; "Ciellos_Cust. Payment"; Integer)
        {
            // FieldClass = FlowField;
            Caption = 'Customer Order Payments';
            // CalcFormula = Count("Ciellos_Customer Order Header" WHERE("Sell to Customer No." = FIELD("No.")));
            Editable = false;

        }
    }

    procedure CustomerOrdersOpen()
    var
        CustomerOrderHeader: Record "Ciellos_Customer Order Header";

    begin
        CustomerOrderHeader.SetRange("Sell to Customer No.", Rec."No.");
        Page.Run(Page::"Ciellos_Customer Order List", CustomerOrderHeader);
    end;

    procedure PostedCustomerOrders()
    var
        PostedCustomerOrderHeader: Record "Ciellos_Posted Cus_Ord Head.";

    begin
        PostedCustomerOrderHeader.SetRange("Sell to Customer No.", Rec."No.");
        Page.Run(Page::"Ciellos_Posted cust. Ord. List", PostedCustomerOrderHeader);
    end;
}
