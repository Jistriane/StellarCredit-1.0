'use client';

import { useTranslations } from 'next-intl';
import { useWalletStore } from '@/stores/walletStore';
import { WelcomeScreen } from '@/components/dashboard/WelcomeScreen';
/**
 * Stellar Credit - Dashboard Principal
 * Sistema de Score de Crédito Descentralizado
 * 
 * Desenvolvido por: Atlantic Hacking HackMeridian 2025
 * Data: 2025
 * Hackathon: Stellar Meridian 2025
 */

import { Dashboard } from '@/components/dashboard/Dashboard';

export default function HomePage() {
  const t = useTranslations();
  const { isConnected } = useWalletStore();

  return (
    <>
      {isConnected ? (
        <Dashboard />
      ) : (
        <WelcomeScreen />
      )}
    </>
  );
}