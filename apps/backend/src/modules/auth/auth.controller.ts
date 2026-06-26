import { Controller, Post, Body } from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  login(@Body() loginDto: any) {
    return { success: true, message: 'Login successful', token: 'fake-token' };
  }

  @Post('register')
  register(@Body() registerDto: any) {
    return { success: true, message: 'Register successful', user: {} };
  }
}
