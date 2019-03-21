#include "lab2.h"
#include <cstring> // need this for strerror
#include <fcntl.h>
#include <iostream>
#include <pthread.h>
#include <semaphore.h>

// abc
// bcd
// ce
// hif
// ghi
// ik

// compile with -lpthreads

// #define NUMBER_OF_C_THREADS 1
// #define NUMBER_OF_P_THREADS 1
#define NUMBER_OF_THREADS 11

pthread_t tid[NUMBER_OF_THREADS];
pthread_mutex_t lock; // critical section lock
sem_t *semA, *semB, *semC, *semD, *semE, *semF, *semG, *semH, *semI, *semK;

unsigned int lab2_task_number() { return 9; }

int const sleep = 1000;

void *thread_newline(void *ptr) {
  sleep_ms(3);

  for (int i = 0; i < 5; ++i) {
    pthread_mutex_lock(&lock);
    std::cout << "\n" << std::flush;
    pthread_mutex_unlock(&lock);
    sleep_ms(sleep);
  }
  return ptr;
}

void *thread_a(void *ptr) {
  pthread_mutex_lock(&lock);
  std::cout << "a" << std::flush;
  pthread_mutex_unlock(&lock);

  sleep_ms(sleep);
  sem_post(semA);
  return ptr;
}

void *thread_b(void *ptr) {
  int const count = 2;
  for (int i = 0; i < count; ++i) {
    pthread_mutex_lock(&lock);
    std::cout << "b" << std::flush;
    pthread_mutex_unlock(&lock);
    sleep_ms(sleep);
  }
  sem_post(semB);
  return ptr;
}

void *thread_c(void *ptr) {
  int const count = 3;
  for (int i = 0; i < count; ++i) {
    pthread_mutex_lock(&lock);
    std::cout << "c" << std::flush;
    pthread_mutex_unlock(&lock);
    sleep_ms(sleep);
  }

  sem_post(semC);
  sem_post(semC);
  sem_post(semC);
  return ptr;
}

void *thread_d(void *ptr) {
  sem_wait(semA);

  pthread_mutex_lock(&lock);
  std::cout << "d" << std::flush;
  pthread_mutex_unlock(&lock);

  sleep_ms(sleep);
  sem_post(semD);
  return ptr;
}

void *thread_e(void *ptr) {
  sem_wait(semB);
  sem_wait(semD);

  pthread_mutex_lock(&lock);
  std::cout << "e" << std::flush;
  pthread_mutex_unlock(&lock);

  sleep_ms(sleep);

  sem_post(semE);
  sem_post(semE);
  sem_post(semE);
  return ptr;
}

void *thread_f(void *ptr) {
  sem_wait(semE);
  sem_wait(semC);

  pthread_mutex_lock(&lock);
  std::cout << "f" << std::flush;
  pthread_mutex_unlock(&lock);

  sleep_ms(sleep);
  sem_post(semF);
  return ptr;
}

void *thread_g(void *ptr) {
  sem_wait(semF);

  pthread_mutex_lock(&lock);
  std::cout << "g" << std::flush;
  pthread_mutex_unlock(&lock);

  sleep_ms(sleep);
  sem_post(semG);
  return ptr;
}

void *thread_h(void *ptr) {
  int const count = 2;
  sem_wait(semE);
  sem_wait(semC);

  for (int i = 0; i < count; ++i) {
    pthread_mutex_lock(&lock);
    std::cout << "h" << std::flush;
    pthread_mutex_unlock(&lock);
    sleep_ms(sleep);
  }

  sem_post(semH);
  return ptr;
}

void *thread_i(void *ptr) {
  int const count = 3;
  sem_wait(semE);
  sem_wait(semC);

  for (int i = 0; i < count; ++i) {
    pthread_mutex_lock(&lock);
    std::cout << "i" << std::flush;
    pthread_mutex_unlock(&lock);
    sleep_ms(sleep);
  }

  sem_post(semI);
  return ptr;
}

void *thread_k(void *ptr) {
  sem_wait(semG);
  sem_wait(semH);

  pthread_mutex_lock(&lock);
  std::cout << "k" << std::flush;
  pthread_mutex_unlock(&lock);

  sem_post(semK);
  return ptr;
}

