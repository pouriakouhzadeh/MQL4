//+------------------------------------------------------------------+
//|                                                         pips.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

static int i=0;
static int j=0;
static double last_bid=0;
static double i_bid=0;
static double j_bid=0;
static double init_bid=Bid;
int OnInit()
  {
//---
i=0;
last_bid=Bid;
 
      

                     ObjectCreate("name", OBJ_HLINE, 0, Time[0], Bid);
                     ObjectCreate("name1", OBJ_VLINE, 0, Time[0], Bid);                     
                    // ObjectSetText(name,MarketInfo(Symbol(),MODE_SPREAD)  ,9,NULL,clrBlue);
              
init_bid=Bid;
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
if (last_bid-Bid>0) 
{
j++;
j_bid=j_bid+(last_bid-Bid);
}
if (last_bid-Bid<0) 
{
i++;
i_bid=i_bid+(Bid-last_bid);
}
double ekhtelaf=0;
if(i>j) ekhtelaf=i-j;
if(i<j) ekhtelaf=j-i;
Comment("Number of Up tik =",i,
"\n","Number of Down tik=",j,
"\n","Ekhtelaf=",ekhtelaf,"\n",
"Init Bid-Current Bid=",MathAbs(init_bid-Bid)*MarketInfo(Symbol(),MODE_POINT)*10,
"\n","Total Down From init=",j_bid*MarketInfo(Symbol(),MODE_DIGITS),
"\n","Total Up From init=",i_bid*MarketInfo(Symbol(),MODE_DIGITS));

if (last_bid!=Bid) last_bid=Bid;


if(((MathAbs(init_bid-Bid)*MarketInfo(Symbol(),MODE_POINT)*10)-ekhtelaf) >10)
   {
      if(i>j)
      {
      //down
                     ObjectCreate("name2", OBJ_ARROW_SELL, 0, Time[0], Bid);        
      }
      if(i<j)
      {
      //up
                     ObjectCreate("name3", OBJ_ARROW_BUY, 0, Time[0], Bid);        
      }
   }
  }
//+------------------------------------------------------------------+
