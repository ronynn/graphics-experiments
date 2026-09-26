// mandelbrot — breathing zoom into the seahorse valley

void main() {
	vec2 uv = (gl_FragCoord.xy - 0.5 * resolution) / resolution.y;

	float k = 0.5 + 0.5 * sin(time * 0.13);
	float zoom = exp(-4.5 * k) * 2.2;
	vec2 c = uv * zoom + vec2(-0.743643887, 0.131825904);

	vec2 z = vec2(0.0);
	float n = 0.0;
	float m2 = 0.0;

	for (int i = 0; i < 128; ++i) {
		z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
		m2 = dot(z, z);
		if (m2 > 64.0) break;
		n += 1.0;
	}

	vec3 col = vec3(0.0);
	if (m2 > 64.0) {
		float sn = n - log2(log2(max(sqrt(m2), 2.0))) + 4.0;
		col = 0.5 + 0.5 * cos(0.18 * sn + vec3(0.0, 0.9, 1.9));
		col *= col;
	}

	gl_FragColor = vec4(col, 1.0);
}