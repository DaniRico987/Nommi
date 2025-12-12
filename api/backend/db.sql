-- ============================================
-- USERS
-- ============================================
CREATE TABLE users (
  "idUser" SERIAL PRIMARY KEY,
  "userFirstName" VARCHAR NOT NULL,
  "userSecondName" VARCHAR,
  "userLastName" VARCHAR NOT NULL,
  "userSecondLastName" VARCHAR,
  "userUsername" VARCHAR NOT NULL UNIQUE,
  "userEmail" VARCHAR NOT NULL UNIQUE,
  "userPassword" VARCHAR NOT NULL,
  "userRole" VARCHAR NOT NULL DEFAULT 'user',
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW()
);
-- ============================================
-- CATEGORIES
-- ============================================
CREATE TABLE categories (
  "idCategory" SERIAL PRIMARY KEY,
  "categoryName" VARCHAR NOT NULL UNIQUE,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW()
);
-- ============================================
-- CUISINES
-- ============================================
CREATE TABLE cuisines (
  "idCuisine" SERIAL PRIMARY KEY,
  "cuisineName" VARCHAR NOT NULL UNIQUE,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW()
);
-- ============================================
-- RECIPES
-- ============================================
CREATE TABLE recipes (
  "idRecipe" SERIAL PRIMARY KEY,
  "recipeTitle" VARCHAR NOT NULL,
  "recipeDescription" TEXT,
  "recipePrepTime" INTEGER,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  "idCategory" INTEGER,
  "idCuisine" INTEGER,
  CONSTRAINT fk_recipe_category FOREIGN KEY ("idCategory") REFERENCES categories("idCategory"),
  CONSTRAINT fk_recipe_cuisine FOREIGN KEY ("idCuisine") REFERENCES cuisines("idCuisine")
);
-- ============================================
-- RECIPE STEPS
-- ============================================
CREATE TABLE recipeSteps (
  "idRecipeStep" SERIAL PRIMARY KEY,
  "recipeStepNumber" INTEGER NOT NULL,
  "recipeStepInstruction" TEXT NOT NULL,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  "idRecipe" INTEGER NOT NULL,
  CONSTRAINT fk_step_recipe FOREIGN KEY ("idRecipe") REFERENCES recipes("idRecipe")
);
-- ============================================
-- INGREDIENTS
-- ============================================
CREATE TABLE ingredients (
  "idIngredient" SERIAL PRIMARY KEY,
  "ingredientName" VARCHAR NOT NULL UNIQUE,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW()
);
-- ============================================
-- RECIPE INGREDIENTS
-- ============================================
CREATE TABLE recipeIngredients (
  "idRecipeIngredient" SERIAL PRIMARY KEY,
  "recipeIngredientQuantity" DOUBLE PRECISION,
  "recipeIngredientUnit" VARCHAR,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  "idRecipe" INTEGER NOT NULL,
  "idIngredient" INTEGER NOT NULL,
  CONSTRAINT fk_recipeIng_recipe FOREIGN KEY ("idRecipe") REFERENCES recipes("idRecipe"),
  CONSTRAINT fk_recipeIng_ingredient FOREIGN KEY ("idIngredient") REFERENCES ingredients("idIngredient")
);
-- ============================================
-- FAVORITES
-- ============================================
CREATE TABLE favorites (
  "idFavorite" SERIAL PRIMARY KEY,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  "idUser" INTEGER NOT NULL,
  "idRecipe" INTEGER NOT NULL,
  CONSTRAINT fk_favorite_user FOREIGN KEY ("idUser") REFERENCES users("idUser"),
  CONSTRAINT fk_favorite_recipe FOREIGN KEY ("idRecipe") REFERENCES recipes("idRecipe"),
  CONSTRAINT unique_user_recipe_fav UNIQUE ("idUser", "idRecipe")
);
-- ============================================
-- HISTORY
-- ============================================
CREATE TABLE history (
  "idHistory" SERIAL PRIMARY KEY,
  "historyViewedAt" TIMESTAMP DEFAULT NOW(),
  "idUser" INTEGER NOT NULL,
  "idRecipe" INTEGER NOT NULL,
  CONSTRAINT fk_history_user FOREIGN KEY ("idUser") REFERENCES users("idUser"),
  CONSTRAINT fk_history_recipe FOREIGN KEY ("idRecipe") REFERENCES recipes("idRecipe")
);
-- ============================================
-- APPLIANCES
-- ============================================
CREATE TABLE appliances (
  "idAppliance" SERIAL PRIMARY KEY,
  "applianceName" VARCHAR NOT NULL UNIQUE,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW()
);
-- ============================================
-- RECIPE ↔ APPLIANCES
-- ============================================
CREATE TABLE recipeAppliances (
  "idRecipeAppliance" SERIAL PRIMARY KEY,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  "idRecipe" INTEGER NOT NULL,
  "idAppliance" INTEGER NOT NULL,
  CONSTRAINT fk_recipeAppl_recipe FOREIGN KEY ("idRecipe") REFERENCES recipes("idRecipe"),
  CONSTRAINT fk_recipeAppl_appl FOREIGN KEY ("idAppliance") REFERENCES appliances("idAppliance"),
  CONSTRAINT unique_recipe_appliance UNIQUE ("idRecipe", "idAppliance")
);
-- ============================================
-- USER ↔ APPLIANCES
-- ============================================
CREATE TABLE userAppliances (
  "idUserAppliance" SERIAL PRIMARY KEY,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  "idUser" INTEGER NOT NULL,
  "idAppliance" INTEGER NOT NULL,
  CONSTRAINT fk_userAppl_user FOREIGN KEY ("idUser") REFERENCES users("idUser"),
  CONSTRAINT fk_userAppl_appl FOREIGN KEY ("idAppliance") REFERENCES appliances("idAppliance"),
  CONSTRAINT unique_user_appliance UNIQUE ("idUser", "idAppliance")
);
-- ============================================
-- TAGS
-- ============================================
CREATE TABLE tags (
  "idTag" SERIAL PRIMARY KEY,
  "tagName" VARCHAR NOT NULL UNIQUE,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW()
);
-- ============================================
-- RECIPE ↔ TAGS
-- ============================================
CREATE TABLE recipeTags (
  "idRecipeTag" SERIAL PRIMARY KEY,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  "idRecipe" INTEGER NOT NULL,
  "idTag" INTEGER NOT NULL,
  CONSTRAINT fk_recipeTag_recipe FOREIGN KEY ("idRecipe") REFERENCES recipes("idRecipe"),
  CONSTRAINT fk_recipeTag_tag FOREIGN KEY ("idTag") REFERENCES tags("idTag"),
  CONSTRAINT unique_recipe_tag UNIQUE ("idRecipe", "idTag")
);
-- ============================================
-- RECIPE MEDIA
-- ============================================
CREATE TABLE recipeMedia (
  "idRecipeMedia" SERIAL PRIMARY KEY,
  "recipeMediaUrl" TEXT NOT NULL,
  "recipeMediaType" VARCHAR DEFAULT 'image',
  "recipeMediaIsMain" BOOLEAN DEFAULT FALSE,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  "idRecipe" INTEGER NOT NULL,
  CONSTRAINT fk_media_recipe FOREIGN KEY ("idRecipe") REFERENCES recipes("idRecipe")
);
-- ============================================
-- REVIEWS
-- ============================================
CREATE TABLE reviews (
  "idReview" SERIAL PRIMARY KEY,
  "reviewRating" INTEGER NOT NULL,
  "reviewComment" TEXT,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW(),
  "idUser" INTEGER NOT NULL,
  "idRecipe" INTEGER NOT NULL,
  CONSTRAINT fk_review_user FOREIGN KEY ("idUser") REFERENCES users("idUser"),
  CONSTRAINT fk_review_recipe FOREIGN KEY ("idRecipe") REFERENCES recipes("idRecipe"),
  CONSTRAINT unique_user_recipe_review UNIQUE ("idUser", "idRecipe")
);