--DML
ALTER TABLE recipe RENAME COLUMN name TO recipe_name;
ALTER TABLE recipe MODIFY recipe_name VARCHAR2(100);
ALTER TABLE recipe ADD serve NUMBER(2, 0);
ALTER TABLE recipe DROP COLUMN sample_image;
ALTER TABLE recipeinstruction MODIFY detail VARCHAR2(1000);
ALTER TABLE unitofmeasurement MODIFY relative_ratio NUMBER(20, 10);
ALTER TABLE ingredient RENAME COLUMN TYPE TO ingredient_type;
ALTER TABLE ingredient MODIFY ingredient_type VARCHAR2(30);
ALTER TABLE ingredient MODIFY price NUMBER(10, 5);
ALTER TABLE nutrientencompassment MODIFY amount NUMBER(20, 10);
ALTER TABLE ingredientrequirement MODIFY amount NUMBER(20, 10);
ALTER TABLE recipeaccess DROP CONSTRAINT r_access_staff_id_fk;
ALTER TABLE recipeaccess DROP CONSTRAINT r_access_recipe_id_fk;
ALTER TABLE recipeaccess DROP PRIMARY KEY;
ALTER TABLE recipeaccess ADD access_id NUMBER(3, 0);
ALTER TABLE recipeaccess ADD CONSTRAINT raccess_access_id_pk PRIMARY KEY(access_id);
ALTER TABLE recipeaccess ADD CONSTRAINT raccess_staff_id_fk FOREIGN KEY(staff_id) REFERENCES restaurantstaff(staff_id) ON DELETE CASCADE;
ALTER TABLE recipeaccess ADD CONSTRAINT raccess_recipe_id_fk FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE; 
ALTER TABLE recipe ADD CONSTRAINT recipe_date_added_chk CHECK(date_added > '01/Jan/2000');
ALTER TABLE recipe ADD CONSTRAINT recipe_recipe_name_uniq UNIQUE(recipe_name);
ALTER TABLE RestaurantStaff DROP CONSTRAINT rstaff_chef_id_fk;
ALTER TABLE RestaurantStaff ADD CONSTRAINT rstaff_chef_id_fk FOREIGN KEY (chef_id) REFERENCES restaurantstaff(staff_id) ON DELETE CASCADE;
ALTER TABLE recipeinstruction DROP CONSTRAINT r_instr_recipe_id_fk;
ALTER TABLE recipeinstruction ADD CONSTRAINT r_instr_recipe_id_fk FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE;
ALTER TABLE ingredientrequirement DROP CONSTRAINT ingrereq_rec_id_fk;
ALTER TABLE ingredientrequirement ADD CONSTRAINT ingrereq_rec_id_fk FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE;
ALTER TABLE ingredientrequirement DROP CONSTRAINT ingrereq_ingre_name_fk;
ALTER TABLE ingredientrequirement ADD CONSTRAINT ingrereq_ingre_name_fk FOREIGN KEY(ingredient_name) REFERENCES ingredient(ingredient_name) ON DELETE CASCADE;
ALTER TABLE ingredientrequirement DROP CONSTRAINT ingrereq_unit_name_fk;
ALTER TABLE ingredientrequirement ADD CONSTRAINT ingrereq_unit_name_fk FOREIGN KEY(unit_name) REFERENCES unitofmeasurement(unit_name) ON DELETE CASCADE;
ALTER TABLE nutrientencompassment DROP CONSTRAINT nutrenc_ingre_name_fk;
ALTER TABLE nutrientencompassment ADD CONSTRAINT nutrenc_ingre_name_fk FOREIGN KEY(ingredient_name) REFERENCES ingredient(ingredient_name) ON DELETE CASCADE;
ALTER TABLE nutrientencompassment DROP CONSTRAINT nutrenc_nutrient_name_fk;
ALTER TABLE nutrientencompassment ADD CONSTRAINT nutrenc_nutrient_name_fk FOREIGN KEY(nutrient_name) REFERENCES nutrient(nutrient_name) ON DELETE CASCADE;
ALTER TABLE nutrientencompassment DROP CONSTRAINT nutrenc_unit_name_fk;
ALTER TABLE nutrientencompassment ADD CONSTRAINT nutrenc_unit_name_fk FOREIGN KEY(unit_name) REFERENCES unitofmeasurement(unit_name) ON DELETE CASCADE;

COMMENT ON COLUMN restaurantstaff.staff_id IS 'identification number of the restaurant staff';
COMMENT ON COLUMN restaurantstaff.first_name IS 'first name of the restaurant staff';
COMMENT ON COLUMN restaurantstaff.last_name IS 'last name of the restaurant staff';
COMMENT ON COLUMN restaurantstaff.chef_id IS 'a staff can be of 2 roles: cook or chef, chef manages cooks. This column is the identification number of the chef managing this cook';
COMMENT ON COLUMN recipe.recipe_id IS 'identification number of the recipe';
COMMENT ON COLUMN recipe.recipe_name IS 'name of the recipe';
COMMENT ON COLUMN recipe.date_added IS 'the date when the recipe is/was added';
COMMENT ON COLUMN recipe.meal_type IS 'type of meal of the recipe';
COMMENT ON COLUMN recipe.cuisine IS 'type of cuisine of the recipe';
COMMENT ON COLUMN recipe.cook_time IS 'how long to cook the recipe';
COMMENT ON COLUMN recipe.serve IS 'serve size of the recipe';
COMMENT ON COLUMN recipeaccess.staff_id IS 'identification number of the restaurant staff that accessed this recipe';
COMMENT ON COLUMN recipeaccess.recipe_id IS 'identification number of the recipe that was accessed';
COMMENT ON COLUMN recipeaccess.access_time IS 'the date that the recipe that was accessed';
COMMENT ON COLUMN recipeaccess.access_id IS 'identification number of the access';
COMMENT ON COLUMN recipeinstruction.instruction_id IS 'identification number of the instruction';
COMMENT ON COLUMN recipeinstruction.detail IS 'one detail/description/step of a recipe';
COMMENT ON COLUMN recipeinstruction.instruction_order IS 'the order in which the instruction should be done to cook a recipe';
COMMENT ON COLUMN recipeinstruction.recipe_id IS 'identification number of the recipe that the instruction refers to';
COMMENT ON COLUMN unitofmeasurement.unit_name IS 'name of the unit';
COMMENT ON COLUMN unitofmeasurement.relative_ratio IS 'the ratio of the unit relative to the standard unit of the same type, eg. gram is the standard unit for mass, so relative ratio of kilogram is 1000';
COMMENT ON COLUMN unitofmeasurement.unit_type IS 'type of the unit eg. mass, energy, etc.';
COMMENT ON COLUMN ingredient.ingredient_name IS 'name of the ingredient';
COMMENT ON COLUMN ingredient.ingredient_type IS 'type of the ingredient';
COMMENT ON COLUMN ingredient.price IS 'price per 100gram of the ingredient';
COMMENT ON COLUMN ingredientrequirement.recipe_id IS 'identification number of the recipe that the requirement refers to';
COMMENT ON COLUMN ingredientrequirement.ingredient_name IS 'name of the ingredient that the requirement refers to';
COMMENT ON COLUMN ingredientrequirement.amount IS 'the amount of ingredient requried';
COMMENT ON COLUMN ingredientrequirement.unit_name IS 'the unit of the amount requried';
COMMENT ON COLUMN nutrient.nutrient_name IS 'name of the nutrient';
COMMENT ON COLUMN nutrientencompassment.ingredient_name IS 'name of the ingredient';
COMMENT ON COLUMN nutrientencompassment.nutrient_name IS 'name of the nutrient';
COMMENT ON COLUMN nutrientencompassment.amount IS 'amount of the nutrient';
COMMENT ON COLUMN nutrientencompassment.unit_name IS 'unit of the amount'; 

--DATA
insert into unitofmeasurement values('gram', 1, 'mass');
insert into unitofmeasurement values('pound', 453.59237, 'mass'); 
insert into unitofmeasurement values('ounce', 28.349523, 'mass'); 
insert into unitofmeasurement values('kilogram', 1000, 'mass');
insert into unitofmeasurement values('miligram', 0.001, 'mass');
insert into unitofmeasurement values('microgram', 0.000001, 'energy');
insert into unitofmeasurement values('calorie', 1, 'energy');
insert into unitofmeasurement values('kilocalorie', 1000, 'energy');
insert into unitofmeasurement values('iu', 1, 'substance');
insert into unitofmeasurement values('percent',1, 'proportion');
insert into unitofmeasurement values('fluid ounce',29.573529 ,'mass');
insert into unitofmeasurement values('cup',236.588232 ,'mass');       

