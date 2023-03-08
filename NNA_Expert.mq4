//+------------------------------------------------------------------+
//|                                                   NNA_Expert.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+


//---------- VARIABLES ---------------------------------------------

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

static datetime lastbar;
extern string MarketPrefix="";
string terminal_data_path=TerminalInfoString(TERMINAL_COMMONDATA_PATH);

//datetime Timearray[15000];

int filehandle_EURUSD,filehandle_USDCHF,filehandle_EURCHF,filehandle_EURAUD,filehandle_AUDUSD,filehandle_AUDCAD,filehandle_USDCAD,filehandle_answer;
double Answer;
double A_R=-1;
double G_P=-1;
double G_P_T=-1;
double S_Q=-1;
string An[5000];
//double LOTS=0.01;

static string Last_Orientation[800];
int Magic_No=20;
static string Market[800];
static string Posi[800];
static int time[800];
static string oriantation[800];
static int wight[800];
static double Level[800];
static int win[800];


int tiket=0;
static double NNA_Answer[800];
static double Last_NNA_Answer[800];
int Net_qty,Last_Net_qty;
int Candle_QTY=15000;
static int B_C_T,W_C_T;
//static datetime L_min;
static int min;
static bool Close_ALL=true;
static datetime Last_Answer_Read;
int counter,Answer_file_counter;


//------------------------------------------------------------------

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   Last_Answer_Read=0;
   B_C_T=60;
   W_C_T=0;
   MqlDateTime L_min;
   TimeToStruct(TimeCurrent(),L_min);
   min=L_min.min;

   GlobalVariableSet("Answer_read",0);

 //  FileDelete("EURUSD.csv",FILE_COMMON|FILE_TXT);
 //  FileDelete("USDCHF.csv",FILE_COMMON|FILE_TXT); 
 //  FileDelete("EURCHF.csv",FILE_COMMON|FILE_TXT); 

   
   for(int j=1;j<=Net_qty;j++)
   {

         Last_Orientation[j]="Pending";
         Last_NNA_Answer[j]=0;
   }     
   // Answer_read();


  EventSetTimer( 1 );
 My_print2( "Next bar " ,830,35,"201",15,"Yellow");
 My_print2( "Spread " ,830,75,"200",15,"Yellow");
 My_print2( "Open Orders " ,830,115,"202",15,"Yellow");
 My_print2( "Open Files " ,830,155,"203",15,"Yellow");
 My_print2( "Accunt Balance " ,830,195,"204",15,"Yellow");
 //ShellExecuteW(0,0,terminal_data_path+"\\files\\"+"NNA.bat","",0,SW_HIDE);   
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
//---Be name davare bar hagh - bakhshandeye bozorg - be name khodavande isar va ensaf

