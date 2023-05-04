DROP TABLE IF EXISTS votes;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS practices;

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
    user_id       INTEGER NOT NULL,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP,
    topic         VARCHAR(50)
        CONSTRAINT CHK_topic CHECK (topic IN ('Разработка', 'Анализ', 'Тестирование', 'Документирование', 'DevOps')),
    preview_image LONGVARCHAR,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

INSERT INTO users (email, password_hash, name, created_at)
VALUES ('example@example.com', 'encrypted_password_hash', 'John Doe', NOW());

INSERT INTO practices (title, description, topic, user_id)
VALUES ('Создание Dockerfile для Spring Boot приложения, собранного при помощи Gradle',
        'Использование ChatGPT для создания Dockerfile для Spring Boot приложения. На выходе получаем готовый Dockerfile, который используется для создания Docker образа и последующего развертывания приложения.',
        'DevOps', 1),
       ('Формирование логического описание БД на основе DDL (Quick documentation idea)',
        'Если уже есть база данных, и в ней присутствую какие-то записи, то можно методом Reverse Engineering получить логическое описание БД / Таблицы с помощью ChatGPT;',
        'Документирование', 1);