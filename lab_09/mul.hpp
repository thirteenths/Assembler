#include "mul.h"

template<typename Type>
Type mul_asm(Type a, Type b)
{
	Type result = 0;

	asm(".intel_syntax noprefix" ENDL
		"fld %1" ENDL
		"fmul %2" ENDL
		"fstp %0" ENDL
		: "=m"(result)
		: "m"(a), "m"(b)
		:);

	return result;
}

template<typename Type>
Type mul_cpp(Type a, Type b)
{
	Type result = 0;

	result = a + b;

	return result;
}
