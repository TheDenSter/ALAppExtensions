﻿// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Finance.VAT.Reporting;

/// <summary>
/// The interface to calculate the amount for a specific box on the IRS 1099 form.
/// </summary>
interface "IRS 1099 Form Box Calc."
{
    /// <summary>
    /// Calculates the amount for a specific box on the IRS 1099 form according to the calculated parameters.
    /// </summary>
    /// <param name="TempVendFormBoxBuffer">The calculated buffer</param>
    /// <param name="IRS1099CalcParameters">The calculated parameters</param>
    procedure GetVendorFormBoxAmount(var TempVendFormBoxBuffer: Record "IRS 1099 Vend. Form Box Buffer" temporary; IRS1099CalcParameters: Record "IRS 1099 Calc. Params")
}
