object ProvidersConnection: TProvidersConnection
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FDConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=Cusro_Pooled')
    LoginPrompt = False
    Left = 32
    Top = 32
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorHome = 'C:\planejamento\daniel\Horse\business'
    Left = 112
    Top = 88
  end
end
