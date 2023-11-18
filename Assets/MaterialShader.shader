Shader "Unlit/MaterialShader"
{
    Properties
    {
        _Color("Color",Color)=(1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
        _Specular("Specular",Color)=(1,1,1,1)
        _Gloss("Gloss",Range(0,20))=20

    }
    SubShader
    {
        Tags { "LightMode"="ForwardBase" }        

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag            
            fixed4 _Color;
            sampler2D _MainTex;
            fixed4 _Specular;
            fixed _Gloss
            fixed4 _MainTex_ST;

            #include "UnityCG.cginc"

          struct a2v
          {
          fixed4 vertex:POSITION;
          fixed3 normal:NORMAL;
          fixed4 texcoord:TEXCOORD0;
          }
          struct v2f
          {
          fixed4 pos:SV_POSITION;
          fixed3 worldNormal:TEXCOORD0;
          fixed3 worldPos:TEXCOORD1;
          fixed2 uv:TEXCORRD2;
          }
          v2f vert(a2v v)
          {
          v2f o;
          o.pos=UnityObjectToClipPos(v.vertex);
          o.worldNormal=UnityObjectToWorldNormal(v.normal);
          o.worldPos=mul(unity_ObjectToWorld*v.vertex.xyz);
          //o.uv=v.texcoord.xy*_MainTex_ST.xy+_MainTex_ST.zw;==ÏÂÃæÄÇ¾ä
          o.uv=TRANSFORM_TEX(v.texcoord,_MainTex);
          return o;
          }
          fixed4 frag(v2f i):SV_Target
          {
          fixed3 worldNormal=normalize(i.worldNormal);
          fixed3 worldLightDir=normalize(UnityWorldSpaceLightDir(i.worldPos));

          }

            ENDCG
        }
    }
}
