//+------------------------------------------------------------------+
//|                                           NNA_Ordermanagment.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int tiket;
extern double LOTs=0.1;
int OnInit()
  {
//---
   print();
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
Close_orders();   
Risk_free();
print();
  }
//+------------------------------------------------------------------+
void Close_orders()
{
   for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                 //  bool p=OrderDelete(OrderTicket(),Gold);
                   //Print((TimeHour((((OrderOpenTime()+(OrderMagicNumber()*60)))-TimeCurrent()))*3600+TimeMinute((((OrderOpenTime()+(OrderMagicNumber()*60)))-TimeCurrent()))*60)/60);
                   if(OrderOpenTime()+(OrderMagicNumber()*60)<=TimeCurrent())
                      {
                      bool c=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),6,Gold);
                      
                      if (OrderType()==OP_BUY)
                      {
                      SendNotification("Position BUY in "+OrderSymbol()+" at time frame "+IntegerToString(OrderMagicNumber())+" successfully Closed and Profit was :"+DoubleToStr(OrderProfit(),4));
                      }
                      if(OrderType()==OP_SELL)
                      {
                      SendNotification("Position SELL in "+OrderSymbol()+" at time frame "+IntegerToString(OrderMagicNumber())+" successfully Closed and Profit was :"+DoubleToStr(OrderProfit(),4));
                      }
                      
                   }
                   
               }  
}

void Risk_free()
{
   for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                     {
                         if(OrderType()==OP_BUY)
                         {
                            if(MarketInfo(OrderSymbol(),MODE_ASK)>=OrderOpenPrice()+200*MarketInfo(OrderSymbol(),MODE_POINT))
                              {
                             // Print("yes");
                                 if(OrderStopLoss()==0)
                                    {
                                       bool M=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+100*MarketInfo(OrderSymbol(),MODE_POINT),0,0,Gold);
                                       bool G=OrderSend(OrderSymbol(),OP_BUYLIMIT,LOTs,OrderOpenPrice(),6,0,0,"Re Enter",((TimeHour((((OrderOpenTime()+(OrderMagicNumber()*60)))-TimeCurrent()))*3600+TimeMinute((((OrderOpenTime()+(OrderMagicNumber()*60)))-TimeCurrent()))*60)/60),TimeCurrent()+((TimeHour((((OrderOpenTime()+(OrderMagicNumber()*60)))-TimeCurrent()))*3600+TimeMinute((((OrderOpenTime()+(OrderMagicNumber()*60)))-TimeCurrent()))*60)/60),Blue);
                                    }
                              }
                         }
                         if(OrderType()==OP_SELL)
                         {
                            if(MarketInfo(OrderSymbol(),MODE_BID)<=OrderOpenPrice()-200*MarketInfo(OrderSymbol(),MODE_POINT))
                              {
                                 if(OrderStopLoss()==0)
                                    {
                                       bool M=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-100*MarketInfo(OrderSymbol(),MODE_POINT),0,0,Gold);
                                       bool G=OrderSend(OrderSymbol(),OP_SELLLIMIT,LOTs,OrderOpenPrice(),6,0,0,"Re Enter",((TimeHour((((OrderOpenTime()+(OrderMagicNumber()*60)))-TimeCurrent()))*3600+TimeMinute((((OrderOpenTime()+(OrderMagicNumber()*60)))-TimeCurrent()))*60)/60),TimeCurrent()+((TimeHour((((OrderOpenTime()+(OrderMagicNumber()*60)))-TimeCurrent()))*3600+TimeMinute((((OrderOpenTime()+(OrderMagicNumber()*60)))-TimeCurrent()))*60)/60),Red);
                                    }
                              }                         
                         }
                
                     }
                   
               }  
}

void print()
{
   My_print("Total orders : "+IntegerToString(OrdersTotal(),3),80,80 , "1" , 15);
      int Order_Riskfree_Cunt=0;
      for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                        {
                           if(OrderStopLoss()!=0)
                              Order_Riskfree_Cunt=Order_Riskfree_Cunt+1;
                        }
               } 
   My_print("Risk free orders : "+IntegerToString(Order_Riskfree_Cunt),80,110 , "2" , 15);     
 
      int Pending_orders_Cunt=0;
      for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                        {
                           if((OrderType()==OP_BUYLIMIT) || (OrderType()==OP_SELLLIMIT))
                              Pending_orders_Cunt=Pending_orders_Cunt+1;
                        }
               } 
   My_print("Pending orders : "+IntegerToString(Pending_orders_Cunt),80,140 , "3" , 15);       

      int Reenter_orders_Cunt=0;
      for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                        {
                           if((OrderComment()=="Re Enter") && (OrderType()!=OP_BUYLIMIT) && (OrderType()!=OP_SELLLIMIT))
                              Reenter_orders_Cunt=Reenter_orders_Cunt+1;
                        }
               } 
   My_print("Re Enter orders : "+IntegerToString(Reenter_orders_Cunt),80,170 , "4" , 15);               
}
//------------------- Print -------------
void My_print(string Text,int x,int y , string lable , int size)
{

   string text=(Text); 
   ObjectCreate(lable,OBJ_LABEL,0,0,0);
   ObjectSet(lable,OBJPROP_XDISTANCE,x);
   ObjectSet(lable,OBJPROP_YDISTANCE,y);
   ObjectSetText(lable,text,size,"Arial",clrRed);
   WindowRedraw(); 
}
