//+------------------------------------------------------------------+
//|                                             Pourias Expert 1.mq4 |
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
//Indicators Variable 
// ------EMA---------
extern double MA_Period14 = 14;
extern double MA_Period21 = 21;
extern double MA_Period50 = 50;
extern double Coef = 0.0;
extern int MA_Shift = 0;
extern int SetPrice = 0;

//----------------------------

//--------------Bolinger band--------
extern int    InpBandsPeriod=20;      // Bands Period
extern int    InpBandsShift=0;        // Bands Shift
extern double InpBandsDeviations=2.0; // Bands Deviations
//--------------------------------------

//-----------------MACD--------------------
input int InpFastEMA=12;   // Fast EMA Period
input int InpSlowEMA=26;   // Slow EMA Period
input int InpSignalSMA=9;  // Signal SMA Period
//--------------------------------------------
//-----------------CCI------------------------
input int InpCCIPeriod=14; // CCI Period
//-----------------------------------------

double ema14,ema21,ema50;
double bolingerhigher,bolingerlower;
double lot=0.01;
int stoploss=400;
int takeprofit=400;
string com="Pourias Expert Position";
int magic=1;
double tiket;
bool orcl;
bool orcl1;
bool ordl;
double macd0,macdline0,macd1,macdline1;
string macdresult="No";
double cciline;
string cciresult="No";
string fastresult="No";
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
macd(15);
cci(5);
Print("result=",result(),"   ","macd=",macdresult,"   ","cci=",cciresult);

if (result()=="Buy")
         {
            if (OrdersTotal()==0)
                     {
                           double hi=iHigh(Symbol(),30,1);
                           tiket=OrderSend(Symbol(),OP_BUYSTOP,lot,hi,6,Ask-stoploss*Point(),Ask+takeprofit*Point(),com,magic,0,Blue);
                           
                     }
         }
         
if (result()=="Sell")
         {
            if (OrdersTotal()==0)
                     {
                           double lo=iLow(Symbol(),30,1);
                           tiket=OrderSend(Symbol(),OP_SELLSTOP,lot,lo,6,Bid+stoploss*Point(),Bid-takeprofit*Point(),com,magic,0,Red);
                           
                     }         
         } 
         
if (result()=="No")
         {
            if (OrdersTotal()!=0)
               {

                     bool orse=OrderSelect(tiket,SELECT_BY_TICKET,MODE_TRADES);
            
                     if (OrderType()==OP_BUY)
                     {
                            orcl=OrderClose(OrderTicket(),OrderLots(),Bid,6,Blue);
                                          Print("Bid=",Bid,"   ","Ask=",Ask);
                     }
                     else

                     if (OrderType()==OP_SELL)
                     {
                     
                            orcl1=OrderClose(OrderTicket(),OrderLots(),Ask,6,Yellow);
                                          Print("Bid=",Bid,"   ","Ask=",Ask);
                                          Print("Sell------");
                     }
                     else
                     
                     ordl=OrderDelete(OrderTicket(),Black);
            
                   //  if ((orcl==0) && (orcl1==0)) Print ("Order Close Error-------");
                   
               }

         }

//macd(5);

//Comment("macd0=",macd0,"\n","macdline0=",macdline0,"\n","macd1=",macd1,"\n","macdline1=",macdline1);

//string r=result();
//if (r=="Sell")
//Print(r);   
//if (r=="Buy")
//Print(r);   
//if (r=="No")
//Print(r);   

//Comment(r);      
   
   
  }
//+------------------------------------------------------------------+
//------------Functions-----------------
void indicators(int i)
{
ema14=iCustom(Symbol(),i,"ema",MA_Period14,Coef,MA_Shift,SetPrice,0,0);
ema21=iCustom(Symbol(),i,"ema",MA_Period21,Coef,MA_Shift,SetPrice,0,0);
ema50=iCustom(Symbol(),i,"ema",MA_Period50,Coef,MA_Shift,SetPrice,0,0);

 
bolingerhigher=iCustom(Symbol(),i,"Bands",InpBandsPeriod,InpBandsShift,InpBandsDeviations,1,0);
bolingerlower=iCustom(Symbol(),i,"Bands",InpBandsPeriod,InpBandsShift,InpBandsDeviations,2,0);




}
//---------------------------------------

string result()
{
indicators(5);
if ((ema14>ema21)&&(ema21>ema50))
   if((bolingerhigher>ema50)&&(ema50>bolingerlower))
         {
            indicators(30);
            if(iClose(Symbol(),30,1)>ema14 || iClose(Symbol(),30,1)>ema21)
                              if ((ema14>ema21)&&(ema21>ema50))
                                 if((bolingerhigher>ema50)&&(ema50>bolingerlower))
                                    {
                                       if (macdresult=="Buy") 
                                          {
                                             if (cciresult=="Buy") return("Buy");
                                          }
                                     }
         
         }
   
   
         
             
             indicators(5);
                  if ((ema14<ema21)&&(ema21<ema50))
                     if((bolingerhigher>ema50)&&(ema50>bolingerlower))
         {
                           indicators(30);
                           if(iClose(Symbol(),30,1)<ema14 || iClose(Symbol(),30,1<ema21))
                                    if ((ema14<ema21)&&(ema21<ema50))
                                          if((bolingerhigher>ema50)&&(ema50>bolingerlower))
                                             {
                                             if (macdresult=="Sell") 
                                                {
                                                   if (cciresult=="Sell") return("Sell");
                                                } 
                                             }
                                             
                                                   
         
          }

          

         
return("No");
}


void macd(int i)
{
   macd0=iMACD(NULL,i,InpFastEMA,InpSlowEMA,InpSignalSMA,PRICE_CLOSE,MODE_MAIN,0);
 //  macd1=iMACD(NULL,i,InpFastEMA,InpSlowEMA,InpSignalSMA,PRICE_CLOSE,MODE_MAIN,1);
   macdline0=iMACD(NULL,i,InpFastEMA,InpSlowEMA,InpSignalSMA,PRICE_CLOSE,MODE_SIGNAL,0);
 //  macdline1=iMACD(NULL,i,InpFastEMA,InpSlowEMA,InpSignalSMA,PRICE_CLOSE,MODE_SIGNAL,1);

      
if ((macd0>=0)&&(macdline0>=0)&&(macd0>macdline0)) macdresult="Buy"; 
else     
if ((macd0<0)&&(macdline0<0)&&(macd0<=macdline0)) macdresult="Sell";
else
macdresult="No";  
      
   
}

void cci(int i)
{
   cciline=iCCI(NULL,i,InpCCIPeriod,PRICE_TYPICAL,0);
   if (cciline>=100)  cciresult="Buy";
   else 
   if (cciline<=-100)  cciresult="Sell";
   else
   cciresult="No";   



}