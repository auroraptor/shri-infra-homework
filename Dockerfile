FROM node:20.14.0-alpine as build
WORKDIR /usr/src/app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем исходный код
COPY . .

# Сборка проекта
RUN npm run build

FROM node:20.14.0-alpine
WORKDIR /usr/src/app

# Копируем собранные файлы из предыдущего этапа
COPY --from=build /usr/src/app .

# Устанавливаем глобально ts-node и typescript
RUN npm install -g ts-node typescript

# Запускаем приложение
CMD ["ts-node", "./src/server/index.ts"]
