import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { CartService } from './cart.service';

@Controller('cart')
export class CartController {
  constructor(private readonly cartService: CartService) {}

  @Get(':userId')
  getCart(@Param('userId') userId: string) {
    return { success: true, data: { items: [] }, message: 'Cart fetched' };
  }

  @Post('add')
  addItem(@Body() addItemDto: any) {
    return { success: true, message: 'Item added to cart' };
  }
}
