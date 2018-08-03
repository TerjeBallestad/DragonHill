Hi!
Thank you for purchasing my assets!



To achieve the same graphics as in the video demo and screenshots you have to be sure that you:

1. Set your project to Deferred Rendering Path (Edit -> Project Settings -> Player > Rendering Path: Deferred);
2. Set your project Color Space to Linear (Edit -> Project Settings -> Player > Color Space: Linear);

3. Switch your camera to HDR mode (Checkbox in the camera component);

4. Use Post Processing Stack (https://www.assetstore.unity3d.com/en/#!/content/83912) and pre-build profiles for that (placed in the DemoScene folder).



If you want to achieve more FPS, you can bake the lighting fully to static lightmaps.
To do this, select Lighting Mode: Subtractive in the Lighting Settings window and press "Generate Lighting" button. Be sure, that you set not too big Lightmap Resolution in Lightmapping Settings, because this can encrease baking time drastically. 7-10 will be enought for test.

If you see a message in Console: "Could not create a custom UI for the shader..." simply ignore it. It popups because you have no Shader Forge, but some shaders from this package have been created with Shader Forge and can be edited with it.

For mobiles use shaders from Mobile category.

That's all!


If you have any other questions relative to this asset, please write an email: support@not-lonely.com



Hey, and don't forget to leave a review at Asset Store :) It's really important for us!