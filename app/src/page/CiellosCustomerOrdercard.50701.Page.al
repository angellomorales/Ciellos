page 50701 "Ciellos_Customer Order card"
{
    ApplicationArea = All;
    Caption = 'Customer Order card';
    PageType = Card;
    SourceTable = "Ciellos_Customer Order Header";

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
            part("Customer Order Lines"; "Ciellos_Cust. Ord. subform")
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
            actionref(PostPromotedActionRef; Post)
            {
            }
        }
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Enabled = Rec."Order Amount" <> 0;

                trigger OnAction()
                begin
                    Message('Run post');
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)

    begin
        if Rec."Posting Date" = 0D then
            Rec."Posting Date" := WorkDate();
    end;
}
