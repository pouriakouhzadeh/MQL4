//+------------------------------------------------------------------+
//|                                                         1MIN.mq4 |
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
extern string Market_Name="EURUSD";
extern string Market_Prefix=".e";
extern int Adjust=1;
//extern int stoploss=1000;
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

Enter(Market_Name+Market_Prefix);
   
  }
//+------------------------------------------------------------------+


void Enter(string Market_Name_Enter)
{
Print(tma(Market_Name_Enter));
closeposition(Market_Name_Enter);
if (OrdersTotal()>2) return;

      if(tma(Market_Name_Enter)=="BUY")
      if (arrow(Market_Name_Enter)=="BUY")
         {
            int tiket=OrderSend(Market_Name_Enter,OP_BUY,0.1,Ask,6,0,0,"I CAN",1,0,Blue);         
         }
      if(tma(Market_Name_Enter)=="SELL")
      if(arrow(Market_Name_Enter)=="SELL")
         {
            int tiket=OrderSend(Market_Name_Enter,OP_SELL,0.1,Bid,6,0,0,"I CAN",2,0,Red);             
         }

}


void closeposition(string Market_Name_closeposition)
{


for (int i=OrdersTotal()-1;i>=0;i--)
   {
        bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if (OrderType()==OP_BUY)
         if((tma1(Market_Name_closeposition)=="BUYCLOSE") || (suport(Market_Name_closeposition)=="BUYCLOSE"))
         //if(OrderProfit()>10)
         bool z=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),6,Gold);
         
   }     

for (int i=OrdersTotal()-1;i>=0;i--)
   {
        bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if (OrderType()==OP_SELL)
         if((tma1(Market_Name_closeposition)=="SELLCLOSE") || (suport(Market_Name_closeposition)=="SELLCLOSE"))
         //if(OrderProfit()>10)
         bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),6,Gold);
         
   }  
}

string tma(string Market_Name_tma)
{
double H=iCustom(Market_Name_tma,5,"Indicador Invertir Mejor 2",1,1);
double L=iCustom(Market_Name_tma,5,"Indicador Invertir Mejor 2",2,1);

if (MarketInfo(Market_Name_tma,MODE_BID)>H+(Adjust*MarketInfo(Market_Name_tma,MODE_POINT))) return("SELL");
if (MarketInfo(Market_Name_tma,MODE_BID)<L-(Adjust*MarketInfo(Market_Name_tma,MODE_POINT))) return("BUY");

return ("BETWEEN");
}
string tma1(string Market_Name_tma)
{

double H1=iCustom(Market_Name_tma,5,"Indicador Invertir Mejor 2",1,0);
double L1=iCustom(Market_Name_tma,5,"Indicador Invertir Mejor 2",2,0);

if (MarketInfo(Market_Name_tma,MODE_BID)>H1) return("BUYCLOSE");
if (MarketInfo(Market_Name_tma,MODE_BID)<L1) return("SELLCLOSE");
return ("BETWEEN");
}



string arrow(string Market_Name_arrow)
{
double S=iCustom(Market_Name_arrow,5,"Stochastic_Buy_Sell_Arrows",1,1);
double B=iCustom(Market_Name_arrow,5,"Stochastic_Buy_Sell_Arrows",0,1);

if(S!=0) return("SELL");
if(B!=0) return("BUY");
return("NO");
}

string suport(string Market_Name_suport)
{
double H=iCustom(Market_Name_suport,5,"SuppRTF",0,2);
double L=iCustom(Market_Name_suport,5,"SuppRTF",1,2);
if(MarketInfo(Market_Name_suport,MODE_BID)<L) return("SELLCLOSE");
if(MarketInfo(Market_Name_suport,MODE_BID)>H) return("BUYCLOSE");

return("NOT");
}
