import type { Metadata } from 'next';
import { ReactNode } from 'react';
import './globals.css';

export const metadata: Metadata = {
  title: {
    template: '%s | Artistic Store',
    default: 'Artistic Store - Premium Beauty Products',
  },
  description:
    'Premium beauty devices, skincare, and hair care products for professionals and beauty enthusiasts',
  keywords: [
    'beauty devices',
    'skincare',
    'hair care',
    'professional beauty',
  ],
  authors: [{ name: 'Artistic Store Team' }],
  creator: 'Artistic Store',
  publisher: 'Artistic Store',
  formatDetection: {
    email: false,
    telephone: false,
    address: false,
  },
  metadataBase: new URL('http://localhost:3000'),
  alternates: {
    canonical: '/',
    languages: {
      en: '/en',
      ru: '/ru',
      de: '/de',
      fr: '/fr',
    },
  },
};

export const viewport = {
  width: 'device-width',
  initialScale: 1,
  maximumScale: 5,
  userScalable: true,
};

export default function RootLayout({
  children,
}: {
  children: ReactNode;
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <head>
        <link rel="icon" href="/favicon.ico" />
        <meta name="theme-color" content="#000000" />
      </head>
      <body className="bg-white dark:bg-black">
        <div id="root">{children}</div>
      </body>
    </html>
  );
}
