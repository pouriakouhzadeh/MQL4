//+------------------------------------------------------------------+
//|                                                   golden eye.mq4 |
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
extern int ADXPeriod=5, DiPlusPeriod = 21, DiMinusPeriod=21;
extern int ma_method=1;
extern int DSma_period=8;
extern int DSma_method=3;

//--------------Bolinger band--------
extern int    InpBandsPeriod=20;      // Bands Period
extern int    InpBandsShift=0;        // Bands Shift
extern double InpBandsDeviations=2.0; // Bands Deviations


extern int stoploss=280;
extern int takeprofit=280;
double lot=0.01;
int magic=0;
static int tiket;
static string signal="NO";
double G1,G2,ADX,bh,bm,bl,pulback;
extern double ADXfactor=25;
extern double pulbackfactor=1.5;
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


   
 G1=iCustom(Symbol(),15,"BOSTS_1",0,0); 
 G2=iCustom(Symbol(),15,"BOSTS_1",1,0);
 Print(G1,"-------",G2,"-------",ADX);
if (OrdersTotal()!=0) 
{
if (G1!=2147483647.0)
if(signal=="BUY") 
{
bool x=OrderClose(tiket,lot,Bid,1,Black);
//Print("BUY CLOSE");
}


if(G2!=2147483647.0)
if(signal=="SELL") 
{
bool x=OrderClose(tiket,lot,Ask,1,Black);
//Print("SELL CLOSE");
}

return; 
}

if ((G1!=2147483647.0)&& (G2!=2147483647.0)) return; 

 pulback=iCustom(Symbol(),1,"Pullback-Factor",0,0);
 ADX=iCustom(Symbol(),15,"ADX_varSmz_+DI-DI",ADXPeriod,DiPlusPeriod,DiMinusPeriod,ma_method,DSma_period,DSma_method,0,0);
 bh=iCustom(Symbol(),15,"Bands",InpBandsPeriod,InpBandsShift,InpBandsDeviations,1,0);
 //bm=iCustom(Symbol(),1,"Bands",InpBandsPeriod,InpBandsShift,InpBandsDeviations,0,0);
 bl=iCustom(Symbol(),15,"Bands",InpBandsPeriod,InpBandsShift,InpBandsDeviations,2,0);
 
 Print(pulback);

if ((G1!=2147483647.0) && (G1>bh) && (ADX>ADXfactor)&& (pulback>pulbackfactor))
{
signal="SELL";
tiket=OrderSend(Symbol(),OP_SELL,lot,Bid,6,Bid+stoploss*Point(),Bid-takeprofit*Point(),"midunam ke mishe",magic,0,Red);
}

if ((G2!=2147483647.0) && (G2<bl) && (ADX>ADXfactor)&& (pulback>pulbackfactor))
{
signal="BUY";
tiket=OrderSend(Symbol(),OP_BUY,lot,Ask,6,Ask-stoploss*Point(),Ask+takeprofit*Point(),"Midunam ke mishe",magic,0,Blue);
} 

 
  
   }
//+------------------------------------------------------------------+
