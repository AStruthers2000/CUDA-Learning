
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <iostream>
#include <exception>


__global__ void addTwo(int* a, int* b, int* c){
	int i = threadIdx.x;
	c[i] = a[i] + b[i];
}

int main() {

	srand(time(NULL));
	const int arrLength = 1000;

	int a[arrLength];
	int b[arrLength];
	int c[arrLength];

	for (int i = 0; i < arrLength; i++) {
		a[i] = rand() % 100;
		b[i] = rand() % 100;
	}

	addTwo<<<1, 32>>>(a, b, c);

}