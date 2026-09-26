// plasma — interfering sine waves + ripples from each pointer

void main() {
	vec2 uv = (gl_FragCoord.xy - 0.5 * resolution) / min(resolution.x, resolution.y);
	float t = time * 0.6;

	float v = 0.0;
	v += sin(uv.x * 6.0 + t * 1.1);
	v += sin(uv.y * 7.0 - t * 1.4);
	v += sin((uv.x + uv.y) * 5.0 + t * 0.9);
	v += sin(length(uv * 8.0) - t * 2.0);
	v += sin(uv.x * 3.0 + uv.y * 4.0 + t * 0.7);

	for (int n = 0; n < 10; ++n) {
		if (n >= pointerCount) break;
		vec2 p = (pointers[n].xy - 0.5 * resolution) / min(resolution.x, resolution.y);
		float d = length(uv - p);
		v += 2.0 * sin(d * 28.0 - time * 5.0) * exp(-d * 7.0);
	}

	v *= 0.6;

	vec3 col = 0.5 + 0.5 * cos(vec3(0.0, 2.1, 4.2) + v * 2.2);
	col = mix(col, col * col * 1.4, 0.35);

	gl_FragColor = vec4(col, 1.0);
}