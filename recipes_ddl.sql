--DDL
--Creating tables, including CONSTRAINTS
CREATE TABLE RestaurantStaff(
    staff_id NUMBER(4,0), 
    first_name VARCHAR2(15), 
    last_name VARCHAR2(15) NOT NULL, 
    chef_id NUMBER(4,0),
    CONSTRAINT rstaff_staff_id_pk PRIMARY KEY (staff_id),
    CONSTRAINT rstaff_chef_id_fk FOREIGN KEY (chef_id) REFERENCES restaurantstaff(staff_id),
    CONSTRAINT rstaff_staff_id_chk CHECK(staff_id NOT LIKE chef_id)
);

CREATE TABLE recipe(
    recipe_id NUMBER(6,0),
    name VARCHAR2(30) NOT NULL,
    sample_image BLOB,
    date_added DATE DEFAULT SYSDATE NOT NULL,
    meal_type VARCHAR2(20),
    cuisine VARCHAR2(20) DEFAULT 'unknown',
    cook_time NUMBER(3,0),
    CONSTRAINT recipe_recipe_id_pk PRIMARY KEY(recipe_id)
);

CREATE TABLE recipeaccess(
    staff_id NUMBER(4,0),
    recipe_id NUMBER(6,0),
    access_time DATE NOT NULL,
    CONSTRAINT r_access_staff_id_recipe_id_pk PRIMARY KEY (staff_id,recipe_id),
    CONSTRAINT r_access_staff_id_fk FOREIGN KEY(staff_id) REFERENCES restaurantstaff(staff_id),
    CONSTRAINT r_access_recipe_id_fk FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id)
);

CREATE TABLE recipeinstruction(
    instruction_id NUMBER(10,0), 
    detail VARCHAR2(300) NOT NULL, 
    instruction_order NUMBER(3,0) NOT NULL, 
    recipe_id NUMBER(6,0) NOT NULL,
    CONSTRAINT r_instr_instruction_id_pk PRIMARY KEY(instruction_id),
    CONSTRAINT r_instr_recipe_id_fk FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id)
);

CREATE TABLE unitofmeasurement(
    unit_name VARCHAR2(20),
    relative_ratio NUMBER(5,5) NOT NULL, 
    unit_type VARCHAR2(10) NOT NULL,
    CONSTRAINT uom_unit_name_pk PRIMARY KEY(unit_name)
);


CREATE TABLE ingredient(
    ingredient_name VARCHAR2(40), 
    type VARCHAR2(15), 
    price NUMBER(4,2),
    CONSTRAINT ingre_ingredient_name_pk PRIMARY KEY(ingredient_name)
);

CREATE TABLE ingredientrequirement(
    recipe_id NUMBER(6,0), 
    ingredient_name VARCHAR2(40),
    amount NUMBER(4,4) NOT NULL, 
    unit_name VARCHAR2(20) NOT NULL,
    CONSTRAINT ingrereq_rec_id_ingre_name_pk PRIMARY KEY(recipe_id,ingredient_name),
    CONSTRAINT ingrereq_rec_id_fk FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id),
    CONSTRAINT ingrereq_ingre_name_fk FOREIGN KEY(ingredient_name) REFERENCES ingredient(ingredient_name),
    CONSTRAINT ingrereq_unit_name_fk FOREIGN KEY(unit_name) REFERENCES unitofmeasurement(unit_name)
);

CREATE TABLE nutrient(
    nutrient_name VARCHAR2(20),
    CONSTRAINT nutr_nutrient_name_pk PRIMARY KEY(nutrient_name)
);

CREATE TABLE nutrientencompassment(
    ingredient_name VARCHAR2(40), 
    nutrient_name VARCHAR2(20), 
    unit_name VARCHAR2(20) NOT NULL,
    amount NUMBER(4,4) NOT NULL,
    CONSTRAINT nutrenc_ingre_nutr_pk PRIMARY KEY(ingredient_name,nutrient_name),
    CONSTRAINT nutrenc_ingre_name_fk FOREIGN KEY(ingredient_name) REFERENCES ingredient(ingredient_name),
    CONSTRAINT nutrenc_nutrient_name_fk FOREIGN KEY(nutrient_name) REFERENCES nutrient(nutrient_name),
    CONSTRAINT nutrenc_unit_name_fk FOREIGN KEY(unit_name) REFERENCES unitofmeasurement(unit_name)
);

--auto increment for ids
CREATE SEQUENCE 
recipe_seq
START WITH 1 
INCREMENT by 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE 
recipeinstruction_seq
START WITH 1 
INCREMENT by 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER recipe_seq_trg
    BEFORE INSERT ON recipe FOR EACH ROW
    WHEN(NEW.recipe_id IS NULL)
    BEGIN
        SELECT recipe_seq.NEXTVAL INTO :NEW.recipe_id FROM DUAL;
    END;
/

CREATE OR REPLACE TRIGGER recipeinstruction_seq_trg
    BEFORE INSERT ON recipeinstruction FOR EACH ROW
    WHEN(NEW.instruction_id IS NULL)
    BEGIN
        SELECT recipeinstruction_seq.NEXTVAL INTO :NEW.instruction_id FROM DUAL;
    END;
/
