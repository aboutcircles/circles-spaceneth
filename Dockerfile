FROM nethermind/nethermind

# Install required packages
RUN apt-get update && \
    apt-get install -y libfaketime python3 python3-flask && \
    rm -rf /var/lib/apt/lists/*

# Copy configuration files
COPY ./circles-chainspec.json /nethermind/chainspec/circles.json
COPY ./circles-config.cfg /nethermind/configs/circles.cfg

# Set libfaketime to 'real time'
ENV FAKETIME="+0 x1" FAKETIME_NO_CACHE=1

# Copy the Python script for the API
COPY ./time_controller.py /app/time_controller.py

# Expose the API port
EXPOSE 5000

# Start the API and Nethermind
ENTRYPOINT ["sh", "-c", "python3 /app/time_controller.py"]
