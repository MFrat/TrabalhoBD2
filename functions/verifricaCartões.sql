create or REPLACE function verifica_cartoes() returns trigger
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.cartaovermelho > 1 THEN
    RAISE EXCEPTION 'N�o pode haver mais de 1 cart�o vermelho';
  END IF;

  IF NEW.cartaoamarelo > 2 THEN
    RAISE EXCEPTION 'N�o pode haver mais de 2 cart�es amarelos';
  END IF;

  RETURN NEW;
END;
$$;
