
import time
import os
import random
from multiprocessing import Pool

# More demanding CPU-bound task
def fibonacci(n):
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a

# More demanding memory-intensive task
def memory_intensive_task(size):
    random_list = [random.random() for _ in range(size)]
    random_list.sort()
    return True

# More demanding I/O-intensive task
def io_intensive_task(size):
    filename = f'tempfile_{os.getpid()}.dat'
    with open(filename, 'w') as file:
        for _ in range(size):
            file.write(str(random.random()) + '\n')
    with open(filename, 'r') as file:
        data = file.readlines()
    os.remove(filename)
    return True

# Function to run tasks in parallel
def run_parallel(num_processes, task, arg):
    with Pool(num_processes) as pool:
        start_time = time.time()
        results = pool.map(task, [arg] * num_processes)
        end_time = time.time()
        return end_time - start_time, results

# Function to run tasks sequentially
def run_sequential(num_processes, task, arg):
    start_time = time.time()
    results = [task(arg) for _ in range(num_processes)]
    end_time = time.time()
    return end_time - start_time, results

if __name__ == '__main__':
    num_processes = 4
    fib_number = 500000  # More demanding Fibonacci calculation
    list_size = 10000000  # Larger list for memory-intensive task
    io_size = 100000     # More data for I/O-intensive task

    # Testing CPU-bound task
    cpu_parallel_time, _ = run_parallel(num_processes, fibonacci, fib_number)
    cpu_sequential_time, _ = run_sequential(num_processes, fibonacci, fib_number)
    print(f'CPU-bound Task (Parallel): {cpu_parallel_time:.2f} seconds')
    print(f'CPU-bound Task (Sequential): {cpu_sequential_time:.2f} seconds')

    # Testing memory-intensive task
    mem_parallel_time, _ = run_parallel(num_processes, memory_intensive_task, list_size)
    mem_sequential_time, _ = run_sequential(num_processes, memory_intensive_task, list_size)
    print(f'Memory-intensive Task (Parallel): {mem_parallel_time:.2f} seconds')
    print(f'Memory-intensive Task (Sequential): {mem_sequential_time:.2f} seconds')

    # Testing I/O-intensive task
    io_parallel_time, _ = run_parallel(num_processes, io_intensive_task, io_size)
    io_sequential_time, _ = run_sequential(num_processes, io_intensive_task, io_size)
    print(f'I/O-intensive Task (Parallel): {io_parallel_time:.2f} seconds')
    print(f'I/O-intensive Task (Sequential): {io_sequential_time:.2f} seconds')
