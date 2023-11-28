
import time
from multiprocessing import Pool

start_time = time.time()

# Function to calculate Fibonacci number - a CPU-intensive task


def fibonacci(n):
    if n <= 1:
        return n
    else:
        return fibonacci(n-1) + fibonacci(n-2)

# Function to run the task in parallel


def run_parallel(num_processes, n):
    with Pool(num_processes) as pool:

        results = pool.map(fibonacci, [n] * num_processes)
        end_time = time.time()
        return end_time - start_time, results

# Function to run the task sequentially


def run_sequential(num_processes, n):
    start_time = time.time()
    results = [fibonacci(n) for _ in range(num_processes)]
    end_time = time.time()
    return end_time - start_time, results


if __name__ == '__main__':
    # Number of processes and Fibonacci number to calculate
    num_processes = 4
    n = 35

    # Running in parallel
    parallel_time, parallel_results = run_parallel(num_processes, n)
    print(f'Parallel execution time: {parallel_time:.2f} seconds')

    # Running sequentially
    sequential_time, sequential_results = run_sequential(num_processes, n)
    print(f'Sequential execution time: {sequential_time:.2f} seconds')
