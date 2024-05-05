#include <stdio.h>
#include <Windows.h>

int fib(int n) {
    if (n <= 1)
        return n;
    return fib(n-1) + fib(n-2);
}

DWORD WINAPI fibThread(LPVOID param) {
    int n = *(int*)param;
    int result = fib(n);
    FILE* file = fopen("fibonacci.txt", "a");
    if (file) {
        fprintf(file, "Fibonacci number %d is %d\n", n, result);
        fclose(file);
    }
    return 0;
}

int main() {
    HANDLE threads[2];
    int n1 = 30, n2 = 35;

    // Создание мьютекса для синхронизации доступа к файлу
    HANDLE mutex = CreateMutex(NULL, FALSE, NULL);

    // Создание первого потока
    threads[0] = CreateThread(NULL, 0, fibThread, &n1, 0, NULL);

    // Создание второго потока
    threads[1] = CreateThread(NULL, 0, fibThread, &n2, 0, NULL);

    // Ожидание завершения потоков
    WaitForMultipleObjects(2, threads, TRUE, INFINITE);

    // Закрытие дескрипторов потоков
    for (int i = 0; i < 2; i++) {
        CloseHandle(threads[i]);
    }

    // Закрытие мьютекса
    CloseHandle(mutex);

    return 0;
}
