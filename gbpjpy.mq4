//+------------------------------------------------------------------+
//|                                                       gbpjpy.mq4 |
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
int stoploss=3;
int takeprofit=9;
int magic;
double lot=0.1;
double tiket;
double gbpjpye,gbpusde,usdjpye,timegbpjpye0,timegbpjpye4,timeusdjpye0,timeusdjpye4,timegbpusde0,timegbpusde4;
int OnInit()
  {
//---
 gbpjpye=MarketInfo("GBPJPYe",MODE_BID);
 gbpusde=MarketInfo("GBPUSDe",MODE_BID);
 usdjpye=MarketInfo("USDJPYe",MODE_BID);
 gbpjpye=StrToDouble(DoubleToStr(gbpjpye,6));
 gbpusde=StrToDouble(DoubleToStr(gbpusde,6));
 usdjpye=StrToDouble(DoubleToStr(usdjpye,6));
 timeusdjpye4=iClose("USDJPYe",1,4);
 timeusdjpye0=iClose("USDJPYe",1,0);
 timegbpjpye4=iClose("GBPJPYe",1,4);
 timegbpjpye0=iClose("GBPJPYe",1,0); 
 timegbpusde4=iClose("GBPUSDe",1,4);
 timegbpusde0=iClose("GBPUSDe",1,0);   
 if (((timegbpjpye0-timegbpjpye4)>0)&&((timegbpjpye0-timegbpjpye4)>=0.012))
         if(((timegbpusde0-timegbpusde4)<0)&&((timegbpusde0-timegbpusde4)<=-0.00012))
                  if(((timeusdjpye0-timeusdjpye4)<=0.003) || ((timeusdjpye0-timeusdjpye4)>=-0.003))
                  {
                   tiket=OrderSend("USDJPYe",OP_BUY,lot,Ask,6,Ask-stoploss*Point(),Ask+takeprofit*Point(),"komak",magic,0,Blue);
                  
                  }
                  
 if (((timegbpjpye0-timegbpjpye4)<0)&&((timegbpjpye0-timegbpjpye4)<=-0.012))
         if(((timegbpusde0-timegbpusde4)>0)&&((timegbpusde0-timegbpusde4)>=0.00012))
                  if(((timeusdjpye0-timeusdjpye4)<=0.003) || ((timeusdjpye0-timeusdjpye4)>=-0.003))
                  {
                   tiket=OrderSend("USDJPYe",OP_SELL,lot,Bid,6,Bid-stoploss*Point(),Bid+takeprofit*Point(),"komak",magic,0,Blue);
                  
                  }
                                    
                  
 Comment("Time 0 GBPJPYe = ",timegbpjpye0,"\n","Time 4 GBPJPYe = ",timegbpjpye4,"\n","Time 0 GBPUSDe = ",timegbpusde0,"\n","Time 4 GBPUSDe = ",timegbpusde4,"\n","Time 0 USDJPYe = ",timeusdjpye0,"\n","Time 4 USDJPYe = ",timeusdjpye4,"\n"); 
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
   
  }
//+------------------------------------------------------------------+
