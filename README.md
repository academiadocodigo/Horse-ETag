# eTag
<b>eTag</b> is not an official middleware. It was created to facilitate working with eTag using the <a href="https://github.com/HashLoad/horse">Horse</a> framework.
<br>We created a channel on Telegram for questions and support:<br><br>
<a href="https://t.me/hashload">
  <img src="https://img.shields.io/badge/telegram-join%20channel-7289DA?style=flat-square">
</a>

## ⚙️ Installation
Installation is done using the [`boss install`](https://github.com/HashLoad/boss) command:
``` sh
boss install bittencourtthulio/Horse-ETag
```
If you choose to install manually, simply add the following folders to your project, in *Project > Options > Resource Compiler > Directories and Conditionals > Include file search path*
```
../Horse-ETag/src
```

## ✔️ Compatibility
This middleware is compatible with projects developed in:
- [X] Delphi
- [X] Lazarus

## ⚡️ Quickstart
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

## ⚠️ License
`eTag` is free and open-source middleware licensed under the [MIT License](https://github.com/bittencourtthulio/Horse-ETag/blob/master/LICENSE). 
