Shader "EveinLearnShader/Dissolve"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
        _DissolveTex("Dissolve texture",2D) = "white" {}
        _DissolveY("Current  Y of dissolve",Float) = 0
        _DissolveSize("Size of dissolve effect",Float) = 2
        _StartingY("Starting point of the effect",Float) = -10

	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
        Cull Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
                
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
                float3 worldPos :TEXCOORD1;
			};

			sampler2D _MainTex;
            sampler2D _DissolveTex;
			float4 _MainTex_ST;
            float _DissolveY;
            float _DissolveSize;
            float _StartingY;

			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.worldPos = mul(unity_ObjectToWorld,v.vertex).xyz ;
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
                float transition =_DissolveY -i.worldPos.y;
                //clip(0);
                clip(_StartingY+(transition + tex2D(_DissolveTex,i.uv) * _DissolveSize ) );
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
