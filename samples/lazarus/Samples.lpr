program Samples;

{$MODE DELPHI}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Horse,
  Horse.Etag,
  Horse.Jhonson,
  SysUtils,
  fpjson;

procedure GetPing(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  LContent: TJSONObject;
begin
  LContent := TJSONObject.Create;
  LContent.Add('Teste', 'Teste1');
  Res.Send<TJsonData>(LContent);
end;

begin
  THorse
    .Use(Jhonson)
    .Use(eTag);

  THorse.Get('/ping', GetPing);

  THorse.Listen(9000);
end.
