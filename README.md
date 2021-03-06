# CartolaFC

1. [Visão Geral](#visão-geral)
2. [Modelo](#modelo)
    1. [Diagrama de relacionamento](#diagrama-de-relacionamento)
    2. [Modelo lógico](#modelo-lógico)
3. [Regras de negócio](#regras-de-negócio)
    1. [Da Tabela Partida](#da-tabela-partida)
    2. [Da Tabela Rodada](#da-tabela-rodada)
    3. [Da Tabela JogadorTimeUsuario](#da-tabela-jogadortimeusuario)
    4. [Da Tabela Jogador](#da-tabela-jogador)
    5. [Da Tabela Pontuação do Jogador](#da-tabela-pontuação-do-jogador)
    6. [Da Tabela Estatísticas do Jogador](#da-tabela-estatísticas-do-jogador)
    7. [Da Tabela Status do Jogador](#da-tabela-status-do-jogador)
    8. [Da tabela Preco do Jogador](#da-tabela-preco-do-jogador)
4. [Outras consultas](#outras-consultas)
    1. [Classificação de um campeonato](#classificação-do-campeonato)
    2. [Pontuação do time de um usuário](#pontuação-do-time-de-um-usuário)
    3. [Classificação dos usuários](#classificação-dos-usuários)

## Visão Geral
Modelagem, simplificada, das relações das entidades e regras de negócios do CartolaFC do Globoesporte.com.

## Modelo

### Diagrama de relacionamento

<p align="center">
  <img src="https://i.imgur.com/yoPlsCR.jpg" width="900"/>
</p>

### Modelo lógico
<p align="center">
  <img src="https://i.imgur.com/zh2nTHR.png" width="900"/>
</p>

## Regras de negócio
### Da Tabela Partida
- Um time só pode ter uma partida por rodada de um campeonato.
``` plpgsql
CREATE TRIGGER verifica_partida
BEFORE INSERT OR UPDATE
  ON partida
FOR EACH ROW
EXECUTE PROCEDURE verifica_jogo_rodada();
```

``` plpgsql
create or REPLACE function verifica_jogo_rodada() returns trigger
LANGUAGE plpgsql
AS $$
DECLARE
  cur CURSOR FOR SELECT * FROM "cartolaFC".partida WHERE idrodada = NEW.idrodada;
BEGIN
  FOR i IN cur LOOP
    IF i.idtime2 = NEW.idTime1 OR i.idtime1 = NEW.idTime2 THEN
      RAISE EXCEPTION 'Esse time já possui uma partida nessa rodada';
    END IF;
  END LOOP;

  RETURN NEW;
END;
$$;
```
- Só podem haver 10 partidas por rodada.
``` plpgsql
CREATE TRIGGER verifica_qtd_partidas
BEFORE INSERT
  ON partida
FOR EACH ROW
EXECUTE PROCEDURE verifica_qtd_partida_rodada();
```
```plpgsql
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
```

### Da Tabela Rodada
- Só pode haver uma rodada de um campeonato por data.
``` plpgsql
unique_index_rodada UNIQUE INDEX rodada (data ASC, idcampeonato ASC)
```

### Da Tabela JogadorTimeUsuario
- Um time de um usuário não pode conter o mesmo jogador duas vezes
``` plpgsql
create unique index jogador_time_usuario_idjogador_idtimeusuario_uindex on jogador_time_usuario ("idJogador", "idTimeUsuario");
```

- O número de jogadores em cada posição não pode exceder ao número imposto pela formação do time escolhida pelo usuário.
``` plpgsql
CREATE TRIGGER trigger_verificia_time_usuario_formacao
BEFORE INSERT
  ON jogador_time_usuario
FOR EACH ROW
EXECUTE PROCEDURE time_usuario_valido_qtd_jogadores();
```
```plpgsql
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
```

### Da Tabela Pontuação do Jogador
- Sempre que houver uma inserção ou atualização de uma tupla, calcular e inserir ou atualizar o preço do jogador em uma partida.
``` plpgsql
CREATE TRIGGER trigger_atualiza_preco_jogador
AFTER INSERT OR UPDATE
  ON pontuacao_jogador
FOR EACH ROW
EXECUTE PROCEDURE atualiza_preco_jogador();
```

``` plpgsql
create or REPLACE function atualiza_preco_jogador() returns trigger
LANGUAGE plpgsql
AS $$
BEGIN
  IF TG_OP = 'UPDATE' THEN
    UPDATE "cartolaFC".preco_jogador SET preco = (NEW.pontuacao * 2)
    WHERE idpartida = NEW.idpartida AND idjogador = NEW.idjogador;
  ELSEIF TG_OP = 'INSERT' THEN
    INSERT INTO "cartolaFC".preco_jogador(idjogador, idpartida, preco) VALUES (NEW.idjogador, NEW.idpartida, (NEW.pontuacao * 2));
  END IF;

  RETURN NEW;
END;
$$;
```

### Da Tabela Estatísticas do jogador
- Um jogador só pode ter uma estatística por partida
``` plpgsql
unique index estatisticas_jogador_idjogador_idrodada_uindex on estatisticas_jogador (idjogador, idpartida);
```

- A cada inserção de tupla na tabela de Estatísticas do Jogador a respectiva pontuação deve ser calculada.
``` plpgsql
CREATE TRIGGER trigger_pontuacao_jogador
BEFORE INSERT OR UPDATE
  ON estatisticas_jogador
FOR EACH ROW
EXECUTE PROCEDURE pontuacao_jogador();
```

``` plpgsql
CREATE OR REPLACE FUNCTION pontuacao_jogador() RETURNS TRIGGER
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
    INSERT INTO "cartolaFC".pontuacao_jogador(pontuacao, idrodada, idjogador) VALUES (pontos, NEW.idrodada, NEW.idjogador);
  END IF;

  IF(TG_OP = 'UPDATE') THEN
    UPDATE "cartolaFC".pontuacao_jogador SET pontuacao = pontos, idrodada = NEW.idrodada, idjogador = NEW.idjogador
    WHERE idrodada = OLD.idrodada AND idjogador = OLD.idjogador;
  END IF;

  RETURN NEW;
END;
$$;
```
- Sempre que houver uma inserção ou atualização em alguma tupla, verificar se o somátorio do número de gols de todos os jogadores de um dado time excedeu o número de gols que esse time fez na partida.
``` plpgsql
CREATE TRIGGER trigger_qtd_gols_jogador
AFTER INSERT OR UPDATE
  ON estatisticas_jogador
FOR EACH ROW
EXECUTE PROCEDURE verifica_qtd_gols_jogador();
```
``` plpgsql
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
  WHERE "idTime" = idTimeJogador and "cartolaFC".estatisticas_jogador.idpartida = NEW.idpartida
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
```
- Não pode haver mais de um cartão vermelho e nem mais de dois amarelos.
``` plpgsql
CREATE TRIGGER trigger_verifica_cartoes
BEFORE INSERT OR UPDATE
  ON estatisticas_jogador
FOR EACH ROW
EXECUTE PROCEDURE verifica_cartoes();
```
``` plpgsql
create or REPLACE function verifica_cartoes() returns trigger
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.cartaovermelho > 1 THEN
    RAISE EXCEPTION 'Não pode haver mais de 1 cartão vermelho';
  END IF;

  IF NEW.cartaoamarelo > 2 THEN
    RAISE EXCEPTION 'Não pode haver mais de 2 cartões amarelos';
  END IF;

  RETURN NEW;
END;
$$;
```
- Um jogador só pode ter uma estatística se a partida na qual a estatística está ligada envolveu o seu time.
``` plpgsql
CREATE TRIGGER trigger_verifica_time_jogador_partida_estatistica
BEFORE INSERT OR UPDATE
  ON estatisticas_jogador
FOR EACH ROW
EXECUTE PROCEDURE verifica_time_jogador_partida_estatistica();
```
``` plpgsql
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
```

### Da Tabela Status do Jogador
- Um jogador não pode ter um status para um partida na qual seu time não está envolvido.
``` plpgsql
CREATE TRIGGER trigger_verifica_partida_status_jogador
BEFORE INSERT OR UPDATE
  ON status_jogador
FOR EACH ROW
EXECUTE PROCEDURE verifica_partida_status_jogador();
```

``` plpgsql
create or REPLACE function verifica_partida_status_jogador() returns trigger
LANGUAGE plpgsql
AS $$
DECLARE
  idTimeJogador INTEGER;
  time1 INTEGER;
  time2 INTEGER;
BEGIN
  SELECT "idTime" INTO idTimeJogador
  FROM "cartolaFC".jogador jogador
  WHERE jogador."idJogador" = NEW."idJogador";

  SELECT partida.idtime1, partida.idtime2 INTO time1, time2
  FROM "cartolaFC".partida partida
  WHERE partida.idpartida = NEW.idpartida;

  IF idTimeJogador <> time1 AND idTimeJogador <> time2 THEN
    RAISE EXCEPTION 'Não pode haver status de um jogador para uma partida na qual seu time não esteja envolvido';
  END IF;

  RETURN NEW;
END;
$$;
```

### Da Tabela Preco do Jogador
- Um jogador só pode ter um preco por partida.
`CREATE UNIQUE INDEX preco_jogador_idjogador_idpartida_uindex ON preco_jogador (idjogador, idpartida);`

## Outras consultas

### Classificação do campeonato
``` plpgsql
CREATE OR REPLACE FUNCTION get_classificacao(idCamp INTEGER) RETURNS
TABLE(equipe VARCHAR,
  nJogos INTEGER,
  vitorias INTEGER,
  empates INTEGER,
  derrotas INTEGER,
  pontos INTEGER) AS
$$
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
$$
LANGUAGE 'plpgsql';
```

### Pontuação do time de um usuário
A pontuação do time do usuário só leva em consideração os jogadores que não possuem status(machucado, suspenso e etc) para uma partida de uma rodada.
``` plpgsql
create or replace function pontuacao_time_usuario(timeusuario integer, rodada integer) returns integer
LANGUAGE plpgsql
AS $$
DECLARE
  pont INTEGER := 0;
  cJogador CURSOR FOR SELECT * FROM "cartolaFC".jogador_time_usuario WHERE "idTimeUsuario" = timeusuario;
  fPontuacao INTEGER := 0;
BEGIN

  FOR j IN cJogador LOOP
    IF NOT EXISTS(SELECT 1
      FROM "cartolaFC".jogador JOIN "cartolaFC".status_jogador ON "cartolaFC".jogador."idJogador" = "cartolaFC".status_jogador."idJogador"
      WHERE "cartolaFC".jogador."idJogador" = j."idJogador") THEN

      SELECT "cartolaFC".pontuacao_jogador.pontuacao INTO pont
      FROM "cartolaFC".pontuacao_jogador NATURAL JOIN "cartolaFC".partida
      WHERE "cartolaFC".pontuacao_jogador.idjogador = j."idJogador" AND "cartolaFC".partida.idrodada = rodada;

      IF NOT pont ISNULL THEN
        fPontuacao := fPontuacao + pont;
      END IF;
    END IF;
  END LOOP;

  RETURN fPontuacao;
END;
$$;
```

### Classificação dos usuários
``` plpgsql
CREATE OR REPLACE FUNCTION "cartolaFC".classificacaoUsuario(camp INTEGER) RETURNS TABLE(
idUsuario INTEGER, pontuacao INTEGER
) LANGUAGE plpgsql
AS
$$
DECLARE
  cUsuario CURSOR FOR SELECT * FROM "cartolaFC".usuario;
  cPartida CURSOR FOR SELECT * FROM "cartolaFC".partida NATURAL JOIN "cartolaFC".rodada WHERE "cartolaFC".rodada.idcampeonato = camp;
  uPont INTEGER := 0;
BEGIN
  for i IN cUsuario LOOP
    for j IN cPartida LOOP
      uPont := uPont + "cartolaFC".pontuacao_time_usuario(i."idUsuario", j.idpartida);
    END LOOP;
    RETURN QUERY SELECT i."idUsuario", uPont;
  END LOOP;
END;
$$;
```
