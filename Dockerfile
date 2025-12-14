FROM haskell:9.4.8

WORKDIR /app

COPY ./ /app

ENV PYTHONUNBUFFERED True

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

RUN stack setup --install-ghc && stack build

EXPOSE 8080

WORKDIR /app
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Run the entry point script
CMD ["/app/entrypoint.sh"]
