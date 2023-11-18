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
            //������ɫ�����ݸ�ƬԪ��ɫ��������
            struct v2f 
            {
                //�ü��ռ��µĶ���������Ϣ
                float4 pos : SV_POSITION;
                //��Ӧ����������������ɫ
                fixed3 color : COLOR;
            };
            
            v2f vert(appdata_base data) {
                v2f v2fdata;

                //�����ع���ģ��
                v2fdata.pos=UnityObjectToClipPos(data.vertex);
                fixed3 normal=UnityObjectToWorldNormal(data.normal);
                fixed3 lightDir=normalize(_WorldSpaceLightPos0.xyz);
                //�������ؾ��ǰ��������0.5+0.5
                fixed3 lambotColor=_MainColor*_LightColor0*max(0,dot(normal,lightDir));

                //�߹ⷴ��
                //����۲���������
                fixed3 WorldPos=mul(UNITY_MATRIX_M,data.vertex);//����ת��Ϊ��������
                fixed3 LookDir=normalize(_WorldSpaceCameraPos-WorldPos);//�۲�����
                //���㷴��Ƕȷ���
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