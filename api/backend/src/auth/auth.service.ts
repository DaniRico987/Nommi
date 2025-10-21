import { Injectable, UnauthorizedException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService
  ) {}

  async register(data: RegisterDto) {
    const existingUser = await this.prisma.users.findUnique({
      where: { userEmail: data.userEmail },
    });

    if (existingUser) {
      throw new BadRequestException('Email already in use');
    }

    const hashedPassword = await bcrypt.hash(data.userPassword, 10);

    const user = await this.prisma.users.create({
      data: {
        ...data,
        userPassword: hashedPassword,
      },
    });

    const token = this.jwtService.sign({ idUser: user.idUser, role: user.userRole });

    return {
      message: 'User registered successfully',
      token,
      user: {
        idUser: user.idUser,
        userEmail: user.userEmail,
        userUsername: user.userUsername,
      },
    };
  }

  async login(data: LoginDto) {
    const user = await this.prisma.users.findUnique({
      where: { userEmail: data.userEmail },
    });

    if (!user) throw new UnauthorizedException('Invalid credentials');

    const validPassword = await bcrypt.compare(data.userPassword, user.userPassword);
    if (!validPassword) throw new UnauthorizedException('Invalid credentials');

    const token = this.jwtService.sign({ idUser: user.idUser, role: user.userRole });

    return {
      message: 'Login successful',
      token,
      user: {
        idUser: user.idUser,
        userEmail: user.userEmail,
        userUsername: user.userUsername,
      },
    };
  }
}
