void
gaplessgrid(Monitor *m) {
	unsigned int n, cols, rows, cn, rn, i, cx, cy, cw, ch;
	Client *c;

	for(n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next))
		n++;
	if(n == 0)
		return;

	/* grid dimensions */
	for(rows = 0; rows <= n/2; rows++)
		if(rows*rows >= n)
			break;
	if(n == 5) /* set layout against the general calculation: not 1:2:2, but 2:3 */
		rows = 2;
	cols = n/rows;

	/* window geometries */
	ch = rows ? m->wh / rows : m->wh;
	cn = 0; /* current column number */
	rn = 0; /* current row number */
	for(i = 0, c = nexttiled(m->clients); c; i++, c = nexttiled(c->next)) {
		if(i/cols + 1 > rows - n%rows)
			cols = n/rows + 1;
		cw = cols ? m->ww / cols : m->ww;
		cx = m->wx + cn*cw;
		cy = m->wy + rn*ch;
		resize(c, cx, cy, cw - 2 * c->bw, ch - 2 * c->bw, False);
		cn++;
		if(cn >= cols) {
			cn = 0;
			rn++;
		}
	}
}
