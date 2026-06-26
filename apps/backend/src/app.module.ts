import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';

// Entities
import { User } from './entities/user.entity';
import { Product } from './entities/product.entity';
import { ProductPrice } from './entities/product-price.entity';
import { Order } from './entities/order.entity';
import { OrderItem } from './entities/order-item.entity';
import { Article } from './entities/article.entity';
import { Cart } from './entities/cart.entity';
import { ShippingRate } from './entities/shipping-rate.entity';
import { PaymentMethod } from './entities/payment-method.entity';
import { PartnerRequest } from './entities/partner-request.entity';
import { AuditLog } from './entities/audit-log.entity';

// Modules
import { ProductsModule } from './modules/products/products.module';
import { OrdersModule } from './modules/orders/orders.module';
import { UsersModule } from './modules/users/users.module';
import { AuthModule } from './modules/auth/auth.module';
import { CartModule } from './modules/cart/cart.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DB_HOST || 'localhost',
      port: parseInt(process.env.DB_PORT || '5432'),
      username: process.env.DB_USER || 'postgres',
      password: process.env.DB_PASSWORD || 'postgres',
      database: process.env.DB_NAME || 'artistic_store',
      entities: [
        User,
        Product,
        ProductPrice,
        Order,
        OrderItem,
        Article,
        Cart,
        ShippingRate,
        PaymentMethod,
        PartnerRequest,
        AuditLog,
      ],
      synchronize: true,
      logging: process.env.NODE_ENV === 'development',
    }),
    ProductsModule,
    OrdersModule,
    UsersModule,
    AuthModule,
    CartModule,
  ],
  controllers: [AppController],
  providers: [],
})
export class AppModule {}
