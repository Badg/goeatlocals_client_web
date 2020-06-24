import sirv from 'sirv';
import polka from 'polka';
import compression from 'compression';
import * as sapper from '@sapper/server';

// NOTE: this means we'll fail (sadly with exit code 0, so silently) if we
// don't set the env vars
const { PORT, HOST, NODE_ENV } = process.env;
const dev = NODE_ENV === 'development';

polka() // You can also use Express
	.use(
		compression({ threshold: 0 }),
		sirv('static', { dev }),
		sapper.middleware()
	)
	.listen(PORT, HOST, err => {
		if (err) console.log('error', err);
	});
