BEGIN;

-- Insérer un nouvel utilisateur
INSERT INTO public.users (username, email) VALUES ('new user', 'newuser@gmail.com');
-- Récupérer l'ID de l'utilisateur nouvellement créé
SELECT id INTO NEW_USER_ID FROM public.users WHERE username = 'new user';

-- Insérer une image dans la galerie associée au nouvel utilisateur
INSERT INTO gallery.images (title, description, url) VALUES ('new image', 'lorem ipsum', 'https://loremispum.com/img.jpg');
-- Récupérer l'ID de l'image nouvellement créée
SELECT id INTO NEW_IMAGE_ID FROM gallery.images WHERE title = 'new image';

-- Associer l'image à l'utilisateur
UPDATE public.users SET image_id = NEW_IMAGE_ID WHERE id = NEW_USER_ID;

COMMIT;
