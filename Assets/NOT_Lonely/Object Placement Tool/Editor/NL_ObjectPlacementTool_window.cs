using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEditorInternal;

public enum PlacementType{
	Everywhere,
	OnLayer,
	OnSelected
}
[InitializeOnLoad]
public class NL_ObjectPlacementTool_window : EditorWindow {

	public static bool RulerMode = false;
	private float RulerDistance = 0;
	private int RulerClickCount = 0;
	public static bool EditMode = false;
	[SerializeField]
	private Vector3 rotations = new Vector3(0,0,0);
	[SerializeField]
	private bool RandomizeRotation = true;
	[SerializeField]
	private Vector3 AnglesMax = new Vector3(0, 360, 0);
	[SerializeField]
	private float objScale = 1;
	[SerializeField]
	private bool RandomizeScale = false;
	[SerializeField]
	private float ScaleMin = 1;
	[SerializeField]
	private float ScaleMax = 1.4f;
	[SerializeField]
	private bool AlignToNormal = true;
	[SerializeField]
	private float yOffset = 0;
	[SerializeField]
	private Transform parentTransform;
	[SerializeField]
	private List<GameObject> droppedObjects = new List<GameObject>();
	private static GameObject obj;
	private static RaycastHit hitInfoA;
	private static RaycastHit hitInfoB;
	private static RaycastHit hitInfoMain;
	[SerializeField]
	private LayerMask layermask;
	[SerializeField]
	private bool BrushMode = false;
	[SerializeField]
	private int BrushIntensity = 10;
	[SerializeField]
	private float BrushSize = 2;
	[SerializeField]
	private float BrushDepth = 1;
	private Ray worldRay;
	private float camDist;
	private Vector3 lastPos = Vector3.zero;
	private Vector3 curPos = Vector3.zero;
	[SerializeField]
	private bool followPath = false;
	[SerializeField]
	private int clickCount = 0;
	private Quaternion pathDir;
	private Vector3 rot;

	[SerializeField]
	private bool GridSnapping = false;
	[SerializeField]
	private Vector2 gridSize;
	[SerializeField]
	private float linesOpacity = 0.5f;

	private Texture2D cursorTex;

	[SerializeField]
	private bool ObjectSelectionFoldout = true;
	[SerializeField]
	private bool RotationFoldout = false;
	[SerializeField]
	private bool ScaleFoldout = false;
	[SerializeField]
	private bool GridFoldout = true;
	private Texture2D logo;

	private Vector2 scrollPos = new Vector2(0,0);
	[SerializeField]
	private PlacementType display = PlacementType.Everywhere;
	int ParentObjID = 0;

	public static NL_ObjectPlacementTool_window window;

	[InitializeOnLoadMethod]
	static void Init()
	{
		//SceneView.onSceneGUIDelegate += Upd;
	}

	[MenuItem ("NOT_Lonely/Object Placement Tool")]
	public static void OPTWindow(){
		window = GetWindow<NL_ObjectPlacementTool_window> ("Object Placement Tool");
		window.maxSize = new Vector2 (480, 2000);
		window.minSize = new Vector2 (400, 330);
		SceneView.onSceneGUIDelegate += Upd;

	}
	[MenuItem ("NOT_Lonely/Deselect All %#_d")]
	static void DoDeselect(){
		Selection.objects = new UnityEngine.Object[0];
	}
	[MenuItem ("NOT_Lonely/Rotate 90 deg by Y axis %#_r")]
	static void RotateAround(){
		Selection.activeTransform.localEulerAngles = new Vector3 (Selection.activeTransform.localEulerAngles.x, Selection.activeTransform.localEulerAngles.y + 90, Selection.activeTransform.localEulerAngles.z);
		Undo.RegisterCompleteObjectUndo (Selection.activeTransform.gameObject, "Rotate 90 deg by Y axis of " +Selection.activeTransform.name);
	}