insert into ingredient values('chicken','lean meat and poultry',2);
insert into ingredient values('flour','powder',0.5);
insert into ingredient values('salt','condiment',0.5);
insert into ingredient values('pepper','condiment',0.5);
insert into ingredient values('butter','dairy product',0.5);
insert into ingredient values('olive oil','fat',0.6);
insert into ingredient values('lemon','fruits and vegetables',0.5);
insert into ingredient values('white wine','alcohol',1);
insert into ingredient values('capers','beans and peas',0.5);
insert into ingredient values('chicken broth','liquid food preparation',1);
insert into ingredient values('parsley','fruits and vegetables',1);

insert into ingredient values('pork','lean meat and poultry',3);
insert into ingredient values('Mai Que Lo wine','alcohol',2);
insert into ingredient values('white vinegar','condiment',0.5);
insert into ingredient values('seasoning powder','seasoning',1);
insert into ingredient values('flavor powder','seasoning',1);
insert into ingredient values('sugar','condiment',0.1);

insert into ingredient values('beef','lean meat and poultry',3);
insert into ingredient values('carrot','vegetables',0.5);
insert into ingredient values('tapioca starch','vegetables',0.5);
insert into ingredient values('boiled water','water',0);
insert into ingredient values('onion','vegetables',0.5);
insert into ingredient values('fish sauce','condiment',1);
insert into ingredient values('lemon grass','vegetables',2);
insert into ingredient values('annatto seed flour','powder',1);
insert into ingredient values('grilled star anise','spice',2);
insert into ingredient values('garlic','vegetables',1);
insert into ingredient values('ginger','vegetables',1);
insert into ingredient values('shallot','vegetables',2);

insert into ingredient values('crab','seafood',2);
insert into ingredient values('anchovy fish','seafood',2);
insert into ingredient values('miso soup','soup',2);
insert into ingredient values('chili sauce','condiment',0.5);
insert into ingredient values('chili powder','condiment',2);
insert into ingredient values('black soy sauce','condiment',2);
insert into ingredient values('rice wine','alcohol',2);

insert into ingredient values('oxtail','lean meat and poultry',2);
insert into ingredient values('beef shank bone','bone',2);
insert into ingredient values('pork neck bone','bone',2);
insert into ingredient values('beef brisket','lean meat and poultry',2);
insert into ingredient values('water','water',0);
insert into ingredient values('red pepper flake','condiment',1);
insert into ingredient values('canola oil','fat',1);
insert into ingredient values('shrimp paste','condiment',2);
insert into ingredient values('rice noodles','whole grain',2);

insert into ingredient values('egg yolk','egg',0.5);
insert into ingredient values('milk','dairy product',0.5);
insert into ingredient values('heavy cream','dairy product',0.5);
insert into ingredient values('vanilla extract','condiment',0.5);
insert into ingredient values('mascarpone cheese','dairy product',0.5);
insert into ingredient values('brewed coffee','coffee',0.5);
insert into ingredient values('rum','alcohol',0.5);
insert into ingredient values('ladyfinger cookie','alcohol',0.5);
insert into ingredient values('cocoa powder','powder',0.5);

insert into nutrient values('calories');
insert into nutrient values('fat');
insert into nutrient values('salt');
insert into nutrient values('cholesterol');
insert into nutrient values('sodium');
insert into nutrient values('carbohydrate');
insert into nutrient values('protein');
insert into nutrient values('vitamin a');
insert into nutrient values('vitamin c');
insert into nutrient values('calcium');
insert into nutrient values('iron');

insert into nutrientencompassment values('chicken','calories','calorie',143);
insert into nutrientencompassment values('chicken','fat','gram',8);
insert into nutrientencompassment values('chicken','cholesterol','miligram',86);
insert into nutrientencompassment values('chicken','sodium','miligram',60);
insert into nutrientencompassment values('chicken','carbohydrate','gram',0);
insert into nutrientencompassment values('chicken','protein','gram',17);
insert into nutrientencompassment values('chicken','vitamin a','percent',0);
insert into nutrientencompassment values('chicken','vitamin c','percent',0);
insert into nutrientencompassment values('chicken','calcium','percent',1);
insert into nutrientencompassment values('chicken','iron','percent',5);

insert into nutrientencompassment values('flour','calories','calorie',364);
insert into nutrientencompassment values('flour','fat','gram',1);
insert into nutrientencompassment values('flour','sodium','miligram',2);
insert into nutrientencompassment values('flour','carbohydrate','gram',76);
insert into nutrientencompassment values('flour','protein','gram',10);
insert into nutrientencompassment values('flour','calcium','percent',1);
insert into nutrientencompassment values('flour','iron','percent',26);
insert into nutrientencompassment values('salt','sodium','miligram',38758);
insert into nutrientencompassment values('salt','calcium','percent',2);
insert into nutrientencompassment values('salt','iron','percent',2);
insert into nutrientencompassment values('pepper','calories','calorie',255);
insert into nutrientencompassment values('pepper','fat','gram',3);
insert into nutrientencompassment values('pepper','sodium','miligram',44);
insert into nutrientencompassment values('pepper','carbohydrate','gram',65);
insert into nutrientencompassment values('pepper','protein','gram',11);
insert into nutrientencompassment values('pepper','vitamin a','percent',6);
insert into nutrientencompassment values('pepper','vitamin c','percent',35);
insert into nutrientencompassment values('pepper','calcium','percent',44);
insert into nutrientencompassment values('pepper','iron','percent',160);
insert into nutrientencompassment values('butter','calories','calorie',717);
insert into nutrientencompassment values('butter','fat','gram',81);
insert into nutrientencompassment values('butter','cholesterol','miligram',215);
insert into nutrientencompassment values('butter','sodium','miligram',576);
insert into nutrientencompassment values('butter','protein','gram',1);
insert into nutrientencompassment values('butter','vitamin a','percent',50);
insert into nutrientencompassment values('butter','calcium','percent',2);
insert into nutrientencompassment values('olive oil','calories','calorie',884);
insert into nutrientencompassment values('olive oil','fat','gram',100);
insert into nutrientencompassment values('olive oil','sodium','miligram',2);
insert into nutrientencompassment values('olive oil','iron','percent',3);
insert into nutrientencompassment values('lemon','calories','calorie',20);
insert into nutrientencompassment values('lemon','sodium','miligram',3);
insert into nutrientencompassment values('lemon','carbohydrate','gram',11);
insert into nutrientencompassment values('lemon','protein','gram',1);
insert into nutrientencompassment values('lemon','vitamin a','percent',1);
insert into nutrientencompassment values('lemon','vitamin c','percent',128);
insert into nutrientencompassment values('lemon','calcium','percent',6);
insert into nutrientencompassment values('lemon','iron','percent',4);
insert into nutrientencompassment values('white wine','calories','calorie',83);
insert into nutrientencompassment values('white wine','carbohydrate','gram',2);
insert into nutrientencompassment values('capers','calories','calorie',23);
insert into nutrientencompassment values('capers','fat','gram',1);
insert into nutrientencompassment values('capers','sodium','miligram',2964);
insert into nutrientencompassment values('capers','carbohydrate','gram',5);
insert into nutrientencompassment values('capers','vitamin a','percent',3);
insert into nutrientencompassment values('capers','vitamin c','percent',7);
insert into nutrientencompassment values('capers','calcium','percent',4);
insert into nutrientencompassment values('capers','iron','percent',9);
insert into nutrientencompassment values('chicken broth','calories','calorie',4);
insert into nutrientencompassment values('chicken broth','sodium','miligram',313);
insert into nutrientencompassment values('chicken broth','calcium','percent',1);
insert into nutrientencompassment values('chicken broth','protein','gram',1);
insert into nutrientencompassment values('parsley','calories','calorie',36);
insert into nutrientencompassment values('parsley','fat','gram',1);
insert into nutrientencompassment values('parsley','sodium','miligram',56);
insert into nutrientencompassment values('parsley','carbohydrate','gram',6);
insert into nutrientencompassment values('parsley','protein','gram',3);
insert into nutrientencompassment values('parsley','vitamin a','percent',168);
insert into nutrientencompassment values('parsley','vitamin c','percent',222);
insert into nutrientencompassment values('parsley','calcium','percent',14);
insert into nutrientencompassment values('parsley','iron','percent',34);

