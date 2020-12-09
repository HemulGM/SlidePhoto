unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics, 
  FMX.Dialogs, System.Math.Vectors, FMX.Ani, FMX.Objects, FMX.Layouts,
  FMX.Layers3D, FMX.Effects, FMX.Objects3D, FMX.Controls3D, FMX.MaterialSources;

type
  TForm2 = class(TForm3D)
    LightMaterialSource1: TLightMaterialSource;
    Light1: TLight;
    Plane1: TPlane;
    Cube1: TCube;
    ShadowEffect1: TShadowEffect;
    Layer3D1: TLayer3D;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    FloatAnimationSObjX: TFloatAnimation;
    FloatAnimationSObjY: TFloatAnimation;
    FloatAnimationSObjR: TFloatAnimation;
    ShadowEffect2: TShadowEffect;
    FloatKeyAnimation1: TFloatKeyAnimation;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

end.
