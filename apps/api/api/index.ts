// Vercel serverless entry point. Unlike src/index.ts (which calls app.listen()
// for the VPS/PM2 setup), this exports the Express app directly so Vercel's
// Node.js runtime can invoke it per-request — see ../vercel.json for the
// rewrite that forwards every path here.
import App from '../src/app';

export default new App().getApp();
