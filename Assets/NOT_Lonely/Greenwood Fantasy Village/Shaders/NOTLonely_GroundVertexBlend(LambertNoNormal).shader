// Upgrade NOTE: upgraded instancing buffer 'Props' to new syntax.

Shader "NOT_Lonely/Ground Vertex Blend (Lambert, No normal)" {
	Properties {
		_TriplanarHardness ("Triplanar Hardness", Range(1.1, 25)) = 5

		[Header(Grass Texture)] _TextureY01 ("Albedo(RGB), Smoothness(A)", 2D) = "white" {}
		[NoScaleOffset]_BlendY01 ("Grass Blend Map", 2D) = "white" {}
		_HeightBlendHardness ("Height Blend Hardness", Range(0, 1)) = 1

		[Space(20)][Header(Ground_1 Texture)] _TextureY02 ("Albedo(RGB), Smoothness(A)", 2D) = "white" {}

        [Space(20)][Header(Ground_2 Texture)] _TextureY03 ("Albedo(RGB), Smoothness(A)", 2D) = "white" {}

		[Space(20)][Header(Rock Texture)] _TextureXZ ("Albedo(RGB), Smoothness(A)", 2D) = "white" {}

	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert
				#pragma target 3.0

		sampler2D _TextureY01, _NormalY01, _BlendY01;	float4	_TextureY01_ST;
		sampler2D _TextureY02, _NormalY02;	float4	_TextureY02_ST;
		sampler2D _TextureY03, _NormalY03;	float4	_TextureY03_ST;
		sampler2D _TextureXZ, _NormalXZ;	float4	_TextureXZ_ST;

		half _TriplanarHardness, _HeightBlendHardness;

		struct Input {
			fixed3 normal;
			fixed3 powerNormal;
			float3 worldPos;
			fixed4 color:COLOR;
		};

		void vert (inout appdata_full v, out Input o) {
		
			UNITY_INITIALIZE_OUTPUT(Input,o);
				
				fixed3 worldNormal = normalize(mul(unity_ObjectToWorld, fixed4(v.normal, 0.0)).xyz);
				
				o.powerNormal = abs(worldNormal);
				o.powerNormal = pow((o.powerNormal - 0.2) * 7, _TriplanarHardness);
				o.powerNormal = normalize(max(o.powerNormal, 0.0001));
				o.powerNormal /= o.powerNormal.x + o.powerNormal.y + o.powerNormal.z;
								
				v.tangent.xyz = 	cross(v.normal, mul(unity_WorldToObject,fixed4(0.0,sign(worldNormal.x),0.0,0.0)).xyz * (o.powerNormal.x))
									+ cross(v.normal, mul(unity_WorldToObject,fixed4(0.0,0.0,sign(worldNormal.y),0.0)).xyz * (o.powerNormal.y))
									+ cross(v.normal, mul(unity_WorldToObject,fixed4(0.0,sign(worldNormal.z),0.0,0.0)).xyz * (o.powerNormal.z));
				
				v.tangent.w = 	(-(worldNormal.x) * (o.powerNormal.x)) 
								+ (-(worldNormal.y) * (o.powerNormal.y)) 
								+ (-(worldNormal.z) * (o.powerNormal.z));

		}

		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutput o) {

			//WorldSpace UV
			float2 posX = IN.worldPos.zy;
			float2 posY = IN.worldPos.xz;
			float2 posZ = float2(-IN.worldPos.x, IN.worldPos.y);

			float2 xUV = posX;
			float2 yUV = posY;
			float2 zUV = posZ;

			float texY_01_Blend = tex2D(_BlendY01, yUV / _TextureY01_ST) * _HeightBlendHardness + (1 - max(max(IN.color.y, IN.color.z), 1 - IN.powerNormal.y));
//			texY_01_Blend = clamp(pow(texY_01_Blend, 10),0,1);
			texY_01_Blend = smoothstep(0.7, 1, texY_01_Blend);
			float texY_02_Blend = clamp((IN.color.z - texY_01_Blend), 0, 1);
			float texY_03_Blend = clamp((IN.color.y - texY_01_Blend), 0, 1);

					//Top Textures
					fixed4 texY_01 = tex2D(_TextureY01, yUV / _TextureY01_ST) * texY_01_Blend;
					fixed4 texY_02 = tex2D(_TextureY02, yUV / _TextureY02_ST) * texY_02_Blend;
					fixed4 texY_03 = tex2D(_TextureY03, yUV / _TextureY03_ST) * texY_03_Blend;

					//Blend Textures
					float4 texY = texY_01 + texY_02 + texY_03;
					fixed4 texX = tex2D(_TextureXZ, xUV / _TextureXZ_ST);
					fixed4 texZ = tex2D(_TextureXZ, zUV / _TextureXZ_ST);

					fixed4 tex = texX * IN.powerNormal.x
					  			+ texY * IN.powerNormal.y
					  			+ texZ * IN.powerNormal.z;

			o.Albedo = tex.rgb;
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
