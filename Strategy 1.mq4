//+------------------------------------------------------------------+
//|                                                   Strategy 1.mq4 |
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
//--------------Bolinger band--------
extern int    InpBandsPeriod=20;      // Bands Period
extern int    InpBandsShift=0;        // Bands Shift
extern double InpBandsDeviations=2.0; // Bands Deviations
//--------------------------------------
double bolingerhigher,bolingerlower,bolingermiddle0,bolingermiddle1,ma500,ma501,ma20,pulback;
int tiket;
double lot=10;
int stoploss=15;
int takeprofit=25;
string com="Badbakhtiye pouria";
int magic=0;
int orcl,orcl1,ordl;
static int tag=0;
int OnInit()
  {
//---
Comment("Pourias expert is running...");    
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

//Comment(ma500,"\n",bolingerhigher,"\n",bolingerlower,"\n",bolingermiddle,"\n",pulback);
//Comment(ma500,"\n",ma501);
if (result()=="Buy") Print("Buy","   ",tag);;// Print("Buy","ma50=",ma500,"   ","bolingermiddle=",bolingermiddle0,"   ","bolingerhigher=",bolingerhigher,"   ","bolingerlower=",bolingerlower,"   ","pulback=",pulback); 
if (result()=="Sell")Print ("Sell","   ",tag);// Print("Sell","ma50=",ma500,"   ","bolingermiddle=",bolingermiddle0,"   ","bolingerhigher=",bolingerhigher,"   ","bolingerlower=",bolingerlower,"   ","pulback=",pulback);
//if (result()=="No")Print(0);
if (result()=="Buy")
         {
            if (OrdersTotal()==0)
            
            if  (tag==0)
                     {
                           tiket=OrderSend(Symbol(),OP_BUY,lot,Ask,6,Ask-stoploss*Point(),Ask+takeprofit*Point(),com,magic,0,Blue);
                           tag=1;
                           Print(OrderOpenTime());
                     }
                     else
                     {
                     tag=1;
                     }
         }
  
 if (result()=="Sell")
         {
            if (OrdersTotal()==0)
            
            if (tag==0)
                     {
                           tiket=OrderSend(Symbol(),OP_SELL,lot,Bid,6,Bid+stoploss*Point(),Bid-takeprofit*Point(),com,magic,0,Red);
                           tag=1;
                           Print(OrderOpenTime()); 
                     }
                     else
                     {
                     tag=1;
                     }         
         }  
  


  
  }
//+------------------------------------------------------------------+
void indicators()
{

ma500=iMA(NULL,1,50,0,0,PRICE_MEDIAN,0);
ma501=iMA(NULL,1,50,0,0,PRICE_MEDIAN,1);

bolingerhigher=iCustom(Symbol(),1,"Bands",InpBandsPeriod,InpBandsShift,InpBandsDeviations,1,0);
bolingermiddle0=iCustom(Symbol(),1,"Bands",InpBandsPeriod,InpBandsShift,InpBandsDeviations,0,0);
bolingermiddle1=iCustom(Symbol(),1,"Bands",InpBandsPeriod,InpBandsShift,InpBandsDeviations,0,1);

bolingerlower=iCustom(Symbol(),1,"Bands",InpBandsPeriod,InpBandsShift,InpBandsDeviations,2,0);

pulback=iCustom(Symbol(),1,"Pullback-Factor",0,0);


string ma500_1=DoubleToStr(ma500,5);
ma500=StrToDouble(ma500_1);

string ma501_1=DoubleToStr(ma501,5);
ma501=StrToDouble(ma501_1);

string bolingerhigher_1=DoubleToStr(bolingerhigher,5);
bolingerhigher=StrToDouble(bolingerhigher_1);

string bolingerlower_1=DoubleToStr(bolingerlower,5);
bolingerlower=StrToDouble(bolingerlower_1);

string bolingermiddle0_1=DoubleToStr(bolingermiddle0,5);
bolingermiddle0=StrToDouble(bolingermiddle0_1);

string bolingermiddle1_1=DoubleToStr(bolingermiddle1,5);
bolingermiddle1=StrToDouble(bolingermiddle1_1);

string pulback_1=DoubleToStr(pulback,5);
pulback=StrToDouble(pulback_1);

}



string result()
{
indicators();


if((ma501>=bolingermiddle1) && (ma500<bolingermiddle0)) 
if(pulback>=4)
if ((iHigh(Symbol(),1,0)>bolingerhigher)) return("Sell");



if ((ma501<=bolingermiddle1)&&(ma500>bolingermiddle0)) 
if (pulback>=4) 
if ((iLow(Symbol(),1,0)<bolingerlower)) return("Buy");



 tag=0;
 return("No");

}