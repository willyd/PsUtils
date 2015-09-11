Function Remove-AndImportModule {
    [CmdletBinding()]
    Param()
    DynamicParam {
            $Options = get-module | % { $_.Name }
            New-DynamicParam -Name Name -ValidateSet $Options -Position 0 -Mandatory
    }
}

New-Alias reload Remove-AndImportModule -Scope Global