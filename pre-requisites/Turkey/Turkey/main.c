//
//  main.c
//  Turkey
//
//  Created by Shawn Ellis Wallace on 3/15/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#include <stdio.h>

int main(int argc, const char * argv[])
{
    float weight;
    
    weight = 14.2;
    
    printf("The turkey weighs %f.\n", weight);
    
    float cookingTime;
    cookingTime = 15.0 + 15.0 * weight;
    printf("Cook it for %f minutes.\n", cookingTime);
    
    
    return 0;
}

