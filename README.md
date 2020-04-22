# Horse-ETag
MIddleware para Servidor Horse para Controle de Etags

<iframe width="560" height="315" src="https://www.youtube.com/embed/3sx5resW8qM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Sample Horse Server
```delphi
uses
  Horse, Horse.Etag, Horse.Jhonson, System.JSON;

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
```