// Utility to resolve backend base URL and fetch contract address from backend stats
// Avoids exposing CONTRACT_ADDRESS via NEXT_PUBLIC_*

let cachedContractAddress: string | null = null;
let lastFetchTs = 0;

export function getBackendBaseUrl(): string {
  // Prefer explicit env; fallback to same origin (useful for vercel rewrites/proxy)
  if (typeof process !== 'undefined' && process.env.NEXT_PUBLIC_API_BASE_URL) {
    return process.env.NEXT_PUBLIC_API_BASE_URL;
  }
  // If running in browser, try relative path
  return '';
}

export async function getContractAddress(options?: { forceRefresh?: boolean }): Promise<string | null> {
  const now = Date.now();
  if (!options?.forceRefresh && cachedContractAddress && now - lastFetchTs < 5 * 60 * 1000) {
    return cachedContractAddress;
  }

  try {
    const base = getBackendBaseUrl();
    const url = base ? `${base.replace(/\/$/, '')}/api/stats` : '/api/stats';
    const res = await fetch(url, { headers: { 'Content-Type': 'application/json' }, cache: 'no-store' });
    if (!res.ok) return null;
    const data = await res.json();
    const addr = data?.contract_address ?? null;
    cachedContractAddress = addr;
    lastFetchTs = now;
    return addr;
  } catch {
    return null;
  }
}

export async function getStellarNetwork(): Promise<string> {
  // Use env for network; default to testnet for safety in demos
  if (typeof process !== 'undefined' && process.env.NEXT_PUBLIC_STELLAR_NETWORK) {
    return process.env.NEXT_PUBLIC_STELLAR_NETWORK;
  }
  return 'testnet';
}
