// infinite tunnel — drag a pointer left/right to steer the rotation

void main() {
	vec2 uv = (2.0 * gl_FragCoord.xy - resolution) / resolution.y;
	float t = time * 0.7;

	float ang = 0.0;
	if (pointerCount > 0) ang = (pointers[0].x / resolution.x - 0.5) * 2.5;
	float ca = cos(ang), sa = sin(ang);
	uv = mat2(ca, -sa, sa, ca) * uv;

	float r = max(length(uv), 0.05);
	float a = atan(uv.y, uv.x) * 0.3183099;   // /pi

	float z = 1.6 / r + t * 2.0;
	vec2 tu = vec2(z, a * 8.0);

	float rings = 0.5 + 0.5 * sin(tu.x * 3.14159);
	float bands = 0.5 + 0.5 * sin(tu.y * 1.5708 + sin(tu.x) * 2.0);
	float grid  = pow(abs(sin(tu.y * 1.5708) * sin(tu.x * 3.14159)), 12.0);

	vec3 col = vec3(0.10, 0.02, 0.28) * rings
	         + vec3(0.15, 0.55, 1.00) * bands * 0.7
	         + vec3(1.00, 0.45, 0.85) * grid * 1.4;

	col *= 1.0 - exp(-2.5 * r);
	col *= smoothstep(0.05, 0.55, r);

	gl_FragColor = vec4(col, 1.0);
}