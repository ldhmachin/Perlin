unit uNoteObjects;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, ExtCtrls, StdCtrls, Graphics;

type
  TNoteObjects = (noCGP_Header,
                  noCGP_TextBox,
                  Basic_Header,
                  Basic_Image,
                  Basic_TextBox);

const
  StrNoteObjects : array [TNoteObjects] of string[16]
    = ('CGP Header',
       'CGP Textbox',
       'Basic Header',
       'Basic Image',
       'Basic Textbox');

  OBJECT_BUFFER = 12;

  clCGPHeader = $00884A4F;
  clCGPSubheader = $00B4CBA8;
  clWashedPink = $00E5DEED;
  clWashedBlue = $00EEE1DE;
  clWashedRed = $00E1E1F5;

type
  TNoteObject = class
    private
      Container: TWinControl;
      Panel: TPanel;
    public
      destructor Destroy;
  end;

  TnoCGP_Header = class(TNoteObject)
    private
      Text: TLabel;
    public
      constructor Create(Cont: TWinControl; var Pos: integer; Str: string);
  end;

  TnoCGP_Subheader = class(TNoteObject)
    private
      Text: TLabel;
    public
      constructor Create(Cont: TWinControl; var Pos: integer; Str: string);
  end;

  TnoBasic_Textbox = class(TNoteObject)
    private
      Text: TMemo;
    public
      constructor Create(Cont: TWinControl; var Pos: integer; Str: string);
  end;

  TnoBasic_Image = class(TNoteObject)
    private
      Image: TImage;
    public
      constructor Create(Cont: TWinControl; var Pos: integer; Path: string);
  end;


implementation

uses
  Dialogs, uNotebook;

destructor TNoteObject.Destroy;
begin
  Panel.Destroy;
end;

constructor TnoBasic_Image.Create(Cont: TWinControl; var Pos: integer; Path: string);
begin
  Container:= Cont;
  Panel:= TPanel.Create(nil);
  // incomplete
  {
    Need to find a way of keeping ratio between height and width of image
    on scaling.
  }
end;

constructor TnoBasic_Textbox.Create(Cont: TWinControl; var Pos: integer; Str: string);
begin
  Container:= Cont;
  Panel:= TPanel.Create(nil);
  with Panel do
    begin
      Parent:= Cont;
      Width:= notebookCurrentWidth-48;
      Height:= 90;
      Left:= 28;
      Top:= Pos;
      BevelWidth:= 0;
      Color:= clWhite;
    end;
  Text:= TMemo.Create(nil);
  with Text do
    begin
      Parent:= Panel;
      Text:= Str;
      BorderStyle:= bsNone;
      WordWrap:= True;
      Width:= notebookCurrentWidth;
      //Height:= Panel.Height;
      Height:=  Lines.Count * 16;
      Panel.Height:= Height;
    end;
  Pos:= Pos+Panel.Height+OBJECT_BUFFER;
end;

constructor TnoCGP_Header.Create(Cont: TWinControl; var Pos: integer; Str: string);
begin
  Container:= Cont;
  Panel:= TPanel.Create(nil);
  with Panel do
    begin
      Parent:= Cont;
      Width:= notebookCurrentWidth-16;
      Height:= 40; // VARIES BETWEEN OBJECTS
      Left:= 8;
      Top:= Pos;
      BevelWidth:= 0;
      Color:= clCGPHeader;
    end;
  Text:= TLabel.Create(nil);
  with Text do
    begin
      Parent:= Panel;
      Caption:= Str;
      Font.Color:= clWhite;
      Font.Size:= 14;
      Font.Style:= [fsBold];
      AutoSize:= False;
      Width:= Panel.Width;
      Height:= Panel.Height;
      Layout:= tlCenter;
      Alignment:= taCenter;
    end;
  Pos:= Pos+Panel.Height+OBJECT_BUFFER;
end;

constructor TnoCGP_Subheader.Create(Cont: TWinControl; var Pos: integer; Str: string);
begin
  Container:= Cont;
  Panel:= TPanel.Create(nil);
  with Panel do
    begin
      Parent:= Cont;
      Width:= notebookCurrentWidth div 3;
      Height:= 28; // VARIES BETWEEN OBJECTS
      Left:= 24;
      Top:= Pos;
      BevelWidth:= 0;
      Color:= clCGPSubheader;
    end;
  Text:= TLabel.Create(nil);
  with Text do
    begin
      Parent:= Panel;
      Caption:= Str;
      Font.Color:= clBlack;
      Font.Size:= 12;
      Font.Style:= [fsItalic];
      AutoSize:= False;
      Width:= Panel.Width;
      Height:= Panel.Height;
      Layout:= tlCenter;
      Alignment:= taCenter;
    end;
  Pos:= Pos+Panel.Height+OBJECT_BUFFER;
end;

end.

