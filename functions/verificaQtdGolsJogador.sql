create or replace function verifica_qtd_gols_jogador() returns trigger
LANGUAGE plpgsql
AS $$
DECLARE
  idTimeJogador INTEGER;
  nGolsJogadores INTEGER := 0;
  nGols1 INTEGER := 0;
  nGols2 INTEGER := 0;
BEGIN
  SELECT "idTime" INTO idTimeJogador
  FROM "cartolaFC".jogador
  WHERE "idJogador" = NEW.idjogador;

  SELECT SUM(numerogols) INTO nGolsJogadores
  FROM "cartolaFC".estatisticas_jogador
  JOIN "cartolaFC".jogador ON "cartolaFC".jogador."idJogador" = "cartolaFC".estatisticas_jogador.idjogador
  WHERE "idTime" = idTimeJogador
  GROUP BY "idTime";

  SELECT golstime1 INTO nGols1
  FROM "cartolaFC".partida partida
  JOIN "cartolaFC".time time ON partida.idtime1 = time."idTime"
  WHERE idpartida = NEW.idpartida;

  SELECT golstime2 INTO nGols2
  FROM "cartolaFC".partida partida
  JOIN "cartolaFC".time time ON partida.idtime2 = time."idTime"
  WHERE idpartida = NEW.idpartida AND time."idTime" = idTimeJogador;

  IF nGols1 IS NULL THEN
    nGols1 := 0;
  END IF;

  IF nGols2 IS NULL THEN
    nGols2 := 0;
  END IF;

  IF nGolsJogadores > (nGols1 + nGols2) THEN
    RAISE EXCEPTION 'Número de gols dos jogadores não pode exceder o número de gols que o time fez na partida.';
  END IF;

  RETURN NEW;
END;
$$;
