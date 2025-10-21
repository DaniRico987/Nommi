import { IsInt, IsOptional, IsString, MaxLength, MinLength } from 'class-validator';

export class CreateRecipeDto {
  @IsString()
  @MinLength(3)
  @MaxLength(100)
  recipeTitle: string;

  @IsOptional()
  @IsString()
  @MaxLength(500)
  recipeDescription: string;

  @IsOptional()
  @IsInt()
  recipePrepTime?: number;

  @IsOptional()
  @IsInt()
  idCategory?: number;

  @IsOptional()
  @IsInt()
  idCuisine?: number;
}
