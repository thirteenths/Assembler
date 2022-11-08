FLAGS :=  -masm=intel -g 
OP1 := -m80387
OP2 := -mno-80387

#a.out: main.cpp
#	g++ $(FLAGS) main.cpp

#add.o: add.cpp
#	g++ $(FLAGS) -c add.cpp

main.o: main.cpp
	g++ $(FLAGS) -c main.cpp	
	
#mul.o: mul.cpp
#	g++ $(FLAGS) -c mul.cpp	

main.exe:  main.o 
	g++ -o main.exe $^

#run:
#	./a.out

clean:
	rm -f *.o *.exe *.out  