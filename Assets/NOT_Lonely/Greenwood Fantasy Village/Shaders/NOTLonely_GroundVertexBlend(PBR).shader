// Upgrade NOTE: upgraded instancing buffer 'Props' to new syntax.

Shader "NOT_Lonely/Ground Vertex Blend (PBR)" {
	Properties {
		_TriplanarHardness ("Triplanar Hardness", Range(1.1, 25)) = 5

		[Header(Grass Texture)] _TextureY01 ("Albedo(RGB), Smoothness(A)", 2D) = "white" {}
		_MetallicY01 ("Metallic", Range(0.0,1.0)) = 0.0
		_GlossinessY01 ("Smoothness", Range(0.0,1.0)) = 0.5
		[NoScaleOffset]_NormalY01 ("Normal", 2D) = "bump" {}
		[NoScaleOffset]_BlendY01 ("Grass Blend Map", 2D) = "white" {}
		_HeightBlendHardness ("Height Blend Hardness", Range(0, 1)) = 1

		[Space(20)][Header(Ground_1 Texture)] _TextureY02 ("Albedo(RGB), Smoothness(A)", 2D) = "white" {}
		_MetallicY02 ("Metallic", Range(0.0,1.0)) = 0.0
		_GlossinessY02 ("Smoothness", Range(0.0,1.0)) = 0.5
		[NoScaleOffset]_NormalY02 ("Normal", 2D) = "bump" {}

        [Space(20)][Header(Ground_2 Texture)] _TextureY03 ("Albedo(RGB), Smoothness(A)", 2D) = "white" {}
        _MetallicY03 ("Metallic", Range(0.0,1.0)) = 0.0
		_GlossinessY03 ("Smoothness", Range(0.0,1.0)) = 0.5
        [NoScaleOffset]_NormalY03 ("Normal", 2D) = "bump" {}

		[Space(20)][Header(Rock Texture)] _TextureXZ ("Albedo(RGB), Smoothness(A)", 2D) = "white" {}
		_MetallicXZ ("Metallic", Range(0.0,1.0)) = 0.0
		_GlossinessXZ ("Smoothness", Range(0.0,1.0)) = 0.5
		[NoScaleOffset]_NormalXZ ("Normal", 2D) = "bump" {}

	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard vertex:vert
		#pragma target 3.0
		 #pragma only_renderers d3d9 d3d11 xboxone ps4 wiiu

		sampler2D _TextureY01, _NormalY01, _BlendY01;	float4	_TextureY01_ST;
		sampler2D _TextureY02, _NormalY02;	float4	_TextureY02_ST;
		sampler2D _TextureY03, _NormalY03;	float4	_TextureY03_ST;
		sampler2D _TextureXZ, _NormalXZ;	float4	_TextureXZ_ST;

		half _MetallicY01, _MetallicY02, _MetallicY03, _MetallicXZ;
		half _GlossinessY01, _GlossinessY02, _GlossinessY03, _GlossinessXZ;
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

		void surf (Input IN, inout SurfaceOutputStandard o) {

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

			//Metallic And Glossines Top
			float2 metGlossY01 = float2(_MetallicY01, _GlossinessY01) * texY_01_Blend; 
			float2 metGlossY02 = float2(_MetallicY02, _GlossinessY02) * texY_02_Blend; 
			float2 metGlossY03 = float2(_MetallicY03, _GlossinessY03) * texY_03_Blend; 

			//Blend Metallic And Glossines
			float2 metGlossY = metGlossY01 + metGlossY02 + metGlossY03;
			float2 metGlossXZ = float2(_MetallicXZ, _GlossinessXZ); 

			fixed2 metGloss = metGlossXZ * IN.powerNormal.x
			  			+ metGlossY * IN.powerNormal.y
			  			+ metGlossXZ * IN.powerNormal.z;

					//Top Normal
					fixed3 bumpY_01 = UnpackNormal(tex2D(_NormalY01, yUV / _TextureY01_ST)) * texY_01_Blend;
					fixed3 bumpY_02 = UnpackNormal(tex2D(_NormalY02, yUV / _TextureY02_ST)) * texY_02_Blend;
					fixed3 bumpY_03 = UnpackNormal(tex2D(_NormalY03, yUV / _TextureY03_ST)) * texY_03_Blend;

					//Blend Normal
					fixed3 bumpY = bumpY_01 + bumpY_02 + bumpY_03;
					fixed3 bumpX = UnpackNormal(tex2D(_NormalXZ, xUV / _TextureXZ_ST));
					fixed3 bumpZ = UnpackNormal(tex2D(_NormalXZ, zUV / _TextureXZ_ST));

					fixed3 bump = bumpX * IN.powerNormal.x
					  			+ bumpY * IN.powerNormal.y
					  			+ bumpZ * IN.powerNormal.z;

			o.Albedo = tex.rgb;
			o.Normal = normalize(bump);
			o.Metallic = metGloss.x;
			o.Smoothness = tex.a * metGloss.y;
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "NOT_Lonely/Ground Vertex Blend (Lambert, No normal)"
}
