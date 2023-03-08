//+------------------------------------------------------------------+
//|                                                    Time 3-15.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern int PIPs=10;
extern int TimeLenth=3;


int tiket;
extern double LOTs=0.1;
extern int Magic_NO=100;
double Stoplos=0;
double Takeprofit=0;



double Spread=0;
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
//Print(Spread_Calculator());

if (Volume[0]<=1)
   {
   
//Print(MarketInfo(Symbol(),MODE_POINT)*150);
      if (MathAbs(iOpen(Symbol(),1,TimeLenth)-iClose(Symbol(),1,1))>MarketInfo(Symbol(),MODE_POINT)*PIPs*10)
         {

           if (Spread_Calculator())
           {
         
               if ((iOpen(Symbol(),1,TimeLenth)-iClose(Symbol(),1,1)>0))
               {
               //------BUY Condition ----------
                  Print("BUY at ",TimeCurrent());
                  Stoplos=Bid-((iOpen(Symbol(),1,TimeLenth)-iClose(Symbol(),1,1)));
                  Takeprofit=Ask+((iOpen(Symbol(),1,TimeLenth)-iClose(Symbol(),1,1))/2);
                  tiket=OrderSend(Symbol(),OP_BUY,LOTs,Ask,2,Stoplos,Takeprofit,"It is near",Magic_NO,0,Blue);

               }
               
         
               if ((iOpen(Symbol(),1,TimeLenth)-iClose(Symbol(),1,1)<0))
               {
               //------SELL Condition ----------
                  Print("SELL at ",TimeCurrent());    
                  Stoplos=Bid+(MathAbs((iOpen(Symbol(),1,TimeLenth)-iClose(Symbol(),1,1))));
                  Takeprofit=Bid+((iOpen(Symbol(),1,TimeLenth)-iClose(Symbol(),1,1))/2);
                  tiket=OrderSend(Symbol(),OP_SELL,LOTs,Bid,2,Stoplos,Takeprofit,"It is near",Magic_NO,0,Red);                             
               
               
               }               
         
            }
         }
   }
   
   
  }
//+------------------------------------------------------------------+

bool Spread_Calculator()
{
Comment(MarketInfo(Symbol(),MODE_SPREAD),"\n",
iOpen(Symbol(),1,TimeLenth)-iClose(Symbol(),1,1));

if(MathAbs((iOpen(Symbol(),1,TimeLenth)-iClose(Symbol(),1,1))/2)>(MarketInfo(Symbol(),MODE_SPREAD)*MarketInfo(Symbol(),MODE_POINT)*2)) return true;
else return false;
}