insert into nutrientencompassment values('pork','calories','calorie',149);
insert into nutrientencompassment values('pork','fat','gram',3);
insert into nutrientencompassment values('pork','cholesterol','miligram',504);
insert into nutrientencompassment values('pork','sodium','miligram',107);
insert into nutrientencompassment values('pork','protein','gram',28);
insert into nutrientencompassment values('pork','vitamin c','percent',19);
insert into nutrientencompassment values('pork','calcium','percent',1);
insert into nutrientencompassment values('pork','iron','percent',124);
insert into nutrientencompassment values('Mai Que Lo wine','calories','calorie',83);
insert into nutrientencompassment values('Mai Que Lo wine','carbohydrate','gram',2);
insert into nutrientencompassment values('white vinegar','calories','calorie',18);
insert into nutrientencompassment values('white vinegar','sodium','miligram',2);
insert into nutrientencompassment values('white vinegar','calcium','percent',1);
insert into nutrientencompassment values('sugar','calories','calorie',387);
insert into nutrientencompassment values('sugar','carbohydrate','gram',100);

insert into nutrientencompassment values('beef','calories','calorie',145);
insert into nutrientencompassment values('beef','fat','gram',4);
insert into nutrientencompassment values('beef','cholesterol','miligram',347);
insert into nutrientencompassment values('beef','sodium','miligram',57);
insert into nutrientencompassment values('beef','protein','gram',25);
insert into nutrientencompassment values('beef','vitamin c','percent',84);
insert into nutrientencompassment values('beef','calcium','percent',1);
insert into nutrientencompassment values('beef','iron','percent',219);
insert into nutrientencompassment values('carrot','calories','calorie',41);
insert into nutrientencompassment values('carrot','sodium','miligram',69);
insert into nutrientencompassment values('carrot','carbohydrate','gram',10);
insert into nutrientencompassment values('carrot','protein','gram',1);
insert into nutrientencompassment values('carrot','vitamin a','percent',334);
insert into nutrientencompassment values('carrot','vitamin c','percent',10);
insert into nutrientencompassment values('carrot','calcium','percent',3);
insert into nutrientencompassment values('carrot','iron','percent',2);
insert into nutrientencompassment values('tapioca starch','calories','calorie',10833);
insert into nutrientencompassment values('tapioca starch','sodium','miligram',283);
insert into nutrientencompassment values('tapioca starch','carbohydrate','gram',2600);
insert into nutrientencompassment values('tapioca starch','iron','percent',67);
insert into nutrientencompassment values('boiled water','sodium','miligram',60);
insert into nutrientencompassment values('boiled water','calcium','percent',1);
insert into nutrientencompassment values('onion','calories','calorie',40);
insert into nutrientencompassment values('onion','sodium','miligram',4);
insert into nutrientencompassment values('onion','carbohydrate','gram',9);
insert into nutrientencompassment values('onion','protein','gram',1);
insert into nutrientencompassment values('onion','vitamin c','percent',12);
insert into nutrientencompassment values('onion','calcium','percent',2);
insert into nutrientencompassment values('onion','iron','percent',1);
insert into nutrientencompassment values('fish sauce','calories','calorie',67);
insert into nutrientencompassment values('fish sauce','sodium','miligram',7933);
insert into nutrientencompassment values('fish sauce','carbohydrate','gram',7);
insert into nutrientencompassment values('fish sauce','protein','gram',13);
insert into nutrientencompassment values('fish sauce','calcium','percent',7);
insert into nutrientencompassment values('fish sauce','iron','percent',13);
insert into nutrientencompassment values('lemon grass','calories','calorie',99);
insert into nutrientencompassment values('lemon grass','sodium','miligram',6);
insert into nutrientencompassment values('lemon grass','carbohydrate','gram',25);
insert into nutrientencompassment values('lemon grass','protein','gram',2);
insert into nutrientencompassment values('lemon grass','vitamin c','percent',4);
insert into nutrientencompassment values('lemon grass','calcium','percent',7);
insert into nutrientencompassment values('lemon grass','iron','percent',45);
insert into nutrientencompassment values('grilled star anise','calories','calorie',337);
insert into nutrientencompassment values('grilled star anise','fat','gram',16);
insert into nutrientencompassment values('grilled star anise','sodium','miligram',16);
insert into nutrientencompassment values('grilled star anise','carbohydrate','gram',50);
insert into nutrientencompassment values('grilled star anise','protein','gram',18);
insert into nutrientencompassment values('grilled star anise','vitamin a','percent',6);
insert into nutrientencompassment values('grilled star anise','vitamin c','percent',35);
insert into nutrientencompassment values('grilled star anise','calcium','percent',65);
insert into nutrientencompassment values('grilled star anise','iron','percent',205);
insert into nutrientencompassment values('garlic','calories','calorie',149);
insert into nutrientencompassment values('garlic','sodium','miligram',17);
insert into nutrientencompassment values('garlic','carbohydrate','gram',33);
insert into nutrientencompassment values('garlic','protein','gram',6);
insert into nutrientencompassment values('garlic','vitamin c','percent',52);
insert into nutrientencompassment values('garlic','calcium','percent',18);
insert into nutrientencompassment values('garlic','iron','percent',9);
insert into nutrientencompassment values('ginger','calories','calorie',80);
insert into nutrientencompassment values('ginger','fat','gram',1);
insert into nutrientencompassment values('ginger','carbohydrate','gram',18);
insert into nutrientencompassment values('ginger','protein','gram',2);
insert into nutrientencompassment values('ginger','vitamin c','percent',8);
insert into nutrientencompassment values('ginger','calcium','percent',2);
insert into nutrientencompassment values('ginger','iron','percent',3);
insert into nutrientencompassment values('shallot','calories','calorie',72);
insert into nutrientencompassment values('shallot','sodium','miligram',12);
insert into nutrientencompassment values('shallot','carbohydrate','gram',17);
insert into nutrientencompassment values('shallot','protein','gram',3);
insert into nutrientencompassment values('shallot','vitamin a','percent',24);
insert into nutrientencompassment values('shallot','vitamin c','percent',13);
insert into nutrientencompassment values('shallot','calcium','percent',4);
insert into nutrientencompassment values('shallot','iron','percent',7);

insert into nutrientencompassment values('crab','calories','calorie',102);
insert into nutrientencompassment values('crab','fat','gram',2);
insert into nutrientencompassment values('crab','cholesterol','miligram',100);
insert into nutrientencompassment values('crab','sodium','miligram',279);
insert into nutrientencompassment values('crab','carbohydrate','gram',0);
insert into nutrientencompassment values('crab','protein','gram',20);
insert into nutrientencompassment values('crab','vitamin c','percent',5);
insert into nutrientencompassment values('crab','calcium','percent',10);
insert into nutrientencompassment values('crab','iron','percent',5);
insert into nutrientencompassment values('anchovy fish','calories','calorie',131);
insert into nutrientencompassment values('anchovy fish','fat','gram',5);
insert into nutrientencompassment values('anchovy fish','cholesterol','miligram',60);
insert into nutrientencompassment values('anchovy fish','sodium','miligram',104);
insert into nutrientencompassment values('anchovy fish','protein','gram',20);
insert into nutrientencompassment values('anchovy fish','vitamin a','percent',1);
insert into nutrientencompassment values('anchovy fish','calcium','percent',15);
insert into nutrientencompassment values('anchovy fish','iron','percent',18);
insert into nutrientencompassment values('miso soup','calories','calorie',16);
insert into nutrientencompassment values('miso soup','sodium','miligram',190);
insert into nutrientencompassment values('miso soup','carbohydrate','gram',3);
insert into nutrientencompassment values('miso soup','protein','gram',1);
insert into nutrientencompassment values('miso soup','vitamin a','percent',23);
insert into nutrientencompassment values('miso soup','vitamin c','percent',2);
insert into nutrientencompassment values('miso soup','calcium','percent',1);
insert into nutrientencompassment values('miso soup','iron','percent',1);
insert into nutrientencompassment values('chili sauce','sodium','miligram',2000);
insert into nutrientencompassment values('chili sauce','carbohydrate','gram',20);
insert into nutrientencompassment values('chili powder','calories','calorie',314);
insert into nutrientencompassment values('chili powder','fat','gram',17);
insert into nutrientencompassment values('chili powder','sodium','miligram',1010);
insert into nutrientencompassment values('chili powder','carbohydrate','gram',55);
insert into nutrientencompassment values('chili powder','protein','gram',12);
insert into nutrientencompassment values('chili powder','vitamin a','percent',593);
insert into nutrientencompassment values('chili powder','vitamin c','percent',107);
insert into nutrientencompassment values('chili powder','calcium','percent',28);
insert into nutrientencompassment values('chili powder','iron','percent',79);
insert into nutrientencompassment values('black soy sauce','calories','calorie',60);
insert into nutrientencompassment values('black soy sauce','sodium','miligram',5586);
insert into nutrientencompassment values('black soy sauce','carbohydrate','gram',6);
insert into nutrientencompassment values('black soy sauce','protein','gram',11);
insert into nutrientencompassment values('black soy sauce','calcium','percent',2);
insert into nutrientencompassment values('black soy sauce','iron','percent',13);
insert into nutrientencompassment values('rice wine','calories','calorie',147);
insert into nutrientencompassment values('rice wine','sodium','miligram',765);
insert into nutrientencompassment values('rice wine','carbohydrate','gram',41);

