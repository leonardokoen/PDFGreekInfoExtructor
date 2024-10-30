# Use a base image with Python (choose the version you need, e.g., 3.11)
FROM python:3.11-slim

# Install system dependencies for Tesseract and other required libraries
RUN apt-get update && \
    apt-get install -y tesseract-ocr libtesseract-dev && \
    apt-get install -y gcc g++ && \
    apt-get clean

# Install Jupyter and other Python packages
RUN pip install --no-cache-dir jupyter

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt to the container to install dependencies
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code to the container
COPY . .

# Expose the port for Jupyter Notebook
EXPOSE 8888

# Set up an entrypoint to run Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
