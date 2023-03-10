//+------------------------------------------------------------------+
//|                                                                  |
//|                                                                  |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "www"


#property link      "www"
#property version   "1.00"
#property strict
static datetime lastbar;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  { 
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
  if (isNewBar())
  {
  
      string name = IntegerToString(MathRand());
                     ObjectCreate(name, OBJ_TEXT, 0, Time[0], Bid+50*Point);
                     ObjectSetText(name,MarketInfo(Symbol(),MODE_SPREAD)  ,9,NULL,clrBlue);
              
  }
}




//+------------------------------------------------------------------+

 
 bool isNewBar() 
{ 
   datetime curbar = Time[0]; 
   if(lastbar!=curbar) 
   { 
      lastbar=curbar; 
      return (true); 
   }    
   else 
   { 
      return(false); 
   } 
 }