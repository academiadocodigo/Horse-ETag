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

![image](https://github.com/academiadocodigo/Horse-ETag/assets/16382981/ed4d8553-cf5f-413c-8522-8b6c08961bb0)

![image](https://github.com/academiadocodigo/Horse-ETag/assets/16382981/5a61fe20-9218-4416-bb25-c5ceca4765e9)

## ⚠️ License
`eTag` is free and open-source middleware licensed under the [MIT License](https://github.com/bittencourtthulio/Horse-ETag/blob/master/LICENSE). 
