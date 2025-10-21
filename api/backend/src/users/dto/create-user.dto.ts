import { IsEmail, IsNotEmpty, IsOptional, IsString, MinLength } from 'class-validator';

export class CreateUserDto {
  @IsString()
  @IsNotEmpty()
  userFirstName: string;

  @IsString()
  @IsOptional()
  userSecondName?: string;

  @IsString()
  @IsNotEmpty()
  userLastName: string;

  @IsString()
  @IsOptional()
  userSecondLastName?: string;

  @IsString()
  @IsNotEmpty()
  userUsername: string;

  @IsEmail()
  userEmail: string;

  @IsString()
  @MinLength(6)
  userPassword: string;

  @IsString()
  @IsOptional()
  userRole?: string;
}
