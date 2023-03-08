//+------------------------------------------------------------------+
//|                                              MACD_DIVERGANCE.mq4 |
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
Calc();
   
  }
//+------------------------------------------------------------------+


void Calc()
{
double Data[101];
double Data_MACD[101];

double Max=0;
int index=0;
int index_return=0;

for(int i=2;i<=100;i++)
   {
     index_return=i;       
     Data_MACD[i]=iMACD(Symbol(),0,12,26,9,PRICE_CLOSE,MODE_MAIN,i);
     Data[i]=iHigh(Symbol(),0,i);
     if ((Data[i]>Max)&&(Data_MACD[i]>0)) { Max=Data[i]; index=i;}
     
         if (Data_MACD[i]<0) i=101;

   }

double Max_MACD=iMACD(Symbol(),0,12,26,9,PRICE_CLOSE,MODE_MAIN,index);
double Current_MACD=iMACD(Symbol(),0,12,26,9,PRICE_CLOSE,MODE_MAIN,1);
double Curren_Price=iHigh(Symbol(),0,1);
Comment("Max=",Max,"\n","Max_MACD=",Max_MACD,"\n","Current Price=",Curren_Price,"\n","Current+MACD=",Current_MACD,"\n","Index=",index_return); 

if ((Curren_Price>(Max+(200*MarketInfo(Symbol(),MODE_POINT)))) && (Max_MACD>Current_MACD) && (Max!=0) && (Max_MACD>0))
   {
   Alert(Symbol(),"  Divergance +","Time =",TimeCurrent() );
   }
   
if ((Curren_Price>Max) && (Max_MACD>Current_MACD+0.0002) && (Max!=0) && (Max_MACD>0))
   {
   Alert(Symbol(),"  Divergance +","Time =",TimeCurrent() );
   } 
   

if ((Curren_Price>(Max+(100*MarketInfo(Symbol(),MODE_POINT)))) && (Max_MACD>Current_MACD+0.0001) && (Max!=0) && (Max_MACD>0))
   {
   Alert(Symbol(),"  Divergance +","Time =",TimeCurrent() );
   }   
     
}