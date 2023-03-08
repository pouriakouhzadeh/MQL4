//+------------------------------------------------------------------+
//|                                                    DT strtgy.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
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
   dt(15);
  }
//+------------------------------------------------------------------+

string dt(int timeframe)
{
double dt_red=iCustom(Symbol(),timeframe,"DT_Oscillator",0,1);
double dt_blue=iCustom(Symbol(),timeframe,"DT_Oscillator",1,1);
Print (dt_red,"----",dt_blue);
return("NO");
}