	//Layer mask popup
	static List<int> layerNumbers = new List<int> ();
	static LayerMask LayerMaskField (GUIContent label, LayerMask layerMask){

		var layers = InternalEditorUtility.layers;

		layerNumbers.Clear ();

		for(int i = 0; i < layers.Length; i++)
			layerNumbers.Add (LayerMask.NameToLayer (layers[i]));
		
		int maskWithoutEmpty = 0;
		for (int i = 0; i < layerNumbers.Count; i++) {
			
			if (((1 << layerNumbers[i]) & layerMask.value) > 0)
				maskWithoutEmpty |= (1 << i);	
		}
				maskWithoutEmpty = EditorGUILayout.MaskField(label, maskWithoutEmpty, layers);

				int mask = 0;
				for(int i = 0; i < layerNumbers.Count; i++){
					if((maskWithoutEmpty & (1 << i)) != 0){
						mask |= (1 << layerNumbers[i]);
					}
				}
				layerMask.value = mask;
				return layerMask;
		}



	void OnEnable(){
		if(window == null){
		OPTWindow ();
		}
	}

		
	void DropAreaGUI(){
		
		Event evt = Event.current;
		Rect drop_area = GUILayoutUtility.GetRect (0, 50, GUILayout.ExpandWidth (true));
		GUI.Box (drop_area, "");
		if (droppedObjects.Count <= 0) {
			GUI.Box (drop_area, "Drag & Drop objects here", EditorStyles.centeredGreyMiniLabel);
		} else {
			GUI.Box (drop_area, "Drag & Drop objects here \n" +droppedObjects.Count + " objects selected", EditorStyles.centeredGreyMiniLabel);
		}

		switch (evt.type) {
		case EventType.DragUpdated:
		case EventType.DragPerform:
			if(!drop_area.Contains(evt.mousePosition)){
				return;
			}
			DragAndDrop.visualMode = DragAndDropVisualMode.Copy;
			if(evt.type == EventType.DragPerform){
				DragAndDrop.AcceptDrag();
				foreach (GameObject droppedObj in DragAndDrop.objectReferences){
					droppedObjects.Add (droppedObj.gameObject);
				}
			}
			break;
		}
	}

