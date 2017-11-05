create or replace function time_usuario_valido("time" integer) returns boolean
LANGUAGE plpgsql
AS $$
DECLARE
  nMeias INTEGER := 0;
  nZagueiros INTEGER := 0;
  nAtacantes INTEGER := 0;
  nMeiasFormacao INTEGER := 0;
  nZagueirosFormacao INTEGER := 0;
  nAtacantesFormacao INTEGER := 0;
  nGoleiros INTEGER := 0;

BEGIN
  SELECT "nMeias" INTO nMeiasFormacao FROM "cartolaFC".formacao NATURAL JOIN "cartolaFC".time_usuario;
  SELECT "nZagueiros" INTO nZagueirosFormacao FROM "cartolaFC".formacao NATURAL JOIN "cartolaFC".time_usuario;
  SELECT "nAtacantes" INTO nAtacantesFormacao FROM "cartolaFC".formacao NATURAL JOIN "cartolaFC".time_usuario;

  IF NOT EXISTS(SELECT * FROM "cartolaFC".time_usuario WHERE "idTimeUsuario" = "time") THEN
    RETURN FALSE;
  END IF;

  SELECT COUNT(*) INTO nGoleiros
  FROM "cartolaFC".time_usuario NATURAL JOIN "cartolaFC".jogador_time_usuario
  NATURAL JOIN "cartolaFC".jogador
  WHERE "cartolaFC".time_usuario."idTimeUsuario" = "time" AND "cartolaFC".jogador.posicao = 'Goleiro'
  GROUP BY posicao;

  IF nGoleiros <> 1 THEN
    RETURN FALSE;
  END IF;

  SELECT COUNT(*) INTO nMeias
  FROM "cartolaFC".time_usuario NATURAL JOIN "cartolaFC".jogador_time_usuario
  NATURAL JOIN "cartolaFC".jogador
  WHERE "cartolaFC".time_usuario."idTimeUsuario" = "time" AND "cartolaFC".jogador.posicao = 'Meio-Campo'
  GROUP BY posicao;

  IF nMeias <> nMeiasFormacao THEN
    RETURN FALSE;
  END IF;

  SELECT COUNT(*) INTO nZagueiros
  FROM "cartolaFC".time_usuario NATURAL JOIN "cartolaFC".jogador_time_usuario
  NATURAL JOIN "cartolaFC".jogador
  WHERE "cartolaFC".time_usuario."idTimeUsuario" = "time" AND "cartolaFC".jogador.posicao = 'Zagueiro'
  GROUP BY posicao;

  IF nZagueiros <> nZagueirosFormacao THEN
    RETURN FALSE;
  END IF;

  SELECT COUNT(*) INTO nAtacantes
  FROM "cartolaFC".time_usuario NATURAL JOIN "cartolaFC".jogador_time_usuario
  NATURAL JOIN "cartolaFC".jogador
  WHERE "cartolaFC".time_usuario."idTimeUsuario" = "time" AND "cartolaFC".jogador.posicao = 'Atacante'
  GROUP BY posicao;

  IF nAtacantes <> nAtacantesFormacao THEN
    RETURN FALSE;
  END IF;

  RETURN TRUE;
END;
$$;
