import { Injectable } from '@nestjs/common';

@Injectable()
export class AuthService {
  async login(email: string, password: string) {
    return { token: 'fake-token' };
  }

  async register(email: string, password: string) {
    return { user: {} };
  }
}
