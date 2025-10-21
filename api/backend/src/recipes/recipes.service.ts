import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateRecipeDto } from './dto/create-recipe.dto';
import { UpdateRecipeDto } from './dto/update-recipe.dto';

@Injectable()
export class RecipesService {
  constructor(private prisma: PrismaService) {}

  async findAll() {
    return await this.prisma.recipes.findMany({
      include: {
        category: true,
        cuisine: true,
      },
      orderBy: { recipeTitle: 'desc' },
    });
  }

  async findOne(idRecipe: number) {
    const recipe = await this.prisma.recipes.findUnique({
      where: { idRecipe },
      include: {
        category: true,
        cuisine: true,
      },
    });

    if (!recipe) {
      throw new Error(`Recipe with ID ${idRecipe} not found`);
    }

    return recipe;
  }

  async create(data: CreateRecipeDto) {
    const recipe = await this.prisma.recipes.create({
      data,
    });
    return recipe;
  }

  async update(idRecipe: number, data: UpdateRecipeDto) {
    const exists = await this.prisma.recipes.findUnique({
      where: { idRecipe },
    });

    if (!exists) {
      throw new Error(`Recipe with ID ${idRecipe} not found`);
    }

    const recipe = await this.prisma.recipes.update({
      where: { idRecipe },
      data,
    });
    return recipe;
  }

  async remove(idRecipe: number) {
    const exists = await this.prisma.recipes.findUnique({
      where: { idRecipe },
    });
    if (!exists) {
      throw new Error(`Recipe with ID ${idRecipe} not found`);
    }
    await this.prisma.recipes.delete({
      where: { idRecipe },
    });
    return { message: `Recipe with ID ${idRecipe} deleted successfully` };
  }
}
