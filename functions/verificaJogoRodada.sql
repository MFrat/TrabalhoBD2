create or REPLACE function verifica_jogo_rodada() returns trigger
LANGUAGE plpgsql
AS $$
DECLARE
  cur CURSOR FOR SELECT * FROM "cartolaFC".partida WHERE idrodada = NEW.idrodada;
BEGIN
  FOR i IN cur LOOP
    IF i.idtime2 = NEW.idTime1 OR i.idtime1 = NEW.idTime2 THEN
      RAISE EXCEPTION 'Esse time já possui uma partida nessa rodada';
    END IF;
  END LOOP;

  RETURN NEW;
END;
$$;
