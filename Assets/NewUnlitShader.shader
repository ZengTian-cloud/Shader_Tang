Shader "Unlit/NewUnlitShader" {
    Properties {
    _MainTex("Texture",2D)=""{}
    }
    SubShader {
        
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"   

            //映射对应纹理属性的图片颜色相关数据
            sampler2D _MainTex;
            //纹理平移和缩放
            float4 _MainTex_ST;//xy代表缩放,zw代表平移

            v2f_img vert(appdata_base v) {
                v2f_img o;
                o.pos = UnityObjectToClipPos(v.vertex);

                v.texcoord.xy;//代表uv坐标
                v.texcoord.zw;//代表平移                
                //先缩放后平移
                o.uv=v.texcoord.xy*_MainTex_ST.xy+_MainTex_ST.zw;
                //上下两句一个意思
                o.uv=TRANSFORM_TEX(v.texcoord.xy,_MainTex);                
                return o;
            }

            fixed4 frag(v2f_img i) : SV_Target {
            //进行纹理颜色采样
            fixed4 color=tex2D(_MainTex,i.uv);
            return color;
            }
            ENDCG
        }
    }
}