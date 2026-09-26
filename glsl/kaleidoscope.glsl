// kaleidoscopic fold fractal

#define PI 3.14159265

vec2 fold(vec2 p, float n) {
	float a = atan(p.y, p.x);
	float r = length(p);
	float seg = PI / n;
	a = mod(a, 2.0 * seg);
	a = abs(a - seg);
	return vec2(cos(a), sin(a)) * r;
}

void main() {
	vec2 uv = (gl_FragCoord.xy - 0.5 * resolution) / resolution.y;
	float t = time * 0.35;

	float acc = 0.0;
	for (int i = 0; i < 7; ++i) {
		float fi = float(i);
		uv = fold(uv, 5.0 + fi);
		uv = abs(uv) - vec2(0.11 + 0.05 * sin(t + fi * 1.7));
		uv *= 1.5;
		acc += length(uv) * 0.35;
	}

	vec3 col = 0.5 + 0.5 * cos(vec3(0.0, 2.0, 4.0) + acc * 1.4 + t * 2.0);
	col *= 1.0 - exp(-1.6 * acc);

	gl_FragColor = vec4(col, 1.0);
}