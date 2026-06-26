import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('shipping_rates')
export class ShippingRate {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'varchar', length: 100 })
  to_country: string;

  @Column({ type: 'varchar', length: 50 })
  carrier: string;

  @Column({ type: 'numeric', precision: 10, scale: 2 })
  base_price: number;

  @Column({ type: 'integer' })
  estimated_days: number;

  @Column({ type: 'boolean', default: true })
  is_active: boolean;
}
