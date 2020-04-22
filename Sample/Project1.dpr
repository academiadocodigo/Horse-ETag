program Project1;

uses
  Horse,
  Horse.Etag,
  Horse.Jhonson,
  System.JSON;

var
  App: THorse;

begin
  App := THorse.Create(9000);

  App.Use(Jhonson);
  App.Use(eTag);

  App.Get('ping',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
	begin
    Res.Send<TJsonObject>(TJsonObject.Create.AddPair('Teste', 'Teste'));
  end);

  App.Start;
end.
