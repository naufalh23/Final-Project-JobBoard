// Derive the API's hostname from NEXT_PUBLIC_BASE_API_URL so uploaded
// images (company logos, profile pictures) work with next/image wherever
// the API actually ends up deployed, without hardcoding a domain here.
let apiRemotePattern;
try {
  const apiUrl = new URL(process.env.NEXT_PUBLIC_BASE_API_URL);
  apiRemotePattern = {
    protocol: apiUrl.protocol.replace(':', ''),
    hostname: apiUrl.hostname,
  };
} catch {
  apiRemotePattern = null;
}

/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      { protocol: 'http', hostname: 'localhost' },
      { protocol: 'https', hostname: 'platform-lookaside.fbsbx.com' },
      { protocol: 'https', hostname: 'img.daisyui.com' },
      ...(apiRemotePattern ? [apiRemotePattern] : []),
    ],
  },
};

module.exports = nextConfig;
