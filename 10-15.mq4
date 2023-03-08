//+------------------------------------------------------------------+
//|                                                        10-15.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
static int  Last_pivot_candle=0;
extern int Magic_NO=1000;
double p=0;
static int cunt=0;
double Distance=0;
string stat="NAN";
int tiket;
extern double LOTS=0.1;
//+------------------------------------------------------------------+
//|                                                                  |
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
   Close_Order();
   Close_All_Order_Check();
   if(spread()>20)
     {
      // Comment("Due to spread is wide Expert forced to return ...","\n","Current Spread is : ",spread());
      //---------------------------
      cunt=cunt+1;
      ObjectCreate("p"+IntegerToString(cunt,20)+TimeToStr(Time[0],TIME_DATE)+TimeToStr(Time[0],TIME_MINUTES)+TimeToStr(Time[0],TIME_SECONDS),OBJ_TEXT,0,Time[0],Bid);
      ObjectSetText("p"+IntegerToString(cunt,20)+TimeToStr(Time[0],TIME_DATE)+TimeToStr(Time[0],TIME_MINUTES)+TimeToStr(Time[0],TIME_SECONDS),"*",10,NULL,clrGold);
      // return ;
     }
   Pivot();
   p=Pivot();
   ObjectCreate("pivot",OBJ_TEXT,0,Time[Last_pivot_candle],p);
   ObjectSetText("pivot","|",30,NULL,clrBlue);
   stat="NAN";
   if(Bid-p>=0) {stat="BUY";} else {stat="SELL";}
   Distance=(MathAbs(p-Bid));
   Comment("Current Spread = ",spread(),"\n","Last pivot = ",p,"\n","Last Pivot Candle Number = "
           ,Last_pivot_candle+1,"\n","Oriantation = ",stat,"\n","Distance = ",Distance);
   if(Total_Orders()>0) { Comment("One order in this symbol is open ...");return;}
//--------------------------------------------------------------------
   if((Distance>0.001) && (Distance<0.0011))
     {
      if(stat=="BUY")
        {
         Close_All_Order();
         if(spread()<=10)
           {
            //--------BUY Condition 

            tiket=OrderSend(Symbol(),OP_BUY,LOTS,Ask,10,0,0,"Afsaneh",Magic_NO,0,Blue);
           }
        }
      if(stat=="SELL")
        {
         Close_All_Order();
         if(spread()<=10)
           {
            //--------SELL Condition
            tiket=OrderSend(Symbol(),OP_SELL,LOTS,Bid,10,0,0,"Afsaneh",Magic_NO,0,Red);

           }
        }

     }

//--------------------------------------------------------------------


  }
//+------------------------------------------------------------------+

double Pivot()
  {
   double Last_pivot=0;
   int find=0;
   int i=1;
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
            if(Last_pivot-Low[n]>=0.001)
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
            if(High[n]-Last_pivot>=0.001)
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

void Close_Order()
  {
   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_NO)
        {
         if(OrderType()==OP_BUY)
            if(Bid>=(OrderOpenPrice()+(50*Point)))
              {
               SendNotification("Position Closed and profit was : "+DoubleToStr(OrderProfit(),10));
               bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
              }
         if(OrderType()==OP_SELL)
            if(Bid<=(OrderOpenPrice()-(50*Point)))
              {
               SendNotification("Position Closed and profit was : "+DoubleToStr(OrderProfit(),10));
               bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
              }

        }

     }

  }
//------------------------------------------------
void Close_All_Order()
  {
   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_NO)
        {
         bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Black);
        }

     }

  }
//------------------------------------------------
void Close_All_Order_Check()
  {
   if((Distance>0.001) && (Distance<0.0013))
     {
      if(stat=="BUY")
        {
         Close_SELL_Order();
        }
      if(stat=="SELL")
        {
         Close_BUY_Order();
        }

     }
  }
//------------------------------------------------
void Close_BUY_Order()
  {
   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_NO)
         if(OrderType()==OP_BUY)
           {
            bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Blue);
           }

     }

  }
//------------------------------------------------
//------------------------------------------------
void Close_SELL_Order()
  {
   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_NO)
         if(OrderType()==OP_SELL)
           {
            bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Blue);
           }

     }

  }
//------------------------------------------------
