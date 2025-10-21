import { IsEmail, IsNotEmpty, IsOptional, IsString, MinLength } from 'class-validator';

export class RegisterDto {
  @IsString()
  @IsNotEmpty()
  userFirstName: string;

  @IsOptional()
  @IsString()
  userSecondName?: string;

  @IsString()
  @IsNotEmpty()
  userLastName: string;

  @IsOptional()
  @IsString()
  userSecondLastName?: string;

  @IsString()
  @IsNotEmpty()
  userUsername: string;

  @IsEmail()
  userEmail: string;

  @IsString()
  @MinLength(6)
  userPassword: string;
}
