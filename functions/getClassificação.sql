create function get_classificacao(idcamp integer) returns TABLE(equipe character varying, njogos integer, vitorias integer, empates integer, derrotas integer, pontos integer)
LANGUAGE plpgsql
AS $$
DECLARE
  cTimes CURSOR FOR
    SELECT DISTINCT equipe.*
    FROM "cartolaFC".partida
    JOIN "cartolaFC".time as equipe ON idtime1 = equipe."idTime" OR idtime2 = equipe."idTime"
    NATURAL JOIN "cartolaFC".rodada
    WHERE "cartolaFC".rodada.idcampeonato = idCamp;

  cPartidas CURSOR (idTime INTEGER) FOR SELECT "cartolaFC".partida.*
                     FROM "cartolaFC".partida
                     NATURAL JOIN "cartolaFC".rodada
                     WHERE (idtime1 = idTime OR idtime2 = idTime) AND idcampeonato = idCamp;

  nVitorias INTEGER := 0;
  nEmpates INTEGER := 0;
  nDerrotas INTEGER := 0;
  pontos INTEGER := 0;
BEGIN

  FOR iTime IN cTimes LOOP

    nVitorias := 0;
    nEmpates := 0;
    nDerrotas := 0;
    FOR iPartida IN cPartidas(iTime."idTime") LOOP
      IF iPartida.idTime1 = iTime."idTime" THEN
        IF iPartida."golstime1" > iPartida."golstime2" THEN
          nVitorias := nVitorias + 1;
        ELSIF iPartida."golstime1" < iPartida."golstime2" THEN
          nDerrotas := nDerrotas + 1;
        ELSE
          nEmpates := nEmpates + 1;
        END IF;

      ELSE
        IF iPartida."golstime1" > iPartida."golstime2" THEN
          nDerrotas := nDerrotas + 1;
        ELSIF iPartida."golstime1" < iPartida."golstime2" THEN
          nVitorias := nVitorias + 1;
        ELSE
          nEmpates := nEmpates + 1;
        END IF;

      END IF;

    END LOOP;

    pontos := nVitorias*3 + nEmpates;

    RETURN QUERY SELECT iTime.nome, nVitorias + nEmpates + nDerrotas, nVitorias, nEmpates, nDerrotas, pontos;
  END LOOP;

END;
$$;
