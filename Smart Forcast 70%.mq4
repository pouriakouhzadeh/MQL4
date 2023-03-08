//+------------------------------------------------------------------+
//|                                            Smart Forcast 70%.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
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

int filehandle;

double close[30000];

static datetime lastbar;

extern int Number_Of_Candle=15000;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
     lastbar=Time[0];
     FileDelete("Answer.csv",FILE_COMMON);   
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
if (isNewBar())
  {
      Data_generator();
      ShellExecuteW(0,0,"c:\\Dayli.bat",0,0,SW_SHOW);
  }
   
   
  }
//+------------------------------------------------------------------+

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


void Data_generator()
{

filehandle=FileOpen("Dayli_Data.csv",FILE_WRITE|FILE_COMMON|FILE_CSV); 

for (int i=1;i<=Number_Of_Candle;i++)
  {
      close[i]=iClose(Symbol(),0,i);
  }  
 
for (int i=Number_Of_Candle;i>=1;i--)
  {

       if(filehandle!=INVALID_HANDLE) 
          { 
              FileWrite(filehandle,(DoubleToStr(close[i],10))); 
          }

   }  
FileClose(filehandle);
  
}

  