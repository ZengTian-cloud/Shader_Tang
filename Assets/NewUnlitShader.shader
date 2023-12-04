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

            //ӳ���Ӧ�������Ե�ͼƬ��ɫ�������
            sampler2D _MainTex;
            //����ƽ�ƺ�����
            float4 _MainTex_ST;//xy��������,zw����ƽ��

            v2f_img vert(appdata_base v) {
                v2f_img o;
                o.pos = UnityObjectToClipPos(v.vertex);

                v.texcoord.xy;//����uv����
                v.texcoord.zw;//����ƽ��                
                //�����ź�ƽ��
                o.uv=v.texcoord.xy*_MainTex_ST.xy+_MainTex_ST.zw;
                //��������һ����˼
                o.uv=TRANSFORM_TEX(v.texcoord.xy,_MainTex);                
                return o;
            }

            fixed4 frag(v2f_img i) : SV_Target {
            //����������ɫ����
            fixed4 color=tex2D(_MainTex,i.uv);
            return color;
            }
            ENDCG
        }
    }
}