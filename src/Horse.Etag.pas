unit Horse.Etag;

{$IF DEFINED(FPC)}
{$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses
  {$IF DEFINED(FPC)}
    fpjson, md5,
  {$ELSE}
    System.SysUtils, System.Classes, System.JSON, Web.HTTPApp, IdHashMessageDigest,
  {$ENDIF}
  Horse, Horse.Commons;

procedure eTag(Req: THorseRequest; Res: THorseResponse; Next: {$IF DEFINED(FPC)}TNextProc{$ELSE}TProc{$ENDIF});

implementation

procedure eTag(Req: THorseRequest; Res: THorseResponse; Next: {$IF DEFINED(FPC)}TNextProc{$ELSE}TProc{$ENDIF});
var
  LContent: TObject;
  {$IFNDEF FPC}
    Hash: TIdHashMessageDigest5;
  {$ENDIF}
  eTag: String;
begin
  try
    Next;
  finally
    LContent := Res.Content;

    if Assigned(LContent) and LContent.InheritsFrom({$IF DEFINED(FPC)}TJSONData{$ELSE}TJSONValue{$ENDIF}) then
    begin
      {$IFNDEF DEFINED(FPC)}
      eTag := MD5Print(MD5String(TJSONData(LContent).ToString));
      {$ELSE}
      Hash := TIdHashMessageDigest5.Create;
      try
        eTag := Hash.HashStringAsHex({$IF DEFINED(FPC)}TJSONData{$ELSE}TJSONValue{$ENDIF}(LContent).ToString);
      finally
        Hash.Free;
      end;
      {$ENDIF}
    end;

    if (Req.Headers['If-None-Match'] = eTag) and (eTag <> '') then
    begin
      Res.Status(THTTPStatus.NotModified);
      Res.Content(nil);
    end;

    Res.RawWebResponse.SetCustomHeader('ETag', eTag);
  end;
end;

end.
