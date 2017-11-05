--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = "cartolaFC", pg_catalog;

ALTER TABLE IF EXISTS ONLY "cartolaFC".rodada DROP CONSTRAINT IF EXISTS rodada_campeonato_idcampeonato_fk;
ALTER TABLE IF EXISTS ONLY "cartolaFC".preco_jogador DROP CONSTRAINT IF EXISTS preco_jogador_partida_idpartida_fk;
ALTER TABLE IF EXISTS ONLY "cartolaFC".preco_jogador DROP CONSTRAINT IF EXISTS preco_jogador_jogador_idjogador_fk;
ALTER TABLE IF EXISTS ONLY "cartolaFC".pontuacao_jogador DROP CONSTRAINT IF EXISTS pontuacao_jogador_rodada_idrodada_fk;
ALTER TABLE IF EXISTS ONLY "cartolaFC".pontuacao_jogador DROP CONSTRAINT IF EXISTS pontuacao_jogador_jogador_idjogador_fk;
ALTER TABLE IF EXISTS ONLY "cartolaFC".partida DROP CONSTRAINT IF EXISTS partida_time_idtime_fk2;
ALTER TABLE IF EXISTS ONLY "cartolaFC".partida DROP CONSTRAINT IF EXISTS partida_time_idtime_fk;
ALTER TABLE IF EXISTS ONLY "cartolaFC".partida DROP CONSTRAINT IF EXISTS partida_rodada_idrodada_fk;
ALTER TABLE IF EXISTS ONLY "cartolaFC".jogador_time_usuario DROP CONSTRAINT IF EXISTS jogador_time_usuario_jogador_idjogador_fk;
ALTER TABLE IF EXISTS ONLY "cartolaFC".time_usuario DROP CONSTRAINT IF EXISTS fk_timeusuario_usuario;
ALTER TABLE IF EXISTS ONLY "cartolaFC".time_usuario DROP CONSTRAINT IF EXISTS fk_timeusuario_formacao;
ALTER TABLE IF EXISTS ONLY "cartolaFC".status_jogador DROP CONSTRAINT IF EXISTS fk_statusjogador_jogador;
ALTER TABLE IF EXISTS ONLY "cartolaFC".jogador_time_usuario DROP CONSTRAINT IF EXISTS fk_jogadortimeusuario_timeusuario;
ALTER TABLE IF EXISTS ONLY "cartolaFC".jogador DROP CONSTRAINT IF EXISTS fk_jogador_time;
ALTER TABLE IF EXISTS ONLY "cartolaFC".classificacao DROP CONSTRAINT IF EXISTS fk_classificacao_time;
ALTER TABLE IF EXISTS ONLY "cartolaFC".estatisticas_jogador DROP CONSTRAINT IF EXISTS estatisticas_jogador_partida_idpartida_fk;
ALTER TABLE IF EXISTS ONLY "cartolaFC".estatisticas_jogador DROP CONSTRAINT IF EXISTS estatisticas_jogador_jogador_idjogador_fk;
ALTER TABLE IF EXISTS ONLY "cartolaFC".classificacao DROP CONSTRAINT IF EXISTS classificacao_campeonato_idcampeonato_fk;
DROP TRIGGER IF EXISTS verifica_qtd_partidas ON "cartolaFC".partida;
DROP TRIGGER IF EXISTS verifica_partida ON "cartolaFC".partida;
DROP TRIGGER IF EXISTS trigger_verificia_time_usuario_formacao ON "cartolaFC".jogador_time_usuario;
DROP TRIGGER IF EXISTS trigger_verifica_time_jogador_partida_estatistica ON "cartolaFC".estatisticas_jogador;
DROP TRIGGER IF EXISTS trigger_verifica_cartoes ON "cartolaFC".estatisticas_jogador;
DROP TRIGGER IF EXISTS trigger_status_jogador_jogador ON "cartolaFC".jogador;
DROP TRIGGER IF EXISTS trigger_qtd_gols_jogador ON "cartolaFC".estatisticas_jogador;
DROP TRIGGER IF EXISTS trigger_pontuacao_jogador ON "cartolaFC".estatisticas_jogador;
DROP TRIGGER IF EXISTS insere_classificacao ON "cartolaFC"."time";
DROP TRIGGER IF EXISTS atualiza_classificacao2 ON "cartolaFC".partida;
DROP TRIGGER IF EXISTS atualiza_classificacao ON "cartolaFC".partida;
DROP INDEX IF EXISTS "cartolaFC".rodada_data_idcampeonato_uindex;
DROP INDEX IF EXISTS "cartolaFC".preco_jogador_idjogador_idpartida_uindex;
DROP INDEX IF EXISTS "cartolaFC".partida_inex_uq;
DROP INDEX IF EXISTS "cartolaFC".partida_idtime4_uindex;
DROP INDEX IF EXISTS "cartolaFC".partida_idtime3_uindex;
DROP INDEX IF EXISTS "cartolaFC".jogador_time_usuario_idjogador_idtimeusuario_uindex;
DROP INDEX IF EXISTS "cartolaFC".jogador_nome_posicao_uindex;
DROP INDEX IF EXISTS "cartolaFC".estatisticas_jogador_idjogador_idrodada_uindex;
DROP INDEX IF EXISTS "cartolaFC".classificacao_idtime_uindex;
ALTER TABLE IF EXISTS ONLY "cartolaFC".usuario DROP CONSTRAINT IF EXISTS usuario_pkey;
ALTER TABLE IF EXISTS ONLY "cartolaFC".usuario DROP CONSTRAINT IF EXISTS uq_usuario_login;
ALTER TABLE IF EXISTS ONLY "cartolaFC".time_usuario DROP CONSTRAINT IF EXISTS time_usuario_pkey;
ALTER TABLE IF EXISTS ONLY "cartolaFC"."time" DROP CONSTRAINT IF EXISTS time_pkey;
ALTER TABLE IF EXISTS ONLY "cartolaFC"."time" DROP CONSTRAINT IF EXISTS time_nome_key;
ALTER TABLE IF EXISTS ONLY "cartolaFC".status_jogador DROP CONSTRAINT IF EXISTS status_jogadpr_pkey;
ALTER TABLE IF EXISTS ONLY "cartolaFC".rodada DROP CONSTRAINT IF EXISTS rodada_pkey;
ALTER TABLE IF EXISTS ONLY "cartolaFC".preco_jogador DROP CONSTRAINT IF EXISTS preco_jogador_pkey;
ALTER TABLE IF EXISTS ONLY "cartolaFC".pontuacao_jogador DROP CONSTRAINT IF EXISTS pontuacao_jogador_pkey;
ALTER TABLE IF EXISTS ONLY "cartolaFC".partida DROP CONSTRAINT IF EXISTS partida_pkey;
ALTER TABLE IF EXISTS ONLY "cartolaFC".jogador_time_usuario DROP CONSTRAINT IF EXISTS jogador_time_usuario_pkey;
ALTER TABLE IF EXISTS ONLY "cartolaFC".jogador DROP CONSTRAINT IF EXISTS jogador_pkey;
ALTER TABLE IF EXISTS ONLY "cartolaFC".formacao DROP CONSTRAINT IF EXISTS formacao_pkey;
ALTER TABLE IF EXISTS ONLY "cartolaFC".estatisticas_jogador DROP CONSTRAINT IF EXISTS estatisticas_jogador_idestatisticajogador_pk;
ALTER TABLE IF EXISTS ONLY "cartolaFC".classificacao DROP CONSTRAINT IF EXISTS classificacao_pkey;
ALTER TABLE IF EXISTS ONLY "cartolaFC".campeonato DROP CONSTRAINT IF EXISTS campeonato_pkey;
ALTER TABLE IF EXISTS "cartolaFC".usuario ALTER COLUMN "idUsuario" DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC".time_usuario ALTER COLUMN "idTimeUsuario" DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC"."time" ALTER COLUMN "idTime" DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC".status_jogador ALTER COLUMN "idStatusJogador" DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC".rodada ALTER COLUMN idrodada DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC".preco_jogador ALTER COLUMN idprecojogador DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC".pontuacao_jogador ALTER COLUMN idpontuacaojogador DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC".partida ALTER COLUMN idpartida DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC".jogador_time_usuario ALTER COLUMN "idJogadorTimeUsuario" DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC".jogador ALTER COLUMN "idJogador" DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC".formacao ALTER COLUMN "idFormacao" DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC".estatisticas_jogador ALTER COLUMN idestatisticajogador DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC".classificacao ALTER COLUMN "idClassificacao" DROP DEFAULT;
ALTER TABLE IF EXISTS "cartolaFC".campeonato ALTER COLUMN idcampeonato DROP DEFAULT;
DROP SEQUENCE IF EXISTS "cartolaFC"."usuario_idUsuario_seq";
DROP TABLE IF EXISTS "cartolaFC".usuario;
DROP SEQUENCE IF EXISTS "cartolaFC"."time_usuario_idTimeUsuario_seq";
DROP TABLE IF EXISTS "cartolaFC".time_usuario;
DROP SEQUENCE IF EXISTS "cartolaFC"."time_idTime_seq";
DROP TABLE IF EXISTS "cartolaFC"."time";
DROP SEQUENCE IF EXISTS "cartolaFC"."status_jogadpr_idStatusJogador_seq";
DROP TABLE IF EXISTS "cartolaFC".status_jogador;
DROP SEQUENCE IF EXISTS "cartolaFC".rodada_idrodada_seq;
DROP TABLE IF EXISTS "cartolaFC".rodada;
DROP SEQUENCE IF EXISTS "cartolaFC".preco_jogador_idprecojogador_seq;
DROP TABLE IF EXISTS "cartolaFC".preco_jogador;
DROP SEQUENCE IF EXISTS "cartolaFC".pontuacao_jogador_idpontuacaojogador_seq;
DROP TABLE IF EXISTS "cartolaFC".pontuacao_jogador;
DROP SEQUENCE IF EXISTS "cartolaFC".partida_idpartida_seq;
DROP TABLE IF EXISTS "cartolaFC".partida;
DROP SEQUENCE IF EXISTS "cartolaFC"."jogador_time_usuario_idJogadorTimeUsuario_seq";
DROP TABLE IF EXISTS "cartolaFC".jogador_time_usuario;
DROP SEQUENCE IF EXISTS "cartolaFC"."jogador_idJogador_seq";
DROP TABLE IF EXISTS "cartolaFC".jogador;
DROP SEQUENCE IF EXISTS "cartolaFC"."formacao_idFormacao_seq";
DROP TABLE IF EXISTS "cartolaFC".formacao;
DROP SEQUENCE IF EXISTS "cartolaFC".estatisticas_jogador_idestatisticajogador_seq;
DROP TABLE IF EXISTS "cartolaFC".estatisticas_jogador;
DROP SEQUENCE IF EXISTS "cartolaFC"."classificacao_idClassificacao_seq";
DROP TABLE IF EXISTS "cartolaFC".classificacao;
DROP SEQUENCE IF EXISTS "cartolaFC".campeonato_idcampeonato_seq;
DROP TABLE IF EXISTS "cartolaFC".campeonato;
DROP FUNCTION IF EXISTS "cartolaFC".verifica_time_jogador_partida_estatistica();
DROP FUNCTION IF EXISTS "cartolaFC".verifica_qtd_partida_rodada();
DROP FUNCTION IF EXISTS "cartolaFC".verifica_qtd_gols_jogador();
DROP FUNCTION IF EXISTS "cartolaFC".verifica_jogo_rodada();
DROP FUNCTION IF EXISTS "cartolaFC".verifica_cartoes();
DROP FUNCTION IF EXISTS "cartolaFC".time_usuario_valido_qtd_jogadores();
DROP FUNCTION IF EXISTS "cartolaFC".time_usuario_valido("time" integer);
DROP FUNCTION IF EXISTS "cartolaFC".status_jogador();
DROP FUNCTION IF EXISTS "cartolaFC".pontuacao_jogador();
DROP FUNCTION IF EXISTS "cartolaFC".insert_classificacao();
DROP FUNCTION IF EXISTS "cartolaFC".get_classificacao(idcamp integer);
DROP FUNCTION IF EXISTS "cartolaFC".atualiza_classificacao2();
DROP FUNCTION IF EXISTS "cartolaFC".atualiza_classificacao();
DROP SCHEMA IF EXISTS "cartolaFC";
--
-- Name: cartolaFC; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "cartolaFC";


