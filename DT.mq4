//+------------------------------------------------------------------+
//|                                                           DT.mq4 |
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
extern int dt_max=70;
extern int dt_min=30;
extern int timeframe=1440;


   extern string TimeFrame  = "Current time frame";
   extern int    PeriodRSI  =13;
   extern int    PriceRSI   = 0;
      // 0=PRICE_CLOSE
      // 1=PRICE_OPEN
      // 2=PRICE_HIGH
      // 3=PRICE_LOW
      // 4=PRICE_MEDIAN
      // 5=PRICE_TYPICAL
   // 6=PRICE_WEIGHTED
   extern int    PeriodStoch= 8;
   extern int    PeriodSK   = 5;
   extern int    PeriodSD   = 3;
   extern int MAMode=0;
         //    0 = SMA
         //    1 - EMA
         //    2 - SMMA
         //    3 - LWMA

extern double LOT=0.2;
static int tiket;
extern int Candle=15;

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
  


  if (OrdersTotal()>=1) 
  {
    closeorder();
  return;
  }
  closeorder();
//---
if (Volume[0]<=1)
{
  
   if(dt()=="BUY")
   {
                  double stoploss=(iLow(Symbol(),0,iLowest(Symbol(),0,MODE_LOW,Candle,0))-0.00010);
                  tiket=OrderSend(Symbol(),OP_BUY,LOT,Ask,6,stoploss,2.00000,"You can win if you want",1000,0,Blue);                  
   }
   
   
   if(dt()=="SELL")   
   {
   
                  double stoploss=(iHigh(Symbol(),0,iHighest(Symbol(),0,MODE_HIGH,Candle,0))+0.00010);
                  Print(stoploss);
                  tiket=OrderSend(Symbol(),OP_SELL,LOT,Bid,6,stoploss,0.00001,"You can win if you want",2000,0,Red);    
   
   }
  }

}
//+------------------------------------------------------------------+
string dt()
{
double dt_red0=iCustom(Symbol(),timeframe,"DT Pouria",TimeFrame,PeriodRSI,PriceRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,0,0);
double dt_blue0=iCustom(Symbol(),timeframe,"DT Pouria",TimeFrame,PeriodRSI,PriceRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,1,0);
double dt_red1=iCustom(Symbol(),timeframe,"DT Pouria",TimeFrame,PeriodRSI,PriceRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,0,1);
double dt_blue1=iCustom(Symbol(),timeframe,"DT Pouria",TimeFrame,PeriodRSI,PriceRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,1,1);

if((dt_red0<=dt_min)&&(dt_blue0<=dt_min))
if((dt_blue1<=dt_blue0)  && (dt_red1<=dt_red0)) return("BUY");

if((dt_red0>=dt_max)&&(dt_blue0>=dt_max))
if((dt_blue1>=dt_blue0) && (dt_red1>=dt_red0)) return("SELL");


return("NO");


}

void closeorder()
{
double dt_red0=iCustom(Symbol(),timeframe,"DT Pouria",TimeFrame,PeriodRSI,PriceRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,0,0);
double dt_blue0=iCustom(Symbol(),timeframe,"DT Pouria",TimeFrame,PeriodRSI,PriceRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,1,0);

if((dt_red0>=dt_max)&&(dt_blue0>=dt_max))
{
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
        if (OrderType()==OP_BUY)
        if(OrderMagicNumber()==1000)
        bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),6,Black);
   }
}
//
//
//
//
//
if((dt_red0<=dt_min)&&(dt_blue0<=dt_min))
{
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
        if (OrderType()==OP_SELL)
        if(OrderMagicNumber()==2000)
        bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),6,Black);
   }
}



}
