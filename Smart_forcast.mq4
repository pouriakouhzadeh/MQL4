//+------------------------------------------------------------------+
//|                                                   Hesam Data.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#define SW_HIDE             0
#define SW_SHOWNORMAL       1
#define SW_NORMAL           1
#define SW_SHOWMINIMIZED    2
#define SW_SHOWMAXIMIZED    3
#define SW_MAXIMIZE         3
#define SW_SHOWNOACTIVATE   4
#define SW_SHOW             5
#define SW_MINIMIZE         6
#define SW_SHOWMINNOACTIVE  7
#define SW_SHOWNA           8
#define SW_RESTORE          9
#define SW_SHOWDEFAULT      10
#define SW_FORCEMINIMIZE    11
#define SW_MAX              11


#import "shell32.dll"
int ShellExecuteW(int hWnd,int lpVerb,string lpFile,int lpParameters,int lpDirectory,int nCmdShow);
#import

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int filehandle;
//extern string Currency_Pair="EURUSD";
//extern string Market_Prefix="";
//extern int Timeframe=1440;
extern int Number_Of_Candle=5247;
double open[100000];
double close[100000];
double high[100000];
double low[100000];
datetime time[100000];


static double Target=0;
static datetime lastbar;
static bool Check_target=false;
static bool Get_position_tag=false;


int tiket;
double LOTS=0.1;
extern int Magic_NO=1000;

//static string Kind="";
int OnInit()
  {
     lastbar=Time[0];
     FileDelete("Answer_Dayli.csv",FILE_COMMON);
//---

     Data_generator();

//ShellExecuteW(0,0,"c:\\Users\\Administrator\\AppData\\Roaming\\MetaQuotes\\Terminal\\Common\\Files\\Dayli.bat","",0,SW_SHOW);
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
if (Check_target==true) Set_Target();
Comment("Target is : ",Target);
if (Get_position_tag==true) Get_position();
if (isNewBar())
  {
      Data_generator();
      ShellExecuteW(0,0,"c:\\Users\\Administrator\\AppData\\Roaming\\MetaQuotes\\Terminal\\Common\\Files\\Dayli.bat","",0,SW_SHOW);
      Check_target=true;
  }

  }
//+------------------------------------------------------------------+
void Data_generator()
{
Comment("Calculating ...");
   filehandle=FileOpen("Dayli_Data.csv",FILE_WRITE|FILE_COMMON|FILE_CSV); 
 //  FileWrite(filehandle,"Open"+","+"Close"+","+"High"+","+"Low"+","+"Time"); 


for (int i=1;i<=Number_Of_Candle;i++)
  {

   //   open[i]=iOpen(Currency_Pair+Market_Prefix,Timeframe,i);
      close[i]=iClose(Symbol(),0,i);
   //   high[i]=iHigh(Currency_Pair+Market_Prefix,Timeframe,i);
   //   low[i]=iLow(Currency_Pair+Market_Prefix,Timeframe,i);
    // time[i]=iTime(Currency_Pair+Market_Prefix,Timeframe,i); 

   }  
   
   
 
for (int i=Number_Of_Candle;i>=1;i--)
  {

   if(filehandle!=INVALID_HANDLE) 
     { 

       FileWrite(filehandle,(DoubleToStr(close[i],10))); 
  
     }

   }  
    FileClose(filehandle);
    Comment("Expert is runing good ...."); 
   
}

 bool isNewBar() 
{ 
   datetime curbar = Time[0]; 
   if(lastbar!=curbar) 
   { 
      lastbar=curbar; 
      return (true); 
   }    
   else 
   { 
      return(false); 
   } 
}   
  
  
  
void Set_Target()
{
   bool filehandle_answer=FileOpen("Answer_Dayli.csv",FILE_READ|FILE_COMMON|FILE_CSV);
   if(filehandle_answer!=INVALID_HANDLE) 
     { 
         Target=StrToDouble(FileReadString(filehandle_answer,10));
  
     } 
     FileClose(filehandle_answer);
     FileDelete("Answer_Dayli.csv",FILE_COMMON);
     if (Target!=0)          
     {
      Check_target=false; 
      Get_position_tag=true;
     }
}     

void Get_position()
{
if (Target>Bid) 
{
//Kind=="BUY";
Print("Buy"); 
         tiket=OrderSend(Symbol(),OP_BUY,LOTS,Ask,10,0,Target,"Afsaneh",Magic_NO,0,Blue);

            Get_position_tag=false;
            Close_revers("BUY");
            
}
if (Target<Bid) 
{
//Kind=="SELL";
Print("Sell"); 

         tiket=OrderSend(Symbol(),OP_SELL,LOTS,Bid,10,0,Target,"Afsaneh",Magic_NO,0,Red);

         Get_position_tag=false;
         Close_revers("SELL");
         
}

}

void Close_revers(string Kind)
{
if (Kind=="BUY")
{
Print("kind == buy so close sell");
            for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                   if(OrderMagicNumber()==Magic_NO)
                   if(OrderType()==OP_SELL)
                   bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
               }   
         
Kind=""; 
        
}


if (Kind=="SELL")
{
Print("kind == sell so close buy");
            for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                   if(OrderMagicNumber()==Magic_NO)
                   if(OrderType()==OP_BUY)
                   bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
               }  
               
Kind=""; 
      

}

}
