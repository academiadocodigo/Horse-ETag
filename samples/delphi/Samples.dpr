program Samples;

uses
  Horse,
  Horse.Etag,
  Horse.Jhonson,
  System.JSON;

begin
  THorse
    .Use(Jhonson)
    .Use(eTag);

  THorse.Get('ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send<TJsonObject>(TJsonObject.Create.AddPair('Teste', 'Teste1'));
    end);

  THorse.Listen(9000);
end.