void OnTimer()
  {
counter=counter+1;
Comment(counter);
if(counter>200)
{
Alert("Program error chek it ! ");
SendNotification("Program error !!!");
}
  
   bool f=GlobalVariableGet("Get_position",G_P);
   if(G_P==1)
     {

         Get_Position();

     }

   bool e=GlobalVariableGet("Answer_read",A_R);
   if(A_R==1)
     {
      Answer_read();
     }

MqlDateTime t;
TimeToStruct(TimeCurrent(),t);


My_print2( IntegerToString((60-t.sec)) ,950,20,"100",30,"clrGold");

My_print2( DoubleToStr(spread(Symbol()),0) ,950,60,"102",30,"clrGold");

My_print2( IntegerToString(OrdersTotal()) ,950,100,"103",30,"clrGold");

My_print( DoubleToString(AccountBalance(),2)+"$" ,960,190,"109",20,"clrGold");

My_print1( "Best and Worst CALC Time:"+IntegerToString(B_C_T)+" & "+IntegerToString(W_C_T)+" Seconds" ,770,250,"110",12,"clrGold");

int files_open=0;
if(FileIsExist("EURUSD.csv",FILE_COMMON|FILE_CSV)) files_open=files_open+1;
if(FileIsExist("USDCHF.csv",FILE_COMMON|FILE_CSV)) files_open=files_open+1;
if(FileIsExist("EURCHF.csv",FILE_COMMON|FILE_CSV)) files_open=files_open+1;
if(FileIsExist("Answer_Robo.txt",FILE_COMMON|FILE_TXT)) 
{
files_open=files_open+1;
Answer_file_counter++;
}
if(Answer_file_counter>10) Answer_read();

My_print2( IntegerToString(files_open) ,950,140,"104",30,"clrGold");

if(t.sec==0)
{  
/*      if(((t.hour==23) && (t.min>=45))  || ((t.hour==0) && (t.min<=15))) 
      {
         FileDelete("EURUSD.csv",FILE_COMMON|FILE_TXT);
         FileDelete("USDCHF.csv",FILE_COMMON|FILE_TXT); 
         FileDelete("EURCHF.csv",FILE_COMMON|FILE_TXT); 
      My_print3(" << This is forbidden time , Expert temprory disabled >>",20,200,"1",30,"Green");
      return;
      }
*/      
      min=t.min;
      Close_orders();
      if(FileIsExist("EURUSD.csv",FILE_COMMON|FILE_CSV))
      {
       return;
      }
      if(FileIsExist("USDCHF.csv",FILE_COMMON|FILE_CSV))
      {
       return;
      }
      if(FileIsExist("EURCHF.csv",FILE_COMMON|FILE_CSV)) 
      { 
       return;
      }

      if(isNewBar())
      {
      //Data_generator();
      }
      else
      {
      //Data_generator_Bid();
      }
     // Answer_read();
     // FileDelete("Answer.txt",FILE_COMMON|FILE_CSV);
      GlobalVariableSet("Answer_read",1);
      GlobalVariableSet("Get_position",0);


     }
     
     
if(t.sec==1  &&  min!=t.min)
{
/*      if(((t.hour==23) && (t.min>=55))  || ((t.hour==0) && (t.min<=5))) 
      {
         FileDelete("EURUSD.csv",FILE_COMMON|FILE_TXT);
         FileDelete("USDCHF.csv",FILE_COMMON|FILE_TXT); 
         FileDelete("EURCHF.csv",FILE_COMMON|FILE_TXT); 
      My_print3(" << This is forbidden time , Expert temprory disabled >>",20,200,"1",30,"Green");
      counter=0;
      return;
      }
*/ 
      min=t.min;
      Close_orders();
      if(FileIsExist("EURUSD.csv",FILE_COMMON|FILE_CSV))
      {
       return;
      }
      if(FileIsExist("USDCHF.csv",FILE_COMMON|FILE_CSV))
      {
       return;
      }
      if(FileIsExist("EURCHF.csv",FILE_COMMON|FILE_CSV)) 
      { 
       return;
      }

      if(isNewBar())
      {
      //Data_generator();
      }
      else
      {
     // Data_generator_Bid();
      }
      
     // Answer_read();

      //FileDelete("Answer.txt",FILE_COMMON|FILE_CSV);
      GlobalVariableSet("Answer_read",1);
      GlobalVariableSet("Get_position",0);
 
}    
     
     
      
if(t.sec==2  &&  min!=t.min)
{
/*      if(((t.hour==23) && (t.min>=45))  || ((t.hour==0) && (t.min<=15))) 
      {
         FileDelete("EURUSD.csv",FILE_COMMON|FILE_TXT);
         FileDelete("USDCHF.csv",FILE_COMMON|FILE_TXT); 
         FileDelete("EURCHF.csv",FILE_COMMON|FILE_TXT); 
      My_print3(" << This is forbidden time , Expert temprory disabled >>",20,200,"1",30,"Green");
      return;
      }
*/      
      min=t.min;
      Close_orders();
      if(FileIsExist("EURUSD.csv",FILE_COMMON|FILE_CSV))
      {
       return;
      }
      if(FileIsExist("USDCHF.csv",FILE_COMMON|FILE_CSV))
      {
       return;
      }
      if(FileIsExist("EURCHF.csv",FILE_COMMON|FILE_CSV)) 
      { 
       return;
      }

      if(isNewBar())
      {
      //Data_generator();
      }
      else
      {
      //Data_generator_Bid();
      }
      
    //  Answer_read();

    //  FileDelete("Answer.txt",FILE_COMMON|FILE_CSV);
      GlobalVariableSet("Answer_read",1);
      GlobalVariableSet("Get_position",0);

}    
    


}
     

  
//+---------------------------------------------------------------------------+
bool isNewBar()
  {
   datetime curbar=Time[0];
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
//------------------------------------------------------------------------------

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
/*void Data_generator()
  {


MqlDateTime time1; 

   filehandle_EURUSD=FileOpen("EURUSD"+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV);
   
   if(filehandle_EURUSD!=INVALID_HANDLE)
   {  
   for(int i=Candle_QTY; i>=1; i--)
     {
         TimeToStruct(iTime("EURUSD",1,i),time1); 
         FileWrite(filehandle_EURUSD,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen(Symbol(),0,i),10)+","+DoubleToStr(iHigh(Symbol(),0,i),10)+","+DoubleToStr(iLow(Symbol(),0,i),10)+","+DoubleToStr(iClose(Symbol(),0,i),10)));
      }
    }
   FileClose(filehandle_EURUSD);
//-------------------- USDCHF -------------------------------------
   filehandle_USDCHF=FileOpen("USDCHF"+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV);

      if(filehandle_USDCHF!=INVALID_HANDLE)
        {      
           if(iTime(Symbol(),1,1)==iTime("USDCHF",1,1))
             {

               for(int i=Candle_QTY; i>=1; i--)
                  {
                  TimeToStruct(iTime("USDCHF",1,i),time1); 
                  FileWrite(filehandle_USDCHF,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("USDCHF",1,i),10)+","+DoubleToStr(iHigh("USDCHF",1,i),10)+","+DoubleToStr(iLow("USDCHF",1,i),10)+","+DoubleToStr(iClose("USDCHF",1,i),10)));
                  }
            }
           if(iTime(Symbol(),1,1)!=iTime("USDCHF",1,1))
             {

               for(int i=Candle_QTY-1; i>=1; i--)
                  {
                  TimeToStruct(iTime("USDCHF",1,i),time1); 
                  FileWrite(filehandle_USDCHF,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("USDCHF",1,i),10)+","+DoubleToStr(iHigh("USDCHF",1,i),10)+","+DoubleToStr(iLow("USDCHF",1,i),10)+","+DoubleToStr(iClose("USDCHF",1,i),10)));
                  }
                  TimeToStruct(MarketInfo("USDCHF",MODE_TIME),time1); 
                  FileWrite(filehandle_USDCHF,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("USDCHF",1,0),10)+","+DoubleToStr(iHigh("USDCHF",1,0),10)+","+DoubleToStr(iLow("USDCHF",1,0),10)+","+DoubleToStr(MarketInfo("USDCHF",MODE_BID),10)));   
            }            
        }
   
   FileClose(filehandle_USDCHF);   
//-------------------- EURCHF -------------------------------------
   filehandle_EURCHF=FileOpen("EURCHF"+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV);

      if(filehandle_EURCHF!=INVALID_HANDLE)
        {      
           if(iTime(Symbol(),1,1)==iTime("EURCHF",1,1))
             {

               for(int i=Candle_QTY; i>=1; i--)
                  {
                  TimeToStruct(iTime("EURCHF",1,i),time1); 
                  FileWrite(filehandle_EURCHF,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("EURCHF",1,i),10)+","+DoubleToStr(iHigh("EURCHF",1,i),10)+","+DoubleToStr(iLow("EURCHF",1,i),10)+","+DoubleToStr(iClose("EURCHF",1,i),10)));
                  }
            }
           if(iTime(Symbol(),1,1)!=iTime("EURCHF",1,1))
             {

               for(int i=Candle_QTY-1; i>=1; i--)
                  {
                  TimeToStruct(iTime("EURCHF",1,i),time1); 
                  FileWrite(filehandle_EURCHF,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("EURCHF",1,i),10)+","+DoubleToStr(iHigh("EURCHF",1,i),10)+","+DoubleToStr(iLow("EURCHF",1,i),10)+","+DoubleToStr(iClose("EURCHF",1,i),10)));
                  }
                  TimeToStruct(MarketInfo("EURCHF",MODE_TIME),time1); 
                  FileWrite(filehandle_EURCHF,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("EURCHF",1,0),10)+","+DoubleToStr(iHigh("EURCHF",1,0),10)+","+DoubleToStr(iLow("EURCHF",1,0),10)+","+DoubleToStr(MarketInfo("EURCHF",MODE_BID),10)));   
            }            
        }
   
   FileClose(filehandle_EURCHF);  
  }
//--------------------------------------------------------------------------------

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Data_generator_Bid()
{

MqlDateTime time1; 

   filehandle_EURUSD=FileOpen("EURUSD"+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV);
   
   if(filehandle_EURUSD!=INVALID_HANDLE)
   {  
   for(int i=Candle_QTY-1; i>=1; i--)
     {
         TimeToStruct(iTime("EURUSD",1,i),time1); 
         FileWrite(filehandle_EURUSD,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen(Symbol(),0,i),10)+","+DoubleToStr(iHigh(Symbol(),0,i),10)+","+DoubleToStr(iLow(Symbol(),0,i),10)+","+DoubleToStr(iClose(Symbol(),0,i),10)));
      }
                 TimeToStruct(TimeCurrent(),time1); 
                  FileWrite(filehandle_EURUSD,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("EURUSD",1,0),10)+","+DoubleToStr(iHigh("EURUSD",1,0),10)+","+DoubleToStr(iLow("EURUSD",1,0),10)+","+DoubleToStr(MarketInfo("EURUSD",MODE_BID),10)));   
      
      
    }
   FileClose(filehandle_EURUSD);
//-------------------- USDCHF -------------------------------------
   filehandle_USDCHF=FileOpen("USDCHF"+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV);

      if(filehandle_USDCHF!=INVALID_HANDLE)
        {      
           if(iTime(Symbol(),1,1)!=iTime("USDCHF",1,1))
             {

               for(int i=Candle_QTY; i>=1; i--)
                  {
                  TimeToStruct(iTime("USDCHF",1,i),time1); 
                  FileWrite(filehandle_USDCHF,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("USDCHF",1,i),10)+","+DoubleToStr(iHigh("USDCHF",1,i),10)+","+DoubleToStr(iLow("USDCHF",1,i),10)+","+DoubleToStr(iClose("USDCHF",1,i),10)));
                  }
            }
           if(iTime(Symbol(),1,1)==iTime("USDCHF",1,1))
             {

               for(int i=Candle_QTY-1; i>=1; i--)
                  {
                  TimeToStruct(iTime("USDCHF",1,i),time1); 
                  FileWrite(filehandle_USDCHF,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("USDCHF",1,i),10)+","+DoubleToStr(iHigh("USDCHF",1,i),10)+","+DoubleToStr(iLow("USDCHF",1,i),10)+","+DoubleToStr(iClose("USDCHF",1,i),10)));
                  }
                  TimeToStruct(TimeCurrent(),time1); 
                  FileWrite(filehandle_USDCHF,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("USDCHF",1,0),10)+","+DoubleToStr(iHigh("USDCHF",1,0),10)+","+DoubleToStr(iLow("USDCHF",1,0),10)+","+DoubleToStr(MarketInfo("USDCHF",MODE_BID),10)));   
            }            
        }
   
   FileClose(filehandle_USDCHF);   
//-------------------- EURCHF -------------------------------------
   filehandle_EURCHF=FileOpen("EURCHF"+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV);

      if(filehandle_EURCHF!=INVALID_HANDLE)
        {      
           if(iTime(Symbol(),1,1)!=iTime("EURCHF",1,1))
             {

               for(int i=Candle_QTY; i>=1; i--)
                  {
                  TimeToStruct(iTime("EURCHF",1,i),time1); 
                  FileWrite(filehandle_EURCHF,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("EURCHF",1,i),10)+","+DoubleToStr(iHigh("EURCHF",1,i),10)+","+DoubleToStr(iLow("EURCHF",1,i),10)+","+DoubleToStr(iClose("EURCHF",1,i),10)));
                  }
            }
           if(iTime(Symbol(),1,1)==iTime("EURCHF",1,1))
             {

               for(int i=Candle_QTY-1; i>=1; i--)
                  {
                  TimeToStruct(iTime("EURCHF",1,i),time1); 
                  FileWrite(filehandle_EURCHF,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("EURCHF",1,i),10)+","+DoubleToStr(iHigh("EURCHF",1,i),10)+","+DoubleToStr(iLow("EURCHF",1,i),10)+","+DoubleToStr(iClose("EURCHF",1,i),10)));
                  }
                  TimeToStruct(TimeCurrent(),time1); 
                  FileWrite(filehandle_EURCHF,IntegerToString(time1.year)+"-"+IntegerToString(time1.mon)+"-"+IntegerToString(time1.day)+" "+IntegerToString(time1.hour)+":"+IntegerToString(time1.min)+","+(DoubleToStr(iOpen("EURCHF",1,0),10)+","+DoubleToStr(iHigh("EURCHF",1,0),10)+","+DoubleToStr(iLow("EURCHF",1,0),10)+","+DoubleToStr(MarketInfo("EURCHF",MODE_BID),10)));   
            }            
        }
   
   FileClose(filehandle_EURCHF);  
}
*/
//--------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------


void Close_orders()
  {
 
Close_ALL=false;
while (Close_ALL==false)
{
Close_ALL=true;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
            
            
            
            if(OrderSymbol()=="EURUSD")
               {

                     if(OrderType()==OP_BUY)
                     {  
                     
                    
                           if( StrToDouble(StringSubstr(OrderComment(),3,6)) !=0)                        
                        if((Bid-StrToDouble((StringSubstr(OrderComment(),3,6))))>=(OrderMagicNumber()*0.0001))
                           {
                           


               if(OrderType()==OP_BUY || OrderType()==OP_SELL)
               {                   
                     bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Red);                          
                           
                     Close_Similar(OrderComment(),OrderSymbol());

                     Alert("Balance is : "+AccountBalance()+" Order closed BY Close_order function");
                }
                           }

                     }

                     if(OrderType()==OP_SELL)
                     {
                     
                       
                           if( StrToDouble(StringSubstr(OrderComment(),3,6)) !=0)                     
                        if((StrToDouble(StringSubstr(OrderComment(),3,6))-Bid)>=(OrderMagicNumber()*0.0001))
                           {

               if(OrderType()==OP_BUY || OrderType()==OP_SELL)
               {
                     bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Red);                          
                           
                     Close_Similar(OrderComment(),OrderSymbol());

                     Alert("Balance is : "+AccountBalance()+" Order closed BY Close_order function");
                     }
                           }

                     }


               }
            
            if(OrderSymbol()=="USDCHF")
               {
                    
                    
                    
             if(OrderType()==OP_BUY)
             
                       {


                           if( StrToDouble(StringSubstr(OrderComment(),3,6)) !=0)                      
                           if((MarketInfo("USDCHF",MODE_BID)-StrToDouble(StringSubstr(OrderComment(),3,6)))>=(OrderMagicNumber()*0.0001))
                              {

               if(OrderType()==OP_BUY || OrderType()==OP_SELL)
               {
                     bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Red);                          
                           
                     Close_Similar(OrderComment(),OrderSymbol());

                     Alert("Balance is : "+AccountBalance()+" Order closed BY Close_order function");
                     }
                              }

                        }
             if(OrderType()==OP_SELL)
             
                       {


                           if( StrToDouble(StringSubstr(OrderComment(),3,6)) !=0)                                                     
                           if((StrToDouble(StringSubstr(OrderComment(),3,6))-MarketInfo("USDCHF",MODE_BID))>=(OrderMagicNumber()*0.0001))
                              {
                                             if(OrderType()==OP_BUY || OrderType()==OP_SELL)
                                             {
                                 bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Red);
                                 Close_Similar(OrderComment(),OrderSymbol());

                                 Alert("Balance is : "+AccountBalance()+" Order closed BY Close_order function");
                                 }
                              }

                        }              
               
               }

            
            if(OrderSymbol()=="EURCHF")
               {
               
               
             if(OrderType()==OP_BUY)
             
                       {              


                           if( StrToDouble(StringSubstr(OrderComment(),3,6)) !=0)
                           if((MarketInfo("EURCHF",MODE_BID)-StrToDouble(StringSubstr(OrderComment(),3,6)))>=(OrderMagicNumber()*0.0001))
                              {


               if(OrderType()==OP_BUY || OrderType()==OP_SELL)
               {
                     bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Red);                          
                           
                     Close_Similar(OrderComment(),OrderSymbol());

                     Alert("Balance is : "+AccountBalance()+" Order closed BY Close_order function");
                     }
                              }
                       }

               
            
             if(OrderType()==OP_SELL)
             
                       {              


                            if( StrToDouble(StringSubstr(OrderComment(),3,6)) !=0)                           
                           if((StrToDouble(StringSubstr(OrderComment(),3,6))-MarketInfo("EURCHF",MODE_BID))>=(OrderMagicNumber()*0.0001))
                              {

               if(OrderType()==OP_BUY || OrderType()==OP_SELL)
               {
                     bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Red);                          
                           
                     Close_Similar(OrderComment(),OrderSymbol());

                     Alert("Balance is : "+AccountBalance()+" Order closed BY Close_order function");
                     }
                              }
                       }

               }


 
         }

}
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Close_Order_Reverse(string Orin,int magic)
{
Close_ALL=false;
while (Close_ALL==false)
{
Close_ALL=true;
if(Orin=="DN" && Market[magic]=="EURUSD")
{
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
            if(OrderType()==OP_BUY )
            if(OrderSymbol()=="EURUSD")   
            if(StrToInteger(StringSubstr(OrderComment(),0,2))==wight[magic])         
            if(OrderMagicNumber()==time[magic])
              {
               if(OrderType()==OP_BUY || OrderType()==OP_SELL)
               {
                  bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Black);              
                  Close_Similar(OrderComment(),OrderSymbol());
                  SendNotification("Your accunt alance is : "+AccountBalance()+" Order closed BY Close_reverse function");   
               }         
              }
     }
}


