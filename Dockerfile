FROM python:3.9-slim
WORKDIR /app

# Copy the requirements.txt file from the project's src directory
# on the local machine to the working directory (/app) inside the container.
COPY src/requirements.txt ./

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all files and folders from the project's src directory
# on the local machine to the working directory (/app) inside the container.
COPY src/ .

# Expose the port the application runs on
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]