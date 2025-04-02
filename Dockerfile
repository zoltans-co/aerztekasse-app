# Build lépés
FROM node:18-alpine as builder

# A munkakönyvtár beállítása
WORKDIR /app

# Dockerfile-ban biztosítsd, hogy a node_modules újraépüljön
RUN rm -rf node_modules

RUN npm rebuild better-sqlite3 --build-from-source

# Package fájlok másolása és függőségek telepítése
COPY package.json package-lock.json ./
RUN npm install

# Az összes forrásfájl másolása
COPY . .

# Nuxt alkalmazás buildelése
RUN npm run build

# Production lépés
FROM node:18-alpine as runner

# A munkakönyvtár beállítása
WORKDIR /app

# Csak a szükséges fájlokat másoljuk át a builderből
COPY --from=builder /app/.output ./.output
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

# A szerver futtatásához szükséges port megnyitása
EXPOSE 3000

# Indítási parancs
CMD ["node", ".output/server/index.mjs"]
