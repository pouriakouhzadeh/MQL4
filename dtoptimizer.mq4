//+------------------------------------------------------------------+
//|                                                  dtoptimizer.mq4 |
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
//-----------------H1---------------------

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
         




   extern int    PeriodRSI_D1  =13;
   extern int    PriceRSI_D1   = 0;
      // 0=PRICE_CLOSE
      // 1=PRICE_OPEN
      // 2=PRICE_HIGH
      // 3=PRICE_LOW
      // 4=PRICE_MEDIAN
      // 5=PRICE_TYPICAL
   // 6=PRICE_WEIGHTED
   extern int    PeriodStoch_D1= 8;
   extern int    PeriodSK_D1   = 5;
   extern int    PeriodSD_D1   = 3;
   extern int MAMode_D1=0;
         //    0 = SMA
         //    1 - EMA
         //    2 - SMMA
         //    3 - LWMA



extern double LOT=0.2;
static int tiket;

extern int dt_max=80;
extern int dt_min=20;

extern int dt_max_d1=80;
extern int dt_min_d1=20;


extern int Brak_Out_Pip=200;

extern int Number_Of_Candle_Count_For_Stoploss=15;
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
   string dtd1result=("Dayli Drirection = "+dt_D1()); 
   ObjectCreate("comment_label",OBJ_LABEL,0,0,0);
   ObjectSet("comment_label",OBJPROP_XDISTANCE,1);
   ObjectSet("comment_label",OBJPROP_YDISTANCE,10);
   ObjectSetText("comment_label",dtd1result,20,"Arial",Yellow);
   WindowRedraw();
   
   
  moneymangment(); 
  if (OrdersTotal()>=1)  
  {
     return;
  
  }
if ((dt_D1()=="UP") && (dt_H1()=="BUY"))
{
                  double stoploss=(iLow(Symbol(),0,iLowest(Symbol(),0,MODE_LOW,Number_Of_Candle_Count_For_Stoploss,0))-0.00010);
                  tiket=OrderSend(Symbol(),OP_BUY,LOT,Ask,6,stoploss,3.00000,"You can win if you want",1000,0,Blue);
}
 
 
if ((dt_D1()=="DOWN") && (dt_H1()=="SELL"))
{
                  double stoploss=(iHigh(Symbol(),0,iHighest(Symbol(),0,MODE_HIGH,Number_Of_Candle_Count_For_Stoploss,0))+0.00010);
                  tiket=OrderSend(Symbol(),OP_SELL,LOT,Bid,6,stoploss,0.00001,"You can win if you want",2000,0,Red); 
}
    
  }
//+------------------------------------------------------------------+

string dt_D1()
{

if (((iHighest(Symbol(),1440,MODE_HIGH,15,0))==1) || (iHighest(Symbol(),1440,MODE_HIGH,15,0)==2)) return ("UP"); 
if (((iLowest(Symbol(),1440,MODE_LOW,15,0)==1))   || (iLowest(Symbol(),1440,MODE_LOW,15,0)==2))   return ("DOWN"); 


double dt_red0=iCustom(Symbol(),1440,"DT Pouria","D1",PeriodRSI_D1,PriceRSI_D1,PeriodStoch_D1,PeriodSK_D1,PeriodSD_D1,MAMode_D1,0,1);
double dt_blue0=iCustom(Symbol(),1440,"DT Pouria","D1",PeriodRSI_D1,PriceRSI_D1,PeriodStoch_D1,PeriodSK_D1,PeriodSD_D1,MAMode_D1,0,1);
double dt_red1=iCustom(Symbol(),1440,"DT Pouria","D1",PeriodRSI_D1,PriceRSI_D1,PeriodStoch_D1,PeriodSK_D1,PeriodSD_D1,MAMode_D1,1,2);
double dt_blue1=iCustom(Symbol(),1440,"DT Pouria","D1",PeriodRSI_D1,PriceRSI_D1,PeriodStoch_D1,PeriodSK_D1,PeriodSD_D1,MAMode_D1,1,2);




if((dt_blue1<dt_blue0)  && (dt_red1<dt_red0)) return("UP");

if(((dt_blue1==dt_blue0)  && (dt_red1==dt_red0)) && ((dt_blue0<dt_min) &&(dt_red0<dt_min))) return("DOWN");

if((dt_blue1>dt_blue0) && (dt_red1>dt_red0)) return("DOWN");

if(((dt_blue1==dt_blue0)  && (dt_red1==dt_red0)) && ((dt_blue0>dt_max) &&(dt_red0>dt_max))) return("UP");



return("NO");

}



