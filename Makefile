
.PHONY: static dynamic test
static:
	gcc -c dense/ptlWindowManager.m -o build/ptlWindowManager.o
	ar rc out/libptlWindowManager.0.0.1.a build/ptlWindowManager.o

dynamic:
	gcc -c dense/ptlWindowManager.m -o build/ptlWindowManager.o
	gcc -dynamiclib dense/ptlWindowManager.m -o out/libptlWindowManager.0.0.1.dylib -framework Cocoa -framework Foundation -framework QuartzCore -compatibility_version 0.0.1 -current_version 0.0.1 
	install_name_tool -id @executable_path/../Frameworks/libptlWindowManager.0.0.1.dylib out/libptlWindowManager.0.0.1.dylib # automatically good for use in .app
	
out/test: test/test.cpp
	gcc test/test.cpp -o out/test -L/out -lptlWindowManager.0.0.1

test: out/test
	out/test
