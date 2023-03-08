//+------------------------------------------------------------------+
//|                                                      Academi.mq4 |
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
extern int    InpBandsPeriod=14;      // Bands Period
extern int    InpBandsShift=0;        // Bands Shift
extern double InpBandsDeviations=2.0; // Bands Deviations
//--------------------------------------

double B_h,B_m,B_l;
double WPR;
extern int Williams_period=14;
extern int WPR_factor_l=-20;
extern int WPR_factor_h=-80;

//--------------Enveloped---------------
extern int En_ma_period=14;
extern int En_ma_method=0;//0-3//
extern int En_A_P=0;//0-6//
extern double En_dev=0.1;//0-1//

//---------------------------------------
double En_h,En_l;


//-----------Positions ------------
extern int MAGIC_BUY=1000;
extern int MAGIC_SELL=2000;
int tiket;
extern double lot=0.2;
extern int stoploss=280;
extern int takeprofit=280;
string com="Pourias Expert Position";

//---------------------------------
double sp_d;
extern int Max_Order=5;

static string No_position_BUY,No_position_SELL;
int OnInit()
  {
//---
No_position_BUY="NO";
No_position_SELL="NO";   
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
B_h=iCustom(Symbol(),5,"Bands",InpBandsPeriod,InpBandsShift,InpBandsDeviations,1,0);
//B_m=iCustom(Symbol(),5,"Bands",InpBandsPeriod,InpBandsShift,InpBandsDeviations,0,0);
B_l=iCustom(Symbol(),5,"Bands",InpBandsPeriod,InpBandsShift,InpBandsDeviations,2,0);

WPR=iWPR(Symbol(),5,Williams_period,0);
//WPR=WPR*-1;

En_h=iEnvelopes(Symbol(),5,En_ma_period,En_ma_method,0,En_A_P,En_dev,1,0);
En_l=iEnvelopes(Symbol(),5,En_ma_period,En_ma_method,0,En_A_P,En_dev,2,0);
//Print ("WPR=",WPR);


sp_d=iCustom(Symbol(),1440,"sp_d",0,0);

Print(sp_d);


//------------Position free SELL--------------
if (No_position_SELL=="YES")
{
//Print("No_position_SELL=YES");
if (iHigh(Symbol(),5,0)<B_h)
{ 
//Print("iHigh<B_h","WPR=",WPR);

if (iHigh(Symbol(),5,0)<En_h)
{
//Print("iHigh<En_h"); 
if (WPR<WPR_factor_l)
{
No_position_SELL="NO";
//Print ("WPR>WPR_factor And No_position_SELL==NO");
}
}
}
}
//-------------------------------------------

//------------Position free BUY--------------


if (No_position_BUY=="YES")  
if ((iLow(Symbol(),5,0)>B_l) && (iLow(Symbol(),5,0)>En_l) && (WPR>WPR_factor_h))
No_position_BUY="NO";

if (OrdersTotal()>Max_Order) return;


//---------SELL Condition -------------
if (No_position_SELL=="NO")
if (iHigh(Symbol(),5,0)>=B_h)
         if (iHigh(Symbol(),5,0)>=En_h)
                  if(WPR>=WPR_factor_l) 
                        {
                        Print ("WPR=",WPR);
                          tiket=OrderSend(Symbol(),OP_SELL,lot,Bid,6,Bid+stoploss*Point(),Bid-takeprofit*Point(),com,MAGIC_SELL,0,Red);
                       
                        No_position_SELL="YES";
                        }

//------------Position limit-----------




                        
//-------------------------------------
//----------BUY Condition-------------
if (No_position_BUY=="NO")
if (iLow(Symbol(),5,0)<=B_l)
         if (iLow(Symbol(),5,0)<=En_l)
                  if(WPR<=WPR_factor_h) 
                        {
                         Print ("WPR=",WPR);
                         tiket=OrderSend(Symbol(),OP_BUY,lot,Ask,6,Ask-stoploss*Point(),Ask+takeprofit*Point(),com,MAGIC_BUY,0,Blue);
                      
                        No_position_BUY="YES";
                        }                        
                        


//  Print (No_position_BUY,"------",No_position_SELL); 
   
  }
//+------------------------------------------------------------------+
