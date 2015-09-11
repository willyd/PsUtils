Function Remove-AndImportModule {
    [CmdletBinding()]
    Param()
    DynamicParam {
            $Options = get-module | % { $_.Name }
            New-DynamicParam -Name Name -ValidateSet $Options -Position 0 -Mandatory
    }
    begin {
    #have to manually populate
    $Name = $PSBoundParameters.Name    
    }
    process {
        $Module = Get-Module $_
        if($Module) {
            Remove-Module $_            
        }
        Import-Module $_
    }
    end {}
}

New-Alias reload Remove-AndImportModule -Scope Global