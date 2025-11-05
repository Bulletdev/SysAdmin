import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 1 },
  ],
};

const BASE_URL = __ENV.BASE_URL || 'http://localhost:4040';
const EMAIL = __ENV.TEST_EMAIL || 'user1@example.com';
const PASSWORD = __ENV.TEST_PASSWORD || 'password123';

function getCsrfToken(html) {
  const match = html.match(/name="authenticity_token" value="([^"]+)"/);
  return match ? match[1] : null;
}

export default function () {
  // Load sign in page and extract CSRF token
  const signInPage = http.get(`${BASE_URL}/users/sign_in`);
  check(signInPage, { 'login page loads': (r) => r.status === 200 });

  const csrf = getCsrfToken(signInPage.body);
  check(csrf, { 'csrf token present': (t) => t !== null });

  // Perform login (Devise)
  const payload = `authenticity_token=${encodeURIComponent(csrf)}&user[email]=${encodeURIComponent(EMAIL)}&user[password]=${encodeURIComponent(PASSWORD)}&commit=Entrar`;
  const headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
  const loginRes = http.post(`${BASE_URL}/users/sign_in`, payload, { headers });
  check(loginRes, { 'logged in or redirected': (r) => r.status === 200 || r.status === 302 });

  // Visit profile page
  const profileRes = http.get(`${BASE_URL}/user_profile`);
  check(profileRes, {
    'profile page loads': (r) => r.status === 200,
    'shows Profile Information': (r) => r.body.includes('Profile Information')
  });

  sleep(1);
}