CREATE OR REPLACE FUNCTION status_jogador() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO "cartolaFC".status_jogador("idJogador", status) VALUES (NEW."idJogador", 0);
    RETURN NEW;
END;
$$;
