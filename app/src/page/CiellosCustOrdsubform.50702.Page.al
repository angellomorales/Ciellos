page 50702 "Ciellos_Cust. Ord. subform"
{
    ApplicationArea = All;
    Caption = 'Customer Order Lines subform';
    PageType = ListPart;
    AutoSplitKey = true;
    DelayedInsert = true;
    SourceTable = "Ciellos_Customer Order Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';

                    trigger OnValidate()
                    begin
                        CalculateOrderAmount();
                    end;
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    trigger OnValidate()
                    begin
                        CalculateOrderAmount();
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        CustomerOrderHeader: Record "Ciellos_Customer Order Header";
    begin
        CustomerOrderHeader.Get(Rec."Document No.");
        Rec."Customer No." := CustomerOrderHeader."Sell to Customer No.";
    end;

    local procedure CalculateOrderAmount()
    var
        CustomerOrderHeader: Record "Ciellos_Customer Order Header";
    begin
        if (Rec."Unit Amount" <> 0) and (Rec.Quantity <> 0) then begin
            CustomerOrderHeader.Get(Rec."Document No.");
            CustomerOrderHeader.CalcFields("Order Amount");
            CurrPage.Update();
        end;
    end;


}
