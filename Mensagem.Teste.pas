﻿// Eduardo - 03/08/2024
unit Mensagem.Teste;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  chat.visualizador,
  chat.editor,
  chat.tipos;

type
  TInicio = class(TForm)
    Panel1: TPanel;
    btnTextoEsquerdo: TButton;
    btnTextoDireito: TButton;
    btnImagemDireito: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnTextoEsquerdoClick(Sender: TObject);
    procedure btnTextoDireitoClick(Sender: TObject);
    procedure btnImagemDireitoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    FID: Integer;
    Visualizador: TChatVisualizador;
    Editor: TChatEditor;
    procedure AoVisualizar(Frame: TFrame);
    procedure AoEnviar(Conteudos: TArray<TConteudo>);
    procedure AoClicar(Frame: TFrame; Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  end;

var
  Inicio: TInicio;

implementation

uses
  chat.mensagem;

{$R *.fmx}

procedure TInicio.FormCreate(Sender: TObject);
begin
  Visualizador := TChatVisualizador.Create(Self);
  Self.AddObject(Visualizador);
  Visualizador.Align := TAlignLayout.Client;
  Visualizador.AoVisualizar := AoVisualizar;
  Visualizador.AoClicar := AoClicar;
  Visualizador.LarguraMaximaConteudo := 500;

  Editor := TChatEditor.Create(Self);
  Self.AddObject(Editor);
  Editor.Align := TAlignLayout.Bottom;
  Editor.AoEnviar := AoEnviar;
  Editor.LarguraMaximaConteudo := 500;

  FID := -1;
end;

procedure TInicio.AoVisualizar(Frame: TFrame);
begin
  if Frame is TChatMensagem then
    TChatMensagem(Frame).Piscar(TAlphaColorRec.Blue, 0.5);
end;

procedure TInicio.AoClicar(Frame: TFrame; Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if Frame is TChatMensagem then
    TChatMensagem(Frame).Piscar(TAlphaColorRec.Pink, 0.5);
end;

procedure TInicio.AoEnviar(Conteudos: TArray<TConteudo>);
begin
  Inc(FID);
  Visualizador.AdicionarMensagem(FID, 'ChatEditor', Now, Conteudos);
  Visualizador.Mensagem[FID].Lado := TLado.Direito;
  Visualizador.Posicionar(FID);
end;

procedure TInicio.btnTextoDireitoClick(Sender: TObject);
begin
  Inc(FID);
  Visualizador.AdicionarMensagem(
    FID,
    'Eduardo',
     Now,
    [
      TConteudo.Create(TTipo.Texto, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam finibus lectus sit amet purus convallis auctor.'),
      TConteudo.Create(TTipo.Texto, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout')
    ],
    0
  );
  Visualizador.Mensagem[FID].Lado := TLado.Direito;
  Visualizador.Posicionar(FID);
end;

procedure TInicio.btnTextoEsquerdoClick(Sender: TObject);
begin
  Inc(FID);
  Visualizador.AdicionarMensagem(
    FID,
    'Eduardo',
     Now,
    [
      TConteudo.Create(TTipo.Texto, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam finibus lectus sit amet purus convallis auctor.'),
      TConteudo.Create(TTipo.Texto, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout')
    ]
  );
  Visualizador.Mensagem[FID].Lado := TLado.Esquerdo;
end;

procedure TInicio.Button1Click(Sender: TObject);
begin
  case Visualizador.Mensagem[5].Status of
    TStatus.Pendente:    Visualizador.Mensagem[5].Status := TStatus.Recebida;
    TStatus.Recebida:    Visualizador.Mensagem[5].Status := TStatus.Visualizada;
    TStatus.Visualizada: Visualizador.Mensagem[5].Status := TStatus.Pendente;
  end;
end;

procedure TInicio.Button2Click(Sender: TObject);
begin
  case Visualizador.Mensagem[5].Lado of
    TLado.Direito:  Visualizador.Mensagem[5].Lado := TLado.Esquerdo;
    TLado.Esquerdo: Visualizador.Mensagem[5].Lado := TLado.Direito;
  end;
end;

procedure TInicio.Button3Click(Sender: TObject);
begin
  Visualizador.Mensagem[5].NomeVisivel := not Visualizador.Mensagem[5].NomeVisivel;
end;

procedure TInicio.Button4Click(Sender: TObject);
begin
  Visualizador.Posicionar(5);
end;

procedure TInicio.Button5Click(Sender: TObject);
var
  sTemp: String;
begin
  for var I in Visualizador.Visiveis do
    sTemp := sTemp +','+ I.ToString;
  ShowMessage(sTemp);
end;

procedure TInicio.btnImagemDireitoClick(Sender: TObject);
begin
  Inc(FID);
  Visualizador.AdicionarMensagem(
    FID,
    'Eduardo',
    Now,
    [
      TConteudo.Create(TTipo.Imagem, 'C:\Users\Eduar\Pictures\Screenshots\Captura de tela 2023-10-15 170059.png'),
      TConteudo.Create(TTipo.Imagem, 'C:\Users\Eduar\Pictures\Screenshots\Captura de tela 2023-10-15 170059.png'),
      TConteudo.Create(TTipo.Texto, 'Ísis'),
      TConteudo.Create(TTipo.Texto, 'Ayla')
    ]
  );
  Visualizador.Mensagem[FID].Lado := TLado.Direito;
  Visualizador.Mensagem[FID].NomeVisivel := True;
end;

procedure TInicio.Button6Click(Sender: TObject);
begin
  Visualizador.RemoverMensagem(5);
end;

procedure TInicio.Button7Click(Sender: TObject);
begin
  Visualizador.AdicionarSeparadorData(EncodeDate(2024, 08, 01), 200);
end;

procedure TInicio.Button8Click(Sender: TObject);
begin
  Visualizador.RemoveSeparadorData(EncodeDate(2024, 08, 01));
end;

end.
