codeunit 50700 "Ciellos_Install Ciellos"
{
    Subtype = Install;
    trigger OnInstallAppPerCompany()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.Get();

        CreateNoSeries('CIE-CUS-ORD');
        SalesSetup."Ciellos_Customer Order Nos." := 'CIE-CUS-ORD';

        CreateNoSeries('CIE-CUS-PAY');
        SalesSetup."Ciellos_Customer Payment Nos." := 'CIE-CUS-PAY';
        SalesSetup.Modify();
    end;

    local procedure CreateNoSeries(NoSeriesCode: Code[20])
    var

        NoSeries: Record "No. Series";
    begin
        if not NoSeries.Get(NoSeriesCode) then begin
            NoSeries.Init();
            NoSeries.Validate(Code, NoSeriesCode);
            NoSeries.Validate("Default Nos.", true);
            NoSeries.Insert(true);
            CreateNoSeriesLine(NoSeriesCode);
        end;

    end;

    local procedure CreateNoSeriesLine(NoSeriesCode: Code[20])
    var
        NoSeriesLine: Record "No. Series Line";
        PrefixList: List of [Text];
        PrefixText: Text;
        Prefix: Text;
    begin
        PrefixList := CopyStr(NoSeriesCode, 1).Split('-');
        foreach PrefixText in PrefixList do
            Prefix += PrefixText.Substring(1, 1) + '-';

        NoSeriesLine.Init();
        NoSeriesLine.Validate("Series Code", NoSeriesCode);
        NoSeriesLine.Validate("Line No.", 10000);
        NoSeriesLine.Validate("Starting No.", PadStr(InsStr(Prefix, '00000', 6), 10));
        NoSeriesLine.Validate("Ending No.", PadStr(InsStr(Prefix, '99999', 6), 10));
        if not NoSeriesLine.Insert(true) then NoSeriesLine.Modify(true);
    end;



}
