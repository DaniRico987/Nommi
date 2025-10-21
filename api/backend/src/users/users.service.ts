import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

@Injectable()
export class UsersService {
  constructor(private readonly prisma: PrismaService) {}

  async create(data: CreateUserDto) {
    return this.prisma.users.create({ data });
  }

  async findAll() {
    return this.prisma.users.findMany();
  }

  async findOne(id: number) {
    return this.prisma.users.findUnique({ where: { idUser: id } });
  }

  async update(id: number, data: UpdateUserDto) {
    return this.prisma.users.update({ where: { idUser: id }, data });
  }

  async remove(id: number) {
    return this.prisma.users.delete({ where: { idUser: id } });
  }
}
