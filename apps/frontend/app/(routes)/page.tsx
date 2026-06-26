'use client';

import { FC } from 'react';
import Link from 'next/link';

export const HomePage: FC = () => {
  return (
    <main className="min-h-screen bg-gradient-to-br from-slate-900 to-slate-800 text-white">
      {/* Header */}
      <header className="border-b border-slate-700">
        <nav className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex items-center justify-between">
            <div className="text-2xl font-bold">🎨 Artistic Store</div>
            <div className="flex gap-6">
              <Link href="/shop" className="hover:text-blue-400 transition">
                Shop
              </Link>
              <Link href="/about" className="hover:text-blue-400 transition">
                About
              </Link>
              <Link href="/contact" className="hover:text-blue-400 transition">
                Contact
              </Link>
            </div>
          </div>
        </nav>
      </header>

      {/* Hero Section */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-20">
        <div className="text-center">
          <h1 className="text-5xl font-bold mb-6 bg-gradient-to-r from-blue-400 to-purple-500 bg-clip-text text-transparent">
            Welcome to Artistic Store
          </h1>
          <p className="text-xl text-slate-300 mb-8 max-w-2xl mx-auto">
            Discover premium beauty devices, skincare, and hair care products 
            for professionals and beauty enthusiasts.
          </p>
          <div className="flex gap-4 justify-center">
            <Link
              href="/shop"
              className="px-8 py-3 bg-blue-500 hover:bg-blue-600 rounded-lg font-semibold transition"
            >
              Shop Now
            </Link>
            <Link
              href="/about"
              className="px-8 py-3 border border-blue-500 hover:bg-blue-500/10 rounded-lg font-semibold transition"
            >
              Learn More
            </Link>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-20 grid grid-cols-1 md:grid-cols-3 gap-8">
        <div className="p-6 bg-slate-700/50 rounded-lg border border-slate-600">
          <h3 className="text-xl font-bold mb-2">Premium Quality</h3>
          <p className="text-slate-300">
            Curated selection of the finest beauty products
          </p>
        </div>
        <div className="p-6 bg-slate-700/50 rounded-lg border border-slate-600">
          <h3 className="text-xl font-bold mb-2">Global Shipping</h3>
          <p className="text-slate-300">
            Fast and reliable delivery to over 50 countries
          </p>
        </div>
        <div className="p-6 bg-slate-700/50 rounded-lg border border-slate-600">
          <h3 className="text-xl font-bold mb-2">Expert Support</h3>
          <p className="text-slate-300">
            Professional guidance and customer service 24/7
          </p>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-slate-700 mt-20 py-8">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 text-center text-slate-400">
          <p>&copy; 2026 Artistic Store. All rights reserved.</p>
        </div>
      </footer>
    </main>
  );
};

export default HomePage;
