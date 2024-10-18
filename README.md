A **comprehensive guide** for deploying a **Node.js application on AWS Elastic Beanstalk using CodePipeline**. This guide includes detailed steps, **Dockerfile creation**, and all necessary **scripts**.

---

# **Deploy a Node.js Application on AWS Elastic Beanstalk with Docker using CodePipeline**

---

## **Step 1: Create a Node.js Application Locally**

### 1.1 Initialize the Node.js Project  
Open your terminal and create a new project folder:

```bash
mkdir node-beanstalk-docker-app && cd node-beanstalk-docker-app
```

Initialize a new Node.js project:

```bash
npm init -y
```

### 1.2 Install Dependencies  
Install **Express.js** to create a basic web server:

```bash
npm install express
```

### 1.3 Create the `index.js` File  
Create a file named `index.js`:

```javascript
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello from Node.js App on AWS Elastic Beanstalk using Docker!');
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
```

### 1.4 Test the Application Locally  
Add a start script to your `package.json`:

```json
"scripts": {
  "start": "node index.js"
}
```

Run the application:

```bash
npm start
```

Open your browser and go to `http://localhost:3000`. You should see the message:  
`Hello from Node.js App on AWS Elastic Beanstalk using Docker!`

---

## **Step 2: Create a Dockerfile for the Application**

Create a file named `Dockerfile` in your project folder with the following content:

```Dockerfile
# Use an official Node.js image from Docker Hub
FROM node:14-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the application's port
EXPOSE 3000

# Start the Node.js application
CMD ["npm", "start"]
```

---

## **Step 3: Test the Docker Container Locally**

1. **Build the Docker image**:

   ```bash
   docker build -t node-beanstalk-docker-app:latest .
   ```

2. **Run the Docker container**:

   ```bash
   docker run -d -p 3000:3000 node-beanstalk-docker-app:latest
   ```

3. **Verify the Application**:
   Open `http://localhost:3000` in your browser and ensure the app is running.

---

## **Step 4: Push Code to GitHub**

1. **Initialize Git**:

   ```bash
   git init
   git remote add origin https://github.com/your-username/node-beanstalk-docker-app.git
   ```

2. **Add and Commit Code**:

   ```bash
   git add .
   git commit -m "Initial commit with Dockerized Node.js app"
   ```

3. **Push to GitHub**:

   ```bash
   git branch -M main
   git push -u origin main
   ```

---

## **Step 5: Set Up AWS Elastic Beanstalk Environment**

1. **Open the AWS Elastic Beanstalk Console**.
2. Click **Create Application**.
3. **Application Name**: Enter `node-beanstalk-docker-app`.
4. **Platform**: Select **Docker**.
5. **Upload your Code**:
   - Choose **Upload your code** and select the **Dockerfile** from your project folder.
6. Click **Create Environment** and wait for the environment to launch.

---

## **Step 6: Create an S3 Bucket for Artifacts**

1. Open the **S3 Console**.
2. Click **Create Bucket** and name it `node-beanstalk-artifacts`.
3. Enable **Versioning** to keep track of changes.

---

## **Step 7: Create an AWS CodePipeline**

1. **Open the AWS CodePipeline Console**.
2. Click **Create Pipeline** and name it `node-beanstalk-pipeline`.
3. **Source Stage**:
   - Select **GitHub** and connect your GitHub account.
   - Choose the **repository** (`node-beanstalk-docker-app`) and **branch** (`main`).

4. **Build Stage (Optional)**:
   - If no build is needed, skip the **Build Stage**.

5. **Deploy Stage**:
   - Choose **Elastic Beanstalk** and select the environment you created earlier.

6. Click **Create Pipeline**.

---

## **Step 8: Test the CodePipeline and Deployment**

1. **Make a change** in your `index.js` file (e.g., update the welcome message).
2. **Commit and push the changes**:

   ```bash
   git add .
   git commit -m "Updated welcome message"
   git push origin main
   ```

3. **Monitor the pipeline** in the AWS Console to ensure the deployment completes successfully.

4. Open the **Elastic Beanstalk URL** to verify the updated application is live.

---

## **Step 9: Set Up CloudWatch Alarms for CodePipeline**

1. Open the **CloudWatch Console**.
2. Click **Create Alarm**.
3. **Select Metric**: Choose **CodePipeline Metrics** and select the **pipeline status**.
4. **Configure Alarm**:
   - Trigger the alarm on **Pipeline failure**.
5. **Set up Notification**:
   - Create an **SNS topic** and subscribe your email for notifications.
6. **Test the Alarm**:
   - Push invalid code to the GitHub repo and monitor the alarm.

---

## **Final Checklist**

1. **Ensure Docker is installed and running**.
2. **Verify the Elastic Beanstalk environment** is set up and functioning.
3. **Confirm GitHub integration** with CodePipeline.
4. **Test the full pipeline** with multiple commits and deployments.
5. **Create CloudWatch alarms** to monitor pipeline status.

---

## **Common Errors and Troubleshooting**

- **Elastic Beanstalk Deployment Fails**:
  - Check the **Elastic Beanstalk logs** for detailed error messages.
  - Ensure the **correct platform (Docker)** is selected.

- **Pipeline Fails at Source Stage**:
  - Verify **GitHub token permissions**.
  - Ensure the **repository and branch** names are correct.

- **Docker Container Fails to Run**:
  - Check for **port conflicts** (ensure port 3000 is available).
  - Use `docker logs <container_id>` to debug container errors.

---

This detailed guide ensures that Amit is fully prepared to deploy a **Node.js application on AWS Elastic Beanstalk using Docker** and **CodePipeline** for his DevOps mid-term exam.
