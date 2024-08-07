﻿// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Bank.Documents;

using Microsoft.Foundation.Navigate;

codeunit 31434 "Navigate Handler CZB"
{
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        IssBankStatementHeaderCZB: Record "Iss. Bank Statement Header CZB";
        [SecurityFiltering(SecurityFilter::Filtered)]
        IssPaymentOrderHeaderCZB: Record "Iss. Payment Order Header CZB";

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', false, false)]
    local procedure OnAfterNavigateFindRecords(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text;
                                                PostingDateFilter: Text)
    begin
        FindIssuedBankStatementHeader(DocumentEntry, DocNoFilter, PostingDateFilter);
        FindIssuedPaymentOrderHeader(DocumentEntry, DocNoFilter, PostingDateFilter);
    end;

    local procedure FindIssuedBankStatementHeader(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text)
    begin
        if not IssBankStatementHeaderCZB.ReadPermission() then
            exit;
        IssBankStatementHeaderCZB.Reset();
        IssBankStatementHeaderCZB.SetFilter("No.", DocNoFilter);
        IssBankStatementHeaderCZB.SetFilter("Document Date", PostingDateFilter);
        DocumentEntry.InsertIntoDocEntry(
            Database::"Iss. Bank Statement Header CZB", Enum::"Document Entry Document Type"::" ",
            IssBankStatementHeaderCZB.TableCaption, IssBankStatementHeaderCZB.Count);
    end;

    local procedure FindIssuedPaymentOrderHeader(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text)
    begin
        if not IssPaymentOrderHeaderCZB.ReadPermission() then
            exit;
        IssPaymentOrderHeaderCZB.Reset();
        IssPaymentOrderHeaderCZB.SetFilter("No.", DocNoFilter);
        IssPaymentOrderHeaderCZB.SetFilter("Document Date", PostingDateFilter);
        DocumentEntry.InsertIntoDocEntry(
            Database::"Iss. Payment Order Header CZB", Enum::"Document Entry Document Type"::" ",
            IssPaymentOrderHeaderCZB.TableCaption, IssPaymentOrderHeaderCZB.Count);
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnBeforeShowRecords', '', false, false)]
    local procedure OnBeforeShowRecords(var TempDocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text; var IsHandled: Boolean)
    begin
        case TempDocumentEntry."Table ID" of
            Database::"Iss. Bank Statement Header CZB":
                begin
                    IssBankStatementHeaderCZB.Reset();
                    IssBankStatementHeaderCZB.SetFilter("No.", DocNoFilter);
                    IssBankStatementHeaderCZB.SetFilter("Document Date", PostingDateFilter);
                    if TempDocumentEntry."No. of Records" = 1 then begin
                        IssBankStatementHeaderCZB.FindFirst();
                        IssBankStatementHeaderCZB.SetRange("Bank Account No.", IssBankStatementHeaderCZB."Bank Account No.");
                        Page.Run(Page::"Iss. Bank Statement CZB", IssBankStatementHeaderCZB)
                    end else
                        Page.Run(0, IssBankStatementHeaderCZB);
                    IsHandled := true;
                end;
            Database::"Iss. Payment Order Header CZB":
                begin
                    IssPaymentOrderHeaderCZB.Reset();
                    IssPaymentOrderHeaderCZB.SetFilter("No.", DocNoFilter);
                    IssPaymentOrderHeaderCZB.SetFilter("Document Date", PostingDateFilter);
                    if TempDocumentEntry."No. of Records" = 1 then begin
                        IssPaymentOrderHeaderCZB.FindFirst();
                        IssPaymentOrderHeaderCZB.SetRange("Bank Account No.", IssPaymentOrderHeaderCZB."Bank Account No.");
                        Page.Run(Page::"Iss. Payment Order CZB", IssPaymentOrderHeaderCZB)
                    end else
                        Page.Run(0, IssPaymentOrderHeaderCZB);
                    IsHandled := true;
                end;
        end;
    end;
}
