create or REPLACE function verifica_cartoes() returns trigger
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.cartaovermelho > 1 THEN
    RAISE EXCEPTION 'Não pode haver mais de 1 cartão vermelho';
  END IF;

  IF NEW.cartaoamarelo > 2 THEN
    RAISE EXCEPTION 'Não pode haver mais de 2 cartões amarelos';
  END IF;

  RETURN NEW;
END;
$$;
