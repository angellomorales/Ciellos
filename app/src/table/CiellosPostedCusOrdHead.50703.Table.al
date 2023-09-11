table 50703 "Ciellos_Posted Cus_Ord Head."
{
    Caption = 'Posted Customer Order Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No';
            // Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get();
                    NoSeriesMgt.TestManual(SalesSetup."Ciellos_Posted Customer Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Sell to Customer No."; Code[20])
        {
            Caption = 'Sell to Customer';
            TableRelation = Customer;
            Editable = false;

            // trigger OnValidate()
            // var
            //     Customer: Record Customer;
            //     PostedCustomerOrderLine: Record "Ciellos_Posted Cust. Ord. Line";
            // begin
            //     if "Sell to Customer No." <> '' then begin
            //         Customer.get("Sell to Customer No.");
            //         "Sell to Customer Name" := Customer.Name;

            //         // PostedCustomerOrderLine.SetRange("Document No.", Rec."No.");
            //         // if PostedCustomerOrderLine.FindSet() then
            //         //     repeat
            //         //         PostedCustomerOrderLine.Validate("Customer No.", Rec."Sell to Customer No.");
            //         //         PostedCustomerOrderLine.Modify(true);
            //         //     until PostedCustomerOrderLine.Next() = 0;
            //     end
            // end;
        }
        field(3; "Sell to Customer Name"; Text[100])
        {
            Caption = 'Sell to Customer Name';
            TableRelation = Customer.Name where("No." = field("Sell to Customer No."));
            Editable = false;
        }
        field(4; "Order Amount"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = sum("Ciellos_Customer Order Line"."Line Amount"
            // where("Document No." = field("No."),
            // "Customer No." = field("Sell to Customer No.")));
            Caption = 'Order Amount';
            Editable = false;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = false;
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(7; "Paid Amount"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Paid Amount';
            Editable = false;
            CalcFormula = sum("Ciellos_Customer Order Payment".Amount
             where("Related Document No." = field("No."),
            "Customer No." = field("Sell to Customer No.")));
        }
        field(8; "Pending Amount"; Decimal)
        {
            Caption = 'Pending Amount';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        InitInsert();
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure InitInsert()
    begin

        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Ciellos_Posted Customer Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Ciellos_Posted Customer Nos.", xRec."No. Series", "Posting Date", Rec."No.", Rec."No. Series");
        end;

    end;

    trigger OnDelete()
    var
        PostedCustomerOrderLine: Record "Ciellos_Posted Cust. Ord. Line";
    begin
        PostedCustomerOrderLine.SetRange("Document No.", Rec."No.");
        PostedCustomerOrderLine.DeleteAll();
    end;

    procedure OpenCustomerOrderPaymentPage()
    var
        CustomerOrderPayment: Record "Ciellos_Customer Order Payment";

    begin
        CustomerOrderPayment.SetRange("Related Document No.", Rec."No.");
        Page.Run(Page::"Ciellos_Cust. Ord. PayList", CustomerOrderPayment);
    end;
}
