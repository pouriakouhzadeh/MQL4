//+------------------------------------------------------------------+
//|                                                         Corr.mq4 |
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
extern string FirstMarket="EURUSD";
extern string SecondMarket="USDSEK";
extern int timeframe=5;
extern int Priod=50;
extern string MarketPrefix="";


double aarray[20000];
double barray[20000];

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
 Comment (Correolation(FirstMarket+MarketPrefix,SecondMarket+MarketPrefix,timeframe,Priod)); 

  }
//+------------------------------------------------------------------+
double  Correolation(string A,string B,int time , int P)
{
double suma=0;
double sumb=0;
for (int i=1;i<=P;i++)  
   {
      aarray[i]=((iHigh(A,time,i)+iLow(A,time,i)+iClose(A,time,i))/3);
      barray[i]=((iHigh(B,time,i)+iLow(B,time,i)+iClose(B,time,i))/3);
      suma=suma+((iHigh(A,time,i)+iLow(A,time,i)+iClose(A,time,i))/3);
      sumb=sumb+((iHigh(B,time,i)+iLow(B,time,i)+iClose(B,time,i))/3);
  }
double averagea=suma/P;
double averageb=sumb/P;


double correlatin=0;
double sumup=0;
double sumdownx=0;
double sumdowny=0;

for (int i=1;i<=P;i++)
      {
       sumup=sumup+((aarray[i]-averagea)*(barray[i]-averageb));
       
       sumdownx=sumdownx+MathPow((aarray[i]-averagea),2);  
       sumdowny=sumdowny+MathPow((barray[i]-averageb),2);  

      }

correlatin=sumup/(MathSqrt(sumdownx*sumdowny));

//Print("sumup=",sumup,"down =",(MathSqrt(sumdownx*sumdowny)),"SUMDOWNX=",sumdownx,"SUMDOWNY",sumdowny);


return correlatin;
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
