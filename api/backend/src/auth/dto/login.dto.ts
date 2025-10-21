import { IsEmail, IsNotEmpty, IsString } from 'class-validator';

export class LoginDto {
  @IsEmail()
  userEmail: string;

  @IsString()
  @IsNotEmpty()
  userPassword: string;
}
