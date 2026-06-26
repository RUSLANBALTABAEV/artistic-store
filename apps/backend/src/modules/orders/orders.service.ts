import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order } from '../../entities/order.entity';

@Injectable()
export class OrdersService {
  constructor(
    @InjectRepository(Order)
    private ordersRepository: Repository<Order>,
  ) {}

  async findAll() {
    return await this.ordersRepository.find();
  }

  async findOne(id: string) {
    return await this.ordersRepository.findOne({ where: { id } });
  }
}
