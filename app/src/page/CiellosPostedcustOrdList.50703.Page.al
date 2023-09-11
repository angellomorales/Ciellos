page 50703 "Ciellos_Posted cust. Ord. List"
{
    ApplicationArea = All;
    Caption = 'Posted Customer Order List';
    PageType = List;
    SourceTable = "Ciellos_Posted Cus_Ord Head.";
    UsageCategory = Lists;
    CardPageId = "Ciellos_Posted Cust. Ord. card";

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
    // actions
    // {
    //     area(Promoted)
    //     {
    //         actionref(PostPromotedActionRef; Post)
    //         {
    //         }
    //     }
    //     area(Processing)
    //     {
    //         action(Post)
    //         {
    //             ApplicationArea = All;
    //             Enabled = Rec."Order Amount" <> 0;

    //             trigger OnAction()
    //             var
    //                 PostCustomerOrder: Codeunit "Ciellos_Post Customer Order";
    //             begin
    //                 PostCustomerOrder.Run(Rec)
    //             end;
    //         }
    //     }
    // }
}
