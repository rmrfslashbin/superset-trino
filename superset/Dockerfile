FROM apache/superset:2.1.0
# Switching to root to install the required packages
USER root
RUN pip install trino
# Switching back to using the `superset` user
USER superset