insert into nutrientencompassment values('oxtail','calories','calorie',148);
insert into nutrientencompassment values('oxtail','fat','gram',8);
insert into nutrientencompassment values('oxtail','cholesterol','miligram',60);
insert into nutrientencompassment values('oxtail','sodium','miligram',131);
insert into nutrientencompassment values('oxtail','protein','gram',17);
insert into nutrientencompassment values('oxtail','iron','percent',11);

insert into nutrientencompassment values('beef shank bone','calories','calorie',116);
insert into nutrientencompassment values('beef shank bone','fat','gram',7);
insert into nutrientencompassment values('beef shank bone','cholesterol','miligram',32);
insert into nutrientencompassment values('beef shank bone','sodium','miligram',145);
insert into nutrientencompassment values('beef shank bone','protein','gram',11);
insert into nutrientencompassment values('beef shank bone','iron','percent',7);

insert into nutrientencompassment values('pork neck bone','calories','calorie',116);
insert into nutrientencompassment values('pork neck bone','fat','gram',7);
insert into nutrientencompassment values('pork neck bone','cholesterol','miligram',32);
insert into nutrientencompassment values('pork neck bone','sodium','miligram',145);
insert into nutrientencompassment values('pork neck bone','protein','gram',11);
insert into nutrientencompassment values('pork neck bone','iron','percent',7);

insert into nutrientencompassment values('beef brisket','calories','calorie',277);
insert into nutrientencompassment values('beef brisket','fat','gram',22);
insert into nutrientencompassment values('beef brisket','cholesterol','miligram',81);
insert into nutrientencompassment values('beef brisket','sodium','miligram',59);
insert into nutrientencompassment values('beef brisket','protein','gram',18);
insert into nutrientencompassment values('beef brisket','calcium','percent',2);
insert into nutrientencompassment values('beef brisket','iron','percent',9);

insert into nutrientencompassment values('water','sodium','miligram',60);
insert into nutrientencompassment values('water','calcium','percent',1);

insert into nutrientencompassment values('red pepper flake','calories','calorie',318);
insert into nutrientencompassment values('red pepper flake','fat','gram',17);
insert into nutrientencompassment values('red pepper flake','sodium','miligram',30);
insert into nutrientencompassment values('red pepper flake','carbohydrate','gram',57);
insert into nutrientencompassment values('red pepper flake','protein','gram',12);
insert into nutrientencompassment values('red pepper flake','vitamin a','percent',832);
insert into nutrientencompassment values('red pepper flake','vitamin c','percent',127);
insert into nutrientencompassment values('red pepper flake','calcium','percent',15);
insert into nutrientencompassment values('red pepper flake','iron','percent',43);

insert into nutrientencompassment values('canola oil','calories','calorie',884);
insert into nutrientencompassment values('canola oil','fat','gram',100);

insert into nutrientencompassment values('shrimp paste','calories','calorie',118);
insert into nutrientencompassment values('shrimp paste','cholesterol','miligram',294);
insert into nutrientencompassment values('shrimp paste','sodium','miligram',8765);
insert into nutrientencompassment values('shrimp paste','carbohydrate','gram',5.882);
insert into nutrientencompassment values('shrimp paste','protein','gram',24);
insert into nutrientencompassment values('shrimp paste','calcium','percent',176);
insert into nutrientencompassment values('shrimp paste','iron','percent',118);

insert into nutrientencompassment values('rice noodles','calories','calorie',192);
insert into nutrientencompassment values('rice noodles','sodium','miligram',33);
insert into nutrientencompassment values('rice noodles','carbohydrate','gram',44);
insert into nutrientencompassment values('rice noodles','protein','gram',2);
insert into nutrientencompassment values('rice noodles','calcium','percent',1);
insert into nutrientencompassment values('rice noodles','iron','percent',1);

insert into nutrientencompassment values('egg yolk','calories','calorie',317);
insert into nutrientencompassment values('egg yolk','fat','gram',27);
insert into nutrientencompassment values('egg yolk','cholesterol','miligram',1234);
insert into nutrientencompassment values('egg yolk','sodium','miligram',48);
insert into nutrientencompassment values('egg yolk','carbohydrate','gram',4);
insert into nutrientencompassment values('egg yolk','protein','gram',16);
insert into nutrientencompassment values('egg yolk','vitamin a','percent',29);
insert into nutrientencompassment values('egg yolk','calcium','percent',13);
insert into nutrientencompassment values('egg yolk','iron','percent',15);

insert into nutrientencompassment values('milk','calories','calorie',60);
insert into nutrientencompassment values('milk','fat','gram',3);
insert into nutrientencompassment values('milk','cholesterol','miligram',10);
insert into nutrientencompassment values('milk','sodium','miligram',40);
insert into nutrientencompassment values('milk','carbohydrate','gram',5);
insert into nutrientencompassment values('milk','protein','gram',3);
insert into nutrientencompassment values('milk','vitamin a','percent',2);
insert into nutrientencompassment values('milk','calcium','percent',11);

insert into nutrientencompassment values('heavy cream','calories','calorie',345);
insert into nutrientencompassment values('heavy cream','fat','gram',37);
insert into nutrientencompassment values('heavy cream','cholesterol','miligram',137);
insert into nutrientencompassment values('heavy cream','sodium','miligram',38);
insert into nutrientencompassment values('heavy cream','carbohydrate','gram',3);
insert into nutrientencompassment values('heavy cream','protein','gram',2);
insert into nutrientencompassment values('heavy cream','vitamin a','percent',29);
insert into nutrientencompassment values('heavy cream','vitamin c','percent',1);
insert into nutrientencompassment values('heavy cream','calcium','percent',7);

insert into nutrientencompassment values('vanilla extract','calories','calorie',288);
insert into nutrientencompassment values('vanilla extract','sodium','miligram',9);
insert into nutrientencompassment values('vanilla extract','carbohydrate','gram',13);
insert into nutrientencompassment values('vanilla extract','calcium','percent',1);
insert into nutrientencompassment values('vanilla extract','iron','percent',1);

insert into nutrientencompassment values('mascarpone cheese','calories','calorie',429);
insert into nutrientencompassment values('mascarpone cheese','fat','gram',46);
insert into nutrientencompassment values('mascarpone cheese','cholesterol','miligram',125);
insert into nutrientencompassment values('mascarpone cheese','sodium','miligram',54);
insert into nutrientencompassment values('mascarpone cheese','protein','gram',7);
insert into nutrientencompassment values('mascarpone cheese','vitamin a','percent',29);
insert into nutrientencompassment values('mascarpone cheese','calcium','percent',14);

insert into nutrientencompassment values('brewed coffee','calories','calorie',1);
insert into nutrientencompassment values('brewed coffee','sodium','miligram',2);

insert into nutrientencompassment values('rum','calories','calorie',231);
insert into nutrientencompassment values('rum','sodium','miligram',1);
insert into nutrientencompassment values('rum','iron','percent',1);

