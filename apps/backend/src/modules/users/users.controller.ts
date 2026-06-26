import { Controller, Get, Post, Body, Param, Put, Delete } from '@nestjs/common';
import { UsersService } from './users.service';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get()
  findAll() {
    return { success: true, data: [], message: 'Users fetched' };
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return { success: true, data: {}, message: 'User fetched' };
  }

  @Post()
  create(@Body() createUserDto: any) {
    return { success: true, data: {}, message: 'User created' };
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() updateUserDto: any) {
    return { success: true, data: {}, message: 'User updated' };
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return { success: true, message: 'User deleted' };
  }
}
