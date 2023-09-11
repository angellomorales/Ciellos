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
        field(50702; "Ciellos_Cust. Payment Amt"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Customer Order Payments Amount';
            CalcFormula = sum("Ciellos_Customer Order Payment".Amount
             where("Customer No." = field("No.")));
            Editable = false;

        }
        field(50703; "Ciellos_Cust. Order Amt"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Customer Order Amount';
            CalcFormula = sum("Ciellos_Customer Order Line"."Line Amount"
             where("Customer No." = field("No.")));
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

    procedure CustomerOrderPaymentPage()
    var
        CustomerOrderPayment: Record "Ciellos_Customer Order Payment";

    begin
        CustomerOrderPayment.SetRange("Customer No.", Rec."No.");
        Page.Run(Page::"Ciellos_Cust. Ord. PayList", CustomerOrderPayment);
    end;

    procedure CustomerOrderLinePage()
    var
        CustomerOrderPLine: Record "Ciellos_Customer Order Line";

    begin
        CustomerOrderPLine.SetRange("Customer No.", Rec."No.");
        Page.Run(Page::"Ciellos_Cust. Ord. subform", CustomerOrderPLine);
    end;
}
