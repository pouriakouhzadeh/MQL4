//+------------------------------------------------------------------+
//|                                                          sar.mq4 |
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
extern double step=0.02;
extern double max=0.2;
extern double step_h4=0.02;
extern double max_h4=0.2;

double LOTs=0.1;
int tiket;

extern int Magic_NO=1000;



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
   //Comment(EURCHF(1));
   closeposition();
   getposition_extra();
   if (orderstotal()>0) return;
   getposition();
  }
//+------------------------------------------------------------------+
string EURCHF(int shift)
{
double sar=0;
double bid=0;
sar=iSAR("EURCHF"+Market_Prefix,60,step,max,shift);
bid=MarketInfo("EURCHF"+Market_Prefix,MODE_BID);
if (bid>sar) return "BUY";
if (bid<sar) return "SELL";
return("RANGE");
}

string EURCHF_H4()
{
double sar=0;
double bid=0;
sar=iSAR("EURCHF"+Market_Prefix,240,step_h4,max_h4,1);
bid=MarketInfo("EURCHF"+Market_Prefix,MODE_BID);
if (bid>sar) return "BUY";
if (bid<sar) return "SELL";
return("RANGE");
}
void getposition()
{
if ((EURCHF(1)=="BUY")&&(EURCHF(2)=="SELL")&& (EURCHF_H4()=="BUY"))
         tiket=OrderSend("EURCHF"+Market_Prefix,OP_BUY,LOTs,Ask,3,0,0,"I CAN",Magic_NO,0,Blue);


if((EURCHF(1)=="SELL")&& (EURCHF(2)=="BUY")&& (EURCHF_H4()=="BUY"))
         tiket=OrderSend("EURCHF"+Market_Prefix,OP_SELL,LOTs,Bid,3,0,0,"I CAN",Magic_NO,0,Red);
}



void closeposition()
{

double orderprofit=0;
for (int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         orderprofit=orderprofit+(OrderProfit()+OrderCommission()+OrderSwap());
         
               //if ((OrderType()==OP_BUY)&&(EURCHF_CLOSE()=="SELL")) bool c=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
               
               //if ((OrderType()==OP_SELL)&&(EURCHF_CLOSE()=="BUY")) bool c=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
     }


if(orderprofit>15)
{
for (int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

   if(OrderLots()==LOTs)
   {   
      bool c=OrderClose(OrderTicket(),OrderLots()/2,OrderClosePrice(),3,Gold);
      orderprofit=0;   
    }
      }
   
}  
Comment(orderprofit);    
if((orderprofit>15)||(orderprofit<0))
{
for (int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

   if(OrderLots()==LOTs/2)   
      bool c=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
      
      }
}      
      

}


int orderstotal()
{

int cunt=0;
for (int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         {
            if (OrderLots()==LOTs) cunt++;
         }
         
     }   
return cunt;
}


void getposition_extra()
{
double orderprofit=0;
for (int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         orderprofit=orderprofit+(OrderProfit()+OrderCommission()+OrderSwap());
         
               //if ((OrderType()==OP_BUY)&&(EURCHF_CLOSE()=="SELL")) bool c=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
               
               //if ((OrderType()==OP_SELL)&&(EURCHF_CLOSE()=="BUY")) bool c=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
     }
   
   
if (orderprofit<-14) 
if (orderstotal()==1)
{
if(position_detecting()=="BUY")          tiket=OrderSend("EURCHF"+Market_Prefix,OP_BUY,LOTs,Ask,3,0,0,"I CAN",Magic_NO,0,Blue);
if(position_detecting()=="SELL")         tiket=OrderSend("EURCHF"+Market_Prefix,OP_SELL,LOTs,Bid,3,0,0,"I CAN",Magic_NO,0,Red);
}

if (orderprofit<-42) 
if (orderstotal()==2)
{
if(position_detecting()=="BUY")          tiket=OrderSend("EURCHF"+Market_Prefix,OP_BUY,LOTs,Ask,3,0,0,"I CAN",Magic_NO,0,Blue);
if(position_detecting()=="SELL")         tiket=OrderSend("EURCHF"+Market_Prefix,OP_SELL,LOTs,Bid,3,0,0,"I CAN",Magic_NO,0,Red);
}
if (orderprofit<-84) 
if (orderstotal()==3)
{
if(position_detecting()=="BUY")          tiket=OrderSend("EURCHF"+Market_Prefix,OP_BUY,LOTs,Ask,3,0,0,"I CAN",Magic_NO,0,Blue);
if(position_detecting()=="SELL")         tiket=OrderSend("EURCHF"+Market_Prefix,OP_SELL,LOTs,Bid,3,0,0,"I CAN",Magic_NO,0,Red);
}
if (orderprofit<-140) 
if (orderstotal()==4)
{
if(position_detecting()=="BUY")          tiket=OrderSend("EURCHF"+Market_Prefix,OP_BUY,LOTs,Ask,3,0,0,"I CAN",Magic_NO,0,Blue);
if(position_detecting()=="SELL")         tiket=OrderSend("EURCHF"+Market_Prefix,OP_SELL,LOTs,Bid,3,0,0,"I CAN",Magic_NO,0,Red);
}
if (orderprofit<-210) 
if (orderstotal()==5)
{
if(position_detecting()=="BUY")          tiket=OrderSend("EURCHF"+Market_Prefix,OP_BUY,LOTs,Ask,3,0,0,"I CAN",Magic_NO,0,Blue);
if(position_detecting()=="SELL")         tiket=OrderSend("EURCHF"+Market_Prefix,OP_SELL,LOTs,Bid,3,0,0,"I CAN",Magic_NO,0,Red);
}
if (orderprofit<-294) 
if (orderstotal()==6)
{
if(position_detecting()=="BUY")          tiket=OrderSend("EURCHF"+Market_Prefix,OP_BUY,LOTs,Ask,3,0,0,"I CAN",Magic_NO,0,Blue);
if(position_detecting()=="SELL")         tiket=OrderSend("EURCHF"+Market_Prefix,OP_SELL,LOTs,Bid,3,0,0,"I CAN",Magic_NO,0,Red);
}
if (orderprofit<-392) 
if (orderstotal()==7)
{
if(position_detecting()=="BUY")          tiket=OrderSend("EURCHF"+Market_Prefix,OP_BUY,LOTs,Ask,3,0,0,"I CAN",Magic_NO,0,Blue);
if(position_detecting()=="SELL")         tiket=OrderSend("EURCHF"+Market_Prefix,OP_SELL,LOTs,Bid,3,0,0,"I CAN",Magic_NO,0,Red);
}

 
}



string position_detecting()
{

string kind="";
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if ((OrderType()==OP_BUY)&&(OrderLots()==LOTs)) kind="BUY";
      if ((OrderType()==OP_SELL)&&(OrderLots()==LOTs)) kind="SELL";
   }      
if (kind=="") return ("ANY");   
return kind;
}

