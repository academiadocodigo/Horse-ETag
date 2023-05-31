unit Horse.Etag;

{$IF DEFINED(FPC)}
  {$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses
  Horse,
  Horse.Commons,
  {$IF DEFINED(FPC)}
    md5,
    fpjson;
  {$ELSE}
    System.SysUtils,
    System.Classes,
    System.JSON,
    Web.HTTPApp,
    IdHashMessageDigest;
  {$ENDIF}

procedure eTag(Req: THorseRequest; Res: THorseResponse; Next: {$IF DEFINED(FPC)}TNextProc{$ELSE}TProc{$ENDIF});

implementation

procedure eTag(Req: THorseRequest; Res: THorseResponse; Next: {$IF DEFINED(FPC)}TNextProc{$ELSE}TProc{$ENDIF});
var
  LContent: TObject;
  LContentStr: String;
  {$IFNDEF FPC}
    Hash: TIdHashMessageDigest5;
  {$ENDIF}
  eTag: String;
begin
  try
    Next;
  finally
    LContentStr := Res.RawWebResponse.Content;
    if (LContentStr.IsEmpty) then
    begin
      LContent := Res.Content;
      if Assigned(LContent) and LContent.InheritsFrom({$IF DEFINED(FPC)}TJSONData{$ELSE}TJSONValue{$ENDIF}) then
        LContentStr := {$IF DEFINED(FPC)}TJSONData{$ELSE}TJSONValue{$ENDIF}(LContent).ToString;
    end;

    {$IF DEFINED(FPC)}
      eTag := MD5Print(MD5String(LContentStr));
    {$ELSE}
      Hash := TIdHashMessageDigest5.Create;
      try
        eTag := Hash.HashStringAsHex(LContentStr);
      finally
        Hash.Free;
      end;
    {$ENDIF}

    if (Req.Headers['If-None-Match'] = eTag) and (eTag <> '') then
    begin
      Res.Status(THTTPStatus.NotModified);
      Res.RawWebResponse.Content := '';
    end;

    Res.RawWebResponse.SetCustomHeader('ETag', eTag);
  end;
end;

end.
