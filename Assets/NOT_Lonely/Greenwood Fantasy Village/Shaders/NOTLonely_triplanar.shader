// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.34 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.34;sub:START;pass:START;ps:flbk:Standard,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:True,rprd:True,enco:False,rmgx:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5716371,fgcg:0.7063671,fgcb:0.8014706,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:2865,x:33213,y:32839,varname:node_2865,prsc:2|diff-6266-OUT,spec-3479-OUT,gloss-1684-OUT,normal-8132-OUT;n:type:ShaderForge.SFN_Tex2d,id:5964,x:31995,y:33610,varname:_NormalY,prsc:2,ntxv:3,isnm:True|UVIN-9186-OUT,TEX-9740-TEX;n:type:ShaderForge.SFN_Tex2d,id:1912,x:31765,y:32996,varname:_TexY,prsc:2,ntxv:0,isnm:False|UVIN-6526-OUT,TEX-586-TEX;n:type:ShaderForge.SFN_Tex2d,id:9874,x:31765,y:33227,varname:_TexX,prsc:2,ntxv:0,isnm:False|UVIN-4165-OUT,TEX-586-TEX;n:type:ShaderForge.SFN_Tex2d,id:4379,x:31995,y:33849,varname:_NormalX,prsc:2,ntxv:3,isnm:True|UVIN-1357-OUT,TEX-9740-TEX;n:type:ShaderForge.SFN_Vector1,id:3479,x:32915,y:32913,varname:node_3479,prsc:2,v1:0;n:type:ShaderForge.SFN_NormalVector,id:2371,x:30432,y:32572,prsc:2,pt:False;n:type:ShaderForge.SFN_FragmentPosition,id:1768,x:30438,y:33093,varname:node_1768,prsc:2;n:type:ShaderForge.SFN_Abs,id:3628,x:30627,y:32582,varname:node_3628,prsc:2|IN-2371-OUT;n:type:ShaderForge.SFN_Multiply,id:3014,x:30969,y:32657,varname:node_3014,prsc:2|A-3628-OUT,B-3628-OUT;n:type:ShaderForge.SFN_Append,id:4945,x:30905,y:33029,varname:node_4945,prsc:2|A-1768-Y,B-1768-Z;n:type:ShaderForge.SFN_Append,id:7974,x:30909,y:33190,varname:node_7974,prsc:2|A-1768-X,B-1768-Z;n:type:ShaderForge.SFN_Append,id:963,x:30909,y:33350,varname:node_963,prsc:2|A-1768-X,B-1768-Y;n:type:ShaderForge.SFN_Tex2dAsset,id:586,x:31462,y:33667,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ChannelBlend,id:2565,x:32417,y:32961,varname:node_2565,prsc:2,chbt:0|M-3646-OUT,R-9874-RGB,G-1912-RGB,B-421-RGB;n:type:ShaderForge.SFN_Tex2d,id:421,x:31765,y:33421,varname:_TexZ,prsc:2,ntxv:0,isnm:False|UVIN-8961-OUT,TEX-586-TEX;n:type:ShaderForge.SFN_Power,id:860,x:31126,y:32657,varname:node_860,prsc:2|VAL-3014-OUT,EXP-6676-OUT;n:type:ShaderForge.SFN_Normalize,id:3646,x:31293,y:32657,varname:node_3646,prsc:2|IN-860-OUT;n:type:ShaderForge.SFN_Slider,id:6676,x:30690,y:32881,ptovrint:False,ptlb:Triplanar Hardness,ptin:_TriplanarHardness,varname:_TriplanarHardness,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:10,max:15;n:type:ShaderForge.SFN_Multiply,id:6526,x:31106,y:33213,varname:node_6526,prsc:2|A-7974-OUT,B-7448-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7448,x:30655,y:33484,ptovrint:False,ptlb:Tiling Multiplier,ptin:_TilingMultiplier,varname:_TilingMultiplier,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Multiply,id:4165,x:31106,y:33029,varname:node_4165,prsc:2|A-4945-OUT,B-7448-OUT;n:type:ShaderForge.SFN_Multiply,id:8961,x:31106,y:33465,varname:node_8961,prsc:2|A-963-OUT,B-7448-OUT;n:type:ShaderForge.SFN_ChannelBlend,id:1684,x:32393,y:33273,varname:node_1684,prsc:2,chbt:0|M-3646-OUT,R-9874-A,G-1912-A,B-421-A;n:type:ShaderForge.SFN_Tex2dAsset,id:9740,x:31680,y:33992,ptovrint:True,ptlb:Normal,ptin:BumpMap,varname:BumpMap,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:5024,x:31995,y:34066,varname:_NormalZ,prsc:2,ntxv:3,isnm:True|UVIN-8920-OUT,TEX-9740-TEX;n:type:ShaderForge.SFN_ChannelBlend,id:5865,x:32652,y:33569,varname:node_5865,prsc:2,chbt:0|M-3646-OUT,R-4379-RGB,G-5964-RGB,B-5024-RGB;n:type:ShaderForge.SFN_NormalBlend,id:8132,x:32943,y:33545,varname:node_8132,prsc:2|BSE-5865-OUT,DTL-5417-RGB;n:type:ShaderForge.SFN_Tex2d,id:5417,x:32657,y:33828,ptovrint:False,ptlb:Normal Detail,ptin:_NormalDetail,varname:_NormalDetail,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Frac,id:1357,x:31361,y:32998,varname:node_1357,prsc:2|IN-4165-OUT;n:type:ShaderForge.SFN_Frac,id:9186,x:31361,y:33181,varname:node_9186,prsc:2|IN-6526-OUT;n:type:ShaderForge.SFN_Frac,id:8920,x:31361,y:33346,varname:node_8920,prsc:2|IN-8961-OUT;n:type:ShaderForge.SFN_Tex2d,id:6622,x:32579,y:32583,ptovrint:False,ptlb:Detail,ptin:_Detail,varname:_Detail,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Add,id:6266,x:32825,y:32481,varname:node_6266,prsc:2|A-6622-RGB,B-2565-OUT;proporder:586-9740-6676-7448-5417-6622;pass:END;sub:END;*/

