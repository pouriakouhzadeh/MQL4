//+------------------------------------------------------------------+
//|                                                      10-15-1.mq4 |
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

static int  Last_pivot_candle=0;
extern int Magic_NO=1000;
int tiket;
extern double LOTS=0.1;
double p=0;
string stat="NAN";
double Distance=0;
static double Last_Pivot=0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   p=Pivot();
   Last_Pivot=p;
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
   p=Pivot();
   ObjectDelete(0,"pii");
   ObjectCreate("pii",OBJ_TEXT,0,Time[Last_pivot_candle],p+25*Point);
   ObjectSetText("pii","V",20,NULL,clrBlue);
   stat="NAN";
   if(Bid-p>=0) {stat="BUY";} else {stat="SELL";}
   Distance=(MathAbs(p-Bid));
   Comment("Current Spread = ",spread(),"\n","Last pivot = ",p,"\n","Last Pivot Candle Number = "
           ,Last_pivot_candle+1,"\n","Oriantation = ",stat,"\n","Distance = ",Distance);

   if(Total_Orders()>0) {Close_Order();};
   Get_Position();

  }
//+------------------------------------------------------------------+

double Pivot()
  {
   double Last_pivot=0;
   int find=0;
   int i=0;
   while(find==0)
     {
      if(Bid<High[i])
        {
         if(High[i]>=Last_pivot || Last_pivot==0) {Last_pivot=High[i]; Last_pivot_candle=i;}
         int Aknwlage=0;
         int n=i+1;
         while(Aknwlage==0)
           {
            if(High[n]>=High[i]){Aknwlage=1;}
            if(Last_pivot-Low[n]>=0.0005)
              {
               Aknwlage=1;
               find=1;
               return Last_pivot;
              }
            n=n+1;
           }
        }

      if(Bid>=Low[i])
        {
         if(Low[i]<=Last_pivot || Last_pivot==0) {Last_pivot=Low[i]; Last_pivot_candle=i;}
         int Aknwlage=0;
         int n=i+1;
         while(Aknwlage==0)
           {
            if(Low[n]<=Low[i]){Aknwlage=1;}
            if(High[n]-Last_pivot>=0.0005)
              {
               Aknwlage=1;
               find=1;
               return Last_pivot;
              }
            n=n+1;
           }

        }

      i=i+1;
     }
   return Last_pivot;
  }
//--------------------------------------------------
double spread()
  {
   return(MarketInfo(Symbol(),MODE_SPREAD));
  }
//--------------------------------------------------
int Total_Orders()
  {
   int sum=0;
   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_NO)
        {
         sum=sum+1;
        }
     }

   return sum;
  }
//-------------------------------------------------
void Get_Position()
  {
   if(Total_Orders()==0)
     {
      if(Distance>=0.0005)
        {
         if((Bid-p)>0)
           {
            //---Buy condition
            tiket=OrderSend(Symbol(),OP_BUY,LOTS,Ask,10,0,0,"Afsaneh",Magic_NO,0,Blue);
           }
         if((Bid-p)<0)
           {
            //---Sell condition
            tiket=OrderSend(Symbol(),OP_SELL,LOTS,Bid,10,0,0,"Afsaneh",Magic_NO,0,Red);
           }

        }

     }
  }
//-------------------------------------------------

void Close_Order()
  {
   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_NO)
        {
         if(OrderType()==OP_BUY)
            if(Bid>=(OrderOpenPrice()+(25*Point)))
              {
               SendNotification("Position Closed and profit was : "+DoubleToStr(OrderProfit(),10));
               bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
              }
         if(OrderType()==OP_SELL)
            if(Bid<=(OrderOpenPrice()-(25*Point)))
              {
               SendNotification("Position Closed and profit was : "+DoubleToStr(OrderProfit(),10));
               bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
              }
        }

      //-----------------------------------------
      if(Distance>=0.0005 || Distance==0)
        {
         Print("Distance");
         if(OrderType()==OP_BUY)
           {
            Print("OP_BUY");
            if(p>=OrderOpenPrice())
              {
               Print("Close");
               bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
              }
           }
         if(OrderType()==OP_SELL)
           {
            Print("OP_BUY");

            if(p<=OrderOpenPrice())
              {
               Print("Close");

               bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
              }
           }
        }

     }

  }
//------------------------------------------------