insert into nutrientencompassment values('ladyfinger cookie','calories','calorie',365);
insert into nutrientencompassment values('ladyfinger cookie','fat','gram',9);
insert into nutrientencompassment values('ladyfinger cookie','cholesterol','miligram',221);
insert into nutrientencompassment values('ladyfinger cookie','sodium','miligram',147);
insert into nutrientencompassment values('ladyfinger cookie','carbohydrate','gram',60);
insert into nutrientencompassment values('ladyfinger cookie','protein','gram',11);
insert into nutrientencompassment values('ladyfinger cookie','vitamin a','percent',1);
insert into nutrientencompassment values('ladyfinger cookie','vitamin c','percent',6);
insert into nutrientencompassment values('ladyfinger cookie','calcium','percent',5);
insert into nutrientencompassment values('ladyfinger cookie','iron','percent',20);

insert into nutrientencompassment values('cocoa powder','calories','calorie',228);
insert into nutrientencompassment values('cocoa powder','fat','gram',14);
insert into nutrientencompassment values('cocoa powder','sodium','miligram',21);
insert into nutrientencompassment values('cocoa powder','carbohydrate','gram',58);
insert into nutrientencompassment values('cocoa powder','protein','gram',20);
insert into nutrientencompassment values('cocoa powder','calcium','percent',13);
insert into nutrientencompassment values('cocoa powder','iron','percent',77);

insert into recipe values(null,'lemon chicken piccata with grilled bread',default,'main dish','europe',30,4);
insert into recipe values(null,'roasted crispy pork belly',default,'main dish','vietnamese',180,4);
insert into recipe values(null,'vietnamese stewed beef recipe',default,'main dish','vietnamese',240,4);
insert into recipe values(null,'fried crabs with chili sauce',default,'main dish','asian',60,2);
insert into recipe values(null,'bun bo hue',default,'main dish','vietnamese',230,6);
insert into recipe values(null,'tiramisu',default,'dessert','italian',300,4);

insert into ingredientrequirement values(1,'chicken',1,'pound');
insert into ingredientrequirement values(1,'flour',32,'gram');
insert into ingredientrequirement values(1,'salt',0.25,'gram');
insert into ingredientrequirement values(1,'pepper',0.25,'gram');
insert into ingredientrequirement values(1,'butter',56,'gram');
insert into ingredientrequirement values(1,'olive oil',27.44,'gram');
insert into ingredientrequirement values(1,'white wine',0.5,'cup');
insert into ingredientrequirement values(1,'chicken broth',1.5,'cup');
insert into ingredientrequirement values(1,'lemon',1,'gram');
insert into ingredientrequirement values(1,'capers',61.75,'gram');
insert into ingredientrequirement values(1,'parsley',10,'gram');

insert into ingredientrequirement values(2,'pork',1,'kilogram');
insert into ingredientrequirement values(2,'Mai Que Lo wine',20,'gram');
insert into ingredientrequirement values(2,'white vinegar',20,'gram');
insert into ingredientrequirement values(2,'salt',5,'gram');
insert into ingredientrequirement values(2,'seasoning powder',5,'gram');
insert into ingredientrequirement values(2,'sugar',15,'gram');
insert into ingredientrequirement values(2,'flavor powder',15,'gram');
insert into ingredientrequirement values(2,'pepper',5,'gram');

insert into ingredientrequirement values(3,'beef',1,'kilogram');
insert into ingredientrequirement values(3,'carrot',300,'gram');
insert into ingredientrequirement values(3,'tapioca starch',20,'gram');
insert into ingredientrequirement values(3,'boiled water',100,'gram');
insert into ingredientrequirement values(3,'salt',5,'gram');
insert into ingredientrequirement values(3,'sugar',15,'gram');
insert into ingredientrequirement values(3,'fish sauce',20,'gram');
insert into ingredientrequirement values(3,'pepper',5,'gram');
insert into ingredientrequirement values(3,'lemon grass',30,'gram');
insert into ingredientrequirement values(3,'annatto seed flour',5,'gram');
insert into ingredientrequirement values(3,'grilled star anise',3,'gram');
insert into ingredientrequirement values(3,'garlic',20,'gram');
insert into ingredientrequirement values(3,'ginger',20,'gram');
insert into ingredientrequirement values(3,'shallot',20,'gram');

insert into ingredientrequirement values(4,'crab',1,'kilogram');
insert into ingredientrequirement values(4,'anchovy fish',100,'gram');
insert into ingredientrequirement values(4,'miso soup',5,'gram');
insert into ingredientrequirement values(4,'chili sauce',5,'gram');
insert into ingredientrequirement values(4,'chili powder',5,'gram');
insert into ingredientrequirement values(4,'black soy sauce',5,'gram');
insert into ingredientrequirement values(4,'rice wine',10,'gram');
insert into ingredientrequirement values(4,'garlic',10,'gram');
insert into ingredientrequirement values(4,'ginger',10,'gram');
insert into ingredientrequirement values(4,'pepper',2,'gram');

insert into ingredientrequirement values(5,'oxtail',2,'pound');
insert into ingredientrequirement values(5,'beef shank bone',2,'pound');
insert into ingredientrequirement values(5,'pork neck bone',2,'pound');
insert into ingredientrequirement values(5,'beef brisket',1,'pound');
insert into ingredientrequirement values(5,'lemon grass',200,'gram');
insert into ingredientrequirement values(5,'water',9,'kilogram');
insert into ingredientrequirement values(5,'red pepper flake',10,'gram');
insert into ingredientrequirement values(5,'annatto seed flour',5,'gram');
insert into ingredientrequirement values(5,'canola oil',15,'gram');
insert into ingredientrequirement values(5,'shallot',100,'gram');
insert into ingredientrequirement values(5,'garlic',50,'gram');
insert into ingredientrequirement values(5,'shrimp paste',50,'gram');
insert into ingredientrequirement values(5,'fish sauce',50,'gram');
insert into ingredientrequirement values(5,'rice noodles',1,'kilogram');

insert into ingredientrequirement values(6,'egg yolk',300,'gram');
insert into ingredientrequirement values(6,'sugar',0.75,'cup');
insert into ingredientrequirement values(6,'milk',0.7,'cup');
insert into ingredientrequirement values(6,'heavy cream',1.25,'cup');
insert into ingredientrequirement values(6,'vanilla extract',2.5,'gram');
insert into ingredientrequirement values(6,'mascarpone cheese',1,'pound');
insert into ingredientrequirement values(6,'brewed coffee',0.25,'cup');
insert into ingredientrequirement values(6,'rum',20,'gram');
insert into ingredientrequirement values(6,'ladyfinger cookie',3,'ounce');
insert into ingredientrequirement values(6,'cocoa powder',10,'gram');

insert into recipeinstruction values(null,'Cut the chicken breasts in half so that you have a total of four pieces. Cover with plastic wrap and pound them to an even thickness of about ½ inch or less. Place the flour in a bowl with some salt and pepper. Dredge the chicken in the flour mixture and set aside.',1,1);
insert into recipeinstruction values(null,'Heat 2 tablespoons of butter and the olive oil in a heavy skillet. Add the chicken and fry for a few minutes, flipping once. Both sides should be golden brown. Remove chicken and set aside.',2,1);
insert into recipeinstruction values(null,'Add the wine to the skillet and let it get all sizzly so you can scrape browned bits off the bottom. Add the broth and lemon slices. Let the mixture reduce to half or less. Add the capers, butter, and any remaining juice you can get out of the lemon nubs. Arrange the chicken pieces back in the pan and sprinkle with fresh parsley.',3,1);

insert into recipeinstruction values(null,'Mix all spices (not including salt). You can grind again for helping absorb in meat easily. Clean well pork belly, slice into 2 pieces.',1,2);
insert into recipeinstruction values(null,'Brush Mai Quế Lộ wine on face of pork. Next, add more mixture spices in step 1 on its face. You should concentrate on marinate on its meat, do not brush on its skin. Wait for 30 minutes. Here is also the important step to create one of stunning',2,2);
insert into recipeinstruction values(null,'Change its face, use knife to cut gently some lines on its skin. Then, add salt and vinegar on it, wait for 30 minutes.',3,2);
insert into recipeinstruction values(null,' Add one tray with water below it to make sure it will not be dried after grilled. Set up the heat from 180 – 200 degree (depend on its size). Grill in 40 – 60 minutes until it turns brown yellow.',4,2);

