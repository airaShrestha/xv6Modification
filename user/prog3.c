#include "kernel/types.h" 
#include "kernel/stat.h" 
#include "user/user.h" 
int main(int argc, char *argv[]) 
{ 
    //FUNCTION_SETS_NUMBER_OF_TICKETS(30);    // write your own function here
		set_tickets(10);
    int i,k; 
    const int loop=100; // adjust this parameter depending on your system speed 
    for(i=0;i<loop;i++) 
    { 
        asm("nop");  // to prevent the compiler from optimizing the for-loop 
        for(k=0;k<loop;k++) 
        { 
           asm("nop"); 
        } 
    } 
    sched_statistics();  // syscall 
	 exit(0);
} 