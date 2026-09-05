FROM node:18-alpine AS builder

WORKDIR /evolution

RUN apk add --no-libc6-compat git

RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

RUN npm install -g pnpm
RUN pnpm install
RUN pnpm build

FROM node:18-alpine

WORKDIR /evolution

COPY --from=builder /evolution ./

ENV PORT=8080
EXPOSE 8080

CMD ["npm", "run", "start:prod"]