insert into recipeinstruction values(null,'Add all sliced beef cubes into pot. Marinate (for 1kg meat) with 2 teaspoons salt + ½ teaspoon Magi’s stuff + 1 tablespoon minced garlic, sliced ginger, minced shallot + smashed lemongrass + 1 teaspoon fish sauce + ½ teaspoon pepper + 1 teaspoon sugar, wait for 20 – 30 minutes and then continue to marinate with 15gr 5 flavors starch + 5g annatto seed flour  + 2-3g grilled star anise. Mix well and wait more 30 minutes.',1,3);
insert into recipeinstruction values(null,'Mix 1 tablespoon tapioca starch or corn starch with 1 bowl water.',2,3);
insert into recipeinstruction values(null,'Put pot (added spices in step 1) on cooking stove, add more 1 tablespoon oil and fry with small heat until meat is shrunk and add a little hot water into. (Make sure you will stop pouring when water reaches the top of meat) and stew with small heat.',3,3);
insert into recipeinstruction values(null,'Stew until all meat is soft, add more sliced carrot + onion and continue stewing until carrot is soft as well.',4,3);
insert into recipeinstruction values(null,'Pour slowly mixture tapioca starch in step 2 into pot, use chopsticks or spoon to stir well and gently until its broth is thicker. Season again to suit your flavor.',5,3);
insert into recipeinstruction values(null,'Your dish is ready served. Eating when it is hot with bread or steamed rice or even rice noodles as I told above is all delicious. Cooking stewed beef is quite multiform. Depend on your flavor; you can change to suit with. Serving this dish for breakfast or main meals is all great choice.',6,3);

insert into recipeinstruction values(null,'Clean well sea crabs, use brush to wash carefully their bodies and legs.',1,4);
insert into recipeinstruction values(null,'Seperate shells and bodies of crabs. Pull out the striangle shapes on their bellies, store the eggs into clean bowl.',2,4);
insert into recipeinstruction values(null,'Put crabs including their shells into pot.',3,4);
insert into recipeinstruction values(null,'Add more 1,5 liters water into another pot plus dried anchovy fishes, 1 teaspoon miso soup, cook about 5 minutes and then put out all anchovy fishes.',4,4);
insert into recipeinstruction values(null,'Add minced garlic, ginger water, black soy sauce, rice wine, chili sauce into bowl, pour more water in step 4 and stir gently to make sauce.',5,4);
insert into recipeinstruction values(null,'Pour the sauce in step 5 into pot which stored crabs, cook with medium heat.',6,4);
insert into recipeinstruction values(null,'Cook in 5 – 7 minutes, sprinkle more pepper on top.',7,4);

insert into recipeinstruction values(null,'In your largest pot (make sure it’s big enough to fit the bones and water to cover by 1 inch) bring a pot of water to a rolling boil. Carefully add in the bones and boil for 3 minutes. Remove the bones and pour out the water. Rinse the bones under running water. This is to force out impurities and will make it so you’re skimming your broth less and will ensure a clearer stock.',1,5);
insert into recipeinstruction values(null,'When the bones are rinsed clean, return them to the pot (make sure you wash the pot first) and add in the brisket.',2,5);
insert into recipeinstruction values(null,'Cut the lemongrass stalks in half and discard the leafy tops. Bruise the remaining lemongrass and add it to the pot. Add 8 quarts of water and bring to a boil over high heat. When the stock comes to a boil, turn the heat down so it’s at a simmer. Skim off any scum as needed.',3,5);
insert into recipeinstruction values(null,'After 45 minutes of simmering, prepare and ice bath. Check the brisket to see if it is cooked through. Remove from the stock and poke it with a chopstick; the juices should run clear. (If needed return to the stock and cook for another 10 minutes.) When the brisket is cooked, plunge into the ice bath until cool. Remove from the ice bath, pat dry, wrap tightly and refrigerate.',4,5);
insert into recipeinstruction values(null,'Continue to simmer the stock with the bones for another two hours, skimming as needed. When the 2 hours are up, remove from the heat and scoop out the bones and set aside. Carefully strain the stock through a fine mesh sieve into another large stock pot. If desired, skim off the majority of the fat and then set the pot to a simmer over medium-low heat.',5,5);
insert into recipeinstruction values(null,'Cool the bones and remove the meat from the oxtails, set aside and reserve in the fridge. Discard the bones.',6,5);
insert into recipeinstruction values(null,'With a mortar and pestle, grind the red pepper flakes and annatto seeds into a coarse powder. Heat up the oil in a frying pan over medium heat. Add the ground red pepper flakes and annatto seeds and cook, stirring, for 10 seconds. Add the shallots, garlic, lemongrass, and shrimp paste and cook, stirring, for 2 minutes more, until the mixture is aromatic and the shallots are just beginning to soften.',7,5);
insert into recipeinstruction values(null,'Add the contents of the frying pan to the simmering stock along with the fish sauce and sugar and simmer for 20 minutes. Taste and adjust the seasoning with fish sauce and sugar as needed.',8,5);
insert into recipeinstruction values(null,'Cook the noodles according to the package and then divid among deep soup bowls. Top with brisket slices and a bit of oxtail meat. Ladle the hot stock over the noodles and beef and serve immediately, accompanied with the platter of garnishes. Enjoy!',9,5);

insert into recipeinstruction values(null,'In a medium saucepan, whisk together egg yolks and sugar until well blended. Whisk in milk and cook over medium heat, stirring constantly, until mixture boils. Boil gently for 1 minute, remove from heat and allow to cool slightly. Cover tightly and chill in refrigerator 1 hour.',1,6);
insert into recipeinstruction values(null,'In a medium bowl, beat cream with vanilla until stiff peaks form. Whisk mascarpone into yolk mixture until smooth.',2,6);
insert into recipeinstruction values(null,'In a small bowl, combine coffee and rum. Split ladyfingers in half lengthwise and drizzle with coffee mixture.',3,6);
insert into recipeinstruction values(null,'Arrange half of soaked ladyfingers in bottom of a 7x11 inch dish. Spread half of mascarpone mixture over ladyfingers, then half of whipped cream over that. Repeat layers and sprinkle with cocoa. Cover and refrigerate 4 to 6 hours, until set.',4,6);

--leaders must be created first
insert into restaurantstaff values(9,'nick','man',null);
insert into restaurantstaff values(10,'iron','fury',9);
insert into restaurantstaff values(5,'captain','witch',9);

insert into restaurantstaff values(1,'black','machine',10);
insert into restaurantstaff values(2,'war','widow',10);
insert into restaurantstaff values(3,null,'hor',5);
insert into restaurantstaff values(4,null,'thulk',10);
insert into restaurantstaff values(6,'scarlet','america',5);
insert into restaurantstaff values(7,null,'hawkion',5);
insert into restaurantstaff values(8,null,'viseye',10);

insert into recipeaccess values(1,6,SYSTIMESTAMP,1);
insert into recipeaccess values(1,5,SYSTIMESTAMP,2);
insert into recipeaccess values(1,3,SYSTIMESTAMP,3);
insert into recipeaccess values(1,5,SYSTIMESTAMP,4);
insert into recipeaccess values(2,5,SYSTIMESTAMP,5);
insert into recipeaccess values(2,1,SYSTIMESTAMP,6);
insert into recipeaccess values(3,3,SYSTIMESTAMP,7);
insert into recipeaccess values(4,2,SYSTIMESTAMP,8);
insert into recipeaccess values(4,1,SYSTIMESTAMP,9);
insert into recipeaccess values(5,6,SYSTIMESTAMP,10);
insert into recipeaccess values(6,5,SYSTIMESTAMP,11);
insert into recipeaccess values(6,2,SYSTIMESTAMP,12);
insert into recipeaccess values(6,1,SYSTIMESTAMP,13);
insert into recipeaccess values(7,1,SYSTIMESTAMP,14);
insert into recipeaccess values(7,2,SYSTIMESTAMP,15);
insert into recipeaccess values(7,5,SYSTIMESTAMP,16);
insert into recipeaccess values(8,5,SYSTIMESTAMP,17);
insert into recipeaccess values(9,5,SYSTIMESTAMP,18);
insert into recipeaccess values(9,4,SYSTIMESTAMP,19);
insert into recipeaccess values(9,4,SYSTIMESTAMP,20);
insert into recipeaccess values(10,5,SYSTIMESTAMP,21);
insert into recipeaccess values(10,5,SYSTIMESTAMP,22);
insert into recipeaccess values(10,5,SYSTIMESTAMP,23);
insert into recipeaccess values(10,5,SYSTIMESTAMP,24);
insert into recipeaccess values(10,5,SYSTIMESTAMP,25);
insert into recipeaccess values(10,5,SYSTIMESTAMP,26);
insert into recipeaccess values(10,5,SYSTIMESTAMP,27);

