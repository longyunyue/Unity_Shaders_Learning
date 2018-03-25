Shader "EveinLearnShader/SpecularReflection"
{
	Properties
	{
		_Color("Color",Color) = (1,1,1,1)
        _SpecularColor("Specular Color",Color) =(1,1,1,1)
        _Shininess("Shininess",Float) = 10

	}
	SubShader
	{
		Tags { "RenderType"="Opaque"  "LightMode" ="ForwardBase"}
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
            
			#include "UnityCG.cginc"


            float4 _Color;
            float4 _SpecularColor;
            float _Shininess;
            float4 _LightColor0;
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
            
			
			v2f vert (appdata v)
			{
				v2f o;
                float3 normalDirection = normalize(mul(float4(v.normal,0.0),unity_WorldToObject).xyz);
                float3 viewDirection = normalize(float3(float4(_WorldSpaceCameraPos.xyz,1.0) - mul(unity_ObjectToWorld,v.vertex).xyz));
                float3 lightDirection;
                float atten =1.0;
                lightDirection =normalize(_WorldSpaceLightPos0.xyz);
                float3 diffuseReflection = atten * _LightColor0.xyz * max(0.0,dot(normalDirection,lightDirection));
                float3 specularReflection =atten * _SpecularColor * max(0.0,dot(normalDirection,lightDirection)) * pow(max(0.0,dot(reflect(-lightDirection,normalDirection),viewDirection)),_Shininess);
                float3 lightFinal = diffuseReflection + specularReflection + UNITY_LIGHTMODEL_AMBIENT;

                o.color = float4(lightFinal * _Color.rgb,1.0);
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
