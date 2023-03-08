//+------------------------------------------------------------------+
//|                                                EURUSDUSDCHF3.mq4 |
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
extern string Market_Prefix="";
extern int MA_Priod=13;
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
  getposition();
  }
//+------------------------------------------------------------------+
void getposition()
{
      double MA_EURUSD=0;
      double MA_USDCHF=0;
      double Bid_EURUSD=0;
      double Bid_USDCHF=0;
      double Spreads=0;
      double EURUSD_PLUS_USDCHF_MA=0;
      double EURUSD_MINES_MA=0;
      double USDCHF_MINES_MA=0;
      MA_EURUSD=iMA("EURUSD"+Market_Prefix,0,MA_Priod,0,MODE_EMA,PRICE_CLOSE,0);
      MA_USDCHF=iMA("USDCHF"+Market_Prefix,0,MA_Priod,0,MODE_EMA,PRICE_CLOSE,0);
      Bid_EURUSD=MarketInfo("EURUSD"+Market_Prefix,MODE_BID);
      Bid_USDCHF=MarketInfo("USDCHF"+Market_Prefix,MODE_BID);
      Spreads=(((MarketInfo("USDCHF"+Market_Prefix,MODE_SPREAD)+MarketInfo("EURUSD"+Market_Prefix,MODE_SPREAD))*MarketInfo("EURUSD"+Market_Prefix,MODE_POINT))*10000);      
      EURUSD_MINES_MA=Bid_EURUSD-MA_EURUSD;
      USDCHF_MINES_MA=Bid_USDCHF-MA_USDCHF;
      EURUSD_PLUS_USDCHF_MA=EURUSD_MINES_MA+USDCHF_MINES_MA;
      
      
       Comment("MA_EURUSD=",MA_EURUSD,"\n",
               "MA_USDCHF=",MA_USDCHF,"\n",
               "Bid_EURUSD=",Bid_EURUSD,"\n",
               "Bid_USDCHF=",Bid_USDCHF,"\n",
               "Spreads=",Spreads,"\n",
               "EURUSDPLUSUSDCHFMA=",EURUSD_PLUS_USDCHF_MA,"\n",
               "EURUSDMINESMA=",EURUSD_MINES_MA,"\n",
               "USDCHFMINESMA=",USDCHF_MINES_MA
               );
               
               
if (Spreads<4)
if (EURUSD_PLUS_USDCHF_MA>0.001)
{
Alert(TimeCurrent());


}
                 
      
      
 


}