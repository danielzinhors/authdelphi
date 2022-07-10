unit Services.Auth;

interface

uses
  System.SysUtils, System.Classes, Providers.Connection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait;

type
  TServiceAuth = class(TProvidersConnection)
    qryLogin: TFDQuery;
    qryLoginid: TLargeintField;
    qryLoginsenha: TWideStringField;
  private
    { Private declarations }
  public
     function permitirAcesso(const AUsuraio, ASenha: String): boolean ;
  end;

var
  ServiceAuth: TServiceAuth;

implementation

uses
  bcrypt;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceAuth }

function TServiceAuth.permitirAcesso(const AUsuraio, ASenha: String): boolean;
begin
  qryLogin.paramByName('login').asString := AUsuraio;
  qryLogin.open;
  if qryLogin.isEmpty then
    exit(false);
  result := TBCrypt.compareHash(ASenha, qryLoginsenha.asString);
end;

end.