int lab2_init() {
  int err;
  // initilize mutex
  if (pthread_mutex_init(&lock, NULL) != 0) {
    std::cerr << "Mutex init failed" << std::endl;
    return 1;
  }
  // initialize semaphores
  if ((semA = sem_open("/my_semaphore_semA", O_CREAT, 0777, 0)) == SEM_FAILED) {
    std::cerr << "Semaphore semA init failed" << std::endl;
    return 1;
  }
  if ((semB = sem_open("/my_semaphore_semB", O_CREAT, 0777, 1)) == SEM_FAILED) {
    std::cerr << "Semaphore semB init failed" << std::endl;
    return 1;
  }
  if ((semC = sem_open("/my_semaphore_semC", O_CREAT, 0777, 1)) == SEM_FAILED) {
    std::cerr << "Semaphore semC init failed" << std::endl;
    return 1;
  }
  if ((semD = sem_open("/my_semaphore_semD", O_CREAT, 0777, 1)) == SEM_FAILED) {
    std::cerr << "Semaphore semD init failed" << std::endl;
    return 1;
  }
  if ((semE = sem_open("/my_semaphore_semE", O_CREAT, 0777, 1)) == SEM_FAILED) {
    std::cerr << "Semaphore semE init failed" << std::endl;
    return 1;
  }
  if ((semF = sem_open("/my_semaphore_semF", O_CREAT, 0777, 1)) == SEM_FAILED) {
    std::cerr << "Semaphore semF init failed" << std::endl;
    return 1;
  }
  if ((semG = sem_open("/my_semaphore_semG", O_CREAT, 0777, 1)) == SEM_FAILED) {
    std::cerr << "Semaphore semG init failed" << std::endl;
    return 1;
  }
  if ((semH = sem_open("/my_semaphore_semH", O_CREAT, 0777, 1)) == SEM_FAILED) {
    std::cerr << "Semaphore semH init failed" << std::endl;
    return 1;
  }
  if ((semI = sem_open("/my_semaphore_semI", O_CREAT, 0777, 1)) == SEM_FAILED) {
    std::cerr << "Semaphore semI init failed" << std::endl;
    return 1;
  }

  if ((semK = sem_open("/my_semaphore_semK", O_CREAT, 0777, 1)) == SEM_FAILED) {
    std::cerr << "Semaphore semK init failed" << std::endl;
    return 1;
  }

  // start the threads
  unsigned int thread_count = 0;

  {
    err = pthread_create(&tid[thread_count], NULL, thread_a, (void *)NULL);
    if (err != 0)
      std::cerr << "Can't create thread. Error: " << strerror(err) << std::endl;
    else
      ++thread_count;
  }

  {
    err = pthread_create(&tid[thread_count], NULL, thread_b, (void *)NULL);
    if (err != 0)
      std::cerr << "Can't create thread. Error: " << strerror(err) << std::endl;
    else
      ++thread_count;
  }

  {
    err = pthread_create(&tid[thread_count], NULL, thread_c, (void *)NULL);
    if (err != 0)
      std::cerr << "Can't create thread. Error: " << strerror(err) << std::endl;
    else
      ++thread_count;
  }

  {
    err = pthread_create(&tid[thread_count], NULL, thread_d, (void *)NULL);
    if (err != 0)
      std::cerr << "Can't create thread. Error: " << strerror(err) << std::endl;
    else
      ++thread_count;
  }

  {
    err = pthread_create(&tid[thread_count], NULL, thread_e, (void *)NULL);
    if (err != 0)
      std::cerr << "Can't create thread. Error: " << strerror(err) << std::endl;
    else
      ++thread_count;
  }

  {
    err = pthread_create(&tid[thread_count], NULL, thread_f, (void *)NULL);
    if (err != 0)
      std::cerr << "Can't create thread. Error: " << strerror(err) << std::endl;
    else
      ++thread_count;
  }
  {
    err = pthread_create(&tid[thread_count], NULL, thread_g, (void *)NULL);
    if (err != 0)
      std::cerr << "Can't create thread. Error: " << strerror(err) << std::endl;
    else
      ++thread_count;
  }
  {
    err = pthread_create(&tid[thread_count], NULL, thread_h, (void *)NULL);
    if (err != 0)
      std::cerr << "Can't create thread. Error: " << strerror(err) << std::endl;
    else
      ++thread_count;
  }
  {
    err = pthread_create(&tid[thread_count], NULL, thread_i, (void *)NULL);
    if (err != 0)
      std::cerr << "Can't create thread. Error: " << strerror(err) << std::endl;
    else
      ++thread_count;
  }
  {
    err = pthread_create(&tid[thread_count], NULL, thread_k, (void *)NULL);
    if (err != 0)
      std::cerr << "Can't create thread. Error: " << strerror(err) << std::endl;
    else
      ++thread_count;
  }

  {
    err =
        pthread_create(&tid[thread_count], NULL, thread_newline, (void *)NULL);
    if (err != 0)
      std::cerr << "Can't create thread. Error: " << strerror(err) << std::endl;
    else
      ++thread_count;
  }

  // wait for threads to finish
  for (int i = 0; i < thread_count; ++i) {
    pthread_join(tid[i], NULL);
  }

  // destroy mutex
  pthread_mutex_destroy(&lock);
  // close semaphores
  sem_close(semA);
  sem_close(semB);
  sem_close(semC);
  sem_close(semD);
  sem_close(semE);
  sem_close(semF);
  sem_close(semG);
  sem_close(semH);
  sem_close(semI);
  sem_close(semK);
  // destroy semaphores
  sem_unlink("/my_semaphore_semA");
  sem_unlink("/my_semaphore_semB");
  sem_unlink("/my_semaphore_semC");
  sem_unlink("/my_semaphore_semD");
  sem_unlink("/my_semaphore_semE");
  sem_unlink("/my_semaphore_semF");
  sem_unlink("/my_semaphore_semG");
  sem_unlink("/my_semaphore_semH");
  sem_unlink("/my_semaphore_semI");
  sem_unlink("/my_semaphore_semK");
  // print a new line
  std::cout << std::endl;
  return 0;
}
