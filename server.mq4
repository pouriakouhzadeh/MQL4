//+------------------------------------------------------------------+
//|                                                       server.mq4 |
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

int OnInit()
  {
//--- file
long i=1;
while (i!=0)
{
i++;
Comment("Data Send NO=",i);

//--- incorrect file opening method 
   //string terminal_data_path=TerminalInfoString(TERMINAL_COMMONDATA_PATH); 
  // string filename=terminal_data_path;  
  // FolderCreate(terminal_data_path+"\\"+"yes",FILE_WRITE);
  // Print(filename);
//   int filehandle=FileOpen(filename,FILE_SHARE_WRITE|FILE_CSV); 
//   if(filehandle<0) 
//     { 
//      Print("Failed to open the file by the absolute path "); 
//      Print("Error code ",GetLastError()); 
//     } 
//--- correct way of working in the "file sandbox" 
//   ResetLastError(); 
  // Print (filename+"\\Data.csv");
   int filehandle=FileOpen("Data.csv",FILE_WRITE|FILE_COMMON|FILE_CSV); 
   if(filehandle!=INVALID_HANDLE) 
     { 
      FileWrite(filehandle, i); 

      FileWrite(filehandle,TimeCurrent());
      
      
      
      
      
      
      
      
      
      
      
      FileWrite(filehandle, MarketInfo("EURUSDe",MODE_BID)); 
      FileWrite(filehandle, MarketInfo("EURUSDe",MODE_SPREAD)); 

      FileWrite(filehandle, MarketInfo("GBPUSDe",MODE_BID)); 
      FileWrite(filehandle, MarketInfo("GBPUSDe",MODE_SPREAD)); 
      
      FileWrite(filehandle, MarketInfo("EURGBPe",MODE_BID)); 
      FileWrite(filehandle, MarketInfo("EURGBPe",MODE_SPREAD)); 

      FileWrite(filehandle, MarketInfo("USDCADe",MODE_BID)); 
      FileWrite(filehandle, MarketInfo("USDCADe",MODE_SPREAD)); 
      

      FileWrite(filehandle, MarketInfo("AUDUSDe",MODE_BID)); 
      FileWrite(filehandle, MarketInfo("AUDUSDe",MODE_SPREAD)); 

      FileWrite(filehandle, MarketInfo("NZDUSDe",MODE_BID)); 
      FileWrite(filehandle, MarketInfo("NZDUSDe",MODE_SPREAD)); 

      FileWrite(filehandle, MarketInfo("USDCHFe",MODE_BID)); 
      FileWrite(filehandle, MarketInfo("USDCHFe",MODE_SPREAD)); 

      FileWrite(filehandle, MarketInfo("EURCHFe",MODE_BID)); 
      FileWrite(filehandle, MarketInfo("EURCHFe",MODE_SPREAD)); 

      FileWrite(filehandle, MarketInfo("GBPJPYe",MODE_BID)); 
      FileWrite(filehandle, MarketInfo("GBPJPYe",MODE_SPREAD)); 

      FileWrite(filehandle, MarketInfo("AUDJPYe",MODE_BID)); 
      FileWrite(filehandle, MarketInfo("AUDJPYe",MODE_SPREAD)); 

      FileWrite(filehandle, MarketInfo("USDJPYe",MODE_BID)); 
      FileWrite(filehandle, MarketInfo("USDJPYe",MODE_SPREAD)); 

      FileWrite(filehandle, MarketInfo("EURJPYe",MODE_BID)); 
      FileWrite(filehandle, MarketInfo("EURJPYe",MODE_SPREAD)); 


      FileClose(filehandle); 
      
      Print("FileOpen OK"); 
     } 
   else Print("Operation FileOpen failed, error ",GetLastError()); 
//--- another example with the creation of an enclosed directory in MQL4\Files\ 
if (i==999999999) i=1;
}

  
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