ALTER SCHEMA "cartolaFC" OWNER TO postgres;

SET search_path = "cartolaFC", pg_catalog;

--
-- Name: atualiza_classificacao(); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION atualiza_classificacao() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  nPontos INTEGER := 0;
  nVitorias INTEGER := 0;
  nEmpates INTEGER := 0;
  nDerrotas INTEGER := 0;
  campId INTEGER;
BEGIN
  SELECT pontos, vitorias, empates, derrotas INTO nPontos, nVitorias, nEmpates, nDerrotas
  FROM "cartolaFC".classificacao
  WHERE "idTime" = NEW.idtime1;

  SELECT idCampeonato INTO campId
  FROM "cartolaFC".rodada NATURAL JOIN "cartolaFC".partida
  WHERE partida.idpartida = NEW.idpartida;

  IF NEW.golstime1 > NEW.golstime2 THEN
    nPontos := nPontos + 3;
    nVitorias := nVitorias + 1;
    nEmpates := nEmpates + 0;
    nDerrotas := nDerrotas + 0;
  ELSEIF NEW.golstime1 < NEW.golstime2 THEN
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
    "nJogos" =  "cartolaFC".classificacao."nJogos" + 1,
    idcamp = campId
  WHERE "idTime" = NEW.idtime1;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "cartolaFC".atualiza_classificacao() OWNER TO postgres;

