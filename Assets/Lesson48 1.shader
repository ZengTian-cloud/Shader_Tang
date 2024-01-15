Shader "Unlit/Tshader"
{ 
 
          Properties{
        _MainTex("Texture", 2D) = "white" {} // ����ͼ
        _Wide("Wide", float) = 1000 
        _Hight("Hight", float) = 259
        _BaseWide("BaseWide", float) = 525
        _BaseHight("BaseHight", float) = 259
        _Left("left", Range(0.1,0.9)) = 1
        _Right("right", Range(0.1,0.9)) = 1
        _Up("up", Range(0.1,0.9)) = 1
        _Down("down", Range(0.1,0.9)) = 1

    }
    
    SubShader{
        Tags{"Queue"="Transparent""RenderType"="Opaque"}
        
        Pass{
            CGPROGRAM
             #pragma vertex vert  
             #pragma fragment frag  
             
             sampler2D _MainTex; // ����ͼ
             float4 _MainTex_ST; //xy�������� zw����ƽ��
             float4x4 unity_Projector; // Unity���ñ��������ڽ�ģ�Ϳռ�ת��Ϊ͸�ӿռ�
             float _Wide; 
             float _Hight; 
             float _BaseWide;
             float _BaseHight;
             float _Left;
             float  _Right;
             float _Up;
             float _Down;
             struct appdata{
                 float4 vertex : POSITION;
                 float3 normal : NORMAL;
                 float2 texcoord : TEXCOORD0;
             };
             
             struct v2f{
                 float4 pos : SV_POSITION;
                 float2 uv : TEXCOORD0;
             };
             
             v2f vert (appdata v){
                 v2f o;
                 o.pos = UnityObjectToClipPos(v.vertex);
                 o.uv = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                 return o;
             }
             
             fixed4 frag (v2f i) : COLOR{
                 float x=i.uv.x;
                 float y=i.uv.y;
                 if(x*_Wide<_Left*_BaseWide)
                 {
                 x=i.uv.x*_Wide/_BaseWide;
                 }
                 else if(i.uv.x>1-_Right)
                 {
                 
                 }
                 else
                 {
                 
                 }

                 if(i.uv.y<_Down)
                 {
                 
                 }
                 else if(i.uv.y>1-_Up)
                 {
                 
                 }
                 else
                 {
                 
                 }


                 return tex2D(_MainTex, float2(x,y)); // ���ض�ӦUV���괦������ֵ��Ϊ�������
             }
             ENDCG
        }
    }
}
