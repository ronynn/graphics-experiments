// metaballs — six orbiting blobs, plus one under each finger

void main() {
	vec2 uv = (gl_FragCoord.xy - 0.5 * resolution) / resolution.y;
	float t = time * 0.8;

	float f = 0.0;
	for (int i = 0; i < 6; ++i) {
		float fi = float(i);
		vec2 p = 0.55 * vec2(
			sin(t * (0.70 + fi * 0.11) + fi * 2.1),
			cos(t * (0.93 + fi * 0.13) + fi * 1.3)
		);
		vec2 d = uv - p;
		f += 0.012 / (dot(d, d) + 0.002);
	}

	for (int n = 0; n < 10; ++n) {
		if (n >= pointerCount) break;
		vec2 p = (pointers[n].xy - 0.5 * resolution) / resolution.y;
		vec2 d = uv - p;
		f += 0.016 / (dot(d, d) + 0.002);
	}

	float m = smoothstep(0.9, 1.4, f);
	vec3 col = mix(vec3(0.02, 0.03, 0.07), vec3(0.25, 0.75, 1.0), m);
	col += pow(m, 5.0) * vec3(1.0, 1.0, 1.0);
	col += vec3(0.35, 0.10, 0.45) * pow(1.0 - m, 6.0);

	gl_FragColor = vec4(col, 1.0);
}