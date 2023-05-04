CREATE TABLE users
(
    id            INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    email         VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255)        NOT NULL,
    name          VARCHAR(255)        NOT NULL,
    created_at    TIMESTAMP           NOT NULL
);

CREATE TABLE practices
(
    id            INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    title         VARCHAR(255) NOT NULL,
    description   LONGVARCHAR  NOT NULL,
    steps         LONGVARCHAR,
    example       LONGVARCHAR,
    conclusion    LONGVARCHAR,
    user_id       INTEGER,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP,
    topic         VARCHAR(50)
        CONSTRAINT CHK_topic CHECK (topic IN ('Разработка', 'Анализ', 'Тестирование', 'Документирование', 'DevOps')),
    preview_image LONGVARCHAR,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE votes
(
    id          INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    user_id     INTEGER   NOT NULL,
    practice_id INTEGER   NOT NULL,
    vote_value  INTEGER   NOT NULL
        CONSTRAINT CHK_vote_value CHECK (vote_value IN (1, -1)),
    created_at  TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (practice_id) REFERENCES practices (id) ON DELETE CASCADE,
    UNIQUE (user_id, practice_id)
);