--VIEWS
CREATE VIEW menu
AS
  SELECT INITCAP(r.recipe_name) AS "Menu",
         r.date_added AS "Has been served since",
         r.serve AS "Serve sizes",
         CONCAT(TRUNC((SELECT Sum(amount * (SELECT relative_ratio
                                            FROM   unitofmeasurement
                                            WHERE  unit_name = ir.unit_name) * (SELECT price
                                                                                FROM   ingredient
                                                                                WHERE  ingredient_name = ir.ingredient_name) / 100)
                       FROM   ingredientrequirement ir
                       WHERE  recipe_id = r.recipe_id), 2), ' euro') AS "Cost"
  FROM   recipe r 
  ORDER BY recipe_name;
  
--PRIVILEGES
--For administrator
GRANT ALL PRIVILEGES ON restaurantstaff TO ie_a341_sql01_t01;
GRANT ALL PRIVILEGES ON recipeaccess TO ie_a341_sql01_t01;
GRANT ALL PRIVILEGES ON recipe TO ie_a341_sql01_t01;
GRANT ALL PRIVILEGES ON recipeinstruction TO ie_a341_sql01_t01;
GRANT ALL PRIVILEGES ON ingredientrequirement TO ie_a341_sql01_t01;
GRANT ALL PRIVILEGES ON ingredient TO ie_a341_sql01_t01;
GRANT ALL PRIVILEGES ON unitofmeasurement TO ie_a341_sql01_t01;
GRANT ALL PRIVILEGES ON nutrientencompassment TO ie_a341_sql01_t01;
GRANT ALL PRIVILEGES ON nutrient TO ie_a341_sql01_t01;

--For classmates
GRANT SELECT ON recipe TO IE_A341_SQL01_S02 WITH GRANT OPTION;
GRANT SELECT ON restaurantstaff TO IE_A341_SQL01_S02;
GRANT SELECT ON recipeaccess TO IE_A341_SQL01_S02;
GRANT SELECT ON recipeinstruction TO IE_A341_SQL01_S02;
GRANT SELECT ON ingredientrequirement TO IE_A341_SQL01_S02;
GRANT SELECT ON ingredient TO IE_A341_SQL01_S02;
GRANT SELECT ON unitofmeasurement TO IE_A341_SQL01_S02;
GRANT SELECT ON nutrientencompassment TO IE_A341_SQL01_S02;
GRANT SELECT ON nutrient TO IE_A341_SQL01_S02;
GRANT SELECT ON recipe TO IE_A341_SQL01_S03 WITH GRANT OPTION;
GRANT SELECT ON restaurantstaff TO IE_A341_SQL01_S03;
GRANT SELECT ON recipeaccess TO IE_A341_SQL01_S03;
GRANT SELECT ON recipeinstruction TO IE_A341_SQL01_S03;
GRANT SELECT ON ingredientrequirement TO IE_A341_SQL01_S03;
GRANT SELECT ON ingredient TO IE_A341_SQL01_S03;
GRANT SELECT ON unitofmeasurement TO IE_A341_SQL01_S03;
GRANT SELECT ON nutrientencompassment TO IE_A341_SQL01_S03;
GRANT SELECT ON nutrient TO IE_A341_SQL01_S03;

--Let the public select the menu view
GRANT SELECT ON menu TO PUBLIC; 


--QUERIES
--1
SELECT LPAD(last_name, LENGTH(last_name) + ( LEVEL * 2 ) - 2, '_') AS "Staffs hierarchy"
FROM   restaurantstaff
START WITH staff_id = 9
CONNECT BY PRIOR staff_id = chef_id; 

--2
SELECT INITCAP(cuisine) AS "Cuisine",
       INITCAP(recipe_name) || ' (' || meal_type || ')'  AS "Recipes"
FROM   recipe
ORDER  BY cuisine;

--3
SELECT instruction_order AS "Order",
       detail AS "How to make bun bo hue"
FROM   recipe
       NATURAL join recipeinstruction
WHERE  recipe_name LIKE '%bun bo hue%'
ORDER  BY instruction_order;

--4
SELECT INITCAP(recipe_name) AS "Menu",
       serve AS "Serves",
       (SELECT CONCAT(TRUNC(SUM(ir.amount * um.relative_ratio * i.price / 100), 3), ' euro')
        FROM   recipe sub_r
               join (ingredient i
                     join (ingredientrequirement ir
                           join unitofmeasurement um
                             ON( um.unit_name = ir.unit_name ))
                       ON ( i.ingredient_name = ir.ingredient_name ))
                 ON( sub_r.recipe_id = ir.recipe_id )
        WHERE  r.recipe_id = sub_r.recipe_id) AS "Cost",
       cook_time
       || ' minutes' AS "Cook time"
FROM   recipe r
ORDER  BY cook_time; 

--5
SELECT INITCAP(recipe_name) AS "Recipes",(SELECT LISTAGG(TRUNC(amount, 3)
                                                         || ' '
                                                         || unit_name
                                                         || ' '
                                                         || ingredient_name, '; ')
                                                   within GROUP(ORDER BY ingredient_name)
                                          FROM   ingredientrequirement
                                          WHERE  recipe_id = r.recipe_id) AS "Ingredients"
FROM   recipe r
ORDER  BY recipe_name;

--6
SELECT INITCAP(recipe_name)
       || ' ('
       || meal_type
       || ')' AS "How to make",
       INITCAP(cuisine) AS "Cuisine",
       (SELECT LISTAGG(detail)
                 within GROUP(ORDER BY instruction_order)
        FROM   recipe
               NATURAL join recipeinstruction
        WHERE  recipe_id = r.recipe_id) AS "Details"
FROM   recipe r
ORDER  BY cuisine; 

--7
SELECT recipe_name AS "Recipes for vegetarian"
FROM   recipe
WHERE  recipe_id NOT IN (SELECT DISTINCT recipe_id
                         FROM   ingredientrequirement
                         WHERE  ingredient_name IN (SELECT ingredient_name
                                                    FROM   ingredient
                                                    WHERE  ingredient_type LIKE '%meat%'
                                                            OR ingredient_type LIKE '%seafood%'
                                                            OR ingredient_type LIKE '%bone%'))
ORDER  BY recipe_name;
                                                        
--8                                                    
SELECT ir.recipe_id AS "Recipe no",
       INITCAP(i.ingredient_name) AS "Ingredient",
       TRUNC(ir.amount * um.relative_ratio, 3)
       || ' '
       || (SELECT um_1.unit_name
           FROM   unitofmeasurement um_1
           WHERE  um_1.relative_ratio = 1
                  AND um.unit_type LIKE um_1.unit_type) AS "Required amount",
       TRUNC(i.price, 3)
       || ' euro' AS "Price per 100g",
       TRUNC(ir.amount * um.relative_ratio * i.price / 100, 3)
       || ' '
       || 'euro' AS "Real cost"
FROM   ingredient i
       join (ingredientrequirement ir
             join unitofmeasurement um
               ON( um.unit_name = ir.unit_name ))
         ON ( i.ingredient_name = ir.ingredient_name )
ORDER  BY ir.recipe_id; 

--9
SELECT INITCAP(recipe_name) AS "Recipes below given fat",
       serve AS "Serves",
       CONCAT(TRUNC((SELECT SUM(( ir.amount * (SELECT um.relative_ratio
                                               FROM   unitofmeasurement um
                                               WHERE  ir.unit_name = um.unit_name) * (SELECT ne.amount
                                                                                      FROM   nutrientencompassment ne
                                                                                      WHERE  ne.ingredient_name = ir.ingredient_name
                                                                                             AND nutrient_name = 'fat') / 100 ))
                     FROM   ingredientrequirement ir
                     WHERE  recipe_id = r.recipe_id), 2), ' gram') AS "Total fat",
       CONCAT(TRUNC((SELECT SUM(( ir.amount * (SELECT um.relative_ratio
                                               FROM   unitofmeasurement um
                                               WHERE  ir.unit_name = um.unit_name) * (SELECT ne.amount
                                                                                      FROM   nutrientencompassment ne
                                                                                      WHERE  ne.ingredient_name = ir.ingredient_name
                                                                                             AND nutrient_name = 'fat') / ( 100 * r.serve ) ))
                     FROM   ingredientrequirement ir
                     WHERE  recipe_id = r.recipe_id), 2), ' gram') AS "Fat per serve"
