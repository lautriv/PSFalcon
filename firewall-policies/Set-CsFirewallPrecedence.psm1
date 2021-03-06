function Set-CsFirewallPrecedence {
<#
    .SYNOPSIS
        Sets the precedence of Firewall policies based on the order of IDs specified in the request. The
        first ID specified will have the highest precedence and the last ID specified will have the lowest.
        You must specify all non-Default Policies for a platform when updating precedence.

    .PARAMETER ID
        An array of one or more Firewall policy IDs

    .PARAMETER PLATFORM
        Target operating system
#>
    [CmdletBinding()]
    [OutputType([psobject])]
    param(
        [Parameter(Mandatory = $true)]
        [array]
        $Id,

        [ValidateSet('Linux', 'Mac', 'Windows')]
        [string]
        $Platform = 'Windows'
    )
    process{
        $Param = @{
            Uri = '/policy/entities/firewall-precedence/v1'
            Method = 'post'
            Header = @{
                accept = 'application/json'
                'content-type' = 'application/json'
            }
            Body = @{
                ids = $Id
                platform_name = $Platform
            } | ConvertTo-Json
        }
        switch ($PSBoundParameters.Keys) {
            'Verbose' { $Param['Verbose'] = $true }
            'Debug' { $Param['Debug'] = $true }
        }
        Invoke-CsAPI @Param
    }
}