shader_type canvas_item;

uniform int pixelSteps = 1;
uniform float alphaThresh = 0.5;
uniform vec4 outlineColor : hint_color = vec4(1.0, 1.0, 1.0, 1.0);

bool pixelInOutline(vec2 uv, vec2 texturePixelSize, sampler2D tex) {
	for(int xs = -pixelSteps; xs <= pixelSteps; ++xs){
		for(int ys = -pixelSteps; ys <= pixelSteps; ++ys){
			if(xs == 0 && ys == 0) continue;
			
			vec2 checkUV = uv + texturePixelSize * vec2(float(xs), float(ys));
			if(checkUV.x < 0.0 || checkUV.x > 1.0 || checkUV.y < 0.0 || checkUV.y > 1.0) {
				return true;
			}
			vec4 checkPixel = texture(tex, checkUV);
			if(checkPixel.a < alphaThresh){
				return true;
			}
		}
	}
	return false;
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if(COLOR.a > alphaThresh && pixelInOutline(UV, TEXTURE_PIXEL_SIZE, TEXTURE)){
		COLOR = outlineColor;
	}
}