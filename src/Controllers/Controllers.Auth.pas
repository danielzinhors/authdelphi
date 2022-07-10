unit Controllers.Auth;

interface

procedure Registry;

implementation

uses
  Horse, System.JSON, Services.Auth, Jose.Core.Jwt, Jose.Core.Builder,
  System.SysUtils, dateUtils, Horse.JWT;

const
  CHAVE = 'curso-rest-rorse';

function getToken(const AIdUsuario: String; const AExpiration: TDateTime): String;
begin
  var LJWT := TJWT.Create;
  try
    LJWT.claims.IssuedAt := now;
    LJWT.claims.Expiration := AExpiration;
    LJWT.claims.Subject := AIdUsuario;
    result := TJose.SHA256CompactToken(CHAVE, LJWT);
  finally
    LJWT.free;
  end;
end;

procedure efetuarLogin(req: THorseRequest; res: THorseResponse; next: TProc);
begin
  var LConteudo := req.body<TJSONObject>;
  var LUsuario := '';
  if not LConteudo.tryGetValue<string>('username', LUsuario) then
    raise EHorseException.new.status(THTTPStatus.badRequest).title('Usuário não informado').error('Não foi informado usuário no json');
  var LSenha := '';
  if not LConteudo.tryGetValue<string>('senha', LSenha) then
    raise EHorseException.new.status(THTTPStatus.badRequest).title('Senha não informado').error('Não foi informado senha no json');
  var LService := TServiceAuth.create(nil);
  try
    if not LService.permitirAcesso(LUsuario, LSenha) then
      raise EHorseException.new.status(THTTPStatus.Unauthorized).title('Usuário não autorizado').error('Usuário não autorizado no sistema');
    var LToken := TJSONObject.create();
    LToken.addPair('access', getToken(LService.qryLoginId.asString, IncMinute(now, 1)));
    LToken.addPair('refresh', getToken(LService.qryLoginId.asString, incMonth(now, 1)));
    res.send(LToken);
  finally

  end;
end;

procedure renovarToken(req: THorseRequest; res: THorseResponse; next: TProc);
begin
  var LSub := req.session<TJSONObject>.getValue<string>('sub');
  var LToken := getToken(LSub, incHour(now));
  res.send(TJSONObject.create(TJSONPair.create('access', LToken)));
end;

procedure Registry;
begin
  THorse.Post('/login', efetuarLogin);
  THorse.AddCallback(HorseJWT(CHAVE)).get('/refresh', renovarToken);
end;

end.
