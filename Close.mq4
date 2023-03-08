//+------------------------------------------------------------------+
//|                                                        Close.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
extern string First_currency="";
extern string Second_currency="";
extern string Market_Prefix="";
extern double TotalProfit_PIPs=0;
extern double LOTs=0;
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
double ordersprofit=0; 
for (int i=OrdersTotal()-1;i>=0;i--)
   {
   

      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
//               Comment ("Current orderProfit =",OrderProfit());
                 if ((OrderSymbol()==First_currency+Market_Prefix) || (OrderSymbol()==Second_currency+Market_Prefix)) 
                 ordersprofit=ordersprofit+OrderProfit()+OrderSwap()+OrderCommission();

//         if (OrderType()==OP_SELL)
//         if(OrderProfit()>7)
//         { 
//         bool z=OrderModify(OrderTicket(),OrderClosePrice(),(OrderOpenPrice()-(50*Point())),OrderTakeProfit(),0,Gold);
//         bool m=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
//         Comment (OrderProfit());
         }
         

Comment("Current profit ",First_currency+Market_Prefix," and ",Second_currency+Market_Prefix," = ",ordersprofit,"<",((TotalProfit_PIPs*10)*LOTs));
if(ordersprofit>=((TotalProfit_PIPs*10)*LOTs))
{
for (int i=OrdersTotal()-1;i>=0;i--)
   {
   

      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                 if ((OrderSymbol()==First_currency+Market_Prefix) || (OrderSymbol()==Second_currency+Market_Prefix)) 

         bool m=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);



         }


}
  }
//+------------------------------------------------------------------+
