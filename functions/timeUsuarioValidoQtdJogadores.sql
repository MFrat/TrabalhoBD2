create or replace function time_usuario_valido_qtd_jogadores() returns trigger
LANGUAGE plpgsql
AS $$
DECLARE
  nZag INTEGER := 0;
  nMeia INTEGER := 0;
  nAta INTEGER := 0;
  nGol INTEGER := 0;
  cur CURSOR FOR SELECT * FROM "cartolaFC".jogador_time_usuario WHERE "idTimeUsuario" = NEW."idTimeUsuario";
  nZagF INTEGER;
  nMeiaF INTEGER;
  nAtaF INTEGER;
  pos VARCHAR(100);
  posNew VARCHAR(100);
BEGIN
  SELECT posicao INTO posNew
  FROM "cartolaFC".jogador
  WHERE NEW."idJogador" = "idJogador";

  FOR i IN cur LOOP
    SELECT posicao INTO pos
    FROM "cartolaFC".jogador
    WHERE i."idJogador" = "idJogador";

    IF pos = 'Zagueiro' OR posNew = 'Zagueiro' THEN
      nZag := nZag + 1;
    END IF;

    IF pos = 'Atacante' OR posNew = 'Atacante' THEN
      nAta := nAta + 1;
    END IF;

    IF pos = 'Meio-Campo' OR posNew = 'Meio-Campo' THEN
      nMeia := nMeia + 1;
    END IF;

    IF pos = 'Goleiro' OR posNew = 'Goleiro' THEN
      nGol := nGol + 1;
    END IF;
  END LOOP;

  IF nGol > 1 THEN
    RAISE EXCEPTION 'Não pode haver mais de um goleiro';
  END IF;

  SELECT "nZagueiros", "nMeias", "nAtacantes" INTO nZagF, nMeiaF, nAtaF
  FROM "cartolaFC".time_usuario
  NATURAL JOIN "cartolaFC".jogador_time_usuario
  NATURAL JOIN "cartolaFC".formacao
  WHERE NEW."idTimeUsuario" = "idTimeUsuario";

  IF nZag > nZagF THEN
    RAISE EXCEPTION 'Numero de zagueiro ultrapassou o numero da sua formação';
  END IF;

  IF nMeia > nMeiaF THEN
    RAISE EXCEPTION 'Numero de meias ultrapassou o numero da sua formação';
  END IF;

  IF nAta > nAtaF THEN
    RAISE EXCEPTION 'Numero de atacantes ultrapassou o numero da sua formação';
  END IF;

  RETURN NEW;

END;
$$;
