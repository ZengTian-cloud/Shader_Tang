Shader "Unlit/Lesson35_Specular"
{
    Properties
    {
        //高光反射颜色
        _SpecularColor("SpecularColor", Color) = (1,1,1,1)
        //光泽度
        _SpecularNum("SpecularNum", Range(0, 20)) = 0.5
    }
    SubShader
    {
        Tags { "LightMode"="ForwardBase" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            struct v2f
            {
                //裁剪空间下的 顶点坐标
                float4 pos:SV_POSITION;
                //颜色信息
                fixed3 color:COLOR;
            };

            //对应属性当中的颜色和光泽度
            fixed4 _SpecularColor;
            float _SpecularNum;

            v2f vert (appdata_base v)
            {
                v2f data;
                //1.将顶点坐标转换到裁剪空间当中
                data.pos = UnityObjectToClipPos(v.vertex);
                //2.计算颜色相关
                //高光反射光照颜色 = 光源的颜色 * 材质高光反射颜色 * max（0, 标准化后观察方向向量· 标准化后的反射方向）幂
                //光源的颜色 _LightColor.rgb
                //材质高光反射颜色 _SpecularColor.rgb
                //幂(光泽度) _SpecularNum

                //1.标准化后观察方向向量
                //将模型空间下的顶点位置 转换到 世界空间下 
                // UNITY_MATRIX_M : 从模型空间下 转到 世界空间下的转换矩阵
                float3 worldPos = mul(UNITY_MATRIX_M, v.vertex);
                //得到的就是视角方向
                float3 viewDir = _WorldSpaceCameraPos.xyz - worldPos;
                //单位化（归一化）
                viewDir = normalize(viewDir);

                //2.标准化后的反射方向
                //得到的光位置的方向向量（世界空间下的）
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                //法线在世界空间下的向量
                float3 normal = UnityObjectToWorldNormal(v.normal);
                //反射光线向量
                float3 reflectDir = reflect(-lightDir, normal);

                //高光反射光照颜色 = 光源的颜色 * 材质高光反射颜色 * max（0, 标准化后观察方向向量· 标准化后的反射方向）幂
                fixed3 color = _LightColor0.rgb * _SpecularColor.rgb * pow( max(0, dot(viewDir, reflectDir)), _SpecularNum);

                data.color = color;

                return data;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return fixed4(i.color.rgb, 1);
            }
            ENDCG
        }
    }
}
