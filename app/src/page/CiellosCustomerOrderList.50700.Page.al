page 50700 "Ciellos_Customer Order List"
{
    ApplicationArea = All;
    Caption = 'Customer Order List';
    PageType = List;
    SourceTable = "Ciellos_Customer Order Header";
    UsageCategory = Lists;
    CardPageId = "Ciellos_Customer Order card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Sell to Customer Name"; Rec."Sell to Customer Name")
                {
                    ToolTip = 'Specifies the value of the Sell to Customer Name field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
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
}
