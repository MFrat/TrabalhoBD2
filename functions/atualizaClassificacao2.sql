create or replace function atualiza_classificacao2() returns trigger
LANGUAGE plpgsql
AS $$
DECLARE
  nPontos INTEGER := 0;
  nVitorias INTEGER := 0;
  nEmpates INTEGER := 0;
  nDerrotas INTEGER := 0;
BEGIN
  SELECT pontos, vitorias, empates, derrotas INTO nPontos, nVitorias, nEmpates, nDerrotas
  FROM "cartolaFC".classificacao
  WHERE "idTime" = NEW.idtime2;

  IF NEW.golstime2 > NEW.golstime1 THEN
    nPontos := nPontos + 3;
    nVitorias := nVitorias + 1;
    nEmpates := nEmpates + 0;
    nDerrotas := nDerrotas + 0;
  ELSEIF NEW.golstime2 < NEW.golstime1 THEN
    nPontos := nPontos + 0;
    nVitorias := nVitorias + 0;
    nEmpates := nEmpates + 0;
    nDerrotas := nDerrotas + 1;
  ELSE
    nPontos := nPontos + 1;
    nVitorias := nVitorias + 0;
    nEmpates := nEmpates + 1;
    nDerrotas := nDerrotas + 0;
  END IF;

  UPDATE "cartolaFC".classificacao SET
    pontos =  nPontos,
    empates = nEmpates,
    vitorias =  nVitorias,
    derrotas = nDerrotas,
    "nJogos" =  "cartolaFC".classificacao."nJogos" + 1
  WHERE "idTime" = NEW.idtime2;

  RETURN NEW;
END;
$$;
