import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('carts')
export class Cart {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid', nullable: true })
  user_id: string;

  @Column({ type: 'jsonb', default: '[]' })
  items: any[];

  @Column({ type: 'numeric', precision: 10, scale: 2, default: 0 })
  total_price: number;

  @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;
}
