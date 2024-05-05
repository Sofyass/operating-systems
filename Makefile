CC = gcc
CFLAGS = -Wall -Wextra

# Список объектных файлов
OBJS = main.o fib.o

# Имя исполняемого файла
TARGET = fibonacci

# Правило для сборки исполняемого файла
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

# Правило для компиляции main.c
main.o: main.c fib.h
	$(CC) $(CFLAGS) -c main.c

# Правило для компиляции fib.c
fib.o: fib.c fib.h
	$(CC) $(CFLAGS) -c fib.c

# Чистка (удаление объектных файлов и исполняемого файла)
clean:
	rm -f $(OBJS) $(TARGET)