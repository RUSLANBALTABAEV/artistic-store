import { Controller, Get, Post, Body, Param, Put, Delete } from '@nestjs/common';
import { OrdersService } from './orders.service';

@Controller('orders')
export class OrdersController {
  constructor(private readonly ordersService: OrdersService) {}

  @Get()
  findAll() {
    return { success: true, data: [], message: 'Orders fetched' };
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return { success: true, data: {}, message: 'Order fetched' };
  }

  @Post()
  create(@Body() createOrderDto: any) {
    return { success: true, data: {}, message: 'Order created' };
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() updateOrderDto: any) {
    return { success: true, data: {}, message: 'Order updated' };
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return { success: true, message: 'Order deleted' };
  }
}
