page 50704 "Ciellos_Posted Cust. Ord. card"
{
    ApplicationArea = All;
    Caption = 'Posted Customer Order card';
    PageType = Card;
    SourceTable = "Ciellos_Posted Cus_Ord Head.";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Sell to Customer No."; Rec."Sell to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell to Customer field.';
                }
                field("Sell to Customer Name"; Rec."Sell to Customer Name")
                {
                    ToolTip = 'Specifies the value of the Sell to Customer Name field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
            }
            part("Customer Order Lines"; "Ciellos_Posted Cus_Ord subform")
            {
                SubPageLink = "Document No." = field("No.");
                UpdatePropagation = Both;
            }
            group(totals)
            {
                Caption = 'Total Order';
                field("Order Amount"; Rec."Order Amount")
                {
                    ToolTip = 'Specifies the value of the Order Amount field.';
                }
                field("Paid Amount"; Rec."Paid Amount")
                {
                    ToolTip = 'Specifies the value of the Paid Amount field.';
                    trigger OnDrillDown()
                    begin
                        Rec.OpenCustomerOrderPaymentPage();
                    end;
                }
                field("Pending Amount"; Rec."Pending Amount")
                {
                    ToolTip = 'Specifies the value of the Pending Amount field.';
                }
            }
        }
        area(FactBoxes)
        {
            part(CustomerInfo; "Customer Details FactBox")
            {
                SubPageLink = "No." = field("Sell to Customer No.");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(PaymentPromotedActionRef; Payment)
            {
            }
        }
        area(Processing)
        {
            action(Payment)
            {
                ApplicationArea = All;
                Caption = 'Set Payment';
                Enabled = Rec."Pending Amount" > 0;

                trigger OnAction()
                var
                    PagecustomerOrderPayment: Page "Ciellos_Cust. Order Payments";
                begin
                    // rec.CalcFields("Paid Amount");
                    PagecustomerOrderPayment.LookupMode(true);
                    PagecustomerOrderPayment.SetDefaults(Rec);
                    if PagecustomerOrderPayment.RunModal() = Action::LookupOK then begin
                        PagecustomerOrderPayment.SavePayment(Rec);
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetAutoCalcFields("Paid Amount");
    end;

    trigger OnAfterGetRecord()
    begin
        Rec."Pending Amount" := Rec."Order Amount" - Rec."Paid Amount";
    end;
}
