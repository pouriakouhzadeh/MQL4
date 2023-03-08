//+------------------------------------------------------------------+
//|                                                          piv.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
double lp;
double llp;
extern int piv=100;
int dis=0;
int  sts=0;
double tmpdig=1;
int line=0;
datetime lp_date;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   llp=Bid;
   lp=Bid;
   dis=0;
   sts= 0;
   for(int i=0; i<MarketInfo(Symbol(),MODE_DIGITS); i++)
     {
      tmpdig=tmpdig *10;
     }
   lp_date=Time[0];
//   Alert(MathArctan(100) *180/M_PI);
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
   if((Bid-lp)*tmpdig>=piv && (sts==0 || sts==2))
     {//new piv up
      line++;
      double dggg=((double)(Bid-lp)/(double)(((double)(iBarShift(_Symbol,0,lp_date)+1))/(double)10000));
      ObjectCreate("dg_zerO_"+line,OBJ_TEXT,0,Time[0],Bid-150*Point);
      ObjectSetText("dg_zerO_"+line,DoubleToString(((atan(dggg) *180)/M_PI),2),10,NULL,clrGold);
      drow(line,lp_date,lp,Time[0],Bid,clrBlue);
      sts = 1;
      dis = (Bid-lp)*tmpdig;
      llp=lp;
      lp=Bid;
      lp_date=Time[0];
      if(((atan(dggg) *180)/M_PI)>80   && (dis >=(piv-10) && dis <=(piv+10)))
        {
         //buy
         OrderSend(Symbol(),OP_BUY,0.1,Ask,6,Bid-100*Point,Bid+100*Point,"",0,0,clrBlue);
        }
     }
   if((Bid-llp)*tmpdig>dis && sts==1)
     {
      dis=(Bid-llp)*tmpdig;
      ObjectSet("zs_"+line,OBJPROP_TIME2,Time[0]);
      ObjectSet("zs_"+line,OBJPROP_PRICE2,Bid);
      lp=Bid;
      lp_date=Time[0];
      //edit line
     }
////////////////
   if((lp -Bid)*tmpdig>=piv && (sts==0 || sts==1))
     {//new piv up

      double dggg=(((double)(iBarShift(_Symbol,0,lp_date)+1)/(double)10000)/(double)(lp -Bid));
      line++;
      ObjectCreate("dg_zerO_"+line,OBJ_TEXT,0,Time[0],Bid+150*Point);
      ObjectSetText("dg_zerO_"+line,DoubleToString(((atan(dggg) *180)/M_PI),2),10,NULL,clrGold);
      drow(line,lp_date,lp,Time[0],Bid,clrRed);
      sts = 2;
      dis = (lp -Bid)*tmpdig;
      llp=lp;
      lp=Bid;
      lp_date=Time[0];
      if(((atan(dggg) *180)/M_PI)<10      && (dis >=(piv-10) && dis <=(piv+10)))
        {
         //buy
         OrderSend(Symbol(),OP_SELL,0.1,Bid,6,Bid+100*Point,Bid-100*Point,"",0,0,clrRed);
        }
     }
   if((llp-Bid)*tmpdig>dis && sts==2)
     {
      dis=(llp-Bid)*tmpdig;
      ObjectSet("zs_"+line,OBJPROP_TIME2,Time[0]);
      ObjectSet("zs_"+line,OBJPROP_PRICE2,Bid);
      lp=Bid;
      lp_date=Time[0];
      //edit line
     }
  }
//+------------------------------------------------------------------+
void drow(string name,datetime t1,double p1,datetime t2,double p2,color c)
  {
   name="zs_"+name;

   ObjectCreate(name,OBJ_TREND,0,t1,p1,t2,p2,clrGreen);// Creating obj.
   ObjectSetInteger(0,name,OBJPROP_COLOR,c);
   ObjectSetInteger(0,name,OBJPROP_RAY,0);

   ObjectSetInteger(0,name,OBJPROP_SELECTABLE,1);
   ObjectSetInteger(0,name,OBJPROP_BACK,0);
  }
//+------------------------------------------------------------------+
