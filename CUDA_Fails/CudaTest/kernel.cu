
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <iostream>
#include <exception>


__global__ void addTwo(int* a, int* b, int* c){
	//int i = threadIdx.x;
	//int stride = blockDim.x;
	//printf("I am threadIdx.x = %d and I have a stride of %d\n", i, stride);
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	printf("Thread %d on block %d has block dim %d and should update index %d\n", threadIdx.x, blockIdx.x, blockDim.x, i);
	c[i] = a[i] + b[i];
}

int main(int argc, char** argv) {

	srand(time(NULL));
	int arrLength = 1000000;
	if (argc == 2)
	{
		arrLength = atoi(argv[1]);
	}

	int* a;
	int* b;
	int* c;

	cudaMallocManaged(&a, arrLength * sizeof(int));
	cudaMallocManaged(&b, arrLength * sizeof(int));
	cudaMallocManaged(&c, arrLength * sizeof(int));

	for (int i = 0; i < arrLength; i++) {
		a[i] = rand() % 100;
		b[i] = rand() % 100;
	}

	addTwo<<<2, 32>>>(a, b, c);
	cudaDeviceSynchronize();

	for (int i = 0; i < arrLength; i++)
	{
		printf("a[%d] = %d\tb[%d] = %d\tc[%d] = %d\n", i, a[i], i, b[i], i, c[i]);
	}
}