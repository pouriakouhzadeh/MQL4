//+------------------------------------------------------------------+
//|                                                          QQE.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+\
extern int SF=5;
extern int RSI_Priod=50;
extern double DARFACTOR=4.236;

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
  if(QQE()!=("NO"))
   Print(QQE());
  }
//+------------------------------------------------------------------+
string QQE()
{

double A1=0;
double A2=0;
double A1_Last=0;
double A2_Last=0;

A1= iCustom(Symbol(),0,"QQE_Scalping",SF,RSI_Priod,DARFACTOR,0,1);
A2= iCustom(Symbol(),0,"QQE_Scalping",SF,RSI_Priod,DARFACTOR,1,1);

A1_Last= iCustom(Symbol(),0,"QQE_Scalping",SF,RSI_Priod,DARFACTOR,0,2);
A2_Last= iCustom(Symbol(),0,"QQE_Scalping",SF,RSI_Priod,DARFACTOR,1,2);

//Comment(A1,"\n",A2,"\n",A1_Last,"\n",A2_Last);
if((A1<A2)&&(A1_Last>A2_Last)) return("SELL");
if((A1>A2)&&(A1_Last<A2_Last)) return("BUY");

return "NO";
}