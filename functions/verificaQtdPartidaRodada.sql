create or replace function verifica_qtd_partida_rodada() returns trigger
LANGUAGE plpgsql
AS $$
DECLARE
  nJogos INTEGER;
BEGIN
  SELECT COUNT(*) INTO nJogos
  FROM "cartolaFC".partida
  WHERE idrodada = NEW.idRodada;

  IF nJogos > 10 THEN
    RAISE EXCEPTION 'Não pode haver mais de 20 partidas por rodada';
  END IF;

  RETURN NEW;
END;
$$;
