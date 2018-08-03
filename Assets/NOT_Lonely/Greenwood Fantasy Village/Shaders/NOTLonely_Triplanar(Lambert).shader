// Upgrade NOTE: upgraded instancing buffer 'Props' to new syntax.

Shader "NOT_Lonely/Triplanar/One Material (Lambert)" {
	Properties {
		_TriplanarHardness ("Triplanar Hardness", Range(1.1, 25)) = 5

		[Header(Grass Texture)] _Texture ("Albedo(RGB), Smoothness(A)", 2D) = "white" {}
		[NoScaleOffset]_Normal ("Normal", 2D) = "bump" {}

	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert
		#pragma target 3.0

		sampler2D _Texture, _Normal;	float4	_Texture_ST;
		half _TriplanarHardness;

		struct Input {
			fixed3 normal;
			fixed3 powerNormal;
			float3 worldPos;
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

					//Textures
					fixed4 texX = tex2D(_Texture, xUV / _Texture_ST) * IN.powerNormal.x;
					fixed4 texY = tex2D(_Texture, yUV / _Texture_ST) * IN.powerNormal.y;
					fixed4 texZ = tex2D(_Texture, zUV / _Texture_ST) * IN.powerNormal.z;

					fixed4 tex = texX + texY + texZ;

			//Top Normal
			fixed3 bumpX = UnpackNormal(tex2D(_Normal, xUV / _Texture_ST)) * IN.powerNormal.x;
			fixed3 bumpY = UnpackNormal(tex2D(_Normal, yUV / _Texture_ST)) * IN.powerNormal.y;
			fixed3 bumpZ = UnpackNormal(tex2D(_Normal, zUV / _Texture_ST)) * IN.powerNormal.z;

			fixed3 bump = bumpX + bumpY + bumpZ;

			o.Albedo = tex.rgb;
			o.Normal = normalize(bump);
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "NOT_Lonely/Triplanar/One Texture (Lambert, No normal)"
}
