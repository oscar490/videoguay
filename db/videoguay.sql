------------------------------
-- Archivo de base de datos --
------------------------------

DROP TABLE IF EXISTS socios CASCADE;

CREATE TABLE socios
(
    id        BIGSERIAL    PRIMARY KEY
  , numero    NUMERIC(6)   NOT NULL UNIQUE
  , nombre    VARCHAR(255) NOT NULL
  , direccion VARCHAR(255) NOT NULL
  , telefono  NUMERIC(9)   CONSTRAINT ck_telefono_no_negativo
                           CHECK (telefono >= 0)
);

CREATE INDEX idx_socios_nombre ON socios (nombre);
CREATE INDEX idx_socios_telefono ON socios (telefono);


DROP TABLE IF EXISTS peliculas CASCADE;

CREATE TABLE peliculas
(
    id         BIGSERIAL    PRIMARY KEY
  , codigo     NUMERIC(4)   NOT NULL UNIQUE
  , titulo     VARCHAR(255) NOT NULL
  , precio_alq NUMERIC(5,2) NOT NULL
);

CREATE INDEX idx_peliculas_titulo ON peliculas (titulo);


DROP TABLE IF EXISTS alquileres CASCADE;

CREATE TABLE alquileres
(
    id          BIGSERIAL    PRIMARY KEY
  , socio_id    BIGINT       NOT NULL REFERENCES socios (id)
                             ON DELETE NO ACTION ON UPDATE CASCADE
  , pelicula_id BIGINT       NOT NULL REFERENCES peliculas (id)
                             ON DELETE NO ACTION ON UPDATE CASCADE
  , create_at   TIMESTAMP(0) NOT NULL DEFAULT current_timestamp
  , devolucion  TIMESTAMP(0)
  , UNIQUE (socio_id, pelicula_id, create_at)

);

CREATE INDEX idx_alquileres_pelicula_id ON alquileres (pelicula_id);
CREATE INDEX idx_alquileres_created_at ON alquileres (create_at DESC);
