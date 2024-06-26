namespace Microsoft.CRM.EmailLoggin;

using Microsoft.Utilities;
using System.Environment;
using System.Threading;
using System.Security.Encryption;
using System.Email;
using System.Security.Authentication;

page 1680 "Email Logging Setup"
{
    Caption = 'Email Logging';
    PageType = Card;
    ApplicationArea = RelationshipMgmt;
    UsageCategory = Administration;
    SourceTable = "Email Logging Setup";
    Permissions = tabledata "Email Logging Setup" = rimd;

    layout
    {
        area(Content)
        {
            group(GeneralSection)
            {
                Caption = 'General';

                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Shared Mailbox Email';
                    ToolTip = 'Specifies the email address of the shared mailbox in Exchange Online that was created for email logging. The shared mailbox must be in the same tenant as Business Central.';
                    ShowMandatory = true;
                    Enabled = not IsEmailLoggingEnabled;
                    NotBlank = true;
                    ExtendedDatatype = EMail;

                    trigger OnValidate()
                    var
                        MailManagement: Codeunit "Mail Management";
                        EmailAddress: Text;
                    begin
                        EmailAddress := Rec."Email Address";
                        MailManagement.ValidateEmailAddressField(EmailAddress);
                    end;
                }
                field("Email Batch Size"; Rec."Email Batch Size")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Email Batch Size';
                    ToolTip = 'Specifies the number of email messages that the job queue entry for email logging will get from Exchange Online in one run. By balancing this number with how often the job queue entry runs you can fine tune the process. If a message is not logged in the current run it will be in the next one.';
                    ShowMandatory = true;
                    Enabled = not IsEmailLoggingEnabled;
                    NotBlank = true;
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Enabled', Comment = 'Name of the toggle that shows whether email logging is enabled.';
                    ToolTip = 'Specifies whether email logging is enabled.';

                    trigger OnValidate()
                    begin
                        IsEmailLoggingEnabled := Rec.Enabled;
                        if not IsEmailLoggingEnabled then begin
                            EmailLoggingManagement.DeleteEmailLoggingJobQueueSetup();
                            Session.LogMessage('0000G0Q', EmailLoggingDisabledTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', CategoryTok);
                            exit;
                        end;

                        if not Confirm(DataHandlingConsentQst, false) then
                            Error('');

                        if OAuthClient.GetApplicationType() <> Enum::"Email Logging App Type"::"First Party" then begin
                            SignInAndGiveAppConsent();
                            SignInAndRenewToken();
                        end;

                        CheckSharedMailboxAvailability();

                        EmailLoggingManagement.DeleteEmailLoggingJobQueueSetup();
                        Session.LogMessage('0000G0R', CreateEmailLoggingJobTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', CategoryTok);
                        EmailLoggingManagement.CreateEmailLoggingJobQueueSetup();
                        Session.LogMessage('0000G0S', EmailLoggingEnabledTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', CategoryTok);
                    end;
                }
            }
            group(OAuth2Section)
            {
                Visible = not SoftwareAsAService;
                ShowCaption = false;

                field("Client Id"; Rec."Client Id")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Client ID';
                    Enabled = not IsEmailLoggingEnabled;
                    ToolTip = 'Specifies the ID of the Azure Active Directory application that will be used to connect to Exchange Online.', Comment = 'Exchange Online and Azure Active Directory are names of a Microsoft service and a Microsoft Azure resource and should not be translated.';
                }
                field("Client Secret Key"; ClientSecretTemp)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Client Secret';
                    ExtendedDatatype = Masked;
                    Enabled = not IsEmailLoggingEnabled;
                    ToolTip = 'Specifies the Azure Active Directory application secret that will be used to connect to Exchange Online.', Comment = 'Exchange Online and Azure Active Directory are names of a Microsoft service and a Microsoft Azure resource and should not be translated.';

                    trigger OnValidate()
                    begin
                        Rec.SetClientSecret(ClientSecretTemp);
                    end;
                }
                field("Redirect URL"; Rec."Redirect URL")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Redirect URL';
                    ExtendedDatatype = URL;
                    Enabled = not IsEmailLoggingEnabled;
                    ToolTip = 'Specifies the redirect URL of the Azure Active Directory application that will be used to connect to Exchange Online.', Comment = 'Exchange Online and Azure Active Directory are names of a Microsoft service and a Microsoft Azure resource and should not be translated.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AssistedSetup)
            {
                ApplicationArea = RelationshipMgmt;
                Image = CheckJournal;
                Caption = 'Assisted Setup';
                ToolTip = 'Assisted Setup';
                Enabled = not IsEmailLoggingEnabled;

                trigger OnAction()
                begin
                    Commit(); // Make sure all data is committed before we run the wizard
                    Page.RunModal(Page::"Email Logging Setup Wizard");
                    if Rec.Find() then;
                    CurrPage.Update(false);
                end;

            }
            action(RenewToken)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Renew Token';
                ToolTip = 'Renew the token for connecting to the shared mailbox. You must sign in with an Exchange Online account that the scheduled job will use to connect to the shared mailbox and process emails. Use this to change the user, or if the token has expired.';
                Image = AuthorizeCreditCard;
                Visible = IsEmailLoggingEnabled and UseThirdPartyApp;

                trigger OnAction()
                begin
                    if SignInAndRenewToken() then
                        Message(SucceedRenewTokenTxt);
                end;
            }
            action(ValidateSetup)
            {
                ApplicationArea = RelationshipMgmt;
                Image = CheckJournal;
                Caption = 'Validate Setup';
                ToolTip = 'Validate the settings for email logging.';
                Enabled = IsEmailLoggingEnabled;

                trigger OnAction()
                begin
                    CheckSharedMailboxAvailability();
                    Message(SetupValidatedTxt);
                end;
            }
            action(RecreateJob)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Recreate Job';
                ToolTip = 'Recreate the job queue entry that processes email messages and creates interaction log entries.';
                Image = ResetStatus;
                Visible = IsEmailLoggingEnabled;

                trigger OnAction()
                begin
                    EmailLoggingManagement.UpdateEmailLoggingJobQueueSetup();
                end;
            }
            action(ClearSetup)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Clear Setup';
                Image = ClearLog;
                ToolTip = 'Clear all settings for email logging.';
                Enabled = not IsEmailLoggingEnabled;

                trigger OnAction()
                begin
                    if Confirm(ClearSetupTxt, true) then
                        EmailLoggingManagement.ClearEmailLoggingSetup(Rec);
                end;
            }
        }

        area(Navigation)
        {
            action(EncryptionManagement)
            {
                ApplicationArea = Advanced;
                Caption = 'Encryption Management';
                Image = EncryptionKeys;
                RunObject = Page "Data Encryption Management";
                RunPageMode = View;
                ToolTip = 'Turn data encryption on or off. Data encryption helps make sure that unauthorized users cannot read business data.';
                Visible = not SoftwareAsAService;
            }
            action("Job Queue Entry")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Job Queue Entry';
                Image = JobListSetup;
                ToolTip = 'View the job queue entry that processes email messages and creates interaction log entries.';

                trigger OnAction()
                var
                    JobQueueEntry: Record "Job Queue Entry";
                begin
                    JobQueueEntry.FilterGroup := 2;
                    JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
                    JobQueueEntry.SetRange("Object ID to Run", Codeunit::"Email Logging Job Runner");
                    JobQueueEntry.FilterGroup := 0;

                    Page.Run(Page::"Job Queue Entries", JobQueueEntry);
                end;
            }
            action(ActivityLog)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Activity Log';
                Image = Log;
                ToolTip = 'View the status and any errors that occurred while processing email messages and creating interaction log entries.';

                trigger OnAction()
                var
                    ActivityLog: Record "Activity Log";
                    RecordId: RecordId;
                begin
                    EmailLoggingManagement.GetActivityLogRelatedRecordId(RecordId);
                    ActivityLog.ShowEntries(RecordId);
                end;
            }
        }
    }

    trigger OnInit()
    var
        EnvironmentInformation: Codeunit "Environment Information";
        ApplicationType: Enum "Email Logging App Type";
    begin
        Session.LogMessage('0000HAG', StrSubstNo(ContextCompanyTxt, CompanyName()), Verbosity::Normal, DataClassification::OrganizationIdentifiableInformation, TelemetryScope::ExtensionPublisher, 'Category', CategoryTok);
        SoftwareAsAService := EnvironmentInformation.IsSaaSInfrastructure();
        EmailLoggingManagement.InitializeOAuthClient(OAuthClient);
        ApplicationType := OAuthClient.GetApplicationType();
        UseThirdPartyApp := ApplicationType = ApplicationType::"Third Party";
        EmailLoggingManagement.RegisterAssistedSetup();
    end;

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec."Redirect URL" := Rec.GetDefaultRedirectUrl();
            Rec."Email Batch Size" := Rec.GetDefaultEmailBatchSize();
            Rec.Insert();
        end else
            if Rec."Redirect URL" = '' then begin
                Rec."Redirect URL" := Rec.GetDefaultRedirectUrl();
                Rec.Modify();
            end;

        ClientSecretTemp := '';
        if (Rec."Client Id" <> '') and (not IsNullGuid(Rec."Client Secret Key")) then
            ClientSecretTemp := '**********';

        IsEmailLoggingEnabled := Rec.Enabled;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        IsEmailLoggingEnabled := Rec.Enabled;
    end;

    var
        EmailLoggingManagement: Codeunit "Email Logging Management";
        OAuthClient: Interface "Email Logging OAuth Client";
        SoftwareAsAService: Boolean;
        UseThirdPartyApp: Boolean;
        IsEmailLoggingEnabled: Boolean;
        [NonDebuggable]
        ClientSecretTemp: Text;
        CannotAccessMailboxErr: Label 'Could not access the shared mailbox.';
        ClearSetupTxt: Label 'This clears the settings in your email logging setup. Do you want to continue?';
        GiveConsentTxt: Label 'You must sign in with an administrator account for Exchange Online and give consent to the application that will be used to connect to the shared mailbox. Do you want to continue?';
        SignInTxt: Label 'You must sign in with an Exchange Online account that the scheduled job will use to connect to the shared mailbox and process emails. Do you want to continue?';
        SetupValidatedTxt: Label 'The setup for email logging is ready to use.';
        SucceedRenewTokenTxt: Label 'The token was successfully renewed.';
        EmailLoggingEnabledTxt: Label 'Email logging has been enabled.', Locked = true;
        EmailLoggingDisabledTxt: Label 'Email logging has been disabled.', Locked = true;
        CreateEmailLoggingJobTxt: Label 'Create email logging job', Locked = true;
        ContextCompanyTxt: Label 'Open Email Logging setup. Company: %1', Locked = true;
        CategoryTok: Label 'Email Logging', Locked = true;
        DataHandlingConsentQst: Label 'This feature requires that you are using Microsoft Exchange Online. By enabling this feature, you consent to sharing some of your organization''s data in Office 365 with Business Central. Business Central will access details about email messages in the shared mailbox that your administrator created for email logging. The details include the message’s IDs, whether it is a draft, the dates and times it was sent and received, the text from the Subject line, a link to the message in Exchange Online, and the email addresses of the sender and the recipients on the To and Cc lines.\\Business Central will store only the IDs, dates, subject, and weblink. We do not store the content of the messages, but there is a link that will open the email message in Outlook Online.\\Do you want to continue?';

    [TryFunction]
    local procedure SignInAndGiveAppConsent()
    var
        TenantId: Text;
        AccessToken: SecretText;
    begin
        if Rec."Consent Given" then
            exit;
        if not Confirm(GiveConsentTxt, false) then
            Error('');
        OAuthClient.Initialize();
        OAuthClient.GetAccessToken(Enum::"Prompt Interaction"::"Admin Consent", AccessToken);
        TenantId := EmailLoggingManagement.ExtractTenantIdFromAccessToken(AccessToken);
        Rec."Consent Given" := TenantId <> '';
    end;

    local procedure SignInAndRenewToken(): Boolean
    var
        AccessToken: SecretText;
    begin
        if not Confirm(SignInTxt, false) then
            Error('');
        OAuthClient.Initialize();
        OAuthClient.GetAccessToken(Enum::"Prompt Interaction"::"Select Account", AccessToken);
        EmailLoggingManagement.UpdateEmailLoggingJobQueueSetup();
        exit(not AccessToken.IsEmpty());
    end;

    local procedure CheckSharedMailboxAvailability()
    var
        EmailLoggingAPIHelper: Codeunit "Email Logging API Helper";
    begin
        if not EmailLoggingAPIHelper.IsSharedMailboxAvailable(Rec."Email Address") then
            Error(CannotAccessMailboxErr);
    end;
}