	void OnGUI(){
		if(Event.current.type == EventType.ValidateCommand){
			switch (Event.current.commandName) {
			case "UndoRedoPerformed":
				if(ParentObjID >0){
					ParentObjID--;
				}
				break;
			}
		}

		//Logo


		logo = Resources.Load ("LogoSmall_dark", typeof(Texture2D)) as Texture2D;

		GUILayout.BeginArea (new Rect(position.width/2 - logo.width/2, 16, logo.width, logo.height));
		GUILayout.Label (logo);
		GUILayout.EndArea ();

		GUILayout.Space (32 + logo.height);


		Rect topLine = GUILayoutUtility.GetRect (0, 1, GUILayout.ExpandWidth (true));
		GUI.Box (topLine, "");

		GUILayout.Space (1);

		if(window != null){
			scrollPos = GUILayout.BeginScrollView (scrollPos, false, false, GUILayout.MaxHeight(window.position.height - 200));
		}


		//Object selection block


		GUILayout.BeginVertical (EditorStyles.helpBox);

		ObjectSelectionFoldout = EditorGUILayout.Foldout (ObjectSelectionFoldout, "Object settings");
		if (ObjectSelectionFoldout) {
			GUILayout.BeginVertical (EditorStyles.helpBox);
			DropAreaGUI ();

			GUILayout.Space (6);

			EditorGUI.BeginDisabledGroup (droppedObjects.Count <= 0);
			if (GUILayout.Button ("Clear the list", GUILayout.Width (100))) {
				droppedObjects.Clear ();
			}
			GUILayout.Space (10);
			GUILayout.EndVertical ();


			EditorGUI.EndDisabledGroup ();


			GUILayout.Space (10);

			GUILayout.BeginVertical (EditorStyles.helpBox);

			GUILayout.BeginHorizontal ();
			if(GUILayout.Button("Create new parent", GUILayout.Width(130))){
				Undo.IncrementCurrentGroup ();
				GameObject newParent = new GameObject ();
				newParent.name = "Parent Object" + ParentObjID;
				ParentObjID++;
				parentTransform = newParent.transform;
				Undo.RegisterCreatedObjectUndo (newParent, "Create new parent");

			}
			Repaint ();

			GUILayout.Space (13);

			GUILayout.Label (new GUIContent("Parent:", "All new objects will be parented to this gameobject. You can create this object by pressing the 'Create new parent' button or select any other object manually from your scene."));
			parentTransform = (Transform)EditorGUILayout.ObjectField (parentTransform, typeof(Transform), true, GUILayout.MinWidth(140));

			GUILayout.EndHorizontal ();

			GUILayout.Space (10);

			EditorGUI.BeginDisabledGroup (!parentTransform);

			GUILayout.BeginHorizontal ();

			if (GUILayout.Button (new GUIContent("Parent selected", "Make all selected objects as child to 'Parent' object."), GUILayout.Width (110))) {
				if (Selection.gameObjects.Length > 0) {
					GameObject[] selectedObjs = Selection.gameObjects;
					foreach (GameObject SelectedObj in selectedObjs) {
						if (parentTransform != null) {
							Undo.SetTransformParent (SelectedObj.transform, parentTransform.transform, "Parent selected");
						}
					}
				} else {
					EditorUtility.DisplayDialog ("No one object selected", "Please, select one or few objects in the scene that you want to make as child to the '" + parentTransform.name + "'.", "Ok");
				}
			}

			GUILayout.Space (36);

			if (GUILayout.Button (new GUIContent("Unparent selected", "Unparent all selected objects from 'Parent' object."), GUILayout.Width (120))) {
				if (Selection.gameObjects.Length > 0) {
					GameObject[] selectedObjs = Selection.gameObjects;
					foreach (GameObject SelectedObj in selectedObjs) {
						if (parentTransform != null) {
							if (SelectedObj.transform.parent == parentTransform) {
								Undo.SetTransformParent (SelectedObj.transform, parentTransform.transform.parent, "Unparent selected");
							}
						}
					}
				} else {
					EditorUtility.DisplayDialog ("No one object selected", "Please, select one or few objects in the scene that you want to be uparented from the '" + parentTransform.name + "'.", "Ok");
				}
			}
			GUILayout.EndHorizontal ();

			GUILayout.Space (10);

			EditorGUI.EndDisabledGroup ();

			display = (PlacementType)EditorGUILayout.EnumPopup (new GUIContent("Placement type:", "Where the objects can be placed."), display);

			if(display == PlacementType.OnLayer){
				GUILayout.Space (10);
				GUILayout.BeginHorizontal ();

				layermask = LayerMaskField (new GUIContent("Layer:", "Objects will be created only on selected layers."), layermask);

				GUILayout.EndHorizontal ();

			}
			GUILayout.EndVertical();

			GUILayout.Space (10);
			GUILayout.BeginVertical (EditorStyles.helpBox);
			if (BrushMode = EditorGUILayout.Toggle (new GUIContent ("Brush mode", "If enabled, your objects will be created by bunches."), BrushMode)) {
				followPath = false;
				GUILayout.BeginHorizontal ();

				GUILayout.Label (new GUIContent("Brush size:", "The radius of the brush."), GUILayout.MinWidth(147));
				BrushSize = EditorGUILayout.Slider (BrushSize, 0.1f, 20, GUILayout.MaxWidth(400));

				GUILayout.EndHorizontal ();

				GUILayout.BeginHorizontal ();

				GUILayout.Label (new GUIContent("Brush intensity:", "How many objects will be created at a one click."), GUILayout.MinWidth(147));
				BrushIntensity = EditorGUILayout.IntSlider (BrushIntensity, 1, 50, GUILayout.MaxWidth(400));

				GUILayout.EndHorizontal ();

				GUILayout.BeginHorizontal ();

				GUILayout.Label (new GUIContent("Brush depth:", "What the depth of the brush impact is."), GUILayout.MinWidth(147));
				BrushDepth = EditorGUILayout.Slider (BrushDepth, 0.05f, 5, GUILayout.MaxWidth(400));

				GUILayout.EndHorizontal ();

				if(display == PlacementType.Everywhere){
					GUILayout.Label ("Recommended to use 'On Layer' or 'On Selected' placement type \nin Brush mode to prevent creation objects at each other.", EditorStyles.centeredGreyMiniLabel);
				}
			}
			GUILayout.EndVertical ();
		}

	

		GUILayout.EndVertical ();


		//Rotation block

		GUILayout.Space (10);

		GUILayout.BeginVertical (EditorStyles.helpBox);
		RotationFoldout = EditorGUILayout.Foldout (RotationFoldout, "Rotation settings");
		if(RotationFoldout){
		GUILayout.BeginHorizontal ();
		//EditorGUI.BeginDisabledGroup (NL_ObjectPlacementTool.RandomizeRotation);
	
			GUILayout.Label (new GUIContent("Rotation:", "Rotation of the created object. Unavailable in Random mode; use Min and Max limits instead."), GUILayout.MinWidth(145));
			rotations = EditorGUILayout.Vector3Field ("", rotations, GUILayout.MaxWidth (400));


		//EditorGUI.EndDisabledGroup ();

		GUILayout.EndHorizontal ();

		if(RandomizeRotation = EditorGUILayout.Toggle (new GUIContent("Random Rotation", "Make a random rotations in the selected range for every created object."), RandomizeRotation)){
			GUILayout.BeginHorizontal ();
				GUILayout.Label (new GUIContent ("Random Angles:", "The Maximum limits of random range of the angle in degrees"), GUILayout.MinWidth(145));
				AnglesMax = EditorGUILayout.Vector3Field("", AnglesMax, GUILayout.MaxWidth (400));
			GUILayout.EndHorizontal ();
		}
			EditorGUI.BeginDisabledGroup (followPath);
				AlignToNormal = EditorGUILayout.Toggle (new GUIContent("Align to Surface", "Align object's up axis to surface normal direction. Good for placing stones and decals, but recommended to disable it for grass, trees and other objects, that have to be oriented strongly vertical regardless of the surface curvature."), AlignToNormal);
			EditorGUI.EndDisabledGroup ();

			EditorGUI.BeginDisabledGroup (BrushMode);
			GUILayout.BeginHorizontal ();
			if (followPath = EditorGUILayout.Toggle (new GUIContent ("Follow Path", "Place new object depending to previous object direction. Good for fence placing."), followPath)) {
				GUILayout.BeginHorizontal ();
				AlignToNormal = false;
				GUILayout.EndHorizontal ();
			} else {
				clickCount = 0;
			}

			EditorGUI.EndDisabledGroup ();
			if(BrushMode){

				GUILayout.Label ("Unavailable in Brush Mode.", EditorStyles.centeredGreyMiniLabel);

			}
			GUILayout.EndHorizontal ();

		}

		GUILayout.EndVertical ();


		//Scale block

		GUILayout.Space (10);

		GUILayout.BeginVertical (EditorStyles.helpBox);

		ScaleFoldout = EditorGUILayout.Foldout (ScaleFoldout, "Scale settings");

		if(ScaleFoldout){
		GUILayout.BeginHorizontal ();
		EditorGUI.BeginDisabledGroup (RandomizeScale);
			GUILayout.Label (new GUIContent ("Scale:", "Uniform scale of the object in Units. Default = 1. Unavailable in Random mode; use Min and Max limits instead."), GUILayout.MinWidth(147));
			objScale = EditorGUILayout.FloatField (objScale, GUILayout.MaxWidth(400));

		EditorGUI.EndDisabledGroup ();

		GUILayout.EndHorizontal ();
		if(RandomizeScale = EditorGUILayout.Toggle (new GUIContent("Random Scale", "Make a random uniform scale in the selected range for every created object."), RandomizeScale)){
			GUILayout.BeginVertical ();
				GUILayout.BeginHorizontal ();
				GUILayout.Label (new GUIContent ("Scale Min:", "The Minimum limit of random range"));
				ScaleMin = EditorGUILayout.FloatField (ScaleMin, GUILayout.MaxWidth(150));
				GUILayout.Label (new GUIContent ("Scale Max:", "The Maximum limit of random range"));
				ScaleMax = EditorGUILayout.FloatField (ScaleMax, GUILayout.MaxWidth(150));
				GUILayout.EndHorizontal ();
			GUILayout.EndVertical ();
		}
		}
		GUILayout.EndVertical ();

		GUILayout.Space (10);
		GUILayout.BeginVertical (EditorStyles.helpBox);
		GridFoldout = EditorGUILayout.Foldout (GridFoldout, "Grid settings");
		if(GridFoldout){
			if (GridSnapping = EditorGUILayout.Toggle (new GUIContent ("Grid", "If enabled, will be shown a grid that represents Move X/Y/Z values from the Edit-> Snap Settings window."), GridSnapping)) {
				gridSize = new Vector2(EditorPrefs.GetFloat ("MoveSnapX"), EditorPrefs.GetFloat ("MoveSnapZ"));
				GUILayout.BeginHorizontal ();
				GUILayout.Label (new GUIContent("Grid opacity:", ""), GUILayout.MinWidth(147));
				linesOpacity = EditorGUILayout.Slider (linesOpacity, 0, 1, GUILayout.MaxWidth(400));
				GUILayout.EndHorizontal ();
			}
		}
		GUILayout.EndVertical ();

		//Offset block

		GUILayout.Space (10);


		GUILayout.BeginHorizontal ();

		GUILayout.Label (new GUIContent("Y (up) Offset:", "Make an offset of the placed object from the surface. Use it for decals, to prevent Z-fighting artifacts."), GUILayout.MinWidth(147));
		window.yOffset = EditorGUILayout.Slider (window.yOffset, -0.99f, 1, GUILayout.MaxWidth(400));

		GUILayout.EndHorizontal ();

		//Ruler block

		GUILayout.Space (10);

		GUILayout.BeginVertical (EditorStyles.helpBox);
		GUILayout.BeginHorizontal ();
		EditorGUI.BeginDisabledGroup (EditMode);
		if (RulerMode) {
			GUI.color = new Color (0.137f, 0.713f, 1, 1);
			if (GUILayout.Button ("Ruler", GUILayout.Width (60))) {
				window.RulerClickCount = 0;
				window.curPos = Vector3.zero;
				window.lastPos = Vector3.zero;
				RulerMode = false;
			}
		} else {
			GUI.color = Color.white;
			if (GUILayout.Button ("Ruler", GUILayout.Width (60))) {
				window.RulerClickCount = 0;
				window.curPos = Vector3.zero;
				window.lastPos = Vector3.zero;
				window.RulerDistance = 0;
				RulerMode = true;
			}
		}
		GUILayout.BeginHorizontal ();
		GUILayout.Label ("Distance between click A and B = " + RulerDistance + "\n (Press Ctrl + Mouse Right to set points)", EditorStyles.centeredGreyMiniLabel);

		EditorGUI.EndDisabledGroup ();

		GUILayout.EndHorizontal ();

		GUILayout.EndHorizontal ();
		GUILayout.EndVertical ();

		GUILayout.Space (10);

		if(window != null){
			GUILayout.EndScrollView ();

		}

		GUILayout.Space (1);

		GUI.color = Color.white;

		Rect bottomLine = GUILayoutUtility.GetRect (0, 1, GUILayout.ExpandWidth (true));
		GUI.Box (bottomLine, "");

		GUILayout.Space (8);

		GUILayout.Label ("Press 'Ctrl + Mouse Right' to place objects in scene", EditorStyles.centeredGreyMiniLabel);


		//Edit button

		GUILayout.Space (10);

		GUILayout.BeginArea (new Rect(position.width/2 - 104, position.height - 48, 208, 32));

		if (EditMode) {
			GUI.color = new Color (0.137f, 0.713f, 1, 1);
			if(GUILayout.Button ("Exit Edit Mode", GUILayout.Width(200), GUILayout.Height(32))){
				EditMode = false;
			}
		} else {
			GUI.color = Color.white;
			if (GUILayout.Button ("Enter Edit Mode", GUILayout.Width(200), GUILayout.Height(32))) {
				if (droppedObjects.Count > 0) {
					EditMode = true;
				} else {
					EditorUtility.DisplayDialog ("No one object added", "Please, drag n drop at least one object into the Drag n Drop area of the Object Placement Tool window.", "Ok");
				}

			}
		}
		GUILayout.EndArea ();
		//SceneView.RepaintAll ();
	}
	private static void Upd (SceneView sceneview){


		Event e = Event.current;
		if (!window || window.droppedObjects.Count <= 0) {
			EditMode = false;
		}

		if(window.GridSnapping){
			GridUpd ();
		}

		if(window){

			if(window.BrushMode){
				window.worldRay = HandleUtility.GUIPointToWorldRay (e.mousePosition);
				if(Physics.Raycast(window.worldRay, out hitInfoA, 10000)){
					Handles.color = Color.white;
					Handles.Disc (Quaternion.identity, hitInfoA.point, hitInfoA.normal, window.BrushSize/2, false, 1);
					Handles.color = Color.black;
					Handles.Disc (Quaternion.identity, hitInfoA.point, hitInfoA.normal, window.BrushSize/2 - 0.1f, false, 1);
				}
			}
		}

		if (RulerMode && !EditMode) {
			if (e.modifiers == EventModifiers.Control) {
				EditorGUIUtility.AddCursorRect (EditorWindow.GetWindow<SceneView> ().camera.pixelRect, MouseCursor.MoveArrow);
				if (e.type == EventType.MouseDown && e.button == 1 && e.modifiers == EventModifiers.Control) {
					e.Use ();
					window.worldRay = HandleUtility.GUIPointToWorldRay (e.mousePosition);
					if (Physics.Raycast (window.worldRay, out hitInfoA, 10000)) {
						if (window.RulerClickCount != 2) {
							window.RulerClickCount++;
						} else if(window.RulerClickCount > 2) {
							window.RulerClickCount = 0;
						}
						window.curPos = window.lastPos;
						if(window.RulerClickCount == 2){
						window.RulerDistance = Vector3.Distance (hitInfoA.point, window.curPos);
						}
						window.lastPos = hitInfoA.point;
					}
				
				}

			}
			if(window.RulerClickCount >= 1){
				Handles.color = Color.white;
				Handles.SphereHandleCap (0, window.lastPos, Quaternion.identity, 0.08f, EventType.Repaint);
				Handles.color = Color.black;
				Handles.SphereHandleCap (0, window.lastPos, Quaternion.identity, 0.04f, EventType.Repaint);
			}
			if(window.RulerClickCount == 2){
				Handles.color = Color.white;
				Handles.SphereHandleCap (0, window.curPos, Quaternion.identity, 0.08f, EventType.Repaint);
				Handles.color = Color.black;
				Handles.SphereHandleCap (0, window.curPos, Quaternion.identity, 0.04f, EventType.Repaint);
				Handles.color = Color.white;
				Handles.DrawDottedLine (window.curPos, window.lastPos, 3);
			}
		}

		if(EditMode){
			if(e.modifiers == EventModifiers.Control){
				EditorGUIUtility.AddCursorRect (EditorWindow.GetWindow<SceneView>().camera.pixelRect, MouseCursor.MoveArrow);
				if(window.followPath && window.clickCount != 0 && !window.BrushMode){
					window.worldRay = HandleUtility.GUIPointToWorldRay (e.mousePosition);
					if(Physics.Raycast(window.worldRay, out hitInfoA, 10000)){

						Handles.color = Color.white;
						Handles.SphereHandleCap (0, window.lastPos, Quaternion.identity, 0.2f, EventType.Repaint);

						Handles.color = Color.black;
						Handles.SphereHandleCap (0, window.lastPos, Quaternion.identity, 0.1f, EventType.Repaint);

						if(window.clickCount >= 2){
							Handles.color = Color.white;
							Handles.ArrowHandleCap (0, window.lastPos, window.pathDir * Quaternion.Euler(1,180,1), 1, EventType.Repaint);
						}

						Handles.color = Color.white;
						Handles.DrawLine (window.lastPos, hitInfoA.point);
					}
				}
			}
			if (e.type == EventType.MouseDown && e.button == 1 && e.modifiers == EventModifiers.Control) {
				e.Use ();

				if (window.display == PlacementType.OnSelected && Selection.activeObject == null) {
					EditorUtility.DisplayDialog ("No one object selected in scene", "Please, select an object in the scene on which you want to place objects.", "Ok");
				} 


				if (window.droppedObjects.Count > 0) {
					if (!window.BrushMode) {
						window.worldRay = HandleUtility.GUIPointToWorldRay (e.mousePosition);
						if (Physics.Raycast (window.worldRay, out hitInfoA, 10000)) {
							PlaceObj ();
							window.clickCount++;
							window.lastPos = hitInfoA.point;

						}
					} else {

						//brush mode here


						//Undo.IncrementCurrentGroup ();

						for (int i = 1; i <= window.BrushIntensity; i++) {

							window.camDist = Vector3.Distance (hitInfoA.point, Camera.current.transform.position);

							Vector2 randomRayPos = Random.insideUnitCircle * ((window.BrushSize * 90) / (window.camDist / 10)) / 2;

							window.worldRay = HandleUtility.GUIPointToWorldRay (e.mousePosition + randomRayPos);

							if (Physics.Raycast (window.worldRay, out hitInfoB, window.camDist + window.BrushDepth)) {
								if (Vector3.Distance (hitInfoB.point, Camera.current.transform.position) >= window.camDist - 4) {
									PlaceObj ();
								}
							}
						}
					}
				}
			}
		}
	}
	private static void PlaceObj (){

		if (window.BrushMode) {
			hitInfoMain = hitInfoB;
		} else {
			hitInfoMain = hitInfoA;
		}

		if(window.display == PlacementType.Everywhere){
			SetObjectProperties ();
		}else if (window.display == PlacementType.OnSelected && hitInfoMain.collider.gameObject == Selection.activeObject){
			SetObjectProperties ();
		}else if(window.display == PlacementType.OnLayer && (window.layermask.value & (1 << hitInfoMain.collider.gameObject.layer)) == (1 << hitInfoMain.collider.gameObject.layer)){
			SetObjectProperties ();
		}
	}

