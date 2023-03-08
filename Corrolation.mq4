//+------------------------------------------------------------------+
//|                                                  Corrolation.mq4 |
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

extern string First_Currency="EURUSD";
extern string Second_Currency="GBPUSD";
extern int First_Currency_Zarbdar=1;
extern int Second_Currency_zarbdar=1;
extern string Market_Prefix="";


int OnInit()
  {
//---
   filehandle=FileOpen(First_Currency+"_"+Second_Currency+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV); 
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
              FileClose(filehandle);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

if(Volume[0]<=1) 
  {

   if(filehandle!=INVALID_HANDLE) 
     { 
      FileWrite(filehandle,First_Currency+Market_Prefix,iClose(First_Currency+Market_Prefix,0,1),Second_Currency+Market_Prefix,iClose(Second_Currency+Market_Prefix,0,1),First_Currency+"*X-"+Second_Currency+"*X",(iClose(First_Currency+Market_Prefix,0,1)*First_Currency_Zarbdar)-(iClose(Second_Currency+Market_Prefix,0,1)*Second_Currency_zarbdar),"Time",TimeCurrent()); 

     }

 
  }
  }
//+------------------------------------------------------------------+
