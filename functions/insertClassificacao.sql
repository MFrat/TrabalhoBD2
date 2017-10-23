create or replace function insert_classificacao() returns trigger
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO "cartolaFC".classificacao(pontos, "nJogos", vitorias, empates, derrotas, "idTime") VALUES
    (0, 0, 0, 0, 0, NEW."idTime");

  return NULL;
END;
$$;