void moneymangment()
{

double dt_red0=iCustom(Symbol(),60,"DT Pouria","H1",PeriodRSI,PriceRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,0,0);
double dt_blue0=iCustom(Symbol(),60,"DT Pouria","H1",PeriodRSI,PriceRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,1,0);

if ((dt_red0>dt_max)&&(dt_blue0>dt_max))
{
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

   if (OrderType()==OP_BUY)
      if(OrderMagicNumber()==1000)
          if(OrderTakeProfit()==3.0)
               {
                  double stoploss=(iLow(Symbol(),60,iLowest(Symbol(),60,MODE_LOW,2,0))-0.00010);
                  bool c=OrderClose(OrderTicket(),(OrderLots()/2),OrderClosePrice(),3,Gold);
                  bool m=OrderSelect(OrdersTotal()-1,SELECT_BY_POS,MODE_TRADES);                  
                  bool z=OrderModify(OrderTicket(),OrderOpenPrice(),stoploss,2.99999,0,Gold);
               }
   }
}
if ((dt_red0<dt_min)&&(dt_blue0<dt_min))
{
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

   if (OrderType()==OP_SELL)
      if(OrderMagicNumber()==2000)
          if(OrderTakeProfit()==0.00001)
               {
                  double stoploss=(iHigh(Symbol(),60,iHighest(Symbol(),60,MODE_HIGH,2,0))+0.00010);
                  bool c=OrderClose(OrderTicket(),(OrderLots()/2),OrderClosePrice(),3,Gold);
                  bool m=OrderSelect(OrdersTotal()-1,SELECT_BY_POS,MODE_TRADES);                  
                  bool z=OrderModify(OrderTicket(),OrderOpenPrice(),stoploss,0.00002,0,Gold);
               }

   }
}
double dt_red0_d1=iCustom(Symbol(),1440,"DT Pouria","D1",PeriodRSI_D1,PriceRSI_D1,PeriodStoch_D1,PeriodSK_D1,PeriodSD_D1,MAMode_D1,0,1);
double dt_blue0_d1=iCustom(Symbol(),1440,"DT Pouria","D1",PeriodRSI_D1,PriceRSI_D1,PeriodStoch_D1,PeriodSK_D1,PeriodSD_D1,MAMode_D1,0,1);
if ((dt_red0_d1>dt_max_d1)&&(dt_blue0_d1>dt_max_d1))
{
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

   if (OrderType()==OP_BUY)
      if(OrderMagicNumber()==1000)
          if(OrderTakeProfit()==2.99999)
               {
                  double stoploss=(iLow(Symbol(),1440,iLowest(Symbol(),1440,MODE_LOW,2,0))-0.00010);
                  bool z=OrderModify(OrderTicket(),OrderOpenPrice(),stoploss,2.99998,0,Gold);
               }
   }
}
if ((dt_red0_d1<dt_min)&&(dt_blue0_d1<dt_min))
{
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

   if (OrderType()==OP_SELL)
      if(OrderMagicNumber()==2000)
          if(OrderTakeProfit()==0.00002)
               {
                  double stoploss=(iHigh(Symbol(),1440,iHighest(Symbol(),1440,MODE_HIGH,2,0))+0.00010);
                  bool z=OrderModify(OrderTicket(),OrderOpenPrice(),stoploss,0.00003,0,Gold);
               }

   }
}


}

string dt_H1()
{
double dt_red0=iCustom(Symbol(),60,"DT Pouria","H1",PeriodRSI,PriceRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,0,0);
double dt_blue0=iCustom(Symbol(),60,"DT Pouria","H1",PeriodRSI,PriceRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,1,0);
double dt_red1=iCustom(Symbol(),60,"DT Pouria","H1",PeriodRSI,PriceRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,0,1);
double dt_blue1=iCustom(Symbol(),60,"DT Pouria","H1",PeriodRSI,PriceRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,1,1);

if((dt_red0<=dt_min)&&(dt_blue0<=dt_min))
if((dt_blue1<=dt_blue0)  && (dt_red1<=dt_red0)) return("BUY");

if((dt_red0>=dt_max)&&(dt_blue0>=dt_max))
if((dt_blue1>=dt_blue0) && (dt_red1>=dt_red0)) return("SELL");


return("NO");


}
