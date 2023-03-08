//+------------------------------------------------------------------+
//|                                               Hesam strategy.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict



extern int MA_PRIOD=13;
extern double SHIB_EMA=0.0005;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
Comment(EMA());

if(EMA()=="RANGE") 
{
for (int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),1,Black);
      }
}
if (OrdersTotal()>0) return;

if (EMA()=="UP") int ticket=OrderSend(Symbol(),OP_BUY,0.1,Ask,0,0,0,"You can win",1,0,Blue);


if(EMA()=="DOWN") int ticket=OrderSend(Symbol(),OP_SELL,0.1,Bid,0,0,0,"You can win",1,0,Blue);



  }
//+------------------------------------------------------------------+

string EMA()
{
double ma_last=iMA(Symbol(),240,MA_PRIOD,0,MODE_EMA,PRICE_CLOSE,2);
double ma=iMA(Symbol(),240,MA_PRIOD,0,MODE_EMA,PRICE_CLOSE,1);

if ((ma-ma_last)<0)
if (ma_last-ma<SHIB_EMA) return ("RANGE"); else return ("DOWN");

if ((ma-ma_last)>0)
if ((ma-ma_last)<SHIB_EMA) return("RANGE"); else return("UP");

return("ERROR");

}