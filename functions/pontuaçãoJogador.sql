create or REPLACE function pontuacao_jogador() returns trigger
LANGUAGE plpgsql
AS $$
DECLARE
  pontos INTEGER := 0;
BEGIN
  pontos := pontos - NEW.cartaoamarelo * 2;
  pontos := pontos - NEW.cartaovermelho * 4;
  pontos := pontos + NEW.chutesgol;
  pontos := pontos + NEW.numerogols * 6;
  pontos := pontos - NEW.faltascometidas;
  pontos := pontos + NEW.roubadasbola;
  pontos := pontos + NEW.defesapenalti * 6;
  pontos := pontos + NEW.defesas * 2;

  IF(TG_OP = 'INSERT') THEN
    INSERT INTO "cartolaFC".pontuacao_jogador(pontuacao, idrodada, idjogador) VALUES (pontos, NEW.idpartida, NEW.idjogador);
  END IF;

  IF(TG_OP = 'UPDATE') THEN
    UPDATE "cartolaFC".pontuacao_jogador SET pontuacao = pontos, idrodada = NEW.idpartida, idjogador = NEW.idjogador
    WHERE idrodada = OLD.idpartida AND idjogador = OLD.idjogador;
  END IF;

  RETURN NEW;
END;
$$;
