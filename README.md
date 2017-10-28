# CartolaFC

1. [Visão Geral](#visão-geral)
2. [Modelo](#modelo)
    1. [Diagrama de relacionamento](#diagrama-de-relacionamento)
    2. [Modelo lógico](#modelo-lógico)
3. [Regras de negócio](#regras-de-negócio)
    1. [Partida](#partida)
    2. [Rodada](#rodada)
    3. [TimeUsuario](#timeusuario)
    4. [Jogador](#jogador)
    5. [Campeonato](#campeonato)
    6. [Formação](#formacao)

## Visão Geral
Modelagem, simplificada, das relações das entidades e regras de negócios do CartolaFC.

## Modelo

### Diagrama de relacionamento

### Modelo lógico

## Regras de negócio

### Partida
1. Um time só pode ter uma partida por rodada de um campeonato.
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

2. Só podem haver 10 partidas por rodada.
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
