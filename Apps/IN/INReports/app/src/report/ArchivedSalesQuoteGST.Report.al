﻿// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Finance.Reports;

using Microsoft.CRM.Team;
using Microsoft.Finance.Currency;
using Microsoft.Finance.Dimension;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Shipping;
using Microsoft.Inventory.Location;
using Microsoft.Sales.Archive;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using System.Globalization;
using System.Utilities;

report 18003 "Archived Sales Quote GST"
{
    DefaultLayout = RDLC;
    RDLCLayout = './rdlc/ArchivedSalesQuote.rdl';
    Caption = 'Archived Sales Quote';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;

    dataset
    {
        dataitem("Sales Header Archive"; "Sales Header Archive")
        {
            DataItemTableView = sorting("Document Type", "No.")
                                where("Document Type" = const(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Archived Sales Quote';

            column(Sales_Header_Archive_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_Archive_No_; "No.")
            {
            }
            column(Sales_Header_Archive_Doc__No__Occurrence; "Doc. No. Occurrence")
            {
            }
            column(Sales_Header_Archive_Version_No_; "Version No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = sorting(Number);

                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = sorting(Number)
                                        where(Number = const(1));

                    column(CompanyInfo2_Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo1_Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(STRSUBSTNO_Text004_CopyText_; StrSubstNo(salesQuoteLbl, CopyText))
                    {
                    }
                    column(CompanyRegistrationLbl; CompanyRegistrationLbl)
                    {
                    }
                    column(CompanyInfo_GST_RegistrationNo; CompanyInfo."GST Registration No.")
                    {
                    }
                    column(CustomerRegistrationLbl; CustomerRegistrationLbl)
                    {
                    }
                    column(Customer_GST_RegistrationNo; Customer."GST Registration No.")
                    {
                    }
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddr[2])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddr[4])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo__Giro_No__; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfo__Bank_Name_; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfo__Bank_Account_No__; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(Sales_Header_Archive___Bill_to_Customer_No__; "Sales Header Archive"."Bill-to Customer No.")
                    {
                    }
                    column(FORMAT__Sales_Header_Archive___Document_Date__0_4_; Format("Sales Header Archive"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(Sales_Header_Archive___VAT_Registration_No__; "Sales Header Archive"."VAT Registration No.")
                    {
                    }
                    column(Sales_Header_Archive___Shipment_Date_; Format("Sales Header Archive"."Shipment Date"))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(Sales_Header_Archive___No__; "Sales Header Archive"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(Sales_Header_Archive___Your_Reference_; "Sales Header Archive"."Your Reference")
                    {
                    }
                    column(CustAddr_7_; CustAddr[7])
                    {
                    }
                    column(CustAddr_8_; CustAddr[8])
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr_6_; CompanyAddr[6])
                    {
                    }
                    column(Sales_Header_Archive___Prices_Including_VAT_; "Sales Header Archive"."Prices Including VAT")
                    {
                    }
                    column(STRSUBSTNO_Text011__Sales_Header_Archive___Version_No____Sales_Header_Archive___No__of_Archived_Versions__; StrSubstNo(VersionLbl, "Sales Header Archive"."Version No.", "Sales Header Archive"."No. of Archived Versions"))
                    {
                    }
                    column(PageCaption; StrSubstNo(PageLbl, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVAT_YesNo; Format("Sales Header Archive"."Prices Including VAT"))
                    {
                    }
                    column(VATBaseDiscountPercent; "Sales Header Archive"."VAT Base Discount %")
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(CompanyInfo__Phone_No__Caption; CompanyInfo__Phone_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No__Caption; CompanyInfo__Fax_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__Caption; CompanyInfo__VAT_Registration_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Giro_No__Caption; CompanyInfo__Giro_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Bank_Name_Caption; CompanyInfo__Bank_Name_CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Bank_Account_No__Caption; CompanyInfo__Bank_Account_No__CaptionLbl)
                    {
                    }
                    column(Sales_Header_Archive___Bill_to_Customer_No__Caption; "Sales Header Archive".FieldCaption("Bill-to Customer No."))
                    {
                    }
                    column(Sales_Header_Archive___Shipment_Date_Caption; Sales_Header_Archive___Shipment_Date_CaptionLbl)
                    {
                    }
                    column(Sales_Header_Archive___No__Caption; Sales_Header_Archive___No__CaptionLbl)
                    {
                    }
                    column(Sales_Header_Archive___Prices_Including_VAT_Caption; "Sales Header Archive".FieldCaption("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Header Archive";
                        DataItemTableView = sorting(Number)
                                            where(Number = filter(1 ..));

                        column(DimText; DimText)
                        {
                        }
                        column(DimText_Control80; DimText)
                        {
                        }
                        column(DimensionLoop1_Number; Number)
                        {
                        }
                        column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            DimText := GetDimensionText(DimSetEntry1, Number, Continue);
                            if not Continue then
                                CurrReport.Break();
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowIntInfo then
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Sales Line Archive"; "Sales Line Archive")
                    {
                        DataItemLink = "Document Type" = field("Document Type"),
                                       "Document No." = field("No."),
                                       "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                       "Version No." = field("Version No.");
                        DataItemLinkReference = "Sales Header Archive";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");


                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = sorting(Number);

                        column(SalesLineArchTmp__Line_Amount_; TempSalesLineArchTmp."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineArchTmp_Description; TempSalesLineArchTmp.Description)
                        {
                        }
                        column(RoundLoopBody3Visibility; TempSalesLineArchTmp.Type = TempSalesLineArchTmp.Type::" ")
                        {
                        }
                        column(Sales_Line_Archive___No__; "Sales Line Archive"."No.")
                        {
                        }
                        column(Sales_Line_Archive__Description; "Sales Line Archive".Description)
                        {
                        }
                        column(Sales_Line_Archive__Quantity; "Sales Line Archive".Quantity)
                        {
                        }
                        column(Sales_Line_Archive___Unit_of_Measure_; "Sales Line Archive"."Unit of Measure")
                        {
                        }
                        column(Sales_Line_Archive___Line_Amount_; "Sales Line Archive"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line_Archive___Unit_Price_; "Sales Line Archive"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Line_Archive___Line_Discount___; "Sales Line Archive"."Line Discount %")
                        {
                        }
                        column(Sales_Line_Archive___Allow_Invoice_Disc__; "Sales Line Archive"."Allow Invoice Disc.")
                        {
                        }
                        column(Sales_Line_Archive___VAT_Identifier_; "Sales Line Archive"."VAT Identifier")
                        {
                        }
                        column(AllowInvoiceDis_YesNo; Format("Sales Line Archive"."Allow Invoice Disc."))
                        {
                        }
                        column(SalesLineNo; "Sales Line Archive"."Line No.")
                        {
                        }
                        column(SalesLineNoText; Format("Sales Line Archive"."Line No."))
                        {
                        }
                        column(RoundLoopBody4Visibility; TempSalesLineArchTmp.Type <> TempSalesLineArchTmp.Type::" ")
                        {
                        }
                        column(SalesLineType; Format("Sales Line Archive".Type))
                        {
                        }
                        column(SalesLineArchTmp__Line_Amount__Control84; TempSalesLineArchTmp."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineArchTmp__Inv__Discount_Amount_; TempSalesLineArchTmp."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineArchTmp__Line_Amount__Control61; TempSalesLineArchTmp."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalesLineArchTmp__Line_Amount__SalesLineArchTmp__Inv__Discount_Amount_; TempSalesLineArchTmp."Line Amount" - TempSalesLineArchTmp."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(SalesLineArchTmp__Line_Amount__SalesLineArchTmp__Inv__Discount_Amount__Control88; TempSalesLineArchTmp."Line Amount" - TempSalesLineArchTmp."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineArchTmp__Line_Amount__SalesLineArchTmp__Inv__Discount_Amount____VATAmount; TempSalesLineArchTmp."Line Amount" - TempSalesLineArchTmp."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control131; TotalExclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText_Control132; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalInclVATText_Control133; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount_Control135; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(Sales_Line_Archive__DescriptionCaption; "Sales Line Archive".FieldCaption(Description))
                        {
                        }
                        column(Sales_Line_Archive___No__Caption; "Sales Line Archive".FieldCaption("No."))
                        {
                        }
                        column(Sales_Line_Archive__QuantityCaption; "Sales Line Archive".FieldCaption(Quantity))
                        {
                        }
                        column(Sales_Line_Archive___Unit_of_Measure_Caption; "Sales Line Archive".FieldCaption("Unit of Measure"))
                        {
                        }
                        column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                        {
                        }
                        column(Sales_Line_Archive___Line_Discount___Caption; Sales_Line_Archive___Line_Discount___CaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(Sales_Line_Archive___Allow_Invoice_Disc__Caption; "Sales Line Archive".FieldCaption("Allow Invoice Disc."))
                        {
                        }
                        column(Sales_Line_Archive___VAT_Identifier_Caption; Sales_Line_Archive___VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control83; ContinuedCaption_Control83Lbl)
                        {
                        }
                        column(SalesLineArchTmp__Inv__Discount_Amount_Caption; SalesLineArchTmp__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = sorting(Number)
                                                where(Number = filter(1 ..));

                            column(DimText_Control81; DimText)
                            {
                            }
                            column(DimensionLoop2_Number; Number)
                            {
                            }
                            column(Line_DimensionsCaption; Line_DimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                DimText := GetDimensionText(DimSetEntry2, Number, Continue);
                                if not Continue then
                                    CurrReport.Break();
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowIntInfo then
                                    CurrReport.Break();
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                TempSalesLineArchTmp.FindFirst()
                            else
                                TempSalesLineArchTmp.Next();
                            "Sales Line Archive" := TempSalesLineArchTmp;

                            DimSetEntry2.SetRange("Dimension Set ID", "Sales Line Archive"."Dimension Set ID");
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempSalesLineArchTmp.DeleteAll();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempSalesLineArchTmp.FindLast();
                            while MoreLines and (TempSalesLineArchTmp.Description = '') and (TempSalesLineArchTmp."Description 2" = '') and
                                  (TempSalesLineArchTmp."No." = '') and (TempSalesLineArchTmp.Quantity = 0) and
                                  (TempSalesLineArchTmp.Amount = 0)
                            do
                                MoreLines := TempSalesLineArchTmp.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();

                            TempSalesLineArchTmp.SetRange("Line No.", 0, TempSalesLineArchTmp."Line No.");
                            SetRange(Number, 1, TempSalesLineArchTmp.Count);
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = sorting(Number);

                        column(VATAmountLine__VAT_Base_; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control69; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control70; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Line Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control71; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control72; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control73; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier_; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control110; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control111; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control97; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control98; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control99; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control114; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control115; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control100; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control104; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control105; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounter_Number; Number)
                        {
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control70Caption; VATAmountLine__VAT_Base__Control70CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control69Caption; VATAmountLine__VAT_Amount__Control69CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control73Caption; VATAmountLine__Line_Amount__Control73CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control72Caption; VATAmountLine__Inv__Disc__Base_Amount__Control72CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control71Caption; VATAmountLine__Invoice_Discount_Amount__Control71CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control110Caption; VATAmountLine__VAT_Base__Control110CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control114Caption; VATAmountLine__VAT_Base__Control114CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmount = 0 then
                                CurrReport.Break();
                            SetRange(Number, 1, TempVATAmountLine.Count);
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = sorting(Number);

                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control152; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control153; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT____Control154; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier__Control155; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATAmountLCY_Control156; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control157; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control159; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control160; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATCounterLCY_Number; Number)
                        {
                        }
                        column(VALVATAmountLCY_Control152Caption; VALVATAmountLCY_Control152CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control153Caption; VALVATBaseLCY_Control153CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT____Control154Caption; VATAmountLine__VAT____Control154CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier__Control155Caption; VATAmountLine__VAT_Identifier__Control155CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control157Caption; VALVATBaseLCY_Control157CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control160Caption; VALVATBaseLCY_Control160CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            VALVATBaseLCY := TempVATAmountLine.GetBaseLCY(
                                "Sales Header Archive"."Posting Date",
                                "Sales Header Archive"."Currency Code",
                                "Sales Header Archive"."Currency Factor");
                            VALVATAmountLCY := TempVATAmountLine.GetAmountLCY(
                                "Sales Header Archive"."Posting Date",
                                "Sales Header Archive"."Currency Code",
                                "Sales Header Archive"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Header Archive"."Currency Code" = '') or
                               (TempVATAmountLine.GetTotalVATAmount() = 0)
                            then
                                CurrReport.Break();

                            SetRange(Number, 1, TempVATAmountLine.Count);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text008Lbl + Text009Lbl
                            else
                                VALSpecLCYHeader := Text008Lbl + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header Archive"."Order Date", "Sales Header Archive"."Currency Code", 1);
                            VALExchRate := StrSubstNo(
                                ExchangeRateLbl,
                                CurrExchRate."Relational Exch. Rate Amount",
                                CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));

                        column(PaymentTerms_Description; PaymentTerms.Description)
                        {
                        }
                        column(ShipmentMethod_Description; ShipmentMethod.Description)
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }
                        column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                        {
                        }
                        column(ShipmentMethod_DescriptionCaption; ShipmentMethod_DescriptionCaptionLbl)
                        {
                        }
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));

                        column(Sales_Header_Archive___Sell_to_Customer_No__; "Sales Header Archive"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr_1_; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr_2_; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr_3_; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr_4_; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr_5_; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr_6_; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr_7_; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr_8_; ShipToAddr[8])
                        {
                        }
                        column(Total2_Number; Number)
                        {
                        }
                        column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
                        {
                        }
                        column(Sales_Header_Archive___Sell_to_Customer_No__Caption; "Sales Header Archive".FieldCaption("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then
                                CurrReport.Break();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesLineArchive: Record "Sales Line Archive";
                    TempSalesHeader: Record "Sales Header" temporary;
                    TempSalesLine: Record "Sales Line" temporary;
                begin
                    Clear(TempSalesLineArchTmp);
                    TempSalesLineArchTmp.DeleteAll();
                    SalesLineArchive.SetRange("Document Type", "Sales Header Archive"."Document Type");
                    SalesLineArchive.SetRange("Document No.", "Sales Header Archive"."No.");
                    SalesLineArchive.SetRange("Version No.", "Sales Header Archive"."Version No.");
                    if SalesLineArchive.FindSet() then
                        repeat
                            TempSalesLineArchTmp := SalesLineArchive;
                            TempSalesLineArchTmp.Insert();
                            TempSalesLine.TransferFields(SalesLineArchive);
                            TempSalesLine.Insert();
                        until SalesLineArchive.Next() = 0;

                    TempSalesHeader.TransferFields("Sales Header Archive");
                    TempSalesLine."Prepayment Line" := true;
                    TempSalesLine.CalcVATAmountLines(0, TempSalesHeader, TempSalesLine, TempVATAmountLine);

                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount := TempVATAmountLine.GetTotalVATDiscount(
                        TempSalesHeader."Currency Code",
                        TempSalesHeader."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then begin
                        CopyText := CopyLbl;
                        OutputNo += 1;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then
                        SalesCountPrintedArch.Run("Sales Header Archive");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopy) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);

                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                "Sell-to Country": Text[50];
            begin
                CurrReport.Language := GlobalLanguage.GetLanguageID("Language Code");
                CurrReport.FormatRegion := GlobalLanguage.GetFormatRegionOrDefault("Format Region");
                Customer.Get("Bill-to Customer No.");
                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");

                if "Salesperson Code" = '' then begin
                    SalesPurchPerson.Init();
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.Get("Salesperson Code");
                    SalesPersonText := SalesPerLbl;
                end;

                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := CopyStr((FieldCaption("Your Reference")), 1, 80);

                if "VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := CopyStr((FieldCaption("VAT Registration No.")), 1, 80);

                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(TotalLbl, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(TotalInCVatLbl, GLSetup."LCY Code");
                    TotalExclVATText := StrSubstNo(TotalExclVatLbl, GLSetup."LCY Code");
                end else begin
                    TotalText := StrSubstNo(TotalLbl, "Currency Code");
                    TotalInclVATText := StrSubstNo(TotalInCVatLbl, "Currency Code");
                    TotalExclVATText := StrSubstNo(TotalExclVatLbl, "Currency Code");
                end;

                FormatAddr.SalesHeaderArchBillTo(CustAddr, "Sales Header Archive");

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init()
                else begin
                    PaymentTerms.Get("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;

                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init()
                else begin
                    ShipmentMethod.Get("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                end;

                if Country.Get("Sell-to Country/Region Code") then
                    "Sell-to Country" := Country.Name;

                FormatAddr.SalesHeaderArchShipTo(ShipToAddr, CustAddr, "Sales Header Archive");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                for i := 1 TO ArrayLen(ShipToAddr) do
                    if (ShipToAddr[i] <> CustAddr[i]) and (ShipToAddr[i] <> '') and (ShipToAddr[i] <> "Sell-to Country") then
                        ShowShippingAddr := true;

                CalcFields("No. of Archived Versions");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopy)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the number of copies that need to be printed.';
                    }
                    field(ShowInternalInfo; ShowIntInfo)
                    {
                        Caption = 'Show Internal Information';
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the line internal information.';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        SalesSetup.Get();

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                CompanyInfo.CalcFields(Picture);
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.Get();
                    CompanyInfo1.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.Get();
                    CompanyInfo2.CalcFields(Picture);
                end;
        end;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        Customer: Record "Customer";
        SalesSetup: Record "Sales & Receivables Setup";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        TempSalesLineArchTmp: Record "Sales Line Archive" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Country: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        GlobalLanguage: Codeunit "Language";
        SalesCountPrintedArch: Codeunit "SalesCount-PrintedArch";
        FormatAddr: Codeunit "Format Address";
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopy: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        ShowIntInfo: Boolean;
        Continue: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        OutputNo: Integer;
        Text008Lbl: Label 'VAT Amount Specification in ';
        Text009Lbl: Label 'Local Currency';
        ExchangeRateLbl: Label 'Exchange rate: %1/%2', Comment = '%1 = Relational Exch. Rate Amount %2 = Exchange Rate Amount';
        VersionLbl: Label 'Version %1 of %2 ', Comment = ' %1 = Version No. , %2 = No. of Archived Versions';
        CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        CompanyInfo__Giro_No__CaptionLbl: Label 'Giro No.';
        CompanyInfo__Bank_Name_CaptionLbl: Label 'Bank';
        CompanyInfo__Bank_Account_No__CaptionLbl: Label 'Account No.';
        Sales_Header_Archive___Shipment_Date_CaptionLbl: Label 'Shipment Date';
        Sales_Header_Archive___No__CaptionLbl: Label 'Quote No.';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        Sales_Line_Archive___Line_Discount___CaptionLbl: Label 'Disc. %';
        AmountCaptionLbl: Label 'Amount';
        Sales_Line_Archive___VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
        ContinuedCaptionLbl: Label 'Continued';
        ContinuedCaption_Control83Lbl: Label 'Continued';
        SalesLineArchTmp__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT_Base__Control70CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT_Amount__Control69CaptionLbl: Label 'VAT Amount';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmountLine__Line_Amount__Control73CaptionLbl: Label 'Line Amount';
        VATAmountLine__Inv__Disc__Base_Amount__Control72CaptionLbl: Label 'Inv. Disc. Base Amount';
        VATAmountLine__Invoice_Discount_Amount__Control71CaptionLbl: Label 'Invoice Discount Amount';
        VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Base__Control110CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Base__Control114CaptionLbl: Label 'Total';
        VALVATAmountLCY_Control152CaptionLbl: Label 'VAT Amount';
        VALVATBaseLCY_Control153CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT____Control154CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT_Identifier__Control155CaptionLbl: Label 'VAT Identifier';
        VALVATBaseLCYCaptionLbl: Label 'Continued';
        TotalLbl: Label 'Total %1', Comment = '%1 = LCY Code';
        TotalInCVatLbl: Label 'Total %1 Incl. VAT', Comment = '%1 = LCY Code';
        CopyLbl: Label 'COPY';
        salesQuoteLbl: Label 'Sales Quote Archived %1', Comment = '%1 = CopyText';
        PageLbl: Label 'Page %1', Comment = '%1= Page No.';
        SalesPerLbl: Label 'Sales Person';
        TotalExclVatLbl: Label 'Total %1 Excl. VAT', Comment = '%1 = LCY Code';
        VALVATBaseLCY_Control157CaptionLbl: Label 'Continued';
        VALVATBaseLCY_Control160CaptionLbl: Label 'Total';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method';
        Ship_to_AddressCaptionLbl: Label 'Ship-to Address';
        CompanyRegistrationLbl: Label 'Company Registration No.';
        CustomerRegistrationLbl: Label 'Customer GST Reg No.';

    local procedure GetDimensionText(var DimSetEntry: Record "Dimension Set Entry"; Number: Integer; var Continue: Boolean): Text[120]
    var
        DimensionText: Text[120];
        PrevDimText: Text[75];
        DimensionTextLbl: Label '%1; %2 - %3', Comment = ' %1 = DimText, %2 = Dimension Code, %3 = Dimension Value Code';
        DimensionLbl: Label '%1 - %2', Comment = '%1 = Dimension Code, %2 = Dimension Value Code';
    begin
        Continue := false;
        if Number = 1 then
            if not DimSetEntry.FindSet() then
                exit;

        repeat
            PrevDimText := CopyStr((DimensionText), 1, 75);
            if DimensionText = '' then
                DimensionText := StrSubstNo(DimensionLbl, DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
            else
                DimensionText := CopyStr(
                    StrSubstNo(
                        DimensionTextLbl,
                        DimensionText,
                        DimSetEntry."Dimension Code",
                        DimSetEntry."Dimension Value Code"),
                    1,
                    120);

            if StrLen(DimensionText) > MaxStrLen(PrevDimText) then begin
                Continue := true;
                exit(PrevDimText);
            end;
        until DimSetEntry.Next() = 0;

        exit(DimensionText)
    end;
}
