// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "NOT_Lonely/Mobile/NOTLonely_Water_mobile" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_FoamColor ("Foam Color", Color) = (1,1,1,1)
	_Speed ("Speed", Float) = 1
	_MainTex ("Foam (RGB) Opacity (A)", 2D) = "white" {}
}

SubShader {
	Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
	LOD 200

CGPROGRAM
#pragma surface surf Lambert alpha:fade

sampler2D _MainTex;
fixed4 _Color;
fixed4 _FoamColor;
float _Speed;

struct Input {
	float2 uv_MainTex;
};

void surf (Input IN, inout SurfaceOutput o) {
	float2 scrollUV = IN.uv_MainTex;
	fixed xScrollValue = _Speed * _Time.x/10;
	scrollUV += fixed2 (xScrollValue, 0);
	half4 c = tex2D(_MainTex, scrollUV) * _FoamColor;
	o.Albedo = c.rgb + _Color + 0.1f;
	o.Alpha = c.a + 0.3f;
}
ENDCG
}

Fallback "Mobile/Diffuse"
}
