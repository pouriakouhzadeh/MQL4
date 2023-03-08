//+------------------------------------------------------------------+
//|                                                EURUSD_USDCHF.mq4 |
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
static double Last_Day_Close;
       double Last_Day_Close_25;
extern string Market_Prefix="";
extern double LOTs=0.1;
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
   Last_Day_Close=iClose("USDCHF"+Market_Prefix,1440,1);
   Last_Day_Close_25=Last_Day_Close*0.0025;
 
   info();
   closeposition();
   if (OrdersTotal()>1) return;
   getposition();
  }
//+------------------------------------------------------------------+



void getposition()
{

   
   if(MarketInfo("USDCHF"+Market_Prefix,MODE_BID)>=Last_Day_Close+Last_Day_Close_25)
   if ((MarketInfo("USDCHF"+Market_Prefix,MODE_SPREAD)+MarketInfo("EURUSD"+Market_Prefix,MODE_SPREAD))<40)

   {
                                      ticket=OrderSend("USDCHF"+Market_Prefix,OP_SELL,LOTs,Bid,3,0,0,"AFSANEH",30,0,Blue);
                                      ticket=OrderSend("EURUSD"+Market_Prefix,OP_SELL,LOTs,Bid,3,0,0,"AFSANEH",30,0,Blue);
  
   }
   if(MarketInfo("USDCHF"+Market_Prefix,MODE_BID)<=Last_Day_Close-Last_Day_Close_25)
   if ((MarketInfo("USDCHF"+Market_Prefix,MODE_SPREAD)+MarketInfo("EURUSD"+Market_Prefix,MODE_SPREAD))<40)
   {
                                      ticket=OrderSend("USDCHF"+Market_Prefix,OP_BUY,LOTs,Ask,3,0,0,"AFSANEH",20,0,Blue);
                                      ticket=OrderSend("EURUSD"+Market_Prefix,OP_BUY,LOTs,Ask,3,0,0,"AFSANEH",20,0,Blue);
  
   }  
}

void closeposition()
{

   if (MarketInfo("USDCHF"+Market_Prefix,MODE_BID)<=Last_Day_Close)
   {
   //closesell

for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if (OrderType()==OP_SELL)
               {
               bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
               } 
                    
   }
   }
   
   if (MarketInfo("USDCHF"+Market_Prefix,MODE_BID)>=Last_Day_Close)
   {
   //closebuy
   
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if (OrderType()==OP_BUY)
               {
               bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
               } 
                    
   }   
   }
}

void info()
{

   Comment("Last Day Close =",Last_Day_Close,"\n","Last Day Close * 0.0025 =",Last_Day_Close_25,"\n","Last Day Close+0.0025 Persent =",Last_Day_Close+Last_Day_Close_25,"\n","Last Day Close-0.0025 Persent =",Last_Day_Close-Last_Day_Close_25,"\n","Curent Price =",MarketInfo("USDCHF"+Market_Prefix,MODE_BID),"\n","Total Spread =",(MarketInfo("USDCHF"+Market_Prefix,MODE_SPREAD)+MarketInfo("EURUSD"+Market_Prefix,MODE_SPREAD)));

}