--
-- Name: atualiza_classificacao2(); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION atualiza_classificacao2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  nPontos INTEGER := 0;
  nVitorias INTEGER := 0;
  nEmpates INTEGER := 0;
  nDerrotas INTEGER := 0;
  campId INTEGER;
BEGIN
  SELECT pontos, vitorias, empates, derrotas INTO nPontos, nVitorias, nEmpates, nDerrotas
  FROM "cartolaFC".classificacao
  WHERE "idTime" = NEW.idtime2;

  SELECT idCampeonato INTO campId
  FROM "cartolaFC".rodada NATURAL JOIN "cartolaFC".partida
  WHERE partida.idpartida = NEW.idpartida;

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
    "nJogos" =  "cartolaFC".classificacao."nJogos" + 1,
    idcamp = campId
  WHERE "idTime" = NEW.idtime2;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "cartolaFC".atualiza_classificacao2() OWNER TO postgres;

--
-- Name: get_classificacao(integer); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION get_classificacao(idcamp integer) RETURNS TABLE(equipe character varying, njogos integer, vitorias integer, empates integer, derrotas integer, pontos integer)
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


ALTER FUNCTION "cartolaFC".get_classificacao(idcamp integer) OWNER TO postgres;

--
-- Name: insert_classificacao(); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION insert_classificacao() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "cartolaFC".classificacao(pontos, "nJogos", vitorias, empates, derrotas, "idTime") VALUES
    (0, 0, 0, 0, 0, NEW."idTime");

  return NULL;
END;
$$;


ALTER FUNCTION "cartolaFC".insert_classificacao() OWNER TO postgres;

--
-- Name: pontuacao_jogador(); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION pontuacao_jogador() RETURNS trigger
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


ALTER FUNCTION "cartolaFC".pontuacao_jogador() OWNER TO postgres;

--
-- Name: status_jogador(); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION status_jogador() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "cartolaFC".status_jogador("idJogador", status) VALUES (NEW."idJogador", 0);
    RETURN NEW;
END;
$$;


ALTER FUNCTION "cartolaFC".status_jogador() OWNER TO postgres;

--
-- Name: time_usuario_valido(integer); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION time_usuario_valido("time" integer) RETURNS boolean
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


ALTER FUNCTION "cartolaFC".time_usuario_valido("time" integer) OWNER TO postgres;

--
-- Name: time_usuario_valido_qtd_jogadores(); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION time_usuario_valido_qtd_jogadores() RETURNS trigger
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


ALTER FUNCTION "cartolaFC".time_usuario_valido_qtd_jogadores() OWNER TO postgres;

--
-- Name: verifica_cartoes(); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION verifica_cartoes() RETURNS trigger
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


ALTER FUNCTION "cartolaFC".verifica_cartoes() OWNER TO postgres;

--
-- Name: verifica_jogo_rodada(); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION verifica_jogo_rodada() RETURNS trigger
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


ALTER FUNCTION "cartolaFC".verifica_jogo_rodada() OWNER TO postgres;

--
-- Name: verifica_qtd_gols_jogador(); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION verifica_qtd_gols_jogador() RETURNS trigger
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


ALTER FUNCTION "cartolaFC".verifica_qtd_gols_jogador() OWNER TO postgres;

--
-- Name: verifica_qtd_partida_rodada(); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION verifica_qtd_partida_rodada() RETURNS trigger
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


ALTER FUNCTION "cartolaFC".verifica_qtd_partida_rodada() OWNER TO postgres;

--
-- Name: verifica_time_jogador_partida_estatistica(); Type: FUNCTION; Schema: cartolaFC; Owner: postgres
--

CREATE FUNCTION verifica_time_jogador_partida_estatistica() RETURNS trigger
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