FROM   recipe r
WHERE  (SELECT SUM(( ir.amount * (SELECT um.relative_ratio
                                  FROM   unitofmeasurement um
                                  WHERE  ir.unit_name = um.unit_name) * (SELECT ne.amount
                                                                         FROM   nutrientencompassment ne
                                                                         WHERE  ne.ingredient_name = ir.ingredient_name
                                                                                AND nutrient_name = 'fat') / 100 ))
        FROM   ingredientrequirement ir
        WHERE  recipe_id = r.recipe_id) < :input_amount
ORDER  BY recipe_name;
        
--10
SELECT INITCAP(recipe_name) AS "Least used recipes",
       (SELECT COUNT(access_id)
        FROM   recipeaccess
        WHERE  recipe_id = r.recipe_id) AS "Number of accesses"
FROM   recipe r
       join (SELECT DISTINCT recipe_id
             FROM   recipeaccess ra1
             WHERE  (SELECT COUNT(recipe_id)
                     FROM   recipeaccess ra2
                     WHERE  ra1.recipe_id = ra2.recipe_id) = (SELECT MIN((SELECT COUNT(recipe_id)
                                                                          FROM   recipeaccess ra3
                                                                          WHERE  ra3.recipe_id = distinct_ids.recipe_id))
                                                              FROM   (SELECT DISTINCT recipe_id
                                                                      FROM   recipeaccess) distinct_ids)) min_used_ids
         ON ( r.recipe_id = min_used_ids.recipe_id )
ORDER  BY recipe_name; 

--11
SELECT (SELECT LISTAGG(INITCAP(recipe_name), ' ; ') WITHIN GROUP(ORDER BY recipe_name)
        FROM   recipe r
               JOIN (SELECT DISTINCT recipe_id
                     FROM   recipeaccess ra1
                     WHERE  (SELECT COUNT(recipe_id)
                             FROM   recipeaccess ra2
                             WHERE  ra1.recipe_id = ra2.recipe_id) = (SELECT MIN((SELECT COUNT(recipe_id)
                                                                                  FROM   recipeaccess ra3
                                                                                  WHERE  ra3.recipe_id = distinct_ids.recipe_id))
                                                                      FROM   (SELECT DISTINCT recipe_id
                                                                              FROM   recipeaccess) distinct_ids)) min_used_ids
                 ON ( r.recipe_id = min_used_ids.recipe_id )) AS "Least used recipes",
       (SELECT LISTAGG(INITCAP(recipe_name), ' ; ') WITHIN GROUP(ORDER BY recipe_name)
        FROM   recipe r
               JOIN (SELECT DISTINCT recipe_id
                     FROM   recipeaccess ra1
                     WHERE  (SELECT COUNT(recipe_id)
                             FROM   recipeaccess ra2
                             WHERE  ra1.recipe_id = ra2.recipe_id) = (SELECT MAX((SELECT COUNT(recipe_id)
                                                                                  FROM   recipeaccess ra3
                                                                                  WHERE  ra3.recipe_id = distinct_ids.recipe_id))
                                                                      FROM   (SELECT DISTINCT recipe_id
                                                                              FROM   recipeaccess) distinct_ids)) max_used_ids
                 ON ( r.recipe_id = max_used_ids.recipe_id )) AS "Most used recipes"
FROM   DUAL;

--12
WITH thebigtable
     AS (
         --pick the larger one here
        SELECT *
         FROM   nutrientencompassment
         WHERE  ingredient_name = ( CASE
                                      WHEN (SELECT COUNT(nutrient_name)
                                            FROM   nutrientencompassment
                                            WHERE  ingredient_name = :ingredient1) < (SELECT COUNT(nutrient_name)
                                                                                      FROM   nutrientencompassment
                                                                                      WHERE  ingredient_name = :ingredient2) THEN :ingredient2
                                      ELSE :ingredient1
                                    END )),
     thesmalltable
     AS (
        --pick the small one here
        SELECT *
         FROM   nutrientencompassment
         WHERE  ingredient_name = ( CASE
                                      WHEN (SELECT COUNT(nutrient_name)
                                            FROM   nutrientencompassment
                                            WHERE  ingredient_name = :ingredient1) < (SELECT COUNT(nutrient_name)
                                                                                      FROM   nutrientencompassment
                                                                                      WHERE  ingredient_name = :ingredient2) THEN :ingredient1
                                      ELSE :ingredient2
                                    END ))
SELECT thebigtable.nutrient_name
       || ' - '
       || thebigtable.amount
       || ' '
       || thebigtable.unit_name
       || ' ('
       || thebigtable.ingredient_name
       || ')' AS "Nutrients",
       NVL2(thesmalltable.nutrient_name, thesmalltable.nutrient_name
                                         || ' - '
                                         || thesmalltable.amount
                                         || ' '
                                         || thesmalltable.unit_name
                                         || ' ('
                                         || thesmalltable.ingredient_name
                                         || ')', 'not available') AS "Nutrients"
FROM   thebigtable
       left outer join thesmalltable
                    ON ( thebigtable.nutrient_name = thesmalltable.nutrient_name )
ORDER  BY thebigtable.nutrient_name;
                    
--13
SELECT (SELECT LISTAGG(recipe_name
                       || ' ('
                       || (SELECT COUNT(instruction_order)
                           FROM   recipeinstruction ri
                           WHERE  ri.recipe_id = r.recipe_id)
                       || ' steps)', '; ')
                 within GROUP(ORDER BY recipe_name)
        FROM   recipe r
        WHERE  (SELECT COUNT(instruction_order)
                FROM   recipeinstruction ri
                WHERE  ri.recipe_id = r.recipe_id) = (SELECT MIN(instruction_count)
                                                      FROM   (SELECT (SELECT COUNT(instruction_order)
                                                                      FROM   recipeinstruction ri
                                                                      WHERE  ri.recipe_id = r1.recipe_id) AS instruction_count
                                                              FROM   recipe r1) instruction_counts_table)) AS "Recipe with least steps",
       (SELECT LISTAGG(recipe_name
                       || ' ('
                       || (SELECT COUNT(recipe_id)
                           FROM   ingredientrequirement ir
                           WHERE  r.recipe_id = ir.recipe_id)
                       || ' ingredients)', '; ')
                 within GROUP(ORDER BY recipe_name)
        FROM   recipe r
        WHERE  (SELECT COUNT(recipe_id)
                FROM   ingredientrequirement ir
                WHERE  r.recipe_id = ir.recipe_id) = (SELECT MIN(ingredient_count)
                                                      FROM   (SELECT (SELECT COUNT(recipe_id)
                                                                      FROM   ingredientrequirement ir
                                                                      WHERE  r1.recipe_id = ir.recipe_id) AS ingredient_count
                                                              FROM   recipe r1) ingredient_counts_table)) AS "Recipe with least ingredients",
       (SELECT LISTAGG(recipe_name
                       || ' ('
                       || cook_time
                       || ' minutes)', '; ')
                 within GROUP(ORDER BY recipe_name)
        FROM   recipe
        WHERE  cook_time = (SELECT MIN(cook_time)
                            FROM   recipe r)) AS "Recipes with lowest cook time"
FROM   dual;

--14
SELECT INITCAP(first_name)
       || ' '
       || INITCAP(last_name) AS "Hardworking staffs"
FROM   restaurantstaff rs
WHERE  (SELECT COUNT(staff_id)
        FROM   recipeaccess ra
        WHERE  ra.staff_id = rs.staff_id) = (SELECT MAX(access_counts)
                                             FROM   (SELECT (SELECT COUNT(staff_id)
                                                             FROM   recipeaccess ra
                                                             WHERE  ra.staff_id = rs1.staff_id) AS access_counts
                                                     FROM   restaurantstaff rs1) access_counts_table)
ORDER  BY last_name;