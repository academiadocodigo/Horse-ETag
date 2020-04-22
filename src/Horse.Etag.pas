unit Horse.Etag;

interface

uses
  System.SysUtils,
  Horse,
  System.Classes,
  System.JSON,
  Web.HTTPApp,
  IdHashMessageDigest;

procedure eTag(Req: THorseRequest; Res: THorseResponse; Next: TProc); overload;


implementation

procedure eTag(Req: THorseRequest; Res: THorseResponse; Next: TProc); overload;
var
  LWebResponse: TWebResponse;
  LContent: TObject;
  Hash : TIdHashMessageDigest5;
  eTag : String;
begin
  try
    Next;
  finally
    LWebResponse := THorseHackResponse(Res).GetWebResponse;
    LContent := THorseHackResponse(Res).GetContent;

    if Assigned(LContent) and LContent.InheritsFrom(TJSONValue) then
    begin
      Hash := TIdHashMessageDigest5.Create;
      try
        eTag := Hash.HashStringAsHex(TJSONValue(LContent).ToString);
      finally
        Hash.Free;
      end;
    end;

     if (Req.Headers['If-None-Match'] = eTag) and (eTag <> '') then
      Res.Status(304);

    THorseHackResponse(Res).GetWebResponse.SetCustomHeader('ETag', eTag);

  end;

end;

end.
