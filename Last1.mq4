//+------------------------------------------------------------------+
//|                                                        Last1.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//---- indicator parameters
extern int       rsi_period=8;
extern int       rsi_price=PRICE_CLOSE;
extern bool      chk_rsi = false;
//+------------------------------------------------------------------+
extern int stoploss=280;
extern int takeprofit=280;
double lot=0.01;
int magic=0;
//extern int priod=48;
//extern double max=0.0017;
extern int ma_priod_5=5;
extern int ma_priod_200=200; 
static string signal="NO";
extern double n=20;
static int tiket;
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
lot =AccountBalance()/3000;


if (OrdersTotal()!=0) 
{
if (Ask>=iCustom("EURUSDe",15,"Trend_Bands",0,0)) bool x=OrderClose(tiket,lot,Ask,1,Black);
if (Bid<=iCustom("EURUSDe",15,"Trend_Bands",2,0)) bool x=OrderClose(tiket,lot,Bid,1,Black);
return; 
}
if (signal=="BUY")
if (Volume[0]<=1) 
{
signal="NO";

tiket=OrderSend("EURUSDe",OP_BUY,lot,Ask,6,Ask-stoploss*Point(),Ask+takeprofit*Point(),"Midunam ke mishe",magic,0,Blue);
}
if (signal=="SELL")
if(Volume[0]<=1)
{
signal="NO";

tiket=OrderSend("EURUSDe",OP_SELL,lot,Bid,6,Bid+stoploss*Point(),Bid+takeprofit*Point(),"midunam ke mishe",magic,0,Red);

}


if (ma("EURUSDe",60)=="BUY" && fxprime("EURUSDe",60)=="BUY")
{
signal="BUY";


}
if (ma("EURUSDe",60)=="SELL" && fxprime("EURUSDe",60)=="SELL") 
{
signal="SELL";
//int tiket=OrderSend("GBPUSDe",OP_SELL,lot,Bid,6,Bid+stoploss*Point(),Bid-takeprofit*Point(),"midunam ke mishe",magic,0,Red);
}

//Print ("FXPRIME =",fxprime("GBPUSDe",15),"-----","MA=",ma("GBPUSDe",15));  
  }
//+------------------------------------------------------------------+
//--------------INDICATORS------------------------
string fxprime (string market,int timeframe)
{
double fx1,fx2,fx3,fx4;
fx1=iCustom(market,timeframe,"FXprime_V2 Final-JE",0,0);
fx2=iCustom(market,timeframe,"FXprime_V2 Final-JE",1,0);
fx3=iCustom(market,timeframe,"FXprime_V2 Final-JE",3,0);
fx4=iCustom(market,timeframe,"FXprime_V2 Final-JE",4,0);

if (fx1>0)
   if (fx3>0) return ("BUY");

if (fx2<0)
   if (fx4>0) return("SELL");

if (fx1>0) 
   if(fx3<0) return("Near BUY");
   
if (fx2<0) 
   if(fx4<0) return("Near SELL");


return("NO");
}
string ma(string market,int timeframe)
{
double ma5_0,ma200_0,ma5_1,ma200_1,average=0;
ma5_0=iMA(market,timeframe,ma_priod_5,0,MODE_EMA,PRICE_MEDIAN,0);
ma200_0=iMA(market,timeframe,ma_priod_200,0,MODE_SMA,PRICE_MEDIAN,0);
ma5_1=iMA(market,timeframe,ma_priod_5,0,MODE_EMA,PRICE_MEDIAN,1);
ma200_1=iMA(market,timeframe,ma_priod_200,0,MODE_SMA,PRICE_MEDIAN,1);

if (ma5_1<=ma200_1 && ma5_0>ma200_0) return ("BUY");

if ((ma5_1>=ma200_1) && (ma5_0<ma200_0)) return ("SELL");

return("NO");
}




