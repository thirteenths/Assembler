#include "add.h"

template<typename Type>
Type add_asm(Type a, Type b)
{
	Type result = 0;

	asm(".intel_syntax noprefix" ENDL 
		"fld %1" ENDL				  // Загрузить вещественное число из источника в стек. st(0) == a
		"fadd %2" ENDL				  // Добавить к вершине стека b.  st(0) += b
		"fstp %0" ENDL				  // FSTP - считать число с вершины стека в приёмник. result = st(0)
		: "=m"(result)				  // список выходных параметров. (m == memory (Т.е. разместить в памяти))
		: "m"(a), "m"(b)			  // список входных параметров.
		:);

	return result;
}

template<typename Type>
Type add_cpp(Type a, Type b)
{
	Type result = 0;

	result = a + b;

	return result;
}