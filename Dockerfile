# Stage 1: Build the Angular app
FROM node:18 as build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular app in production mode
RUN npm run build 

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Copy the build output to replace the default Nginx contents.
COPY --from=build /app/dist/YOUR_APP_NAME /usr/share/nginx/html

# Copy custom nginx configuration if needed
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose the port the app will run on
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]