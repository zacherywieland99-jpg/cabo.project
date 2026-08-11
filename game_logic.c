#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

const char *suits[4] = {"spades", "clubs", "hearts", "diamonds"};
int organized_cards_object[52];

int deck_of_cards[52];
char scrambled[52];

struct card_structure
{
    const char *suits;
    int i;
};

struct card_structure all_cards[52];

int min_card = 0;
int random_num;

void create_cards()
{

    for (int p = 0; p < 4; p++)
    {

        for (int i = 0; i < 13; i++)
        {

            int card = p * 13 + i;

            all_cards[card].suits = suits[p];
            all_cards[card].i = i + 1;
        }
    }
}

void organize_cards()
{
    for (int m = 0; m < 52; m++)
    {
        organized_cards_object[m] = m;
    }
}

void scramble_cards()
{
    for (int m = 52; m > 0; m--)
    {

        int k = rand() % (m + 1);

        random_num = deck_of_cards[m];
        deck_of_cards[m] = deck_of_cards[k];
        deck_of_cards[k] = random_num;
    }

    for (int l = 0; l < 52; l++)
    {

        int card = deck_of_cards[l];

        // deck_of_cards[m] returns the scrambled array of integers
        // assign rand() nums to list of cards

        printf("%s-%d.jpg\n", all_cards[card].suits, all_cards[card].i);
    }
}

int main()
{

    printf("Welcome to card randomizer!\n");

    create_cards();
    organize_cards();
    scramble_cards();

    return 0;
}