if(Orin=="UP" && Market[magic]=="EURUSD")
{
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
            if(OrderType()==OP_SELL)
            if(OrderSymbol()=="EURUSD")
            if(StrToInteger(StringSubstr(OrderComment(),0,2))==wight[magic])         
            if(OrderMagicNumber()==time[magic] )
           
              {
               if(OrderType()==OP_BUY || OrderType()==OP_SELL)
               {
                  bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Black);              
                  Close_Similar(OrderComment(),OrderSymbol());
                  SendNotification("Your accunt alance is : "+AccountBalance()+" Order closed BY Close_reverse function");   
               }         
              }
     }
}




if(Orin=="DN" && Market[magic]=="EURCHF")
{
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
            if(OrderType()==OP_BUY )
            if(OrderSymbol()=="EURCHF")   
            if(StrToInteger(StringSubstr(OrderComment(),0,2))==wight[magic])         
            if(OrderMagicNumber()==time[magic] )
              {
               if(OrderType()==OP_BUY || OrderType()==OP_SELL)
               {
                  bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Black);              
                  Close_Similar(OrderComment(),OrderSymbol());
                  SendNotification("Your accunt alance is : "+AccountBalance()+" Order closed BY Close_reverse function");   
               }         
              }
     }
}


if(Orin=="UP" && Market[magic]=="EURCHF")
{
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
            if(OrderType()==OP_SELL)
            if(OrderSymbol()=="EURCHF")
            if(StrToInteger(StringSubstr(OrderComment(),0,2))==wight[magic] )         
            if(OrderMagicNumber()==time[magic])
           
              {
               if(OrderType()==OP_BUY || OrderType()==OP_SELL)
               {
                  bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Black);              
                  Close_Similar(OrderComment(),OrderSymbol());
                  SendNotification("Your accunt alance is : "+AccountBalance()+" Order closed BY Close_reverse function");   
               }         
              }
     }
}





