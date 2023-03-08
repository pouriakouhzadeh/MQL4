//+------------------------------------------------------------------+
//|                                                      Digital.mq4 |
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
int tiket;
double LOTs=0.1;
int Magic_NO=1000;
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
if(Trend_Magic()!="NO")
   Print(Trend_Magic());
   closeposition();
   ordermangment();
   if(OrdersTotal()>0) return;
   getposition();
  }
//+------------------------------------------------------------------+


string Trend_Magic()
{
double A1;
double A2;
double A1_last;
double A2_last;

A1=iCustom(Symbol(),0,"Trend Magic",0,1);
A2=iCustom(Symbol(),0,"Trend Magic",1,1);
A1_last=iCustom(Symbol(),0,"Trend Magic",0,4);
A2_last=iCustom(Symbol(),0,"Trend Magic",1,4);

if((A1==2147483647.0) && (A2!=2147483647.0) && (A1_last!=2147483647.0) && (A2_last==2147483647.0)) return("SELL");
if((A1!=2147483647.0) && (A2==2147483647.0) && (A1_last==2147483647.0) && (A2_last!=2147483647.0)) return("BUY");
return("NO");
}




string Trend_Magic_Close()
{
double A1;
double A2;

A1=iCustom(Symbol(),0,"Trend Magic",0,1);
A2=iCustom(Symbol(),0,"Trend Magic",1,1);

if((A1==2147483647.0) && (A2!=2147483647.0) ) return("SELL");
if((A1!=2147483647.0) && (A2==2147483647.0) ) return("BUY");
return("NO");
}


string RBCI_hist()
{
double A1;
double A2;
A1=iCustom(Symbol(),0,"RBCI_hist",0,1);
A2=iCustom(Symbol(),0,"RBCI_hist",1,1);
if((A1>0) && (A2==0)) return("BUY");
if((A1==0) && (A2>0)) return("UP");
if((A2<0) && (A1==0)) return("SELL");
if((A2==0) && (A1<0)) return("DOWN");
return("NO");
}

string HG()
{
double A1;
double A2;
double A3;
double A4;
double A5;
double A6;
double A7;
double A8;

A1=iCustom(Symbol(),0,"HG_0001a_MTF",0,1);
A2=iCustom(Symbol(),0,"HG_0001a_MTF",1,1);
A3=iCustom(Symbol(),0,"HG_0001a_MTF",2,1);
A4=iCustom(Symbol(),0,"HG_0001a_MTF",3,1);
A5=iCustom(Symbol(),0,"HG_0001a_MTF",4,1);
A6=iCustom(Symbol(),0,"HG_0001a_MTF",5,1);
A7=iCustom(Symbol(),0,"HG_0001a_MTF",6,1);
A8=iCustom(Symbol(),0,"HG_0001a_MTF",7,1);
//Comment(A1,"\n",A2,"\n",A3,"\n",A4,"\n",A5,"\n",A6,"\n",A7,"\n",A8);
if((A1==1) && (A3==2) && (A5==3) && (A7==4) && (A2==0) && (A4==0) && (A6==0) && (A8==0)) return("SELL");
if((A2==1) && (A4==2) && (A6==3) && (A8==4) && (A1==0) && (A3==0) && (A5==0) && (A7==0)) return("BUY");

return("NO");

}

void getposition()
{
if((Trend_Magic()=="BUY") && (HG()=="BUY") && (RBCI_hist()=="BUY"))
      tiket=OrderSend(Symbol(),OP_BUY,LOTs,Ask,6,0,0,"I CAN",Magic_NO,0,Blue);

if((Trend_Magic()=="SELL") && (HG()=="SELL") && (RBCI_hist()=="SELL"))
      tiket=OrderSend(Symbol(),OP_SELL,LOTs,Bid,6,0,0,"I CAN",Magic_NO,0,Red);
}

void closeposition()
{


for (int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         {
         if(OrderMagicNumber()==Magic_NO)
             if(OrderType()==OP_BUY)
                 if(Trend_Magic_Close()=="SELL")
                     {
                        bool z=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),6,Gold);
                     }   
             
         }   
     }



for (int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         {
         if(OrderMagicNumber()==Magic_NO)
             if(OrderType()==OP_SELL)
                 if(Trend_Magic_Close()=="BUY")
                     {
                        bool z=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),6,Gold);
                     }   
             
         }   
     }




}



void ordermangment()
{

for (int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         {
               if (OrderProfit()>=(30*LOTs))
               if(OrderTakeProfit()==0)
               if (OrderType()==OP_SELL)
                     {
                     
                                       bool q=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderOpenPrice()-3000*MarketInfo(Symbol(),MODE_POINT),Yellow);                   
                     }

 
         }
     }    
     
     




for (int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         {
               if (OrderProfit()>=(30*LOTs))
               if(OrderTakeProfit()==0)
               if (OrderType()==OP_BUY)
                     {
                     
                                       bool q=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderOpenPrice()+3000*MarketInfo(Symbol(),MODE_POINT),Yellow);                   
                     }

 
         }
     }        
     
     
}
