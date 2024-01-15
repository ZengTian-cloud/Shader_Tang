Shader "Unlit/news"
{   Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" { }
        _SliceBorder ("Slice Border", Range (0, 0.5)) = 0.1
    }
    
    SubShader
    {
        Tags { "Queue" = "Overlay" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float _SliceBorder;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            
            fixed4 frag(v2f i) : COLOR
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                
                // ¾Å¹¬¸ñÀ­ÉìÂß¼­
                float2 uvScaled = i.uv * 2 - 1; // ½«UVÓ³Éäµ½[-1, 1]·¶Î§
                
                float2 border = _SliceBorder * 0.5;
                float2 scale = 1 - step(border, abs(uvScaled));
                
                col.rgb *= scale.x * scale.y;
                
                return col;
            }
            ENDCG
        }
    }
}
