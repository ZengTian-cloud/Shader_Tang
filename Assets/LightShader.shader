Shader "Test/NewUnlitShader" {
    Properties {
        _MainColor ("MainColor", COLOR) = (1, 1, 1, 1)
        _SpecularNum("SpecularNum", Range(0, 20)) = 0.5
    }

    SubShader {
        Tags { "LightMode" = "ForwardBase" }
        

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            fixed4 _MainColor;
            float _SpecularNum;
            // make fog work
            //顶点着色器传递给片元着色器的内容
            struct v2f 
            {
                //裁剪空间下的顶点坐标信息
                float4 pos : SV_POSITION;
                //对应顶点的漫反射光照颜色
                fixed3 color : COLOR;
            };
            
            v2f vert(appdata_base data) {
                v2f v2fdata;

                //兰伯特光照模型
                v2fdata.pos=UnityObjectToClipPos(data.vertex);
                fixed3 normal=UnityObjectToWorldNormal(data.normal);
                fixed3 lightDir=normalize(_WorldSpaceLightPos0.xyz);
                //半兰伯特就是把这个乘以0.5+0.5
                fixed3 lambotColor=_MainColor*_LightColor0*max(0,dot(normal,lightDir));

                //高光反射
                //计算观察向量方向
                fixed3 WorldPos=mul(UNITY_MATRIX_M,data.vertex);//将点转换为世界坐标
                fixed3 LookDir=normalize(_WorldSpaceCameraPos-WorldPos);//观察向量
                //计算反射角度方向
                fixed3 revertDir=reflect(-lightDir,normal);
                fixed3 PhoneColor=_LightColor0.rgb * _MainColor.rgb * pow( max(0, dot(LookDir, revertDir)), _SpecularNum);
                v2fdata.color=lambotColor+PhoneColor+UNITY_LIGHTMODEL_AMBIENT;
                        
                return v2fdata;
            }
            fixed4 frag(v2f i) : SV_Target {
                return fixed4(i.color.rgb, 1);
            }
            ENDCG
        }
    }
}