	private static void GridUpd(){

		Vector3 pos = Camera.current.transform.position;

		for (float z = pos.z - 400; z < pos.z + 400; z += window.gridSize.y) {
			Handles.DrawLine (new Vector3 (-100000, 0 , Mathf.Floor (z / window.gridSize.y) * window.gridSize.y),
				new Vector3 (100000, 0, Mathf.Floor (z / window.gridSize.y) * window.gridSize.y));
			Handles.color = new Color (1, 0.1f, 0.1f, window.linesOpacity);
		}

		for (float x = pos.x - 400; x < pos.y + 400; x += window.gridSize.x) {
			Handles.DrawLine (new Vector3 (Mathf.Floor (x / window.gridSize.x) * window.gridSize.x, 0, -100000),
				new Vector3 (Mathf.Floor (x / window.gridSize.x) * window.gridSize.x, 0, 100000));
			Handles.color = new Color (0, 0.3f, 1, window.linesOpacity);
		}
	}
	private static void SetObjectProperties(){

		int rndIndex = Random.Range(0, window.droppedObjects.Count);
		obj = (GameObject)PrefabUtility.InstantiatePrefab (window.droppedObjects[rndIndex].gameObject);
		obj.transform.position = hitInfoMain.point + hitInfoMain.normal * window.yOffset;
		if(window.clickCount != 0 && window.followPath){
			obj.transform.LookAt (window.lastPos);
			obj.transform.rotation = new Quaternion (0, obj.transform.rotation.y, 0, obj.transform.rotation.w);
			window.pathDir = obj.transform.rotation;
		}

		if(window.AlignToNormal){
			obj.transform.LookAt (hitInfoMain.point - hitInfoMain.normal);
			obj.transform.Rotate (Vector3.left * 90);
		}

		if(window.RandomizeRotation){
			obj.transform.Rotate (window.rotations.x + Random.Range(-window.AnglesMax.x/2, window.AnglesMax.x/2), window.rotations.y + obj.transform.rotation.y + Random.Range(-window.AnglesMax.y/2, window.AnglesMax.y/2), window.rotations.z + Random.Range(-window.AnglesMax.z/2, window.AnglesMax.z/2));
		}else{
			obj.transform.Rotate (window.rotations.x, obj.transform.rotation.y + window.rotations.y + 180, window.rotations.z);

		}


		if (window.RandomizeScale) {
			float randScale = Random.Range (window.ScaleMin, window.ScaleMax);
			obj.transform.localScale = new Vector3 (randScale, randScale, randScale);
		} else {
			obj.transform.localScale = new Vector3 (window.objScale, window.objScale, window.objScale);
		}

		if(window.parentTransform != null){
			obj.transform.parent = window.parentTransform;
		}


		Undo.RegisterCreatedObjectUndo (obj, "Place object with Object Placement Tool");
	}
}