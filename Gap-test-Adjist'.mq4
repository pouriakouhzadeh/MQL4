//+------------------------------------------------------------------+
//|                                             Gap-test-Adjist'.mq4 |
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
int q=1;
while (q!=0)
{
q++;
Comment(q,"-----",OrdersTotal()-1);

for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if (OrderType()==OP_BUY)
         {
            if (OrderStopLoss()!=(OrderClosePrice()-(20*Point())))
            {
               bool y=OrderModify(OrderTicket(),OrderOpenPrice(),OrderClosePrice()-(20*Point()),OrderTakeProfit(),Yellow);

            }
    
          
          
         }  
         
         if (OrderType()==OP_SELL)
         {
            if (OrderStopLoss()!=(OrderClosePrice()+(20*Point())))
            {
               bool y=OrderModify(OrderTicket(),OrderOpenPrice(),OrderClosePrice()+(20*Point()),OrderTakeProfit(),Yellow);
            }

         }            

         }  
         


         
         }          
          
          
          
          



   
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
   
  }
//+------------------------------------------------------------------+
