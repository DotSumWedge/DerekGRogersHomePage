FROM node:12

WORKDIR C:/Projects/Svelte/githubIOWebsite

COPY package*.json ./

RUN npm install

COPY . .

ENV PORT=5173

EXPOSE 5173

CMD [ "npm", "start" ]