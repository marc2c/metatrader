// HOLA
//+--------------------------------------------+
//|                              orderslib.mq4 |
//|                        Developed by marc2c |
//|                       https://www.mql5.com |
//+--------------------------------------------+
#property library
#property copyright "Copyright 2017, marc2c"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

const int SLEEP_TIME = 1000;

bool CloseAllOrders(int magicNumber) export
{
    int i;
    bool result = true;

    while (OrdersTotal() > 0) {
        for (i=OrdersTotal()-1; i>=0; i--) {
            if (!OrderSelect(i, SELECT_BY_POS)) {
                continue;
            }

            if ((OrderMagicNumber() == magicNumber) && (OrderSymbol() == Symbol())) {
                if (OrderType() == OP_BUY) {
                    if (!OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 15, Red)) {
                        result = false;
                    }
                }
                if (OrderType() == OP_SELL) {
                    if (!OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 15, Red)) {
                        result = false;
                    }
                }
            }
        }

        Sleep(SLEEP_TIME);
    }

    return result;
}
