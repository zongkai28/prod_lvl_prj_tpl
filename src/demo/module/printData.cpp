#include "printData.hpp"
#include <iostream>


using namespace std;


void printData::print(int i)
{
    cout << "integrate is:" << i << endl;
}

void printData::print(double f)
{
    cout << "float is:" << f << endl;
}

void printData::print(char c[])
{
    cout << "string is:" << c << endl;
}
