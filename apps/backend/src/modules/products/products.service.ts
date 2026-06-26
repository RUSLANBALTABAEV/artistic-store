import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Product } from '../../entities/product.entity';

@Injectable()
export class ProductsService {
  constructor(
    @InjectRepository(Product)
    private productsRepository: Repository<Product>,
  ) {}

  async findAll() {
    return await this.productsRepository.find();
  }

  async findOne(id: string) {
    return await this.productsRepository.findOne({ where: { id } });
  }

  async create(createProductDto: any) {
    const product = this.productsRepository.create(createProductDto);
    return await this.productsRepository.save(product);
  }

  async update(id: string, updateProductDto: any) {
    await this.productsRepository.update(id, updateProductDto);
    return await this.findOne(id);
  }

  async remove(id: string) {
    return await this.productsRepository.delete(id);
  }
}
