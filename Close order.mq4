//+------------------------------------------------------------------+
//|                                                  Close order.mq4 |
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
double orderprofit[10];
double LOTs=1;
static double min=0;
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
for(int i=0;i<10;i++)
{
orderprofit[i]=0;
}


for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      orderprofit[i]=OrderProfit()+OrderCommission()+OrderSwap();
      
   }   
double sum=0;
for(int i=0;i<10;i++)
{
sum=sum+orderprofit[i];
}
if (sum<min) min=sum;

Comment("Orders Profit= ",sum,"\n","Min= ",min);
if(sum>50*LOTs)
{

for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      bool c=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),6,Gold);
      
   }  
}




   
  }
//+------------------------------------------------------------------+
