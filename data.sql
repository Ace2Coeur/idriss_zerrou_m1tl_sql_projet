-- Insérer des données dans la table gallery.images
INSERT INTO gallery.images (title, description, url) VALUES
  ('Image1', 'lorem ipsum', 'https://exemple.com/image.jpg'),
  ('Image2', 'lorem ipsum', 'https://exemple.com/image2.jpg');

-- Insérer des données dans la table forum.posts
INSERT INTO forum.posts (title, content, user_id) VALUES
  ('first message', 'Lorem ipsum', 1),
  ('second message', 'Lorem ipsum', 2);

-- Insérer des données dans la table shop.products
INSERT INTO shop.products (name, price) VALUES
  ('product1', 10.99),
  ('product2', 19.99),
  ('product3', 5.99);

-- Insérer des données dans la table public.users
INSERT INTO public.users (username, email) VALUES
  ('user1', 'user@gmail.com'),
  ('user2', 'user2@gmail.com');

-- Insérer des données dans la table public.user_products (relation Many-to-Many)
INSERT INTO public.user_products (user_id, product_id) VALUES
  (1, 1),
  (1, 2),
  (2, 3);
