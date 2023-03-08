//+------------------------------------------------------------------+
//|                                                 Last stratgy.mq4 |
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
// ------EMA---------
extern double MA_Period50 = 30;
extern double MA_Period100 = 96;
extern double Coef = 0.0;
extern int MA_Shift = 0;
extern int SetPrice = 0;

//----------------------------
double ema50,ema100,sto0,sto1,sto2,sto3;
extern int stoploss=8;
extern int takeprofit=8;
int tiket;
double lot=0.1;
string com="pourias expert";
int magic=0;
datetime m,m1;
extern int stolow=12;
extern int stohigh=75;
extern int a,b,c;

int OnInit()
  {
//---
 MqlDateTime time,time1;
 m=TimeCurrent();
 TimeToStruct(m,time); 
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
indicators();
lot=AccountBalance()/1000;
if (AccountFreeMargin()<50) return;
if ((sto0<80)&&(sto0>20)) return;
if (((ema50-ema100)<=0.0001)&& ((ema50-ema100)>0)) return;
if (((ema50-ema100)>=-0.0001)&&((ema50-ema100)<0)) return;

if (OrdersTotal()!=0) return;


 MqlDateTime time,time1;
 m1=TimeCurrent();
 TimeToStruct(m1,time1);
 if (time.hour==time1.hour && time.day==time1.day) 
 {
Print("zamane barabar");
 return;
}
//---------BUY CONDITION--------
if (ema50>ema100)
      if ((iClose(Symbol(),1,1)<ema100))
                  if(Ask>=ema100 && Ask<ema50)
                        if (sto1<stolow || sto2<stolow || sto3<stolow)
                              if (sto0>=stolow)
                                    {
                              //      if ((Ask-Bid)<=0.00006)
                              //      {
                                    tiket=OrderSend(Symbol(),OP_BUY,lot,Ask,6,Ask-stoploss*Point(),Ask+takeprofit*Point(),com,magic,0,Blue);
                                    m=TimeCurrent();
                                    TimeToStruct(m,time);
                               //     }
                                    }
//---------SELL CONDITION-------
if (ema100>ema50)
      if ((iClose(Symbol(),1,1)>ema100))
                  if(Bid<=ema100 && Bid >ema50)
                        if (sto1>stohigh || sto2>stohigh || sto3>stohigh)
                              if (sto0<=stohigh)
                                    {
                                //    if ((Ask-Bid)<=0.00006)
                                //    {
                                     tiket=OrderSend(Symbol(),OP_SELL,lot,Bid,6,Bid+stoploss*Point(),Bid-takeprofit*Point(),com,magic,0,Red);
                                     m=TimeCurrent();
                                     TimeToStruct(m,time);
                                 //   } 
                                    }



   
  }
//+------------------------------------------------------------------+
//-----------INDICATORS---------------
void indicators()
{

ema50=iCustom(Symbol(),1,"ema",MA_Period50,Coef,MA_Shift,SetPrice,0,0);
ema100=iCustom(Symbol(),1,"ema",MA_Period100,Coef,MA_Shift,SetPrice,0,0);

sto0=iStochastic(NULL,1,a,b,c,MODE_LWMA,0,MODE_MAIN,0);
sto1=iStochastic(NULL,1,a,b,c,MODE_LWMA,0,MODE_MAIN,1);
sto2=iStochastic(NULL,1,a,b,c,MODE_LWMA,0,MODE_MAIN,2);
sto3=iStochastic(NULL,1,a,b,c,MODE_LWMA,0,MODE_MAIN,3);

} 