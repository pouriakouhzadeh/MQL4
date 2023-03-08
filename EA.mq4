//+------------------------------------------------------------------+
//|                                                           EA.mq4 |
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
long cunt=0;
long lastcunt=0;
datetime Datetime;
double info[50];
double info_s[50];
double data[50];
double data_s[50];

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
  int f=0;
   while ((lastcunt==cunt) && (f<=100))
   {
   f++;
   int filehandle=FileOpen("data.csv",FILE_SHARE_READ|FILE_COMMON|FILE_CSV); 
   if(filehandle!=INVALID_HANDLE) 
     { 
   cunt=StrToInteger(FileReadString(filehandle,30));  
   Datetime=StrToTime(FileReadString(filehandle,30));
   int j=0;
   while(!FileIsLineEnding(filehandle) || !FileIsEnding(filehandle))
   {
   info[j]=StrToDouble(FileReadString(filehandle,30));
   info_s[j]=StrToDouble(FileReadString(filehandle,30));
   //Print(StrToDouble(FileReadString(filehandle,30)),"----",j);
   j++;
   }
      FileClose(filehandle); 
      Print("FileOpen OK"); 
     } 

   //else Print("Operation FileOpen failed, error ",GetLastError()); 
   }
   
   if(f>=100)   { Print(f);Comment("Server Not working"); return; }
   if(lastcunt != cunt) Comment("Server is working....");
   lastcunt =cunt;


      data[0]=MarketInfo("EURUSD",MODE_BID); 
      data_s[0]=MarketInfo("EURUSD",MODE_SPREAD); 

      data[1]=MarketInfo("GBPUSD",MODE_BID); 
      data_s[1]=MarketInfo("GBPUSD",MODE_SPREAD); 
      

      data[2]=MarketInfo("EURGBP",MODE_BID); 
      data_s[2]=MarketInfo("EURGBP",MODE_SPREAD); 
      

      data[3]=MarketInfo("USDCAD",MODE_BID); 
      data_s[3]=MarketInfo("USDCAD",MODE_SPREAD); 

      data[4]=MarketInfo("AUDUSD",MODE_BID); 
      data_s[4]=MarketInfo("AUDUSD",MODE_SPREAD); 


      data[5]=MarketInfo("NZDUSD",MODE_BID); 
      data_s[5]=MarketInfo("NZDUSD",MODE_SPREAD); 

      data[6]=MarketInfo("USDCHF",MODE_BID); 
      data_s[6]=MarketInfo("USDCHF",MODE_SPREAD); 

      data[7]=MarketInfo("EURCHF",MODE_BID); 
      data_s[7]=MarketInfo("EURCHF",MODE_SPREAD); 

      data[8]=MarketInfo("GBPJPY",MODE_BID); 
      data_s[8]=MarketInfo("GBPJP",MODE_SPREAD); 

      data[9]=MarketInfo("AUDJPY",MODE_BID); 
      data_s[9]=MarketInfo("AUDJPY",MODE_SPREAD); 


      data[10]=MarketInfo("USDJPY",MODE_BID); 
      data_s[10]=MarketInfo("USDJPY",MODE_SPREAD); 

      data[11]=MarketInfo("EURJPY",MODE_BID); 
      data_s[11]=MarketInfo("EURJPY",MODE_SPREAD); 


   for (int i=0;i<12;i++) 
   {

   string information=(DoubleToStr(info[i],5)+" - "+DoubleToStr(data[i],5)+" = "+DoubleToStr(info[i]-data[i],5)+"-->"+DoubleToStr(info_s[i],5)+" + "+DoubleToStr(data_s[i],5)+" = "+DoubleToStr(((info_s[i]+data_s[i])*Point()),5)); 
   ObjectCreate("comment_label4"+IntegerToString(i),OBJ_LABEL,0,0,0);
   ObjectSet("comment_label4"+IntegerToString(i),OBJPROP_XDISTANCE,700);   
   ObjectSet("comment_label4"+IntegerToString(i),OBJPROP_YDISTANCE,50+(15*i));
   ObjectSetText("comment_label4"+IntegerToString(i),information,8,"Arial",Yellow);
   WindowRedraw();
   
   
   //Print (info[i],"==",info_s[i]); 
   //Print(data[i],"==",data_s[i]);
   //Print(info[i]-data[i]);
   }


//Print(cunt,"---",Datetime);
  }

//+------------------------------------------------------------------+
