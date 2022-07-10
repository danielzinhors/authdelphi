inherited ServiceAuth: TServiceAuth
  inherited FDConnection: TFDConnection
    Connected = True
  end
  object qryLogin: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select u.id, u.senha'
      'from usuario u'
      'where u.login=:login'
      '  and u.status=1')
    Left = 136
    Top = 40
    ParamData = <
      item
        Name = 'LOGIN'
        ParamType = ptInput
      end>
    object qryLoginid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryLoginsenha: TWideStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 255
    end
  end
end
