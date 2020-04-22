# Horse-ETag
MIddleware para Servidor Horse para Controle de Etags

Sample Horse Server
```delphi
uses
  Horse, Horse.Etag, System.JSON;

var
  App: THorse;

begin
  App := THorse.Create(9000);

  App.Use(eTag);

  App.Post('ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      Res.Send('Result');
    end);

  App.Start;
end.
```