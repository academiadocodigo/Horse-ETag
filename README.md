# Horse-ETag
MIddleware para Servidor Horse para Controle de Etags

CLIQUE NA IMAGEM ABAIXO PARA ASSISTIR O VIDEO DE DEMONSTRAÇÃO

[![Watch the video](https://img.youtube.com/vi/3sx5resW8qM/maxresdefault.jpg)](https://www.youtube.com/watch?v=3sx5resW8qM)

Sample Horse Server
```delphi
uses Horse, Horse.Etag, Horse.Jhonson, System.JSON;

begin
  THorse
    .Use(Jhonson)
    .Use(eTag);

  THorse.Get('ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send<TJsonObject>(TJsonObject.Create.AddPair('Teste', 'Teste'));
    end);

  THorse.Listen(9000);
end.
```
