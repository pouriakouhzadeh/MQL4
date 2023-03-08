//+------------------------------------------------------------------+
//|                                                       candel.mq4 |
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
//  if (((candle("EURUSDe",240,1)=="HU") && (candle("EURUSDe",240,2)=="HU")) || ((candle("EURUSDe",240,1)=="HU") && (candle("EURUSDe",240,2)=="HUR")) || ((candle("EURUSDe",240,1)=="HUR") && (candle("EURUSDe",240,2)=="HUR")) || ((candle("EURUSDe",240,1)=="HUR") && (candle("EURUSDe",240,2)=="HU"))) 
//  Print("BUY h4");
//  if (((candle("EURUSDe",60,1)=="HU") && (candle("EURUSDe",60,2)=="HU")) || ((candle("EURUSDe",60,1)=="HU") && (candle("EURUSDe",60,2)=="HUR")) || ((candle("EURUSDe",60,1)=="HUR") && (candle("EURUSDe",60,2)=="HUR")) || ((candle("EURUSDe",60,1)=="HUR") && (candle("EURUSDe",60,2)=="HU"))) 
//  Print("BUY h1"); 
//  if (((candle("EURUSDe",30,1)=="HU") && (candle("EURUSDe",30,2)=="HU")) || ((candle("EURUSDe",30,1)=="HU") && (candle("EURUSDe",30,2)=="HUR")) || ((candle("EURUSDe",30,1)=="HUR") && (candle("EURUSDe",30,2)=="HUR")) || ((candle("EURUSDe",30,1)=="HUR") && (candle("EURUSDe",30,2)=="HU"))) 
//  Print("BUY 30");
  if (((candle("EURUSDe",15,1)=="HU") && (candle("EURUSDe",15,2)=="HU")) || ((candle("EURUSDe",15,1)=="HU") && (candle("EURUSDe",15,2)=="HUR")) || ((candle("EURUSDe",15,1)=="HUR") && (candle("EURUSDe",15,2)=="HUR")) || ((candle("EURUSDe",15,1)=="HUR") && (candle("EURUSDe",15,2)=="HU"))) 
  Print("BUY 15"); 
  }
//+------------------------------------------------------------------+
string candle(string market,int timeframe,int shift)
{
double boddy=0;
double boddy1=0;
double lenth=0;
lenth=iHigh(market,timeframe,shift)-iLow(market,timeframe,shift);
double y=0;
if (timeframe==240) y=0.00200;
if (timeframe==60) y=0.00160;
if (timeframe==15) y=0.00100;
if (timeframe==30) y=0.00130;
if (lenth<y) return "NO";

if((iOpen(market,timeframe,shift)-iClose(market,timeframe,shift))>0)  boddy=iOpen(market,timeframe,shift)-iClose(market,timeframe,shift);
if((iOpen(market,timeframe,shift)-iClose(market,timeframe,shift))<0)  boddy=iClose(market,timeframe,shift)-iOpen(market,timeframe,shift);
if((iOpen(market,timeframe,shift)-iClose(market,timeframe,shift))==0)  boddy=0.00001;
boddy1=iOpen(market,timeframe,shift)-iClose(market,timeframe,shift);
double x=(lenth/boddy);
if (x>=2.5)
{ 
            if (boddy1>0)
            {
                  if ((iHigh(market,timeframe,shift)-iOpen(market,timeframe,shift))<=(lenth/=6) || (iHigh(market,timeframe,shift)-iOpen(market,timeframe,shift)==0) )
                          if (Volume[0]<=1)
                           //Print ("Hammer up ","---","ihigh=",iHigh(market,timeframe,shift),"ilow",iLow(market,timeframe,shift),"---",lenth,"-----",boddy,"----",x);
                           return "HU";
               
                  if ((iClose(market,timeframe,shift)-iLow(market,timeframe,shift))<=(lenth/=6) || (iClose(market,timeframe,shift)-iLow(market,timeframe,shift)==0) )
                          if (Volume[0]<=1)
                           //Print ("Hammer down ","---","ihigh=",iHigh(market,timeframe,shift),"ilow",iLow(market,timeframe,shift),"---",lenth,"-----",boddy,"----",x);
                          return "HD"; 
            }

            if (boddy1<0)
            {
                  if ((iHigh(market,timeframe,shift)-iClose(market,timeframe,shift))<=(lenth/=6) || (iHigh(market,timeframe,shift)-iClose(market,timeframe,shift)==0) )
                          if (Volume[0]<=1)
                           //Print ("Hammer up revers ","---",lenth,"-----",boddy,"----",x);
                           return "HUR";   
                  if ((iOpen(market,timeframe,shift)-iLow(market,timeframe,shift))<=(lenth/=6) || (iOpen(market,timeframe,shift)-iLow(market,timeframe,shift)==0) )
                          if (Volume[0]<=1)
                           //Print ("Hammer down revers ","---",lenth,"-----",boddy,"----",x);
                          return "HDR";
            }
}
return "NO";
}
                           