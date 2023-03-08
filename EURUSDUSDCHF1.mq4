//+------------------------------------------------------------------+
//|                                                EURUSDUSDCHF1.mq4 |
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
double Last_Close_EURUSD;
double Last_Close_USDCHF;
extern string Market_Prefix="";
extern double Profit=0.0005;
extern double LOTs=0.1;
double Spreads;
int ticket;
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
      Last_Close_EURUSD=iClose("EURUSD"+Market_Prefix,60,1);
      Last_Close_USDCHF=iClose("USDCHF"+Market_Prefix,60,1); 
      Spreads=((MarketInfo("USDCHF"+Market_Prefix,MODE_SPREAD)+MarketInfo("EURUSD"+Market_Prefix,MODE_SPREAD))*MarketInfo("EURUSD"+Market_Prefix,MODE_POINT));      
      Comment ("Last_Close_EURUSD=",Last_Close_EURUSD,"\n","Last_Close_USDCHF=",Last_Close_USDCHF,"\n","Spreads=",Spreads);     
      
      closeposition();
      getposition();
      
  }
//+------------------------------------------------------------------+


void getposition()
{
 
   if (OrdersTotal()>1) return;

   if(MarketInfo("USDCHF"+Market_Prefix,MODE_BID)>=Last_Close_USDCHF+Spreads+Profit)
   if(MarketInfo("EURUSD"+Market_Prefix,MODE_BID)>=Last_Close_EURUSD+Spreads+Profit)
   {
   
                       ticket=OrderSend("EURUSD"+Market_Prefix,OP_SELL,LOTs,MarketInfo("EURUSD"+Market_Prefix,MODE_BID),3,0,0,"AFSANEH",30,0,Blue);
                       ticket=OrderSend("USDCHF"+Market_Prefix,OP_SELL,LOTs,MarketInfo("USDCHF"+Market_Prefix,MODE_BID),3,0,0,"AFSANEH",30,0,Blue);

   }
   
   
   
   if(MarketInfo("USDCHF"+Market_Prefix,MODE_BID)<=(Last_Close_USDCHF-(Spreads+Profit)))
   if(MarketInfo("EURUSD"+Market_Prefix,MODE_BID)<=(Last_Close_EURUSD-(Spreads+Profit)))
   {
                       ticket=OrderSend("EURUSD"+Market_Prefix,OP_BUY,LOTs,MarketInfo("EURUSD"+Market_Prefix,MODE_ASK),3,0,0,"AFSANEH",20,0,Blue);
                       ticket=OrderSend("USDCHF"+Market_Prefix,OP_BUY,LOTs,MarketInfo("USDCHF"+Market_Prefix,MODE_ASK),3,0,0,"AFSANEH",20,0,Blue);

   }
      

}

void closeposition()
{

double orderprofit=0;
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      orderprofit=orderprofit+(OrderProfit()+OrderCommission()+OrderSwap());
   }      

if(orderprofit>=5)
{
//close all
   
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
               bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
   }   
}
}   

 
 