using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.Linq;

public class Mgui4 : ShaderGUI
{

	MaterialEditor editor;
	MaterialProperty[] properties;

	
	private Texture button_tex;
	private GUIContent button_tex_con;
	
//Manage editor, array of properties 
public override void OnGUI (
		MaterialEditor editor, MaterialProperty[] properties
	) {
		this.editor = editor;
		this.properties = properties;
		DoMain();
	}
	
	void DoMain() {
	
	
	//Material stuff
	GUILayout.Label(" ");
	GUILayout.Label("Material 1", EditorStyles.boldLabel);
	MaterialProperty Tiling1 = FindProperty("_Tiling1", properties);
	MaterialProperty Offset1 = FindProperty("_Offset1", properties);
	editor.FloatProperty(Tiling1, "Tiling");
	editor.VectorProperty(Offset1, "Offset");
	
		GUILayout.Label("Material 2", EditorStyles.boldLabel);
	MaterialProperty Tiling2 = FindProperty("_Tiling2", properties);
	MaterialProperty Offset2 = FindProperty("_Offset2", properties);
	editor.FloatProperty(Tiling2, "Tiling");
	editor.VectorProperty(Offset2, "Offset");
	

	
	//Vertex Color
	
	MaterialProperty BlendToggle1 = FindProperty("_UseBlendDetailTexture", properties);

	
	GUILayout.Label(" ");
	GUILayout.Label("Vertex Color Mask", EditorStyles.boldLabel);
	MaterialProperty blendTex = FindProperty("_BlendDetailTexture", properties);
	GUIContent blend1Label = new GUIContent(blendTex.displayName);
	editor.TexturePropertySingleLine(blend1Label, blendTex);	
	MaterialProperty v1 = FindProperty("_VertexRHardness1", properties);
	MaterialProperty v2 = FindProperty("_VertexRHardness2", properties);
	editor.FloatProperty(v1, "Vertex Hardness 1");
	editor.FloatProperty(v2, "Vertex Hardness 2");
	
	editor.ShaderProperty(BlendToggle1, "Mix Texture");
	
	MaterialProperty TilingBlend = FindProperty("_BlendDetailTextureTile", properties);
	MaterialProperty OffsetBlend = FindProperty("_BlendDetailTextureOffset", properties);
	editor.FloatProperty(TilingBlend, "Tiling");
	editor.VectorProperty(OffsetBlend, "Offset");
		
	
	//Textures
	GUILayout.Label(" ");
	GUILayout.Label("Albedo Maps", EditorStyles.boldLabel);
		
	MaterialProperty mainTex = FindProperty("_MainTex", properties);
	GUIContent albedo1Label = new GUIContent(mainTex.displayName);
	editor.TexturePropertySingleLine(albedo1Label, mainTex);

	MaterialProperty Albedo2 = FindProperty("_Albedo2", properties);
	GUIContent albedo2Label = new GUIContent(Albedo2.displayName);
	editor.TexturePropertySingleLine(albedo2Label, Albedo2);	

	
	GUILayout.Label("Normal Maps", EditorStyles.boldLabel);
	MaterialProperty NormalTex = FindProperty("_Normal1", properties);
	MaterialProperty NormalIntensity1 = FindProperty("_NormalIntensity1", properties);

	GUIContent normal1Label = new GUIContent(NormalTex.displayName);
	editor.TexturePropertySingleLine(normal1Label, NormalTex, NormalIntensity1);
	
	MaterialProperty NormalTex2 = FindProperty("_Normal2", properties);
	MaterialProperty NormalIntensity2 = FindProperty("_NormalIntensity2", properties);

	GUIContent normal2Label = new GUIContent(NormalTex2.displayName);
	editor.TexturePropertySingleLine(normal1Label, NormalTex2, NormalIntensity2);
	
	
	//Packed stuff
	GUILayout.Label(" ");
	GUILayout.Label("Metallic + Smoothness + Occlusion Maps", EditorStyles.boldLabel);
		
	MaterialProperty MetTex1 = FindProperty("_MetallicSmoothnessOcclusion1", properties);	
	MaterialProperty Toggle1 = FindProperty("_UseOcclusionTexture1", properties);
	GUIContent met1Label = new GUIContent(MetTex1.displayName);
	editor.TexturePropertySingleLine(met1Label, MetTex1,Toggle1);
	
	MaterialProperty MetTex2 = FindProperty("_MetallicSmoothnessOcclusion2", properties);	
	MaterialProperty Toggle2 = FindProperty("_UseOcclusionTexture2", properties);
	GUIContent met2Label = new GUIContent(MetTex2.displayName);
	editor.TexturePropertySingleLine(met2Label, MetTex2,Toggle2);	
	
		
	
	//Additional stuff
	GUILayout.Label(" ");
	editor.RenderQueueField();
	#if UNITY_5_6_OR_NEWER
			editor.EnableInstancingField();
	#endif
	#if UNITY_5_6_2 || UNITY_5_6_3 || UNITY_5_6_4 || UNITY_2017_1_OR_NEWER
			editor.DoubleSidedGIField();
	#endif
	editor.LightmapEmissionProperty();
	
	
	
	
	}	
	
	
	

}



