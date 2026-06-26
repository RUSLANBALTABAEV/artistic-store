// packages/shared-types/src/index.ts
// Общие TypeScript типы для всего проекта

// ═════════════════════════════════════════════════════════════════════════════
// USERS
// ═════════════════════════════════════════════════════════════════════════════

export type UserRole = 'customer' | 'partner' | 'admin';

export type ActivityType = 
  | 'distributor' 
  | 'retailer' 
  | 'salon' 
  | 'clinic' 
  | 'wholesaler' 
  | 'other';

export interface User {
  id: string;
  email: string;
  role: UserRole;
  first_name?: string;
  last_name?: string;
  phone?: string;
  country?: string;
  city?: string;
  company?: string;
  contact_person?: string;
  website?: string;
  activity_type?: ActivityType;
  is_approved: boolean;
  is_active: boolean;
  last_login_at?: Date;
  created_at: Date;
  updated_at: Date;
}

export interface CreateUserDto {
  email: string;
  password: string;
  role?: UserRole;
  first_name?: string;
  last_name?: string;
  country?: string;
}

export interface UpdateUserDto {
  email?: string;
  first_name?: string;
  last_name?: string;
  phone?: string;
  country?: string;
  city?: string;
}

// ═════════════════════════════════════════════════════════════════════════════
// PRODUCTS
// ═════════════════════════════════════════════════════════════════════════════

export type ProductCategory = 
  | 'Beauty Devices' 
  | 'Skincare' 
  | 'Hair Care' 
  | 'Accessories';

export interface ProductImage {
  url: string;
  alt?: string;
  position: number;
}

export interface Product {
  id: string;
  cms_id?: string;
  name: string;
  slug: string;
  description?: string;
  category: ProductCategory;
  weight_kg?: number;
  dimensions_length_cm?: number;
  dimensions_width_cm?: number;
  dimensions_height_cm?: number;
  images?: ProductImage[];
  seo_title?: string;
  seo_description?: string;
  is_active: boolean;
  is_featured: boolean;
  created_at: Date;
  updated_at: Date;
  prices?: ProductPrice[];
}

export interface CreateProductDto {
  name: string;
  slug: string;
  description?: string;
  category: ProductCategory;
  weight_kg?: number;
  images?: ProductImage[];
}

export interface UpdateProductDto {
  name?: string;
  description?: string;
  category?: ProductCategory;
  weight_kg?: number;
  images?: ProductImage[];
  is_featured?: boolean;
}

// ═════════════════════════════════════════════════════════════════════════════
// PRODUCT PRICES
// ═════════════════════════════════════════════════════════════════════════════

export type Region = 'EU' | 'UAE' | 'IL' | 'RU' | 'GLOBAL';
export type Currency = 'EUR' | 'AED' | 'USD' | 'ILS' | 'RUB';

export interface ProductPrice {
  id: string;
  product_id: string;
  region: Region;
  currency: Currency;
  price: number;
  cost_price?: number;
  is_active: boolean;
  created_at: Date;
  updated_at: Date;
}

export interface CreateProductPriceDto {
  region: Region;
  currency: Currency;
  price: number;
  cost_price?: number;
}

export interface PricesByRegion {
  region: Region;
  prices: {
    currency: Currency;
    price: number;
  }[];
}

// ═════════════════════════════════════════════════════════════════════════════
// CART
// ═════════════════════════════════════════════════════════════════════════════

export interface CartItem {
  product_id: string;
  quantity: number;
  price: number;
  currency: Currency;
}

export interface Cart {
  id: string;
  user_id?: string;
  session_id?: string;
  items: CartItem[];
  total_items: number;
  subtotal: number;
  created_at: Date;
  updated_at: Date;
  expires_at: Date;
}

export interface AddToCartDto {
  product_id: string;
  quantity: number;
  currency: Currency;
}

