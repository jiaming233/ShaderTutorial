Shader "Tutorial/05_Surface"
{
    //show values to edit in inspector
    Properties{
      _Color("Tint", Color) = (0, 0, 0, 1)
      _MainTex("Texture", 2D) = "white" {}

      _Smoothness("Smoothness", Range(0, 1)) = 0
      _Metallic("Metalness", Range(0, 1)) = 0
    }

        SubShader{
        //the material is completely non-transparent and is rendered at the same time as the other opaque geometry
        Tags{ "RenderType" = "Opaque" "Queue" = "Geometry" }

          CGPROGRAM

        //to make the shader correctly handle light 
        //followed by the kind of shader we’re declaring (surface), 
        //then the name of the surface method (surf) 
        //and last the lighting model we want it to use (Standard).
        #pragma surface surf Standard fullforwardshadows

          //texture and transforms of the texture
          sampler2D _MainTex;

          //tint of the texture
          fixed4 _Color;

          half _Smoothness;
          half _Metallic;

          struct Input {
              //Here the naming is important though, we’ll name it uv_MainTex, 
              //this way it will already have the tiling and offset of the MainTex texture. 
              float2 uv_MainTex;
          };

          //SurfaceOutputStandard is all of the data which unity will use for it’s lighting calculations. 
         void surf(Input i, inout SurfaceOutputStandard o) {
            fixed4 col = tex2D(_MainTex, i.uv_MainTex);
            col *= _Color;
            o.Albedo = col.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Smoothness;
        }

        ENDCG
    }
        Fallback "VertexLit"
}
