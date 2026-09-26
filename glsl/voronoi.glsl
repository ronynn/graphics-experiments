// animated voronoi cells with glowing cores

vec2 hash2(vec2 p) {
	p = vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)));
	return fract(sin(p) * 43758.5453123);
}

void main() {
	vec2 uv = gl_FragCoord.xy / resolution.y * 7.0;
	uv += vec2(time * 0.25, time * 0.17);

	vec2 ip = floor(uv);
	vec2 fp = fract(uv);

	float d1 = 9.0, d2 = 9.0;
	vec2 cell = vec2(0.0);

	for (int y = -1; y <= 1; ++y) {
		for (int x = -1; x <= 1; ++x) {
			vec2 g = vec2(float(x), float(y));
			vec2 o = hash2(ip + g);
			o = 0.5 + 0.5 * sin(time * 1.7 + 6.2831853 * o);
			vec2 r = g + o - fp;
			float d = length(r);
			if (d < d1)      { d2 = d1; d1 = d; cell = ip + g; }
			else if (d < d2) { d2 = d; }
		}
	}

	float edge = d2 - d1;
	vec3 col = 0.5 + 0.5 * cos(vec3(0.0, 2.1, 4.2) + hash2(cell).x * 6.2831853 + time * 0.6);
	col *= smoothstep(0.0, 0.22, edge);
	col += pow(1.0 - clamp(d1, 0.0, 1.0), 10.0) * 1.5;

	gl_FragColor = vec4(col, 1.0);
}