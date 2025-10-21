-- CreateTable
CREATE TABLE "users" (
    "idUser" SERIAL NOT NULL,
    "userFirstName" TEXT NOT NULL,
    "userSecondName" TEXT,
    "userLastName" TEXT NOT NULL,
    "userSecondLastName" TEXT,
    "userUsername" TEXT NOT NULL,
    "userEmail" TEXT NOT NULL,
    "userPassword" TEXT NOT NULL,
    "userRole" TEXT NOT NULL DEFAULT 'user',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("idUser")
);

-- CreateTable
CREATE TABLE "categories" (
    "idCategory" SERIAL NOT NULL,
    "categoryName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("idCategory")
);

-- CreateTable
CREATE TABLE "cuisines" (
    "idCuisine" SERIAL NOT NULL,
    "cuisineName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "cuisines_pkey" PRIMARY KEY ("idCuisine")
);

-- CreateTable
CREATE TABLE "recipes" (
    "idRecipe" SERIAL NOT NULL,
    "recipeTitle" TEXT NOT NULL,
    "recipeDescription" TEXT,
    "recipePrepTime" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "idCategory" INTEGER,
    "idCuisine" INTEGER,

    CONSTRAINT "recipes_pkey" PRIMARY KEY ("idRecipe")
);

-- CreateTable
CREATE TABLE "recipeSteps" (
    "idRecipeStep" SERIAL NOT NULL,
    "recipeStepNumber" INTEGER NOT NULL,
    "recipeStepInstruction" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "idRecipe" INTEGER NOT NULL,

    CONSTRAINT "recipeSteps_pkey" PRIMARY KEY ("idRecipeStep")
);

-- CreateTable
CREATE TABLE "ingredients" (
    "idIngredient" SERIAL NOT NULL,
    "ingredientName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ingredients_pkey" PRIMARY KEY ("idIngredient")
);

-- CreateTable
CREATE TABLE "recipeIngredients" (
    "idRecipeIngredient" SERIAL NOT NULL,
    "recipeIngredientQuantity" DOUBLE PRECISION,
    "recipeIngredientUnit" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "idRecipe" INTEGER NOT NULL,
    "idIngredient" INTEGER NOT NULL,

    CONSTRAINT "recipeIngredients_pkey" PRIMARY KEY ("idRecipeIngredient")
);

-- CreateTable
CREATE TABLE "favorites" (
    "idFavorite" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "idUser" INTEGER NOT NULL,
    "idRecipe" INTEGER NOT NULL,

    CONSTRAINT "favorites_pkey" PRIMARY KEY ("idFavorite")
);

-- CreateTable
CREATE TABLE "history" (
    "idHistory" SERIAL NOT NULL,
    "historyViewedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "idUser" INTEGER NOT NULL,
    "idRecipe" INTEGER NOT NULL,

    CONSTRAINT "history_pkey" PRIMARY KEY ("idHistory")
);

-- CreateTable
CREATE TABLE "appliances" (
    "idAppliance" SERIAL NOT NULL,
    "applianceName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "appliances_pkey" PRIMARY KEY ("idAppliance")
);

-- CreateTable
CREATE TABLE "recipeAppliances" (
    "idRecipeAppliance" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "idRecipe" INTEGER NOT NULL,
    "idAppliance" INTEGER NOT NULL,

    CONSTRAINT "recipeAppliances_pkey" PRIMARY KEY ("idRecipeAppliance")
);

-- CreateTable
CREATE TABLE "userAppliances" (
    "idUserAppliance" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "idUser" INTEGER NOT NULL,
    "idAppliance" INTEGER NOT NULL,

    CONSTRAINT "userAppliances_pkey" PRIMARY KEY ("idUserAppliance")
);

-- CreateTable
CREATE TABLE "tags" (
    "idTag" SERIAL NOT NULL,
    "tagName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("idTag")
);

-- CreateTable
CREATE TABLE "recipeTags" (
    "idRecipeTag" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "idRecipe" INTEGER NOT NULL,
    "idTag" INTEGER NOT NULL,

    CONSTRAINT "recipeTags_pkey" PRIMARY KEY ("idRecipeTag")
);

-- CreateTable
CREATE TABLE "recipeMedia" (
    "idRecipeMedia" SERIAL NOT NULL,
    "recipeMediaUrl" TEXT NOT NULL,
    "recipeMediaType" TEXT DEFAULT 'image',
    "recipeMediaIsMain" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "idRecipe" INTEGER NOT NULL,

    CONSTRAINT "recipeMedia_pkey" PRIMARY KEY ("idRecipeMedia")
);

