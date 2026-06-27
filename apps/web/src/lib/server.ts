'use server';

import { cookies } from 'next/headers';

export async function createToken(token: string) {
  const oneDay = 24 * 60 * 60 * 1000;
  const cookieStore = await cookies();
  cookieStore.set('token', token, {
    expires: Date.now() + oneDay,
    path: '/',
    secure: true,
    sameSite: 'strict',
  });
}

export async function getToken() {
  const cookieStore = await cookies();
  return cookieStore.get('token')?.value;
}

export async function deleteToken() {
  const cookieStore = await cookies();
  cookieStore.delete('token');
}
