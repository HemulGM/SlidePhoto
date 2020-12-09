unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Ani, FMX.Effects;

type
  TForm1 = class(TForm)
    Rectangle1: TRectangle;
    LayoutSwipeFrame: TLayout;
    FloatAnimationSObjX: TFloatAnimation;
    FloatAnimationSObjY: TFloatAnimation;
    FloatAnimationSObjR: TFloatAnimation;
    ShadowEffectSwipe: TShadowEffect;
    Rectangle2: TRectangle;
    ShadowEffect1: TShadowEffect;
    procedure Rectangle1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LayoutSwipeFrameMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure LayoutSwipeFrameMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure FormCreate(Sender: TObject);
    procedure FloatAnimationSObjRProcess(Sender: TObject);
    procedure LayoutSwipeFrameMouseLeave(Sender: TObject);
  private
    FSwipeObject: TRectangle;
    FSwipe: Boolean;
    FSwipePos: TPointF;
    FSwipeDirTop: Boolean;
    procedure ResetSwipeObject(const SObject: TRectangle);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FloatAnimationSObjRProcess(Sender: TObject);
begin
  ShadowEffectSwipe.UpdateParentEffects;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ResetSwipeObject(Rectangle1);
end;

procedure TForm1.LayoutSwipeFrameMouseLeave(Sender: TObject);
begin
  LayoutSwipeFrameMouseUp(Sender, TMouseButton.mbLeft, [], 0, 0);
end;

procedure TForm1.LayoutSwipeFrameMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
  A: Single;
begin
  if FSwipe and Assigned(FSwipeObject) then
  begin
    FSwipeObject.Position.Point := TPointF.Create(FSwipeObject.Position.Point.X + (Screen.MousePos.X - FSwipePos.X), FSwipeObject.Position.Point.Y + (Screen.MousePos.Y - FSwipePos.Y));
    A := ((LayoutSwipeFrame.Width / 2) - (FSwipeObject.Position.X + FSwipeObject.Width / 2));
    if FSwipeDirTop then
      A := -0.2 * A
    else
      A := 0.2 * A;
    FSwipeObject.RotationAngle := A; //-90..90
    ShadowEffectSwipe.UpdateParentEffects;
    FSwipePos := Screen.MousePos;
  end;
end;

procedure TForm1.ResetSwipeObject(const SObject: TRectangle);
begin
  FloatAnimationSObjX.Enabled := False;
  FloatAnimationSObjY.Enabled := False;
  FloatAnimationSObjR.Enabled := False;

  FloatAnimationSObjX.Parent := SObject;
  FloatAnimationSObjY.Parent := SObject;
  FloatAnimationSObjR.Parent := SObject;

  FloatAnimationSObjX.StopValue := (LayoutSwipeFrame.Width / 2) - (SObject.Width / 2);
  FloatAnimationSObjY.StopValue := (LayoutSwipeFrame.Height / 2) - (SObject.Height / 2);

  FloatAnimationSObjX.Enabled := True;
  FloatAnimationSObjY.Enabled := True;
  FloatAnimationSObjR.Enabled := True;
end;

procedure TForm1.LayoutSwipeFrameMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if FSwipe then
  begin
    FSwipe := False;
    if Assigned(FSwipeObject) then
    begin
      FSwipeObject.HitTest := True;
      ResetSwipeObject(FSwipeObject);
      FSwipeObject := nil;
    end;
    FSwipePos := Screen.MousePos;
    LayoutSwipeFrame.HitTest := False;
  end;
end;

procedure TForm1.Rectangle1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FSwipeObject := (Sender as TRectangle);
  FSwipePos := Screen.MousePos;
  FSwipe := True;
  FSwipeObject.HitTest := False;
  FSwipeDirTop := Y < FSwipeObject.Height / 2;
  if FSwipeDirTop then
    FSwipeObject.RotationCenter.Point := TPointF.Create(0.5, 1)
  else
    FSwipeObject.RotationCenter.Point := TPointF.Create(0.5, 0);
  LayoutSwipeFrame.HitTest := True;
end;

end.

