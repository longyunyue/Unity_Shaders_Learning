// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "EveinLearnShader/Lambert"
{
    Properties
    {
        _Color("Color",Color) = (1.0,1.0,1.0,1.0)
    }
    SubShader
    {
    //光照模式设置为前向模式，这样光照的方向看起来才是正确的
        Tags { "RenderType"="Opaque" "LightMode" = "ForwardBase"}
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
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 color : COLOR;
                float4 vertex : SV_POSITION;
            };

            //define veriables
            float4 _Color;
            float4 _LightColor0;

            
            v2f vert (appdata v)
            {
                v2f o;
                //计算法线方向的位置并归一化
                float3 normalDirection = normalize(mul(float4(v.normal,0.0),unity_WorldToObject).xyz);
                float3 lightDirection;
                float atten =1.0;
                //计算光照的方向并归一化
                lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                //计算反射颜色,并且会受到光线的强度和颜色影响,并且受我们设定的_Color影响，lambert漫反射计算公式！
                float3 diffuseReflection = atten *_LightColor0.xyz * _Color.rgb * max(0.0,dot(normalDirection,lightDirection));
                o.color = float4(diffuseReflection,1.0);
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }
            
            float4 frag (v2f i) : SV_Target
            {
                
                return i.color;
            }
            ENDCG
        }
    }
}