// ═════════════════════════════════════════════════════════════════════════════
// ORDERS
// ═════════════════════════════════════════════════════════════════════════════

export type OrderStatus = 
  | 'pending' 
  | 'paid' 
  | 'processing' 
  | 'shipped' 
  | 'delivered' 
  | 'cancelled' 
  | 'refunded';

export type PaymentStatus = 'pending' | 'completed' | 'failed' | 'refunded';
export type PaymentMethod = 'stripe' | 'paypal' | 'bank_transfer' | 'apple_pay' | 'google_pay';
export type Carrier = 'dhl' | 'fedex' | 'ups' | 'local';

export interface OrderItem {
  product_id: string;
  product_name: string;
  quantity: number;
  price: number;
}

export interface Address {
  firstName: string;
  lastName: string;
  email: string;
  phone: string;
  address: string;
  city: string;
  country: string;
  postalCode?: string;
}

export interface Order {
  id: string;
  user_id: string;
  order_number: string;
  status: OrderStatus;
  items: OrderItem[];
  subtotal: number;
  shipping_cost: number;
  tax: number;
  total: number;
  currency: Currency;
  region?: Region;
  shipping_address: Address;
  billing_address?: Address;
  payment_method?: PaymentMethod;
  payment_id?: string;
  payment_status: PaymentStatus;
  tracking_number?: string;
  carrier?: Carrier;
  shipped_at?: Date;
  delivered_at?: Date;
  notes?: string;
  created_at: Date;
  paid_at?: Date;
  updated_at: Date;
}

export interface CreateOrderDto {
  items: CartItem[];
  shipping_address: Address;
  billing_address?: Address;
  payment_method: PaymentMethod;
  currency: Currency;
}

export interface UpdateOrderStatusDto {
  status: OrderStatus;
  tracking_number?: string;
  carrier?: Carrier;
}

// ═════════════════════════════════════════════════════════════════════════════
// ARTICLES
// ═════════════════════════════════════════════════════════════════════════════

export type ArticleStatus = 'draft' | 'published' | 'archived';

export interface Article {
  id: string;
  cms_id?: string;
  title: string;
  slug: string;
  content?: string;
  excerpt?: string;
  cover_image?: string;
  author_id?: string;
  author_name?: string;
  category?: string;
  tags?: string[];
  seo_title?: string;
  seo_description?: string;
  status: ArticleStatus;
  is_featured: boolean;
  view_count: number;
  published_at?: Date;
  created_at: Date;
  updated_at: Date;
}

export interface CreateArticleDto {
  title: string;
  slug: string;
  content?: string;
  excerpt?: string;
  cover_image?: string;
  category?: string;
  tags?: string[];
  status?: ArticleStatus;
}

export interface UpdateArticleDto {
  title?: string;
  content?: string;
  excerpt?: string;
  cover_image?: string;
  category?: string;
  tags?: string[];
  status?: ArticleStatus;
  is_featured?: boolean;
}

// ═════════════════════════════════════════════════════════════════════════════
// PARTNER REQUESTS
// ═════════════════════════════════════════════════════════════════════════════

export type PartnerRequestStatus = 'pending' | 'reviewing' | 'approved' | 'rejected';

export interface PartnerRequest {
  id: string;
  user_id?: string;
  email: string;
  phone?: string;
  first_name?: string;
  last_name?: string;
  company: string;
  contact_person?: string;
  website?: string;
  country?: string;
  city?: string;
  activity_type?: ActivityType;
  message?: string;
  status: PartnerRequestStatus;
  rejection_reason?: string;
  created_at: Date;
  reviewed_at?: Date;
  reviewed_by?: string;
}

export interface CreatePartnerRequestDto {
  email: string;
  phone?: string;
  first_name?: string;
  last_name?: string;
  company: string;
  contact_person?: string;
  website?: string;
  country?: string;
  city?: string;
  activity_type?: ActivityType;
  message?: string;
}

