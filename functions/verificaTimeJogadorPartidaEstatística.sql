create or REPLACE function verifica_time_jogador_partida_estatistica() returns trigger
LANGUAGE plpgsql
AS $$
DECLARE
  idTimeJogador INTEGER;
  time1 INTEGER;
  time2 INTEGER;
BEGIN
  SELECT "idTime" INTO idTimeJogador
  FROM "cartolaFC".jogador jogador
  WHERE jogador."idJogador" = NEW.idjogador;

  SELECT partida.idtime1, partida.idtime2 INTO time1, time2
  FROM "cartolaFC".partida partida
  WHERE partida.idpartida = NEW.idpartida;

  IF idTimeJogador <> time1 AND idTimeJogador <> time2 THEN
    RAISE EXCEPTION 'Não pode haver estatísticas de um jogador para uma partida na qual seu time não esteja envolvido';
  END IF;

  RETURN NEW;
END;
$$;
