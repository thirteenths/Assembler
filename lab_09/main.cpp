#include <iostream>
#include <cmath>
#include <ctime>
using namespace std;

#include "add.hpp"
#include "mul.hpp"

#define ENDL "\n\t"
#define OK 0

void sin_result()
{
    double result = 0;
    double pi1 = 3.14;
    double pi2 = 3.141596;
    cout << "sin(3.14) = " << sin(pi1) << endl;
    cout << "sin(3.141596) = " << sin(pi2) << endl;
    asm(".intel_syntax noprefix" ENDL
		"FLDPI" ENDL
        "fsin" ENDL
		"fstp %0" ENDL
		: "=m"(result)
		:);
    cout << "fsin: " << result << endl;

    cout << endl;

	//cout << pi_1 / 2;
	double pi1_2 = pi1 / 2;
	double pi2_2 = pi2 / 2;
    cout << "sin(3.14 / 2.) = " << sin(pi1_2) << endl;
    cout << "sin(3.141596 / 2.) = " << sin(pi2_2) << endl;
    double a = 2;
    asm(".intel_syntax noprefix" ENDL
		"FLDPI" ENDL
        "fdiv %1" ENDL
        "fsin" ENDL
		"fstp %0" ENDL
		: "=m"(result)
        : "m"(a)
		:);
    cout << "fsin: " << result << endl;
}

int main()
{
    double a, b;
    double result;
	//cout << "Inpup a, b: ";
    //cin >> a >> b;
    //result = add(a, b);
    //cout << "Result add: " << result << endl;
	//result = mul(a, b);
	///cout << "Result mul: " << result << endl;

	double start_time;
	double end_time;

	double double_a = 2.3;
	double double_b = 6.5;

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		add_asm(double_a, double_b);
	end_time = clock();

	cout << "ADD ASM of double: " << end_time - start_time << endl;

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		add_cpp(double_a, double_b);
	end_time = clock();

	cout << "ADD C++ of double: " << end_time - start_time << endl;

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		mul_asm(double_a, double_b);
	end_time = clock();

	cout << "MUL ASM of double: " << end_time - start_time << endl;

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		mul_cpp(double_a, double_b);
	end_time = clock();

	cout << "MUL C++ of double: " << end_time - start_time << endl;

	long double long_double_a = 2.3;
	long double long_double_b = 6.5;

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		//add(long_double_a, long_double_b);
	end_time = clock();

	//cout << end_time - start_time << endl;

	float float_a = 2.3;
	float float_b = 6.5;

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		add_asm(float_a, float_b);
	end_time = clock();

	cout << "ADD ASM of float " << end_time - start_time << endl;

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		add_cpp(float_a, float_b);
	end_time = clock();

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		mul_asm(float_a, float_b);
	end_time = clock();

	cout << "MUL ASM of float " << end_time - start_time << endl;

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		mul_cpp(float_a, float_b);
	end_time = clock();

	cout << "MUL C++ of float " << end_time - start_time << endl;


	int int_a = 2;
	int int_b = 6;

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		add_asm(int_a, int_b);
	end_time = clock();

	cout << "ADD ASM of int " << end_time - start_time << endl;

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		add_cpp(int_a, int_b);
	end_time = clock();

	cout << "ADD C++ of int " << end_time - start_time << endl;

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		mul_asm(int_a, int_b);
	end_time = clock();

	cout << "MUL ASM of int " << end_time - start_time << endl;

	start_time = clock();
	for (int i = 0 ; i < 1000000; i++)
		mul_cpp(int_a, int_b);
	end_time = clock();

	cout << "MUL C++ of int " << end_time - start_time << endl;

    sin_result();
    return OK;
}