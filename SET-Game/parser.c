#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_CARDS 12	// limits the range of inputs
#define MAX_IN 9		// max input "xx xx xx\0" = 8 chars
#define DELIMS " \t\r\n"

int cards[4];

void sort (int numbers[], int count) {
	int i, j, k, temp;
	
	do {
		j = 0;
		for (i = 0;i<=count;i++){
			if (i<=count-2 || i<count-1){
	                    j = 1;
	                    temp = numbers[i];
	                    numbers[i] = numbers[i+1];
	                    numbers[i+1] = temp;
	                }
	            }
	} while (j == 1);
}

int* get_user_input () {

	while (1) { // continue to get input until a valid input is parsed
		printf ("#: ");
		fflush (stdout);
		
		// reset user input array
		char input[MAX_IN] = {0};
		
		// read the user input
		if (!fgets(input, MAX_IN, stdin)) {
			printf ("Error reading input.\n");
			continue;
		}
		
		// reset array
		cards[0] = 0; cards[1] = 0; cards[2] = 0; cards[3] = 100;
		char *token = {0};
		int i = 0;
		
		// parse input into seperate tokens and store them into an array
		if (input != NULL && (input[0] != '\n')) {
			token = strtok (input, DELIMS);		// retrieve first token
			for (;*token;++token) *token = tolower(*token);

			// OPTIONS //////////////////////////////////////////////////////////
			if (strcmp(token, "exit") || strcmp(token, "quit")) {
				cards[3] = 0;
				return cards;
			}
			else if (strcmp(token, "cards")) {
				cards[3] = 1;
				return cards;
			}
			else if (strcmp(token, "results")) {
				cards[3] = 2;
				return cards;
			}
			else {
				////////////////////////////////////////////////////////////////////
				while (token != NULL && i < 3) {	// parse the token
					errno = 0;
					char *garbage = NULL;
					long l_value = strtol(token, &garbage, 0);
					switch (errno) {
						case ERANGE:
							printf("ERROR: Input cannot be represented as an integer.\n"
							       "       Out of (long int) range. Please try again.\n");
							break;
						case EINVAL:
						    printf("ERROR: Unsupported base / radix. Please try again.\n");
						    break;
					}
					if (strlen(garbage) > 0) {
						printf("ERROR: Input contains unsupported characters for base: %s. "
						       "Please try again.\n", garbage);
						errno = 98;
					}
					if (!(l_value >= 0 && l_value < MAX_CARDS)) {
						printf("ERROR: Input out of range of selectable cards.\n");
						errno = 99;
					}
					if (errno != 0) break;
	
					// only valid inputs make it pase this point
					cards[i++] = l_value;
					token = strtok (NULL, DELIMS); // retrieve the next token
				}
				////////////////////////////////////////////////////////////////////
			}
		}
		if (errno != 0) continue;
		if (i > 2) break;
	}
	
	// get here only after a valid array has been constructed
	sort(cards, 4);
	return cards;
}
