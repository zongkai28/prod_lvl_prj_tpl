#include <iostream>

#include "printData.hpp"


int main(void)
{
    printData pd;

    pd.print(5);

    pd.print(500.263);

    char c[] = "hello c++";

    pd.print(c);

    return 0;
}