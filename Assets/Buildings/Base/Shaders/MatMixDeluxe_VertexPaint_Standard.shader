// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Indie Pockets/MatMix Deluxe VertexPaint Standard"
{
	Properties
	{
		[NoScaleOffset]_MainTex("Albedo 1", 2D) = "white" {}
		[NoScaleOffset]_Albedo2("Albedo 2", 2D) = "white" {}
		[NoScaleOffset]_MetallicSmoothnessOcclusion1("Metallic+Smoothness+Occlusion 1", 2D) = "black" {}
		[NoScaleOffset]_MetallicSmoothnessOcclusion2("Metallic+Smoothness+Occlusion 2", 2D) = "black" {}
		[Toggle]_UseOcclusionTexture1("Use Occlusion Texture 1", Float) = 1
		[Toggle]_UseOcclusionTexture2("Use Occlusion Texture 2", Float) = 1
		[NoScaleOffset]_Normal1("Normal 1", 2D) = "bump" {}
		[NoScaleOffset]_Normal2("Normal 2", 2D) = "bump" {}
		_Tiling1("Tiling 1", Float) = 1
		_Tiling2("Tiling 2", Float) = 1
		_Offset1("Offset 1", Vector) = (0,0,0,0)
		_Offset2("Offset 2", Vector) = (0,0,0,0)
		_NormalIntensity2("Normal Intensity 2", Float) = 1
		_NormalIntensity1("Normal Intensity 1", Float) = 1
		_VertexRHardness1("Vertex(R) Hardness 1", Float) = 1.74
		_VertexRHardness2("Vertex(R) Hardness 2", Float) = -1.56
		[NoScaleOffset]_BlendDetailTexture("Blend Detail Texture", 2D) = "white" {}
		[Toggle]_UseBlendDetailTexture("Use Blend Detail Texture", Float) = 1
		_BlendDetailTextureTile("Blend Detail Texture Tile", Float) = 1
		_BlendDetailTextureOffset("Blend Detail Texture Offset", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 5.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float _UseBlendDetailTexture;
		uniform float _VertexRHardness1;
		uniform float _VertexRHardness2;
		uniform sampler2D _BlendDetailTexture;
		uniform float _BlendDetailTextureTile;
		uniform float2 _BlendDetailTextureOffset;
		uniform float _NormalIntensity1;
		uniform sampler2D _Normal1;
		uniform float _Tiling1;
		uniform float2 _Offset1;
		uniform float _NormalIntensity2;
		uniform sampler2D _Normal2;
		uniform float _Tiling2;
		uniform float2 _Offset2;
		uniform sampler2D _MainTex;
		uniform sampler2D _Albedo2;
		uniform sampler2D _MetallicSmoothnessOcclusion1;
		uniform sampler2D _MetallicSmoothnessOcclusion2;
		uniform float _UseOcclusionTexture1;
		uniform float _UseOcclusionTexture2;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float temp_output_84_0 = saturate( pow( i.vertexColor.r , _VertexRHardness1 ) );
			float4 temp_cast_0 = (temp_output_84_0).xxxx;
			float temp_output_90_0 = ( 1.0 - i.vertexColor.r );
			float2 temp_cast_1 = (_BlendDetailTextureTile).xx;
			float2 uv_TexCoord101 = i.uv_texcoord * temp_cast_1 + _BlendDetailTextureOffset;
			float4 temp_cast_2 = (temp_output_90_0).xxxx;
			float VertexColor45 = (saturate( lerp(temp_cast_0,( temp_output_84_0 + saturate( ( ( pow( temp_output_90_0 , _VertexRHardness2 ) * tex2D( _BlendDetailTexture, uv_TexCoord101 ) ) - temp_cast_2 ) ) ),_UseBlendDetailTexture) )).r;
			float2 temp_cast_3 = (_Tiling1).xx;
			float2 uv_TexCoord60 = i.uv_texcoord * temp_cast_3 + _Offset1;
			float3 Normal110 = UnpackScaleNormal( tex2D( _Normal1, uv_TexCoord60 ), _NormalIntensity1 );
			float2 temp_cast_4 = (_Tiling2).xx;
			float2 uv_TexCoord65 = i.uv_texcoord * temp_cast_4 + _Offset2;
			float3 Normal224 = UnpackScaleNormal( tex2D( _Normal2, uv_TexCoord65 ), _NormalIntensity2 );
			float layeredBlendVar47 = VertexColor45;
			float3 layeredBlend47 = ( lerp( Normal110,Normal224 , layeredBlendVar47 ) );
			float3 normalizeResult105 = normalize( layeredBlend47 );
			o.Normal = normalizeResult105;
			float4 Albedo19 = tex2D( _MainTex, uv_TexCoord60 );
			float4 Albedo223 = tex2D( _Albedo2, uv_TexCoord65 );
			float layeredBlendVar41 = VertexColor45;
			float4 layeredBlend41 = ( lerp( Albedo19,Albedo223 , layeredBlendVar41 ) );
			o.Albedo = layeredBlend41.rgb;
			float4 tex2DNode3 = tex2D( _MetallicSmoothnessOcclusion1, uv_TexCoord60 );
			float Metallic111 = tex2DNode3.r;
			float4 tex2DNode20 = tex2D( _MetallicSmoothnessOcclusion2, uv_TexCoord65 );
			float Metallic219 = tex2DNode20.r;
			float layeredBlendVar49 = VertexColor45;
			float layeredBlend49 = ( lerp( Metallic111,Metallic219 , layeredBlendVar49 ) );
			o.Metallic = saturate( layeredBlend49 );
			float Smoothness112 = tex2DNode3.g;
			float Smoothness222 = tex2DNode20.g;
			float layeredBlendVar51 = VertexColor45;
			float layeredBlend51 = ( lerp( Smoothness112,Smoothness222 , layeredBlendVar51 ) );
			o.Smoothness = saturate( layeredBlend51 );
			float Occlusion113 = lerp(1.0,tex2DNode3.b,_UseOcclusionTexture1);
			float Occlusion227 = lerp(1.0,tex2DNode20.b,_UseOcclusionTexture2);
			float layeredBlendVar58 = VertexColor45;
			float layeredBlend58 = ( lerp( Occlusion113,Occlusion227 , layeredBlendVar58 ) );
			o.Occlusion = saturate( layeredBlend58 );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "Mgui4"
}
/*ASEBEGIN
Version=16807
2824;81;1006;952;2084.611;2272.848;4.76956;False;False
Node;AmplifyShaderEditor.CommentaryNode;66;-1379.236,-1381.164;Float;False;2813.793;679.6371;;19;45;95;94;100;96;84;89;97;72;73;93;75;88;87;90;101;42;104;103;Vertex Color;0.5839751,0.1457814,0.7924528,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-1297.896,-973.0686;Float;False;Property;_BlendDetailTextureTile;Blend Detail Texture Tile;18;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;104;-1298.223,-856.4182;Float;False;Property;_BlendDetailTextureOffset;Blend Detail Texture Offset;19;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.VertexColorNode;42;-1053.207,-1307.369;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;101;-1000.968,-927.887;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;90;-815.8227,-1222.517;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-1038.546,-1040.464;Float;False;Property;_VertexRHardness2;Vertex(R) Hardness 2;15;0;Create;True;0;0;False;0;-1.56;-1.56;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;88;-676.9792,-1077.358;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;75;-702.0068,-949.75;Float;True;Property;_BlendDetailTexture;Blend Detail Texture;16;1;[NoScaleOffset];Create;True;0;0;False;0;None;16d574e53541bba44a84052fa38778df;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;73;-1041.041,-1130.382;Float;False;Property;_VertexRHardness1;Vertex(R) Hardness 1;14;0;Create;True;0;0;False;0;1.74;1.74;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;-353.9332,-976.9588;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;97;-228.7866,-1163.805;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;72;-381.3046,-1286.069;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;18;-1357.373,410.9083;Float;False;1510.27;788.8628;;13;23;19;22;27;24;21;26;20;65;64;63;67;69;Material 2;0.8584906,0.4413938,0.4413938,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;17;-1369.45,-540.9653;Float;False;1513.826;801.1533;;13;60;10;12;11;13;9;14;1;3;61;62;68;70;Material 1;0.9757375,1,0,1;0;0
Node;AmplifyShaderEditor.SaturateNode;89;-19.9171,-1132.591;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;84;-132.9459,-1284.279;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;96;232.73,-1200.187;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;63;-1312.697,836.441;Float;False;Property;_Offset2;Offset 2;11;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;64;-1312.697,723.1954;Float;False;Property;_Tiling2;Tiling 2;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1331.531,-218.4591;Float;False;Property;_Tiling1;Tiling 1;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;62;-1331.531,-105.2135;Float;False;Property;_Offset1;Offset 1;10;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ToggleSwitchNode;100;390.9091,-1301.668;Float;False;Property;_UseBlendDetailTexture;Use Blend Detail Texture;17;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;65;-1063.919,738.7362;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;60;-1082.752,-211.5432;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;20;-785.2411,937.1743;Float;True;Property;_MetallicSmoothnessOcclusion2;Metallic+Smoothness+Occlusion 2;3;1;[NoScaleOffset];Create;True;0;0;False;0;None;a5e4b1e595c57a04f9732ff8873126f9;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;69;-1114.717,979.1552;Float;False;Property;_NormalIntensity2;Normal Intensity 2;12;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-782.7863,-14.69953;Float;True;Property;_MetallicSmoothnessOcclusion1;Metallic+Smoothness+Occlusion 1;2;1;[NoScaleOffset];Create;True;0;0;False;0;None;70c2ccc7c3cfef043b1b41b37ee3a134;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;94;749.5644,-1300.462;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-1090.053,-8.650627;Float;False;Property;_NormalIntensity1;Normal Intensity 1;13;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;95;957.2701,-1309.437;Float;False;True;False;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;67;-774.2774,700.9021;Float;True;Property;_Normal2;Normal 2;7;1;[NoScaleOffset];Create;True;0;0;False;0;bd734c29baceb63499732f24fbaea45f;76117e8e27926354283aecae6e1b194b;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;14;-408.6057,135.7711;Float;False;Property;_UseOcclusionTexture1;Use Occlusion Texture 1;4;0;Create;True;0;0;False;0;1;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;68;-778.6202,-238.1881;Float;True;Property;_Normal1;Normal 1;6;1;[NoScaleOffset];Create;True;0;0;False;0;8178c5ce4aa3d5341804ce7d0ff18428;755bc3270bb6b444f9801f0904e20306;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;21;-398.0603,1076.645;Float;False;Property;_UseOcclusionTexture2;Use Occlusion Texture 2;5;0;Create;True;0;0;False;0;1;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;-77.05132,1074.865;Float;False;Occlusion2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-399.8347,885.863;Float;False;Metallic2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;1212.826,-1313.646;Float;False;VertexColor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;26;-789.0609,460.9083;Float;True;Property;_Albedo2;Albedo 2;1;1;[NoScaleOffset];Create;True;0;0;False;0;None;53266f1e816107d4b853e232d5ebe050;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;22;-397.0784,981.6179;Float;False;Smoothness2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-411.6238,35.74409;Float;False;Smoothness1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;59;295.8726,-420.7786;Float;False;830.2475;1520.08;;24;105;51;49;41;58;37;55;56;50;52;33;57;38;53;47;34;54;46;48;35;36;106;107;108;Blend;0.3349057,1,0.980055,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-411.3801,-57.01083;Float;False;Metallic1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-77.59666,72.99149;Float;False;Occlusion1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-436.5357,656.5599;Float;False;Normal2;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1;-787.3436,-459.1465;Float;True;Property;_MainTex;Albedo 1;0;1;[NoScaleOffset];Create;False;0;0;False;0;None;a9b0b7bdfb700bb479b422626a3e1836;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-434.0811,-295.3138;Float;False;Normal1;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;48;355.5829,-64.07373;Float;False;45;VertexColor;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;372.8687,815.267;Float;False;45;VertexColor;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;369.1469,527.6422;Float;False;45;VertexColor;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;363.988,104.7727;Float;False;24;Normal2;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;38;363.1552,394.6147;Float;False;19;Metallic2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;57;374.6834,992.8655;Float;False;27;Occlusion2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;359.4807,240.8665;Float;False;45;VertexColor;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;363.1552,317.448;Float;False;11;Metallic1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-438.2527,-397.3955;Float;False;Albedo1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;35;362.3892,13.54845;Float;False;10;Normal1;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;53;368.2712,624.134;Float;False;12;Smoothness1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;-441.9221,538.1607;Float;False;Albedo2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;371.9929,911.7589;Float;False;13;Occlusion1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;370.9616,705.2402;Float;False;22;Smoothness2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LayeredBlendNode;49;634.8391,246.296;Float;False;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LayeredBlendNode;47;630.9411,-58.64423;Float;False;6;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LayeredBlendNode;51;644.506,533.0717;Float;False;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LayeredBlendNode;58;648.2281,820.6965;Float;False;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;362.1519,-370.7787;Float;False;45;VertexColor;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;366.4554,-187.2335;Float;False;23;Albedo2;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;366.9841,-267.179;Float;False;9;Albedo1;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;108;870.6591,155.9676;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;105;944.2075,-98.12034;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;107;880.4729,412.7672;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;106;909.9151,615.5896;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LayeredBlendNode;41;637.5101,-365.3492;Float;False;6;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1662.087,-312.3486;Float;False;True;7;Float;Mgui4;0;0;Standard;Indie Pockets/MatMix Deluxe VertexPaint Standard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;101;0;103;0
WireConnection;101;1;104;0
WireConnection;90;0;42;1
WireConnection;88;0;90;0
WireConnection;88;1;87;0
WireConnection;75;1;101;0
WireConnection;93;0;88;0
WireConnection;93;1;75;0
WireConnection;97;0;93;0
WireConnection;97;1;90;0
WireConnection;72;0;42;1
WireConnection;72;1;73;0
WireConnection;89;0;97;0
WireConnection;84;0;72;0
WireConnection;96;0;84;0
WireConnection;96;1;89;0
WireConnection;100;0;84;0
WireConnection;100;1;96;0
WireConnection;65;0;64;0
WireConnection;65;1;63;0
WireConnection;60;0;61;0
WireConnection;60;1;62;0
WireConnection;20;1;65;0
WireConnection;3;1;60;0
WireConnection;94;0;100;0
WireConnection;95;0;94;0
WireConnection;67;1;65;0
WireConnection;67;5;69;0
WireConnection;14;1;3;3
WireConnection;68;1;60;0
WireConnection;68;5;70;0
WireConnection;21;1;20;3
WireConnection;27;0;21;0
WireConnection;19;0;20;1
WireConnection;45;0;95;0
WireConnection;26;1;65;0
WireConnection;22;0;20;2
WireConnection;12;0;3;2
WireConnection;11;0;3;1
WireConnection;13;0;14;0
WireConnection;24;0;67;0
WireConnection;1;1;60;0
WireConnection;10;0;68;0
WireConnection;9;0;1;0
WireConnection;23;0;26;0
WireConnection;49;0;50;0
WireConnection;49;1;37;0
WireConnection;49;2;38;0
WireConnection;47;0;48;0
WireConnection;47;1;35;0
WireConnection;47;2;36;0
WireConnection;51;0;52;0
WireConnection;51;1;53;0
WireConnection;51;2;54;0
WireConnection;58;0;55;0
WireConnection;58;1;56;0
WireConnection;58;2;57;0
WireConnection;108;0;49;0
WireConnection;105;0;47;0
WireConnection;107;0;51;0
WireConnection;106;0;58;0
WireConnection;41;0;46;0
WireConnection;41;1;33;0
WireConnection;41;2;34;0
WireConnection;0;0;41;0
WireConnection;0;1;105;0
WireConnection;0;3;108;0
WireConnection;0;4;107;0
WireConnection;0;5;106;0
ASEEND*/
//CHKSM=0F6AD5D5732B90B0EE8C1BB80C0F0DA594C2BC00