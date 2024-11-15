FROM gcc:latest

WORKDIR /app

COPY src/hello.c .

RUN gcc -o hello hello.c

CMD ["./hello"]