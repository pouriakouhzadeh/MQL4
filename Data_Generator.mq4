//+------------------------------------------------------------------+
//|                                               Data_Generator.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
extern string Market_prefix="";
extern int Candle_QTY=2000;
static int min;
static datetime lastbar;
int filehandle;
double open[3501],high[3501],low[3501],close[3501];
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   FileDelete(StringSubstr(ChartSymbol(),0,6)+".csv",FILE_COMMON|FILE_CSV);  
   EventSetTimer(1);
   Data_Write();
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
if(Period()!=1)
{
My_print("Error Please Set Time frame period to 1Min",100,200,3,40,Red);
}
else
{
My_print("",200,100,3,40,Red);
}
  MqlDateTime t;
TimeToStruct(TimeCurrent(),t);
My_print(IntegerToString(60-t.sec),900,50,2,100,Red);
if(t.sec==1)
{  
min=t.min;
if(FileIsExist(StringSubstr(ChartSymbol(),0,6)+".csv",FILE_COMMON|FILE_CSV)){return;}
Data_Generator();
}
if(t.sec==2  &&  min!=t.min)
{
min=t.min;
if(FileIsExist(StringSubstr(ChartSymbol(),0,6)+".csv",FILE_COMMON|FILE_CSV)){return;}
Data_Generator();
}
if(t.sec==3  &&  min!=t.min)
{
min=t.min;
if(FileIsExist(StringSubstr(ChartSymbol(),0,6)+".csv",FILE_COMMON|FILE_CSV)){return;}
Data_Generator();
}
if(t.sec==4  &&  min!=t.min)
{
min=t.min;
if(FileIsExist(StringSubstr(ChartSymbol(),0,6)+".csv",FILE_COMMON|FILE_CSV)){return;}
Data_Generator();
}

  }
//+------------------------------------------------------------------+
bool isNewBar()
  {
   datetime curbar=iTime(Symbol(),1,0);
   
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
   
void Data_Write()
{
for(int i=1; i<=Candle_QTY; i++)
{
open[i]=iOpen(Symbol()+Market_prefix,1,i);
high[i]=iHigh(Symbol()+Market_prefix,1,i);
low[i]=iLow(Symbol()+Market_prefix,1,i);
close[i]=iClose(Symbol()+Market_prefix,1,i);
}

   filehandle=FileOpen(StringSubstr(ChartSymbol(),0,6)+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV);

      if(filehandle!=INVALID_HANDLE)
        {      
               for(int i=Candle_QTY; i>=1; i--)
                  {
                  FileWrite(filehandle,DoubleToStr(open[i],10)+","+DoubleToStr(high[i],10)+","+DoubleToStr(low[i],10)+","+DoubleToStr(close[i],10));
                  }
        }
   
   FileClose(filehandle);  
}
void Data_Write_BID()
{

for(int i=0; i<=Candle_QTY; i++)
{
open[i+1]=iOpen(Symbol()+Market_prefix,1,i);
high[i+1]=iHigh(Symbol()+Market_prefix,1,i);
low[i+1]=iLow(Symbol()+Market_prefix,1,i);
close[i+1]=iClose(Symbol()+Market_prefix,1,i);
}
   filehandle=FileOpen(StringSubstr(ChartSymbol(),0,6)+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV);

      if(filehandle!=INVALID_HANDLE)
        {      
               for(int i=Candle_QTY+1; i>=1; i--)
                  {
                  FileWrite(filehandle,DoubleToStr(open[i],10)+","+DoubleToStr(high[i],10)+","+DoubleToStr(low[i],10)+","+DoubleToStr(close[i],10));
                  }
        }
   
   FileClose(filehandle);  
}

void My_print(string Text,int x,int y,string lable,int size,string Color1)
  {

   string text=(Text);
   ObjectCreate(lable,OBJ_LABEL,0,0,0);
   ObjectSet(lable,OBJPROP_XDISTANCE,x);
   ObjectSet(lable,OBJPROP_YDISTANCE,y);
   ObjectSetText(lable,text,size,"Times New Roman",Yellow);
   WindowRedraw();
  }
void Data_Generator()
  {
if(isNewBar())
{
Data_Write();
My_print(StringSubstr(ChartSymbol(),0,6)+" New Bar "+DoubleToStr(iClose(Symbol(),1,1)),250,100,1,30,20);
}   
else
{
Data_Write_BID();
My_print(StringSubstr(ChartSymbol(),0,6)+" MODE BID "+DoubleToStr(iClose(Symbol(),1,0)),250,100,1,30,20);
}
  }