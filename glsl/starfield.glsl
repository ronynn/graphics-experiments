// warp-speed starfield — drag to steer

float hash(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

void main() {
	vec2 uv = (2.0 * gl_FragCoord.xy - resolution) / resolution.y;

	vec2 steer = vec2(0.0);
	for (int n = 0; n < 10; ++n) {
		if (n >= pointerCount) break;
		steer += (pointers[n].xy / resolution - 0.5) * 0.6;
	}
	uv -= steer;

	float t = time * 0.35;
	vec3 col = vec3(0.0);

	for (int i = 0; i < 22; ++i) {
		float fi = float(i);
		float z = fract(hash(vec2(fi, 7.0)) - t);
		z = 0.06 + 0.94 * z;

		vec2 p = uv / z;
		vec2 g = floor(p * 9.0);
		vec2 fp = fract(p * 9.0);
		float h = hash(g + fi * 31.0);

		if (h > 0.86) {
			vec2 off = vec2(hash(g + 1.0), hash(g + 5.0)) - 0.5;
			float d = length(fp - 0.5 - off * 0.6);
			col += (1.0 - smoothstep(0.0, 0.10, d)) * z * vec3(0.75, 0.85, 1.0);
			col += (1.0 - smoothstep(0.0, 0.45, d)) * z * 0.12 * vec3(0.4, 0.6, 1.0);
		}
	}

	col *= 1.0 - 0.55 * length(uv);
	gl_FragColor = vec4(col, 1.0);
}