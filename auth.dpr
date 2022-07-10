program auth;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  System.SysUtils,
  Controllers.Auth in 'src\Controllers\Controllers.Auth.pas',
  Providers.Connection in 'src\Providers\Providers.Connection.pas' {ProvidersConnection: TDataModule},
  Services.Auth in 'src\Services\Services.Auth.pas' {ServiceAuth: TDataModule};

begin
  THorse
    .use(Jhonson())
    .Use(HandleException);
  Controllers.Auth.registry;
  THorse.Listen(9001);
end.
