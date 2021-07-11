Function New-MessageBox
{
    [cmdletbinding()]
    param(

    )
    
    $Domain = [AppDomain]::CurrentDomain
    $DynAssembly = New-Object System.Reflection.AssemblyName("DynamicAssembly")
    $AssemblyBuilder = $Domain.DefineDynamicAssembly($DynAssembly, [System.Reflection.Emit.AssemblyBuilderAccess]::Run)
    $ModuleBuilder = $AssemblyBuilder.DefineDynamicModule("DynamicModule", $False)
    $TypeBuilder = $ModuleBuilder.DefineType("user32", "Public, Class")

    $MessageBox = $TypeBuilder.DefineMethod(
        "MessageBox", # Method Name
        [System.Reflection.MethodAttributes] "Public, Static", # Method Attributes
        [Int], # Method Return Type
        [Type[]] @(
            [Int32],
            [String],
            [String],
            [Int32]
        )
    ) 

    $MessageBoxDLL = [System.Runtime.InteropServices.DllImportAttribute].GetConstructor(@([String]))
    $MessageBoxFieldArray = [System.Reflection.FieldInfo[]] @(
        [System.Runtime.InteropServices.DllImportAttribute].GetField("EntryPoint"),
        [System.Runtime.InteropServices.DllImportAttribute].GetField("PreserveSig"),
        [System.Runtime.InteropServices.DllImportAttribute].GetField("SetLastError"),
        [System.Runtime.InteropServices.DllImportAttribute].GetField("CallingConvention"),
        [System.Runtime.InteropServices.DllImportAttribute].GetField("CharSet")
    )
    $MessageBoxFieldValueArray = [Object[]] @(
        "MessageBox",
        $True,
        $True,
        [System.Runtime.InteropServices.CallingConvention]::Winapi,
        [System.Runtime.InteropServices.CharSet]::Auto
    )

    # Create a Custom Attribute and add to our Method
    $MessageBoxCustomAttribute = New-Object System.Reflection.Emit.CustomAttributeBuilder(
        $MessageBoxDLL,
        @("user32.dll"),
        $MessageBoxFieldArray,
        $MessageBoxFieldValueArray
    )
    $MessageBox.SetCustomAttribute($MessageBoxCustomAttribute)

    # Create the Type within our Module
    $User32 = $TypeBuilder.CreateType()
    $User32::MessageBox($null, "Test", "LOLOLOL", 0x00000100)
}