-- CreateTable
CREATE TABLE "reviews" (
    "idReview" SERIAL NOT NULL,
    "reviewRating" INTEGER NOT NULL,
    "reviewComment" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "idUser" INTEGER NOT NULL,
    "idRecipe" INTEGER NOT NULL,

    CONSTRAINT "reviews_pkey" PRIMARY KEY ("idReview")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_userUsername_key" ON "users"("userUsername");

-- CreateIndex
CREATE UNIQUE INDEX "users_userEmail_key" ON "users"("userEmail");

-- CreateIndex
CREATE UNIQUE INDEX "categories_categoryName_key" ON "categories"("categoryName");

-- CreateIndex
CREATE UNIQUE INDEX "cuisines_cuisineName_key" ON "cuisines"("cuisineName");

-- CreateIndex
CREATE UNIQUE INDEX "ingredients_ingredientName_key" ON "ingredients"("ingredientName");

-- CreateIndex
CREATE UNIQUE INDEX "favorites_idUser_idRecipe_key" ON "favorites"("idUser", "idRecipe");

-- CreateIndex
CREATE UNIQUE INDEX "appliances_applianceName_key" ON "appliances"("applianceName");

-- CreateIndex
CREATE UNIQUE INDEX "recipeAppliances_idRecipe_idAppliance_key" ON "recipeAppliances"("idRecipe", "idAppliance");

-- CreateIndex
CREATE UNIQUE INDEX "userAppliances_idUser_idAppliance_key" ON "userAppliances"("idUser", "idAppliance");

-- CreateIndex
CREATE UNIQUE INDEX "tags_tagName_key" ON "tags"("tagName");

-- CreateIndex
CREATE UNIQUE INDEX "recipeTags_idRecipe_idTag_key" ON "recipeTags"("idRecipe", "idTag");

-- CreateIndex
CREATE UNIQUE INDEX "reviews_idUser_idRecipe_key" ON "reviews"("idUser", "idRecipe");

-- AddForeignKey
ALTER TABLE "recipes" ADD CONSTRAINT "recipes_idCategory_fkey" FOREIGN KEY ("idCategory") REFERENCES "categories"("idCategory") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipes" ADD CONSTRAINT "recipes_idCuisine_fkey" FOREIGN KEY ("idCuisine") REFERENCES "cuisines"("idCuisine") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipeSteps" ADD CONSTRAINT "recipeSteps_idRecipe_fkey" FOREIGN KEY ("idRecipe") REFERENCES "recipes"("idRecipe") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipeIngredients" ADD CONSTRAINT "recipeIngredients_idRecipe_fkey" FOREIGN KEY ("idRecipe") REFERENCES "recipes"("idRecipe") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipeIngredients" ADD CONSTRAINT "recipeIngredients_idIngredient_fkey" FOREIGN KEY ("idIngredient") REFERENCES "ingredients"("idIngredient") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favorites" ADD CONSTRAINT "favorites_idUser_fkey" FOREIGN KEY ("idUser") REFERENCES "users"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favorites" ADD CONSTRAINT "favorites_idRecipe_fkey" FOREIGN KEY ("idRecipe") REFERENCES "recipes"("idRecipe") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "history" ADD CONSTRAINT "history_idUser_fkey" FOREIGN KEY ("idUser") REFERENCES "users"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "history" ADD CONSTRAINT "history_idRecipe_fkey" FOREIGN KEY ("idRecipe") REFERENCES "recipes"("idRecipe") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipeAppliances" ADD CONSTRAINT "recipeAppliances_idRecipe_fkey" FOREIGN KEY ("idRecipe") REFERENCES "recipes"("idRecipe") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipeAppliances" ADD CONSTRAINT "recipeAppliances_idAppliance_fkey" FOREIGN KEY ("idAppliance") REFERENCES "appliances"("idAppliance") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "userAppliances" ADD CONSTRAINT "userAppliances_idUser_fkey" FOREIGN KEY ("idUser") REFERENCES "users"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "userAppliances" ADD CONSTRAINT "userAppliances_idAppliance_fkey" FOREIGN KEY ("idAppliance") REFERENCES "appliances"("idAppliance") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipeTags" ADD CONSTRAINT "recipeTags_idRecipe_fkey" FOREIGN KEY ("idRecipe") REFERENCES "recipes"("idRecipe") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipeTags" ADD CONSTRAINT "recipeTags_idTag_fkey" FOREIGN KEY ("idTag") REFERENCES "tags"("idTag") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipeMedia" ADD CONSTRAINT "recipeMedia_idRecipe_fkey" FOREIGN KEY ("idRecipe") REFERENCES "recipes"("idRecipe") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_idUser_fkey" FOREIGN KEY ("idUser") REFERENCES "users"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_idRecipe_fkey" FOREIGN KEY ("idRecipe") REFERENCES "recipes"("idRecipe") ON DELETE RESTRICT ON UPDATE CASCADE;
