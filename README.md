# CartolaFC

1. [Visão Geral](#visão-geral)
2. [Modelo](#modelo)
    1. [Diagrama de relacionamento](#diagrama-de-relacionamento)
    2. [Modelo lógico](#modelo-lógico)
3. [Tabelas](#tabelas)
    1. [Partida](#partida)
    2. [Rodada](#rodada)
    3. [TimeUsuario](#timeusuario)
    4. [Jogador](#jogador)
    5. [Campeonato](#campeonato)
    6. [Formação](#formacao)
4. [Regras de negócio](#regras-de-negócio)
    1. [Da Tabela Partida](#partida)
    2. [Da Tabela Rodada](#rodada)
    3. [Da Tabela TimeUsuario](#timeusuario)
    4. [Da Tabela Jogador](#jogador)
    5. [Da Tabela Campeonato](#campeonato)
    6. [Da Tabela Formação](#formacao)

## Visão Geral
Modelagem, simplificada, das relações das entidades e regras de negócios do CartolaFC.

## Modelo

### Diagrama de relacionamento

<p align="center">
  <img src="https://i.imgur.com/7qef8yQ.png" width="900"/>
</p>

### Modelo lógico

## Tabelas
### Partida
Tabela que armazena as informações de uma partida.


## Regras de negócio
### Partida
- Um time só pode ter uma partida por rodada de um campeonato.
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

### JogadorTimeUsuario
- O número de jogadores em cada posição não pode exceder ao número imposto pela formação do time escolhida pelo usuário.

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
  FOR i IN cur LOOP
    SELECT posicao INTO pos
    FROM "cartolaFC".jogador
    WHERE i."idJogador" = "idJogador";

    SELECT posicao INTO posNew
    FROM "cartolaFC".jogador
    WHERE NEW."idJogador" = "idJogador";

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