ALTER FUNCTION "cartolaFC".verifica_time_jogador_partida_estatistica() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: campeonato; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE campeonato (
    idcampeonato integer NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE campeonato OWNER TO postgres;

--
-- Name: campeonato_idcampeonato_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE campeonato_idcampeonato_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE campeonato_idcampeonato_seq OWNER TO postgres;

--
-- Name: campeonato_idcampeonato_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE campeonato_idcampeonato_seq OWNED BY campeonato.idcampeonato;


--
-- Name: classificacao; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE classificacao (
    "idClassificacao" integer NOT NULL,
    pontos integer NOT NULL,
    "nJogos" integer NOT NULL,
    vitorias integer NOT NULL,
    empates integer NOT NULL,
    derrotas integer NOT NULL,
    "idTime" integer,
    idcamp integer
);


ALTER TABLE classificacao OWNER TO postgres;

--
-- Name: classificacao_idClassificacao_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE "classificacao_idClassificacao_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "classificacao_idClassificacao_seq" OWNER TO postgres;

--
-- Name: classificacao_idClassificacao_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE "classificacao_idClassificacao_seq" OWNED BY classificacao."idClassificacao";


--
-- Name: estatisticas_jogador; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE estatisticas_jogador (
    idestatisticajogador integer NOT NULL,
    idpartida integer NOT NULL,
    idjogador integer NOT NULL,
    chutesgol integer DEFAULT 0 NOT NULL,
    defesas integer DEFAULT 0 NOT NULL,
    numerogols integer DEFAULT 0 NOT NULL,
    roubadasbola integer DEFAULT 0 NOT NULL,
    cartaovermelho integer DEFAULT 0 NOT NULL,
    cartaoamarelo integer DEFAULT 0 NOT NULL,
    faltascometidas integer DEFAULT 0 NOT NULL,
    defesapenalti integer DEFAULT 0 NOT NULL
);


ALTER TABLE estatisticas_jogador OWNER TO postgres;

--
-- Name: estatisticas_jogador_idestatisticajogador_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE estatisticas_jogador_idestatisticajogador_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estatisticas_jogador_idestatisticajogador_seq OWNER TO postgres;

--
-- Name: estatisticas_jogador_idestatisticajogador_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE estatisticas_jogador_idestatisticajogador_seq OWNED BY estatisticas_jogador.idestatisticajogador;


--
-- Name: formacao; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE formacao (
    "idFormacao" integer NOT NULL,
    "nZagueiros" integer NOT NULL,
    "nMeias" integer,
    "nAtacantes" integer
);


ALTER TABLE formacao OWNER TO postgres;

--
-- Name: formacao_idFormacao_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE "formacao_idFormacao_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "formacao_idFormacao_seq" OWNER TO postgres;

--
-- Name: formacao_idFormacao_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE "formacao_idFormacao_seq" OWNED BY formacao."idFormacao";


--
-- Name: jogador; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE jogador (
    "idJogador" integer NOT NULL,
    nome character varying NOT NULL,
    posicao character varying,
    "idTime" integer
);


ALTER TABLE jogador OWNER TO postgres;

--
-- Name: jogador_idJogador_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE "jogador_idJogador_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "jogador_idJogador_seq" OWNER TO postgres;

--
-- Name: jogador_idJogador_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE "jogador_idJogador_seq" OWNED BY jogador."idJogador";


--
-- Name: jogador_time_usuario; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE jogador_time_usuario (
    "idJogadorTimeUsuario" integer NOT NULL,
    "idTimeUsuario" integer,
    "idJogador" integer
);


ALTER TABLE jogador_time_usuario OWNER TO postgres;

--
-- Name: jogador_time_usuario_idJogadorTimeUsuario_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE "jogador_time_usuario_idJogadorTimeUsuario_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "jogador_time_usuario_idJogadorTimeUsuario_seq" OWNER TO postgres;

--
-- Name: jogador_time_usuario_idJogadorTimeUsuario_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE "jogador_time_usuario_idJogadorTimeUsuario_seq" OWNED BY jogador_time_usuario."idJogadorTimeUsuario";


--
-- Name: partida; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE partida (
    idpartida integer NOT NULL,
    idtime1 integer NOT NULL,
    idtime2 integer NOT NULL,
    golstime1 integer NOT NULL,
    golstime2 integer NOT NULL,
    idrodada integer NOT NULL
);


ALTER TABLE partida OWNER TO postgres;

--
-- Name: partida_idpartida_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE partida_idpartida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE partida_idpartida_seq OWNER TO postgres;

--
-- Name: partida_idpartida_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE partida_idpartida_seq OWNED BY partida.idpartida;


--
-- Name: pontuacao_jogador; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE pontuacao_jogador (
    idpontuacaojogador integer NOT NULL,
    pontuacao integer NOT NULL,
    idrodada integer NOT NULL,
    idjogador integer NOT NULL
);


ALTER TABLE pontuacao_jogador OWNER TO postgres;

--
-- Name: pontuacao_jogador_idpontuacaojogador_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE pontuacao_jogador_idpontuacaojogador_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pontuacao_jogador_idpontuacaojogador_seq OWNER TO postgres;

--
-- Name: pontuacao_jogador_idpontuacaojogador_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE pontuacao_jogador_idpontuacaojogador_seq OWNED BY pontuacao_jogador.idpontuacaojogador;


--
-- Name: preco_jogador; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE preco_jogador (
    idprecojogador integer NOT NULL,
    idjogador integer NOT NULL,
    idpartida integer,
    preco integer NOT NULL
);


ALTER TABLE preco_jogador OWNER TO postgres;

--
-- Name: preco_jogador_idprecojogador_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE preco_jogador_idprecojogador_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE preco_jogador_idprecojogador_seq OWNER TO postgres;

--
-- Name: preco_jogador_idprecojogador_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE preco_jogador_idprecojogador_seq OWNED BY preco_jogador.idprecojogador;


--
-- Name: rodada; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE rodada (
    idrodada integer NOT NULL,
    data date NOT NULL,
    idcampeonato integer
);


ALTER TABLE rodada OWNER TO postgres;

--
-- Name: rodada_idrodada_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE rodada_idrodada_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rodada_idrodada_seq OWNER TO postgres;

--
-- Name: rodada_idrodada_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE rodada_idrodada_seq OWNED BY rodada.idrodada;


--
-- Name: status_jogador; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE status_jogador (
    "idStatusJogador" integer NOT NULL,
    "idJogador" integer,
    status integer DEFAULT 0 NOT NULL
);


ALTER TABLE status_jogador OWNER TO postgres;

--
-- Name: status_jogadpr_idStatusJogador_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE "status_jogadpr_idStatusJogador_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "status_jogadpr_idStatusJogador_seq" OWNER TO postgres;

--
-- Name: status_jogadpr_idStatusJogador_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE "status_jogadpr_idStatusJogador_seq" OWNED BY status_jogador."idStatusJogador";


--
-- Name: time; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE "time" (
    "idTime" integer NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE "time" OWNER TO postgres;

--
-- Name: time_idTime_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE "time_idTime_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "time_idTime_seq" OWNER TO postgres;

--
-- Name: time_idTime_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE "time_idTime_seq" OWNED BY "time"."idTime";


--
-- Name: time_usuario; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE time_usuario (
    "idTimeUsuario" integer NOT NULL,
    "idFormacao" integer,
    "idUsuario" integer
);


ALTER TABLE time_usuario OWNER TO postgres;

--
-- Name: time_usuario_idTimeUsuario_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE "time_usuario_idTimeUsuario_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "time_usuario_idTimeUsuario_seq" OWNER TO postgres;

--
-- Name: time_usuario_idTimeUsuario_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE "time_usuario_idTimeUsuario_seq" OWNED BY time_usuario."idTimeUsuario";


--
-- Name: usuario; Type: TABLE; Schema: cartolaFC; Owner: postgres
--

CREATE TABLE usuario (
    "idUsuario" integer NOT NULL,
    nome character varying NOT NULL,
    login character varying NOT NULL,
    senha character varying NOT NULL
);


ALTER TABLE usuario OWNER TO postgres;

--
-- Name: usuario_idUsuario_seq; Type: SEQUENCE; Schema: cartolaFC; Owner: postgres
--

CREATE SEQUENCE "usuario_idUsuario_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "usuario_idUsuario_seq" OWNER TO postgres;

--
-- Name: usuario_idUsuario_seq; Type: SEQUENCE OWNED BY; Schema: cartolaFC; Owner: postgres
--

ALTER SEQUENCE "usuario_idUsuario_seq" OWNED BY usuario."idUsuario";


--
-- Name: campeonato idcampeonato; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY campeonato ALTER COLUMN idcampeonato SET DEFAULT nextval('campeonato_idcampeonato_seq'::regclass);


--
-- Name: classificacao idClassificacao; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY classificacao ALTER COLUMN "idClassificacao" SET DEFAULT nextval('"classificacao_idClassificacao_seq"'::regclass);


--
-- Name: estatisticas_jogador idestatisticajogador; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY estatisticas_jogador ALTER COLUMN idestatisticajogador SET DEFAULT nextval('estatisticas_jogador_idestatisticajogador_seq'::regclass);


--
-- Name: formacao idFormacao; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY formacao ALTER COLUMN "idFormacao" SET DEFAULT nextval('"formacao_idFormacao_seq"'::regclass);


--
-- Name: jogador idJogador; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY jogador ALTER COLUMN "idJogador" SET DEFAULT nextval('"jogador_idJogador_seq"'::regclass);


--
-- Name: jogador_time_usuario idJogadorTimeUsuario; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY jogador_time_usuario ALTER COLUMN "idJogadorTimeUsuario" SET DEFAULT nextval('"jogador_time_usuario_idJogadorTimeUsuario_seq"'::regclass);


--
-- Name: partida idpartida; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY partida ALTER COLUMN idpartida SET DEFAULT nextval('partida_idpartida_seq'::regclass);


--
-- Name: pontuacao_jogador idpontuacaojogador; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY pontuacao_jogador ALTER COLUMN idpontuacaojogador SET DEFAULT nextval('pontuacao_jogador_idpontuacaojogador_seq'::regclass);


--
-- Name: preco_jogador idprecojogador; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY preco_jogador ALTER COLUMN idprecojogador SET DEFAULT nextval('preco_jogador_idprecojogador_seq'::regclass);


--
-- Name: rodada idrodada; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY rodada ALTER COLUMN idrodada SET DEFAULT nextval('rodada_idrodada_seq'::regclass);


--
-- Name: status_jogador idStatusJogador; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY status_jogador ALTER COLUMN "idStatusJogador" SET DEFAULT nextval('"status_jogadpr_idStatusJogador_seq"'::regclass);


--
-- Name: time idTime; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY "time" ALTER COLUMN "idTime" SET DEFAULT nextval('"time_idTime_seq"'::regclass);


--
-- Name: time_usuario idTimeUsuario; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY time_usuario ALTER COLUMN "idTimeUsuario" SET DEFAULT nextval('"time_usuario_idTimeUsuario_seq"'::regclass);


--
-- Name: usuario idUsuario; Type: DEFAULT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY usuario ALTER COLUMN "idUsuario" SET DEFAULT nextval('"usuario_idUsuario_seq"'::regclass);


--
-- Data for Name: campeonato; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY campeonato (idcampeonato, nome) FROM stdin;
1	Campeonato Brasileiro 2017
2	Campeonato Carioca 2017
\.


--
-- Name: campeonato_idcampeonato_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('campeonato_idcampeonato_seq', 2, true);


--
-- Data for Name: classificacao; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY classificacao ("idClassificacao", pontos, "nJogos", vitorias, empates, derrotas, "idTime", idcamp) FROM stdin;
\.


--
-- Name: classificacao_idClassificacao_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('"classificacao_idClassificacao_seq"', 22, true);


--
-- Data for Name: estatisticas_jogador; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY estatisticas_jogador (idestatisticajogador, idpartida, idjogador, chutesgol, defesas, numerogols, roubadasbola, cartaovermelho, cartaoamarelo, faltascometidas, defesapenalti) FROM stdin;
13	3	3	0	0	1	0	0	0	0	0
11	3	2	0	0	1	0	0	0	0	0
\.


--
-- Name: estatisticas_jogador_idestatisticajogador_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('estatisticas_jogador_idestatisticajogador_seq', 13, true);


--
-- Data for Name: formacao; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY formacao ("idFormacao", "nZagueiros", "nMeias", "nAtacantes") FROM stdin;
1	4	4	2
2	3	5	2
3	3	4	3
4	4	5	1
\.


--
-- Name: formacao_idFormacao_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('"formacao_idFormacao_seq"', 4, true);


--
-- Data for Name: jogador; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY jogador ("idJogador", nome, posicao, "idTime") FROM stdin;
2	Paolo Guerrero	Atacante	1
3	Diego Ribas	Meio-Campo	1
4	Everton Ribeiro	Meio-Campo	1
5	Diego Alves	Goleiro	1
6	Nenê	Meio-Campo	2
7	Jean	Meio-Campo	2
8	Luís Fabiano	Atacante	2
10	Henrique Dourado	Atacante	4
11	Gustavo Scarpa	Meio-Campo	4
12	Henrique	Zagueiro	4
13	Diego Cavalieri	Goleiro	4
14	Rodrigo Pimpão	Atacante	5
15	Bruno Silva	Meio-Campo	5
16	Joel Carli	Zagueiro	5
17	Gatito Fernandez	Goleiro	5
18	Sassá	Atacante	6
19	Thiago Neves	Meio-Campo	6
20	De Arrascaeta	Meio-Campo	6
48	Pará	Zagueiro	1
49	Réver	Zagueiro	1
50	Juan	Zagueiro	1
51	Luan	Atacante	8
\.


--
-- Name: jogador_idJogador_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('"jogador_idJogador_seq"', 51, true);


--
-- Data for Name: jogador_time_usuario; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY jogador_time_usuario ("idJogadorTimeUsuario", "idTimeUsuario", "idJogador") FROM stdin;
1	1	2
2	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
10	1	12
11	1	16
12	1	48
13	1	50
\.


--
-- Name: jogador_time_usuario_idJogadorTimeUsuario_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('"jogador_time_usuario_idJogadorTimeUsuario_seq"', 45, true);


--
-- Data for Name: partida; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY partida (idpartida, idtime1, idtime2, golstime1, golstime2, idrodada) FROM stdin;
3	1	2	3	1	1
6	6	7	1	0	1
14	18	19	1	1	1
15	10	11	0	0	1
16	8	12	1	0	1
19	4	5	5	5	1
20	9	13	0	0	1
21	14	15	1	2	1
22	16	17	2	2	1
25	20	18	1	0	2
13	20	21	2	1	1
\.


--
-- Name: partida_idpartida_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('partida_idpartida_seq', 25, true);


--
-- Data for Name: pontuacao_jogador; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY pontuacao_jogador (idpontuacaojogador, pontuacao, idrodada, idjogador) FROM stdin;
12	6	3	3
10	6	3	2
\.


--
-- Name: pontuacao_jogador_idpontuacaojogador_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('pontuacao_jogador_idpontuacaojogador_seq', 12, true);


--
-- Data for Name: preco_jogador; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY preco_jogador (idprecojogador, idjogador, idpartida, preco) FROM stdin;
\.


--
-- Name: preco_jogador_idprecojogador_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('preco_jogador_idprecojogador_seq', 1, false);


--
-- Data for Name: rodada; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY rodada (idrodada, data, idcampeonato) FROM stdin;
2	2017-10-03	1
3	2017-10-05	1
1	2017-10-10	1
6	2017-10-27	1
4	2017-10-07	1
5	2017-10-18	1
\.


--
-- Name: rodada_idrodada_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('rodada_idrodada_seq', 6, true);


--
-- Data for Name: status_jogador; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY status_jogador ("idStatusJogador", "idJogador", status) FROM stdin;
2	48	0
3	49	0
4	50	0
5	51	0
\.


--
-- Name: status_jogadpr_idStatusJogador_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('"status_jogadpr_idStatusJogador_seq"', 5, true);


--
-- Data for Name: time; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY "time" ("idTime", nome) FROM stdin;
1	Flamengo
2	Vasco
4	Fluminense
5	Botafogo
6	Cruzeiro
7	Atlético Mineiro
8	Grêmio
9	Internacional
10	São Paulo
11	Santos
12	Palmeiras
13	Corinthians
14	Chapecoense
15	Atlético Paranaense
16	Coritiba
17	Sport
18	Vitória
19	Bahia
20	Atlético Goianiense
21	Avaí
\.


--
-- Name: time_idTime_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('"time_idTime_seq"', 23, true);


--
-- Data for Name: time_usuario; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY time_usuario ("idTimeUsuario", "idFormacao", "idUsuario") FROM stdin;
1	1	1
\.


--
-- Name: time_usuario_idTimeUsuario_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('"time_usuario_idTimeUsuario_seq"', 1, true);


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: cartolaFC; Owner: postgres
--

COPY usuario ("idUsuario", nome, login, senha) FROM stdin;
1	Max Fratane	MFratane	123
3	user2	user2	123
\.


--
-- Name: usuario_idUsuario_seq; Type: SEQUENCE SET; Schema: cartolaFC; Owner: postgres
--

SELECT pg_catalog.setval('"usuario_idUsuario_seq"', 3, true);


--
-- Name: campeonato campeonato_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY campeonato
    ADD CONSTRAINT campeonato_pkey PRIMARY KEY (idcampeonato);


--
-- Name: classificacao classificacao_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY classificacao
    ADD CONSTRAINT classificacao_pkey PRIMARY KEY ("idClassificacao");


--
-- Name: estatisticas_jogador estatisticas_jogador_idestatisticajogador_pk; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY estatisticas_jogador
    ADD CONSTRAINT estatisticas_jogador_idestatisticajogador_pk PRIMARY KEY (idestatisticajogador);


--
-- Name: formacao formacao_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY formacao
    ADD CONSTRAINT formacao_pkey PRIMARY KEY ("idFormacao");


--
-- Name: jogador jogador_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY jogador
    ADD CONSTRAINT jogador_pkey PRIMARY KEY ("idJogador");


--
-- Name: jogador_time_usuario jogador_time_usuario_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY jogador_time_usuario
    ADD CONSTRAINT jogador_time_usuario_pkey PRIMARY KEY ("idJogadorTimeUsuario");


--
-- Name: partida partida_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY partida
    ADD CONSTRAINT partida_pkey PRIMARY KEY (idpartida);


--
-- Name: pontuacao_jogador pontuacao_jogador_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY pontuacao_jogador
    ADD CONSTRAINT pontuacao_jogador_pkey PRIMARY KEY (idpontuacaojogador);


--
-- Name: preco_jogador preco_jogador_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY preco_jogador
    ADD CONSTRAINT preco_jogador_pkey PRIMARY KEY (idprecojogador);


--
-- Name: rodada rodada_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY rodada
    ADD CONSTRAINT rodada_pkey PRIMARY KEY (idrodada);


--
-- Name: status_jogador status_jogadpr_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY status_jogador
    ADD CONSTRAINT status_jogadpr_pkey PRIMARY KEY ("idStatusJogador");


--
-- Name: time time_nome_key; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY "time"
    ADD CONSTRAINT time_nome_key UNIQUE (nome);


--
-- Name: time time_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY "time"
    ADD CONSTRAINT time_pkey PRIMARY KEY ("idTime");


--
-- Name: time_usuario time_usuario_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY time_usuario
    ADD CONSTRAINT time_usuario_pkey PRIMARY KEY ("idTimeUsuario");


--
-- Name: usuario uq_usuario_login; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT uq_usuario_login UNIQUE (login);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY ("idUsuario");


--
-- Name: classificacao_idtime_uindex; Type: INDEX; Schema: cartolaFC; Owner: postgres
--

CREATE UNIQUE INDEX classificacao_idtime_uindex ON classificacao USING btree ("idTime");


--
-- Name: estatisticas_jogador_idjogador_idrodada_uindex; Type: INDEX; Schema: cartolaFC; Owner: postgres
--

CREATE UNIQUE INDEX estatisticas_jogador_idjogador_idrodada_uindex ON estatisticas_jogador USING btree (idjogador, idpartida);


--
-- Name: jogador_nome_posicao_uindex; Type: INDEX; Schema: cartolaFC; Owner: postgres
--

CREATE UNIQUE INDEX jogador_nome_posicao_uindex ON jogador USING btree (nome, posicao);


--
-- Name: jogador_time_usuario_idjogador_idtimeusuario_uindex; Type: INDEX; Schema: cartolaFC; Owner: postgres
--

CREATE UNIQUE INDEX jogador_time_usuario_idjogador_idtimeusuario_uindex ON jogador_time_usuario USING btree ("idJogador", "idTimeUsuario");


--
-- Name: partida_idtime3_uindex; Type: INDEX; Schema: cartolaFC; Owner: postgres
--

CREATE UNIQUE INDEX partida_idtime3_uindex ON partida USING btree (idtime2, idrodada, idpartida);


--
-- Name: partida_idtime4_uindex; Type: INDEX; Schema: cartolaFC; Owner: postgres
--

CREATE UNIQUE INDEX partida_idtime4_uindex ON partida USING btree (idtime1, idrodada, idpartida);


--
-- Name: partida_inex_uq; Type: INDEX; Schema: cartolaFC; Owner: postgres
--

CREATE UNIQUE INDEX partida_inex_uq ON partida USING btree (idrodada, idtime1, idtime2);


--
-- Name: preco_jogador_idjogador_idpartida_uindex; Type: INDEX; Schema: cartolaFC; Owner: postgres
--

CREATE UNIQUE INDEX preco_jogador_idjogador_idpartida_uindex ON preco_jogador USING btree (idjogador, idpartida);


--
-- Name: rodada_data_idcampeonato_uindex; Type: INDEX; Schema: cartolaFC; Owner: postgres
--

CREATE UNIQUE INDEX rodada_data_idcampeonato_uindex ON rodada USING btree (data, idcampeonato);


--
-- Name: partida atualiza_classificacao; Type: TRIGGER; Schema: cartolaFC; Owner: postgres
--

CREATE TRIGGER atualiza_classificacao AFTER INSERT OR UPDATE ON partida FOR EACH ROW EXECUTE PROCEDURE atualiza_classificacao();


--
-- Name: partida atualiza_classificacao2; Type: TRIGGER; Schema: cartolaFC; Owner: postgres
--

CREATE TRIGGER atualiza_classificacao2 AFTER INSERT OR UPDATE ON partida FOR EACH ROW EXECUTE PROCEDURE atualiza_classificacao2();


--
-- Name: time insere_classificacao; Type: TRIGGER; Schema: cartolaFC; Owner: postgres
--

CREATE TRIGGER insere_classificacao AFTER INSERT ON "time" FOR EACH ROW EXECUTE PROCEDURE insert_classificacao();


--
-- Name: estatisticas_jogador trigger_pontuacao_jogador; Type: TRIGGER; Schema: cartolaFC; Owner: postgres
--

CREATE TRIGGER trigger_pontuacao_jogador BEFORE INSERT OR UPDATE ON estatisticas_jogador FOR EACH ROW EXECUTE PROCEDURE pontuacao_jogador();


--
-- Name: estatisticas_jogador trigger_qtd_gols_jogador; Type: TRIGGER; Schema: cartolaFC; Owner: postgres
--

CREATE TRIGGER trigger_qtd_gols_jogador AFTER INSERT OR UPDATE ON estatisticas_jogador FOR EACH ROW EXECUTE PROCEDURE verifica_qtd_gols_jogador();


--
-- Name: jogador trigger_status_jogador_jogador; Type: TRIGGER; Schema: cartolaFC; Owner: postgres
--

CREATE TRIGGER trigger_status_jogador_jogador AFTER INSERT ON jogador FOR EACH ROW EXECUTE PROCEDURE status_jogador();


--
-- Name: estatisticas_jogador trigger_verifica_cartoes; Type: TRIGGER; Schema: cartolaFC; Owner: postgres
--

CREATE TRIGGER trigger_verifica_cartoes BEFORE INSERT OR UPDATE ON estatisticas_jogador FOR EACH ROW EXECUTE PROCEDURE verifica_cartoes();


--
-- Name: estatisticas_jogador trigger_verifica_time_jogador_partida_estatistica; Type: TRIGGER; Schema: cartolaFC; Owner: postgres
--

CREATE TRIGGER trigger_verifica_time_jogador_partida_estatistica BEFORE INSERT OR UPDATE ON estatisticas_jogador FOR EACH ROW EXECUTE PROCEDURE verifica_time_jogador_partida_estatistica();


--
-- Name: jogador_time_usuario trigger_verificia_time_usuario_formacao; Type: TRIGGER; Schema: cartolaFC; Owner: postgres
--

CREATE TRIGGER trigger_verificia_time_usuario_formacao BEFORE INSERT ON jogador_time_usuario FOR EACH ROW EXECUTE PROCEDURE time_usuario_valido_qtd_jogadores();


--
-- Name: partida verifica_partida; Type: TRIGGER; Schema: cartolaFC; Owner: postgres
--

CREATE TRIGGER verifica_partida BEFORE INSERT OR UPDATE ON partida FOR EACH ROW EXECUTE PROCEDURE verifica_jogo_rodada();


--
-- Name: partida verifica_qtd_partidas; Type: TRIGGER; Schema: cartolaFC; Owner: postgres
--

CREATE TRIGGER verifica_qtd_partidas BEFORE INSERT ON partida FOR EACH ROW EXECUTE PROCEDURE verifica_qtd_partida_rodada();


--
-- Name: classificacao classificacao_campeonato_idcampeonato_fk; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY classificacao
    ADD CONSTRAINT classificacao_campeonato_idcampeonato_fk FOREIGN KEY (idcamp) REFERENCES campeonato(idcampeonato);


--
-- Name: estatisticas_jogador estatisticas_jogador_jogador_idjogador_fk; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY estatisticas_jogador
    ADD CONSTRAINT estatisticas_jogador_jogador_idjogador_fk FOREIGN KEY (idjogador) REFERENCES jogador("idJogador") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: estatisticas_jogador estatisticas_jogador_partida_idpartida_fk; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY estatisticas_jogador
    ADD CONSTRAINT estatisticas_jogador_partida_idpartida_fk FOREIGN KEY (idpartida) REFERENCES partida(idpartida) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: classificacao fk_classificacao_time; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY classificacao
    ADD CONSTRAINT fk_classificacao_time FOREIGN KEY ("idTime") REFERENCES "time"("idTime");


--
-- Name: jogador fk_jogador_time; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY jogador
    ADD CONSTRAINT fk_jogador_time FOREIGN KEY ("idTime") REFERENCES "time"("idTime");


--
-- Name: jogador_time_usuario fk_jogadortimeusuario_timeusuario; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY jogador_time_usuario
    ADD CONSTRAINT fk_jogadortimeusuario_timeusuario FOREIGN KEY ("idTimeUsuario") REFERENCES time_usuario("idTimeUsuario") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: status_jogador fk_statusjogador_jogador; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY status_jogador
    ADD CONSTRAINT fk_statusjogador_jogador FOREIGN KEY ("idJogador") REFERENCES jogador("idJogador");


--
-- Name: time_usuario fk_timeusuario_formacao; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY time_usuario
    ADD CONSTRAINT fk_timeusuario_formacao FOREIGN KEY ("idFormacao") REFERENCES formacao("idFormacao");


--
-- Name: time_usuario fk_timeusuario_usuario; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY time_usuario
    ADD CONSTRAINT fk_timeusuario_usuario FOREIGN KEY ("idUsuario") REFERENCES usuario("idUsuario");


--
-- Name: jogador_time_usuario jogador_time_usuario_jogador_idjogador_fk; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY jogador_time_usuario
    ADD CONSTRAINT jogador_time_usuario_jogador_idjogador_fk FOREIGN KEY ("idJogador") REFERENCES jogador("idJogador") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: partida partida_rodada_idrodada_fk; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY partida
    ADD CONSTRAINT partida_rodada_idrodada_fk FOREIGN KEY (idrodada) REFERENCES rodada(idrodada) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: partida partida_time_idtime_fk; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY partida
    ADD CONSTRAINT partida_time_idtime_fk FOREIGN KEY (idtime1) REFERENCES "time"("idTime") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: partida partida_time_idtime_fk2; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY partida
    ADD CONSTRAINT partida_time_idtime_fk2 FOREIGN KEY (idtime2) REFERENCES "time"("idTime") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pontuacao_jogador pontuacao_jogador_jogador_idjogador_fk; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY pontuacao_jogador
    ADD CONSTRAINT pontuacao_jogador_jogador_idjogador_fk FOREIGN KEY (idjogador) REFERENCES jogador("idJogador");


--
-- Name: pontuacao_jogador pontuacao_jogador_rodada_idrodada_fk; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY pontuacao_jogador
    ADD CONSTRAINT pontuacao_jogador_rodada_idrodada_fk FOREIGN KEY (idrodada) REFERENCES rodada(idrodada);


--
-- Name: preco_jogador preco_jogador_jogador_idjogador_fk; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY preco_jogador
    ADD CONSTRAINT preco_jogador_jogador_idjogador_fk FOREIGN KEY (idjogador) REFERENCES jogador("idJogador") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: preco_jogador preco_jogador_partida_idpartida_fk; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY preco_jogador
    ADD CONSTRAINT preco_jogador_partida_idpartida_fk FOREIGN KEY (idpartida) REFERENCES partida(idpartida) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rodada rodada_campeonato_idcampeonato_fk; Type: FK CONSTRAINT; Schema: cartolaFC; Owner: postgres
--

ALTER TABLE ONLY rodada
    ADD CONSTRAINT rodada_campeonato_idcampeonato_fk FOREIGN KEY (idcampeonato) REFERENCES campeonato(idcampeonato);


--
-- PostgreSQL database dump complete
--

