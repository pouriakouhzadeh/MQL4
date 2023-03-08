//+------------------------------------------------------------------+
//|                                                   Hesam Data.mq4 |
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
int filehandle;
extern string Currency_Pair="EURUSD";
extern string Market_Prefix="";
extern int Timeframe=5;
extern int Number_Of_Candle=1000;

int InpDepth=12;     // Depth
int InpDeviation=5;  // Deviation
int InpBackstep=3;   // Backstep



double open[100000];
double close[100000];
double high[100000];
double low[100000];
datetime time[100000];

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
Comment("Calculating ...");
   filehandle=FileOpen(Currency_Pair+Market_Prefix+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV); 
   FileWrite(filehandle,"Open"+","+"Close"+","+"High"+","+"Low"+","+"Time"); 


for (int i=1;i<=Number_Of_Candle;i++)
  {

      open[i]=iOpen(Currency_Pair+Market_Prefix,Timeframe,i);
      close[i]=iClose(Currency_Pair+Market_Prefix,Timeframe,i);
      high[i]=iHigh(Currency_Pair+Market_Prefix,Timeframe,i);
      low[i]=iLow(Currency_Pair+Market_Prefix,Timeframe,i);
      time[i]=iTime(Currency_Pair+Market_Prefix,Timeframe,i); 

   }  
   
   
 
for (int i=Number_Of_Candle;i>=1;i--)
  {

   if(filehandle!=INVALID_HANDLE) 
     { 
       
   
   
       FileWrite(filehandle,(DoubleToStr(open[i],10))+","+(DoubleToStr(close[i],10))+","+(DoubleToStr(high[i],10))+","+DoubleToStr(low[i],10)+","+(TimeToString(time[i],TIME_DATE|TIME_MINUTES))); 
  
     }

   }  
    
  
  
  
  
   FileClose(filehandle);

   
   Comment("Expert is runing good ....");  
  }
//+------------------------------------------------------------------+
