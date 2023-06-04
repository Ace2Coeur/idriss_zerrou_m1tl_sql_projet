-- Création du schéma "gallery"
CREATE SCHEMA gallery;

-- Création des tables dans le schéma "gallery"
CREATE TABLE gallery.images (
  id SERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  description TEXT,
  url VARCHAR(255) NOT NULL
);

-- Création du schéma "forum"
CREATE SCHEMA forum;

-- Création des tables dans le schéma "forum"
CREATE TABLE forum.posts (
  id SERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  content TEXT,
  user_id INT REFERENCES public.users(id)
);

-- Création du schéma "shop"
CREATE SCHEMA shop;

-- Création des tables dans le schéma "shop"
CREATE TABLE shop.products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  price DECIMAL(10, 2) NOT NULL
);

-- Création du schéma "public" (partagé entre toutes les applications)
CREATE SCHEMA public;

-- Création des tables partagées dans le schéma "public"
CREATE TABLE public.users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL
);

-- Création des relations entre les tables
-- Relation One-to-One entre users et gallery.images
ALTER TABLE public.users ADD COLUMN image_id INT REFERENCES gallery.images(id);

-- Relation Many-to-One entre users et forum.posts
ALTER TABLE forum.posts ADD COLUMN user_id INT REFERENCES public.users(id);

-- Relation Many-to-Many entre users et shop.products
CREATE TABLE public.user_products (
  user_id INT REFERENCES public.users(id),
  product_id INT REFERENCES shop.products(id),
  PRIMARY KEY (user_id, product_id)
);

-- Création d'une vue
CREATE VIEW public.active_users AS
SELECT * FROM public.users WHERE last_login >= now() - interval '1 month';

-- Création d'un type ou d'un domaine
CREATE DOMAIN public.status AS VARCHAR(20) CHECK (VALUE IN ('active', 'inactive'));

-- Création d'un trigger
CREATE OR REPLACE FUNCTION public.update_user_status()
RETURNS TRIGGER AS $$
BEGIN
  IF (NEW.last_login IS NULL) THEN
    NEW.status = 'inactive';
  ELSE
    NEW.status = 'active';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_user_status_trigger
BEFORE INSERT OR UPDATE ON public.users
FOR EACH ROW EXECUTE FUNCTION public.update_user_status();

-- Création d'une fonction (routine)
CREATE OR REPLACE FUNCTION public.get_total_price(user_id INT)
RETURNS DECIMAL(10, 2) AS $$
DECLARE
  total DECIMAL(10, 2);
BEGIN
  SELECT SUM(price) INTO total FROM shop.products
  JOIN public.user_products ON shop.products.id = public.user_products.product_id
  WHERE public.user_products.user_id = user_id;
  RETURN total;
END;
$$ LANGUAGE plpgsql;
