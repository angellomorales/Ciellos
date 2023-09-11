codeunit 50702 "Ciellos_Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure SkipPostingOnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; PreviewMode: Boolean)
    var
        customerOrders: Record "Ciellos_Customer Order Header";
        postedcustomerOrders: Record "Ciellos_Posted Cus_Ord Head.";
        skipflow: Boolean;
    begin
        customerOrders.SetRange("Sell to Customer No.", SalesHeader."Sell-to Customer No.");
        if customerOrders.FindFirst() then
            skipflow := true;

        postedcustomerOrders.SetRange("Sell to Customer No.", SalesHeader."Sell-to Customer No.");
        if postedcustomerOrders.FindFirst() then
            skipflow := true;

        if skipflow then
            if not Confirm('Current customer has related Customer Orders\Do you want to continue Posting?') then begin
                IsHandled := true;
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure PreventCustomerDeletion(var Rec: Record Customer)
    begin
        if not Confirm('Do you really want to delete %1 customer?', false, Rec.Name) then
            Error('Customer deletion stopped');
    end;

}