Shader "NOT_Lonely/NOTLonely_Triplanar" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        BumpMap ("Normal", 2D) = "bump" {}
        _TriplanarHardness ("Triplanar Hardness", Range(1, 15)) = 10
        _TilingMultiplier ("Tiling Multiplier", Float ) = 0.1
        _NormalDetail ("Normal Detail", 2D) = "bump" {}
        _Detail ("Detail", 2D) = "black" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "DEFERRED"
            Tags {
                "LightMode"="Deferred"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_DEFERRED
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile ___ UNITY_HDR_ON
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _TriplanarHardness;
            uniform float _TilingMultiplier;
            uniform sampler2D BumpMap; uniform float4 BumpMap_ST;
            uniform sampler2D _NormalDetail; uniform float4 _NormalDetail_ST;
            uniform sampler2D _Detail; uniform float4 _Detail_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD7;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                return o;
            }
            void frag(
                VertexOutput i,
                out half4 outDiffuse : SV_Target0,
                out half4 outSpecSmoothness : SV_Target1,
                out half4 outNormal : SV_Target2,
                out half4 outEmission : SV_Target3 )
            {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 node_3628 = abs(i.normalDir);
                float3 node_3646 = normalize(pow((node_3628*node_3628),_TriplanarHardness));
                float2 node_4165 = (float2(i.posWorld.g,i.posWorld.b)*_TilingMultiplier);
                float2 node_1357 = frac(node_4165);
                float3 _NormalX = UnpackNormal(tex2D(BumpMap,TRANSFORM_TEX(node_1357, BumpMap)));
                float2 node_6526 = (float2(i.posWorld.r,i.posWorld.b)*_TilingMultiplier);
                float2 node_9186 = frac(node_6526);
                float3 _NormalY = UnpackNormal(tex2D(BumpMap,TRANSFORM_TEX(node_9186, BumpMap)));
                float2 node_8961 = (float2(i.posWorld.r,i.posWorld.g)*_TilingMultiplier);
                float2 node_8920 = frac(node_8961);
                float3 _NormalZ = UnpackNormal(tex2D(BumpMap,TRANSFORM_TEX(node_8920, BumpMap)));
                float3 _NormalDetail_var = UnpackNormal(tex2D(_NormalDetail,TRANSFORM_TEX(i.uv0, _NormalDetail)));
                float3 node_8132_nrm_base = (node_3646.r*_NormalX.rgb + node_3646.g*_NormalY.rgb + node_3646.b*_NormalZ.rgb) + float3(0,0,1);
                float3 node_8132_nrm_detail = _NormalDetail_var.rgb * float3(-1,-1,1);
                float3 node_8132_nrm_combined = node_8132_nrm_base*dot(node_8132_nrm_base, node_8132_nrm_detail)/node_8132_nrm_base.z - node_8132_nrm_detail;
                float3 node_8132 = node_8132_nrm_combined;
                float3 normalLocal = node_8132;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
////// Lighting:
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 _TexX = tex2D(_MainTex,TRANSFORM_TEX(node_4165, _MainTex));
                float4 _TexY = tex2D(_MainTex,TRANSFORM_TEX(node_6526, _MainTex));
                float4 _TexZ = tex2D(_MainTex,TRANSFORM_TEX(node_8961, _MainTex));
                float gloss = (node_3646.r*_TexX.a + node_3646.g*_TexY.a + node_3646.b*_TexZ.a);
                float perceptualRoughness = 1.0 - (node_3646.r*_TexX.a + node_3646.g*_TexY.a + node_3646.b*_TexZ.a);
                float roughness = perceptualRoughness * perceptualRoughness;
/////// GI Data:
                UnityLight light; // Dummy light
                light.color = 0;
                light.dir = half3(0,1,0);
                light.ndotl = max(0,dot(normalDirection,light.dir));
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = 1;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMin[0] = unity_SpecCube0_BoxMin;
                    d.boxMin[1] = unity_SpecCube1_BoxMin;
                #endif
                #if UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMax[0] = unity_SpecCube0_BoxMax;
                    d.boxMax[1] = unity_SpecCube1_BoxMax;
                    d.probePosition[0] = unity_SpecCube0_ProbePosition;
                    d.probePosition[1] = unity_SpecCube1_ProbePosition;
                #endif
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
////// Specular:
                float3 specularColor = 0.0;
                float specularMonochrome;
                float4 _Detail_var = tex2D(_Detail,TRANSFORM_TEX(i.uv0, _Detail));
                float3 node_2565 = (node_3646.r*_TexX.rgb + node_3646.g*_TexY.rgb + node_3646.b*_TexZ.rgb);
                float3 diffuseColor = (_Detail_var.rgb+node_2565); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
/////// Diffuse:
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
/// Final Color:
                outDiffuse = half4( diffuseColor, 1 );
                outSpecSmoothness = half4( specularColor, gloss );
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4(0,0,0,1);
                outEmission.rgb += indirectSpecular * 1;
                outEmission.rgb += indirectDiffuse * diffuseColor;
                #ifndef UNITY_HDR_ON
                    outEmission.rgb = exp2(-outEmission.rgb);
                #endif
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _TriplanarHardness;
            uniform float _TilingMultiplier;
            uniform sampler2D BumpMap; uniform float4 BumpMap_ST;
            uniform sampler2D _NormalDetail; uniform float4 _NormalDetail_ST;
            uniform sampler2D _Detail; uniform float4 _Detail_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD10;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 node_3628 = abs(i.normalDir);
                float3 node_3646 = normalize(pow((node_3628*node_3628),_TriplanarHardness));
                float2 node_4165 = (float2(i.posWorld.g,i.posWorld.b)*_TilingMultiplier);
                float2 node_1357 = frac(node_4165);
                float3 _NormalX = UnpackNormal(tex2D(BumpMap,TRANSFORM_TEX(node_1357, BumpMap)));
                float2 node_6526 = (float2(i.posWorld.r,i.posWorld.b)*_TilingMultiplier);
                float2 node_9186 = frac(node_6526);
                float3 _NormalY = UnpackNormal(tex2D(BumpMap,TRANSFORM_TEX(node_9186, BumpMap)));
                float2 node_8961 = (float2(i.posWorld.r,i.posWorld.g)*_TilingMultiplier);
                float2 node_8920 = frac(node_8961);
                float3 _NormalZ = UnpackNormal(tex2D(BumpMap,TRANSFORM_TEX(node_8920, BumpMap)));
                float3 _NormalDetail_var = UnpackNormal(tex2D(_NormalDetail,TRANSFORM_TEX(i.uv0, _NormalDetail)));
                float3 node_8132_nrm_base = (node_3646.r*_NormalX.rgb + node_3646.g*_NormalY.rgb + node_3646.b*_NormalZ.rgb) + float3(0,0,1);
                float3 node_8132_nrm_detail = _NormalDetail_var.rgb * float3(-1,-1,1);
                float3 node_8132_nrm_combined = node_8132_nrm_base*dot(node_8132_nrm_base, node_8132_nrm_detail)/node_8132_nrm_base.z - node_8132_nrm_detail;
                float3 node_8132 = node_8132_nrm_combined;
                float3 normalLocal = node_8132;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 _TexX = tex2D(_MainTex,TRANSFORM_TEX(node_4165, _MainTex));
                float4 _TexY = tex2D(_MainTex,TRANSFORM_TEX(node_6526, _MainTex));
                float4 _TexZ = tex2D(_MainTex,TRANSFORM_TEX(node_8961, _MainTex));
                float gloss = (node_3646.r*_TexX.a + node_3646.g*_TexY.a + node_3646.b*_TexZ.a);
                float perceptualRoughness = 1.0 - (node_3646.r*_TexX.a + node_3646.g*_TexY.a + node_3646.b*_TexZ.a);
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0+1.0);
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMin[0] = unity_SpecCube0_BoxMin;
                    d.boxMin[1] = unity_SpecCube1_BoxMin;
                #endif
                #if UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMax[0] = unity_SpecCube0_BoxMax;
                    d.boxMax[1] = unity_SpecCube1_BoxMax;
                    d.probePosition[0] = unity_SpecCube0_ProbePosition;
                    d.probePosition[1] = unity_SpecCube1_ProbePosition;
                #endif
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = 0.0;
                float specularMonochrome;
                float4 _Detail_var = tex2D(_Detail,TRANSFORM_TEX(i.uv0, _Detail));
                float3 node_2565 = (node_3646.r*_TexX.rgb + node_3646.g*_TexY.rgb + node_3646.b*_TexZ.rgb);
                float3 diffuseColor = (_Detail_var.rgb+node_2565); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                half surfaceReduction;
                #ifdef UNITY_COLORSPACE_GAMMA
                    surfaceReduction = 1.0-0.28*roughness*perceptualRoughness;
                #else
                    surfaceReduction = 1.0/(roughness*roughness + 1.0);
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = (floor(attenuation) * _LightColor0.xyz)*specularPBL*FresnelTerm(specularColor, LdotH);
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
                indirectSpecular *= surfaceReduction;
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _TriplanarHardness;
            uniform float _TilingMultiplier;
            uniform sampler2D BumpMap; uniform float4 BumpMap_ST;
            uniform sampler2D _NormalDetail; uniform float4 _NormalDetail_ST;
            uniform sampler2D _Detail; uniform float4 _Detail_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 node_3628 = abs(i.normalDir);
                float3 node_3646 = normalize(pow((node_3628*node_3628),_TriplanarHardness));
                float2 node_4165 = (float2(i.posWorld.g,i.posWorld.b)*_TilingMultiplier);
                float2 node_1357 = frac(node_4165);
                float3 _NormalX = UnpackNormal(tex2D(BumpMap,TRANSFORM_TEX(node_1357, BumpMap)));
                float2 node_6526 = (float2(i.posWorld.r,i.posWorld.b)*_TilingMultiplier);
                float2 node_9186 = frac(node_6526);
                float3 _NormalY = UnpackNormal(tex2D(BumpMap,TRANSFORM_TEX(node_9186, BumpMap)));
                float2 node_8961 = (float2(i.posWorld.r,i.posWorld.g)*_TilingMultiplier);
                float2 node_8920 = frac(node_8961);
                float3 _NormalZ = UnpackNormal(tex2D(BumpMap,TRANSFORM_TEX(node_8920, BumpMap)));
                float3 _NormalDetail_var = UnpackNormal(tex2D(_NormalDetail,TRANSFORM_TEX(i.uv0, _NormalDetail)));
                float3 node_8132_nrm_base = (node_3646.r*_NormalX.rgb + node_3646.g*_NormalY.rgb + node_3646.b*_NormalZ.rgb) + float3(0,0,1);
                float3 node_8132_nrm_detail = _NormalDetail_var.rgb * float3(-1,-1,1);
                float3 node_8132_nrm_combined = node_8132_nrm_base*dot(node_8132_nrm_base, node_8132_nrm_detail)/node_8132_nrm_base.z - node_8132_nrm_detail;
                float3 node_8132 = node_8132_nrm_combined;
                float3 normalLocal = node_8132;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 _TexX = tex2D(_MainTex,TRANSFORM_TEX(node_4165, _MainTex));
                float4 _TexY = tex2D(_MainTex,TRANSFORM_TEX(node_6526, _MainTex));
                float4 _TexZ = tex2D(_MainTex,TRANSFORM_TEX(node_8961, _MainTex));
                float gloss = (node_3646.r*_TexX.a + node_3646.g*_TexY.a + node_3646.b*_TexZ.a);
                float perceptualRoughness = 1.0 - (node_3646.r*_TexX.a + node_3646.g*_TexY.a + node_3646.b*_TexZ.a);
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = 0.0;
                float specularMonochrome;
                float4 _Detail_var = tex2D(_Detail,TRANSFORM_TEX(i.uv0, _Detail));
                float3 node_2565 = (node_3646.r*_TexX.rgb + node_3646.g*_TexY.rgb + node_3646.b*_TexZ.rgb);
                float3 diffuseColor = (_Detail_var.rgb+node_2565); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _TriplanarHardness;
            uniform float _TilingMultiplier;
            uniform sampler2D _Detail; uniform float4 _Detail_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                o.Emission = 0;
                
                float4 _Detail_var = tex2D(_Detail,TRANSFORM_TEX(i.uv0, _Detail));
                float3 node_3628 = abs(i.normalDir);
                float3 node_3646 = normalize(pow((node_3628*node_3628),_TriplanarHardness));
                float2 node_4165 = (float2(i.posWorld.g,i.posWorld.b)*_TilingMultiplier);
                float4 _TexX = tex2D(_MainTex,TRANSFORM_TEX(node_4165, _MainTex));
                float2 node_6526 = (float2(i.posWorld.r,i.posWorld.b)*_TilingMultiplier);
                float4 _TexY = tex2D(_MainTex,TRANSFORM_TEX(node_6526, _MainTex));
                float2 node_8961 = (float2(i.posWorld.r,i.posWorld.g)*_TilingMultiplier);
                float4 _TexZ = tex2D(_MainTex,TRANSFORM_TEX(node_8961, _MainTex));
                float3 node_2565 = (node_3646.r*_TexX.rgb + node_3646.g*_TexY.rgb + node_3646.b*_TexZ.rgb);
                float3 diffColor = (_Detail_var.rgb+node_2565);
                float specularMonochrome;
                float3 specColor;
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, 0.0, specColor, specularMonochrome );
                float roughness = 1.0 - (node_3646.r*_TexX.a + node_3646.g*_TexY.a + node_3646.b*_TexZ.a);
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Standard"
    CustomEditor "ShaderForgeMaterialInspector"
}
