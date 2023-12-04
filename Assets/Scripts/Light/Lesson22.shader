Shader "Unlit/Lesson22"
{
    Properties
    {
        
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            //�ýṹ��
            //�����ڴ�Ӧ�ý׶λ�ȡ��Ӧ�������ݺ�
            //���ݸ�������ɫ���ص�������
            struct a2v
            {
                //��������(����ģ�Ϳռ�)
                float4 vertex:POSITION;
                //���㷨��(����ģ�Ϳռ�)
                float3 normal:NORMAL;
                //��������(uv����)
                float2 uv:TEXCOORD0;
            };


            //�Ӷ�����ɫ�����ݸ�ƬԪ��ɫ���� �ṹ������ 
            //ͬ��������ĳ�ԱҲ��Ҫ������ȥ��������
            struct v2f
            {
                //�ü��ռ��µ�����
                float4 position:SV_POSITION;
                //���㷨��(����ģ�Ϳռ�)
                float3 normal:NORMAL;
                //��������(uv����)
                float2 uv:TEXCOORD0;
            };

            v2f vert(a2v data)
            {
                //��Ҫ���ݸ�ƬԪ��ɫ��������
                v2f v2fData;
                v2fData.position = UnityObjectToClipPos(data.vertex);
                v2fData.normal = data.normal;
                v2fData.uv = data.uv;

                return v2fData;
            }

          
            fixed4 frag(v2f data):SV_Target
            {
                return fixed4(0,1,0,1);
            }
            ENDCG
        }
    }
}
