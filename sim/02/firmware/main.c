// main.c
// this doesnt have a type, its just unsiged ...?
volatile unsigned *led = (unsigned *)0x10000000;

int main(void) {

	*(volatile unsigned*)0x00000020 = 0x12345678;  // some RAM address
//	*(volatile unsigned*)0x00000020 = 0x00000001;  // some RAM address



	// do something observable (modify memory, spin, etc.)
	for (volatile int i = 0; i < 1000; i++) { }

	*(volatile unsigned*)0x10000000 = 0x12345678;
//	if (led) *led = 0x12345678; // harmless store if nothing mapped


	while (1) { }               // don't return


	return 0;
}




