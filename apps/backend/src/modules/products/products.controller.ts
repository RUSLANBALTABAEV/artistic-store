import { Controller, Get, Post, Body, Param, Put, Delete } from '@nestjs/common';
import { ProductsService } from './products.service';

@Controller('products')
export class ProductsController {
  constructor(private readonly productsService: ProductsService) {}

  @Get()
  findAll() {
    return { success: true, data: [], message: 'Products fetched' };
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return { success: true, data: {}, message: 'Product fetched' };
  }

  @Post()
  create(@Body() createProductDto: any) {
    return { success: true, data: {}, message: 'Product created' };
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() updateProductDto: any) {
    return { success: true, data: {}, message: 'Product updated' };
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return { success: true, message: 'Product deleted' };
  }
}