if(Orin=="DN" && Market[magic]=="USDCHF")
{
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
            if(OrderType()==OP_BUY )
            if(OrderSymbol()=="USDCHF")            
            if(StrToInteger(StringSubstr(OrderComment(),0,2))==wight[magic])         
            if(OrderMagicNumber()==time[magic])
              {
               if(OrderType()==OP_BUY || OrderType()==OP_SELL)
               {
                  bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Black);              
                  Close_Similar(OrderComment(),OrderSymbol());
                  SendNotification("Your accunt alance is : "+AccountBalance()+" Order closed BY Close_reverse function");   
               }         
              }
     }
}


if(Orin=="UP" && Market[magic]=="USDCHF")
{
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
            if(OrderType()==OP_SELL)
            if(OrderSymbol()=="USDCHF")
            if(StrToInteger(StringSubstr(OrderComment(),0,2))==wight[magic])         
            if(OrderMagicNumber()==time[magic])
           
              {
               if(OrderType()==OP_BUY || OrderType()==OP_SELL)
               {
                  bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Black);              
                  Close_Similar(OrderComment(),OrderSymbol());
                  SendNotification("Your accunt alance is : "+AccountBalance()+" Order closed BY Close_reverse function");   
               }         
              }
     }
}


}
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Answer_read()
  {
      for(int k=1;k<=Last_Net_qty*8;k++)
      {
      An[k]=NULL;
      }
      

      for(int k=1;k<=Last_Net_qty;k++)
      {
         Market[k]=NULL;

         Posi[k]=NULL;

         NNA_Answer[k]=NULL;

         time[k]=NULL;

         oriantation[k]=NULL;

         wight[k]=NULL;
         
         Level[k]=NULL;
         
         win[k]=NULL;


      }

   filehandle_answer=FileOpen("Answer_Robo.txt",FILE_READ|FILE_COMMON|FILE_TXT);
   if(filehandle_answer<0)
     {
     

      for(int i=1;i<=Net_qty;i++)
      {
         My_print("",10,80,IntegerToString(i,5),10,"Yellow");
      }
      My_print("",10,80,"1",10,"Yellow");
      My_print1("Calculating . . .",10,120,"2",90,"Yellow");

      My_print("",300,35,"20",7,"Yellow");   
      My_print("",300,35,"21",7,"Yellow");        
      My_print2("",300,35,"300",7,"Yellow");      
      return;
     }
   if(filehandle_answer!=INVALID_HANDLE)
     {

      Net_qty=1;
      while(!FileIsEnding(filehandle_answer))
        {
         An[Net_qty]=FileReadString(filehandle_answer,40);
         Net_qty++;

        }
      FileClose(filehandle_answer);
      Net_qty=Net_qty/8;
      My_print2("Nets Qty : "+IntegerToString(Net_qty),850,320,"300",15,"Yellow");
//------------------Answer reading  read --------------- 
      int n=1;
      for(int k=1;k<=Net_qty;k++)
      {
         Market[k]=StringSubstr(An[n],0,6);
         n=n+1;
         Posi[k]=StringSubstr(An[n],0,2);
         n=n+1;
         NNA_Answer[k]=StrToDouble(StringSubstr(An[n],0,7));
         n=n+1;
         time[k]=StrToInteger(An[n]);
         n=n+1;
         oriantation[k]=StringSubstr(An[n],0,2);
         n=n+1;
         wight[k]=StrToInteger(StringSubstr(An[n],0,2));
         n=n+1;
         Level[k]=StrToDouble(StringSubstr(An[n],0,7));
         n=n+1;
         win[k]=StrToInteger(StringSubstr(An[n],0,2));
         n=n+1;
         
      }
//-------------- End of reading-----------------
  
   for(int j=1;j<=Net_qty;j++)
   {
   
   if((Posi[j]=="BY"))
     {
      GlobalVariableSet("Get_position",1);
      Get_Position();
     }
   if((Posi[j]=="SL"))
     {
      GlobalVariableSet("Get_position",1);
      Get_Position();
     }
     

     
     
   }

     }
      if(An[1]!=NULL)
       {
         
         FileDelete("Answer_Robo.txt",FILE_COMMON|FILE_TXT);
         Answer_file_counter=0;
                  MqlDateTime t;
         TimeToStruct(TimeCurrent(),t);

         MqlDateTime t1;       
         TimeToStruct(TimeCurrent()-Last_Answer_Read,t1); 
         Comment(counter);
         counter=0;
         if(t1.min<2)
         {
         GlobalVariableSet("Answer_read",0);
         }


         
         Last_Answer_Read=TimeCurrent();
                
         Last_Net_qty=Net_qty;
         int C_T=t.sec;
         if(C_T>W_C_T)
         {
         W_C_T=C_T;
         }
         if(C_T<B_C_T)
         {
         B_C_T=C_T;
         }

       }    


//--------------------- Close reverse EURUSD -------------
   for(int j=1;j<=Net_qty;j++)
   {
      if(oriantation[j]=="UP"  || oriantation[j]=="DN")
         Close_Order_Reverse(oriantation[j],j);
   }
      
   
   for(int j=1;j<=Net_qty;j++)
   {
      if(oriantation[j]=="UP"  || oriantation[j]=="DN")
         Last_Orientation[j]=oriantation[j];
      if(NNA_Answer[j]!=0)
         Last_NNA_Answer[j]=NNA_Answer[j];
   }

//-------------------------------------------------------





   if(An[1]!="NO_ANSWER")
     {
      My_print1(" Market    Order      Ans     Tp    U/D     W     L    win",5,35,"2",7,"clrGold");     
      int m=50;
      for(int i=1;i<=Net_qty;i++)
      {
         if(NNA_Answer[i]!=0)
         {
            if(Posi[i]=="BY" || Posi[i]=="SL" )
                    My_print1(Market[i]+"   "+Posi[i]+"  "+DoubleToStr(NNA_Answer[i],5)+"    "+IntegerToString(time[i])+"    "+Last_Orientation[i]+"     "+IntegerToString(wight[i])+"    "+DoubleToStr(Level[i],1)+"    "+IntegerToString(win[i]),9,m,IntegerToString(i,5),7,"Green");
            
            if(Posi[i]!="BY" && Posi[i]!="SL"   )
                    My_print(Market[i]+"   "+Posi[i]+"  "+DoubleToStr(NNA_Answer[i],5)+"    "+IntegerToString(time[i])+"    "+Last_Orientation[i]+"     "+IntegerToString(wight[i])+"    "+DoubleToStr(Level[i],1)+"    "+IntegerToString(win[i]),9,m,IntegerToString(i,5),7,"Green");
            
            
            m=m+11;
         }
/*
            if(Last_NNA_Answer[i]>)
                    {
                    My_print2(Market[i]+"   "+Posi[i]+"   "+DoubleToStr(Last_NNA_Answer[i],5)+"   "+IntegerToString(time[i])+"    "+Last_Orientation[i]+"     "+IntegerToString(wight[i])+"    "+DoubleToStr(Level[i],1)+"    "+IntegerToString(win[i]),9,m,IntegerToString(i,5),7,"Green");
                    m=m+11;
                    }
*/
      }
   
     }
         if(An[1]=="NO_ANSWER")
         {
              My_print("",9,50,"2",7,"Green");
              My_print(" << There is No Network Answer at this time >>",20,200,"1",30,"Green");
         }       

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Get_Position()
  {
  double price=0;
  int s=0;
  // Alert("Getposition      "+TimeCurrent());
   for(int i=1;i<=Net_qty;i++)
   {

   
   if(Posi[i]=="BY")
     {

     //if(checkposition(time[i])==false)
     

         if(spread(Market[i])<=20)
           {
           if(MarketInfo(Market[i]+MarketPrefix,MODE_BID)<=iClose(Market[i],1,1)   || (time[i]>=6))
           {
            double Pre_Lots=      ((MathRound((((MathRound((AccountFreeMargin()/500))*0.01)*10)/wight[i])*100))/100)   ;
            double L_Lots= (MathRound(((Pre_Lots/Level[i])*(NNA_Answer[i]))*100))/100;    
            double Lots= (MathRound((L_Lots*(1+(win[i]/6)))*100))/100;
            if(Lots<0.01)
            {
            Lots=0.01;
            }
            price=MarketInfo(Market[i],MODE_ASK);      
            tiket=OrderSend(Market[i]+MarketPrefix,OP_BUY,Lots,price,10,0,0,IntegerToString(wight[i])+"_"+DoubleToStr(iClose(Market[i],1,1)),time[i],0,Blue);
            Posi[i]="-$$$-";
            
            for(s=1;s<=10;s++)
            {
               price=price-(time[i]*0.0001);
               tiket=OrderSend(Market[i]+MarketPrefix,OP_BUYLIMIT,Lots,price,10,0,0,IntegerToString(wight[i])+"_"+DoubleToStr(iClose(Market[i],1,1)),-1,0,Blue);
               Alert(TimeCurrent());
           
            }
           }
           }
     
     }




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(Posi[i]=="SL")
     {

     
     // if(checkposition(time[i])==false)
                       if(spread(Market[i])<=20)
           {
           if(MarketInfo(Market[i]+MarketPrefix,MODE_BID)>=iClose(Market[i],1,1)     || (time[i]>=6) )
           {
            double Pre_Lots=      ((MathRound((((MathRound((AccountFreeMargin()/500))*0.01)*10)/wight[i])*100))/100)   ;
            double L_Lots= (MathRound(((Pre_Lots/Level[i])*(NNA_Answer[i]))*100))/100;    
            double Lots= (MathRound((L_Lots*(1+(win[i]/6)))*100))/100;
            if(Lots<0.01)
            {
            Lots=0.01;
            }
            price=MarketInfo(Market[i],MODE_BID);
            tiket=OrderSend(Market[i]+MarketPrefix,OP_SELL,Lots,price,10,0,0,IntegerToString(wight[i])+"_"+DoubleToStr(iClose(Market[i],1,1)),time[i],0,Red);
            Posi[i]="-$$$-";
            
            for(s=1;s<=10;s++)
            {
               price=price+(time[i]*0.0001);
               tiket=OrderSend(Market[i]+MarketPrefix,OP_SELLLIMIT,Lots,price,10,0,0,IntegerToString(wight[i])+"_"+DoubleToStr(iClose(Market[i],1,1)),-1,0,Red);
               Alert(TimeCurrent());
            }
            
            
           }
           }

        
     
        }
  }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void My_print(string Text,int x,int y,string lable,int size,string Color1)
  {

   string text=(Text);
   ObjectCreate(lable,OBJ_LABEL,0,0,0);
   ObjectSet(lable,OBJPROP_XDISTANCE,x);
   ObjectSet(lable,OBJPROP_YDISTANCE,y);
   ObjectSetText(lable,text,size,"Times New Roman","clrHotPink");
   WindowRedraw();
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void My_print1(string Text,int x,int y,string lable,int size,string Color1)
  {

   string text=(Text);
   ObjectCreate(lable,OBJ_LABEL,0,0,0);
   ObjectSet(lable,OBJPROP_XDISTANCE,x);
   ObjectSet(lable,OBJPROP_YDISTANCE,y);
   ObjectSetText(lable,text,size,"Times New Roman","clrYellow");
   WindowRedraw();
  }
//+----------------------------------------------------------------+
//+------------------------------------------------------------------+
void My_print2(string Text,int x,int y,string lable,int size,string Color1)
  {

   string text=(Text);
   ObjectCreate(lable,OBJ_LABEL,0,0,0);
   ObjectSet(lable,OBJPROP_XDISTANCE,x);
   ObjectSet(lable,OBJPROP_YDISTANCE,y);
   ObjectSetText(lable,text,size,"Times New Roman","clrSnow");
   WindowRedraw();
  }
  
  
//+------------------------------------------------------------------+
void My_print3(string Text,int x,int y,string lable,int size,string Color1)
  {

   string text=(Text);
   ObjectCreate(lable,OBJ_LABEL,0,0,0);
   ObjectSet(lable,OBJPROP_XDISTANCE,x);
   ObjectSet(lable,OBJPROP_YDISTANCE,y);
   ObjectSetText(lable,text,size,"Times New Roman",MathRand());
   WindowRedraw();
  }
//+------------------------------------------------------------------+

  double spread(string MARKET)
  {
   return(MarketInfo(MARKET,MODE_SPREAD));
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

bool checkposition(int t)
{
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==t)
      {
      return true;
      }
     }
   return false;
}



void Close_Similar(string COM,string symbol)
{
Close_ALL=false;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

            if(OrderComment()==COM)
               if(OrderSymbol()==symbol)
                  {
                  
                     if(OrderType()==OP_BUYLIMIT || OrderType()==OP_SELLLIMIT)
                     bool z=OrderDelete(OrderTicket()); 

                    // if(OrderType()==OP_BUY  || OrderType()==OP_SELL)
                    // bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Red);

                  }
     }
}