export interface ApprovePartnerRequestDto {
  status: 'approved' | 'rejected';
  rejection_reason?: string;
}

// ═════════════════════════════════════════════════════════════════════════════
// SHIPPING RATES
// ═════════════════════════════════════════════════════════════════════════════

export interface ShippingRate {
  id: string;
  from_region?: Region;
  to_country: string;
  carrier: Carrier;
  estimated_days: number;
  base_price: number;
  price_per_kg?: number;
  currency: Currency;
  min_weight_kg: number;
  max_weight_kg?: number;
  is_active: boolean;
  created_at: Date;
  updated_at: Date;
}

export interface CalculateShippingDto {
  to_country: string;
  weight_kg: number;
  from_region?: Region;
  carrier?: Carrier;
}

export interface ShippingCalculation {
  carrier: Carrier;
  base_price: number;
  weight_price: number;
  total_price: number;
  currency: Currency;
  estimated_days: number;
}

// ═════════════════════════════════════════════════════════════════════════════
// PAYMENT METHODS
// ═════════════════════════════════════════════════════════════════════════════

export interface PaymentMethod {
  id: string;
  name: string;
  code: PaymentMethod;
  region?: Region;
  is_active: boolean;
  fee_percentage: number;
  created_at: Date;
  updated_at: Date;
}

export interface PaymentIntent {
  id: string;
  order_id: string;
  amount: number;
  currency: Currency;
  status: PaymentStatus;
  payment_method: PaymentMethod;
  created_at: Date;
  updated_at: Date;
}

// ═════════════════════════════════════════════════════════════════════════════
// API RESPONSES
// ═════════════════════════════════════════════════════════════════════════════

export interface ApiResponse<T = any> {
  success: boolean;
  data?: T;
  error?: string;
  message?: string;
  timestamp: Date;
}

export interface PaginatedResponse<T> {
  items: T[];
  total: number;
  page: number;
  limit: number;
  pages: number;
}

export interface ApiError {
  status: number;
  message: string;
  error?: string;
  details?: Record<string, any>;
}

// ═════════════════════════════════════════════════════════════════════════════
// AUTH
// ═════════════════════════════════════════════════════════════════════════════

export interface LoginDto {
  email: string;
  password: string;
}

export interface RegisterDto {
  email: string;
  password: string;
  first_name: string;
  last_name: string;
  country?: string;
}

export interface AuthResponse {
  access_token: string;
  refresh_token?: string;
  user: User;
  expires_in: number;
}

export interface JwtPayload {
  sub: string; // user id
  email: string;
  role: UserRole;
  iat: number;
  exp: number;
}

// ═════════════════════════════════════════════════════════════════════════════
// FILTERS & PAGINATION
// ═════════════════════════════════════════════════════════════════════════════

export interface PaginationParams {
  page?: number;
  limit?: number;
  sort?: string;
  order?: 'asc' | 'desc';
}

export interface ProductFilters extends PaginationParams {
  category?: ProductCategory;
  region?: Region;
  currency?: Currency;
  minPrice?: number;
  maxPrice?: number;
  search?: string;
  is_active?: boolean;
}

export interface OrderFilters extends PaginationParams {
  status?: OrderStatus;
  payment_status?: PaymentStatus;
  from_date?: Date;
  to_date?: Date;
  region?: Region;
  currency?: Currency;
}

// ═════════════════════════════════════════════════════════════════════════════
// NOTIFICATIONS
// ═════════════════════════════════════════════════════════════════════════════

export type NotificationType = 
  | 'order_created' 
  | 'order_paid' 
  | 'order_shipped' 
  | 'order_delivered' 
  | 'partner_approved' 
  | 'partner_rejected';

export interface Notification {
  id: string;
  user_id: string;
  type: NotificationType;
  title: string;
  message: string;
  data?: Record<string, any>;
  is_read: boolean;
  created_at: Date;
}
