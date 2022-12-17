#include "gtest/gtest.h"

#include <iostream>

#include "printData.hpp"


using namespace std;


TEST(printData, printData_print)
{
    printData pd;

    pd.print(5);

    pd.print(500.263);

    char c[] = "hello c++";

    pd.print(c);
}
