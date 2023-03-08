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


double signal=2;
static double target;         
static double stop;    

#import "shell32.dll"
int ShellExecuteW(int hWnd,int lpVerb,string lpFile,int lpParameters,int lpDirectory,int nCmdShow);
#import

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int filehandle;
double low[100000];
double high[100000];
double open[100000];
double close[100000];
static string Target;
static datetime lastbar;
//static bool Check_target;
//static bool Get_position_tag;
static datetime time;
double Ch_t;
double G_P_T;


int tiket;
double LOTS=0.1;
extern string MarketPrefix="";
extern int Risk_free_Pips=20;
int OnInit()
  {
     lastbar=Time[0];
     FileDelete("Answer.csv",FILE_COMMON);
//---
     Data_generator();
     comment();
           ShellExecuteW(0,0,"c:\\Matlab"+"_"+"USDCHF"+".bat","",0,SW_SHOW);
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
risk_free();
comment();
bool e=GlobalVariableGet("Check_target",Ch_t);
if (Ch_t==1) Set_Target();
//if(target==0) {Comment("NOT certain target avalable right now");}
//if(target!=0) {Comment("Target is : ",target);}
bool e1=GlobalVariableGet("Get_position_tag",G_P_T);

if (G_P_T==1) Get_position();
if (isNewBar())
  {
      Data_generator();
      GlobalVariableSet("Check_target",1);      
      ShellExecuteW(0,0,"c:\\Matlab"+"_"+Symbol()+".bat","",0,SW_SHOW);


  }

  }
//+------------------------------------------------------------------+
void Data_generator()
{

int i=200;
while (i>=1)
{
     close[i]=iClose(Symbol(),0,i);
     i--;
}
filehandle=FileOpen("M15"+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV); 
for (int j=200;j>=1;j--)
  {
   if(filehandle!=INVALID_HANDLE) 
     { 
       FileWrite(filehandle,(DoubleToStr(close[j],10))); 
     }
  }  
    FileClose(filehandle);
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
   bool filehandle_answer=FileOpen("Answer.csv",FILE_READ|FILE_COMMON|FILE_CSV);
   if(filehandle_answer!=INVALID_HANDLE) 
     { 
         signal=StrToDouble(FileReadString(filehandle_answer,10));
         target=StrToDouble(FileReadString(filehandle_answer,10));
         stop=StrToDouble(FileReadString(filehandle_answer,10));         
     } 
     
     FileClose(filehandle_answer);
     FileDelete("Answer.csv",FILE_COMMON);

     if (signal==-1) 
     {
      Target="SELL";
      GlobalVariableSet("Get_position_tag",1);
      GlobalVariableSet("Check_target",0);
     }
     if (signal==1) 
     {
      Target="BUY";
      GlobalVariableSet("Get_position_tag",1); 
      GlobalVariableSet("Check_target",0);    
     } 
     if (signal==2) 
     {
      Target="NAN";
      GlobalVariableSet("Get_position_tag",0);
      GlobalVariableSet("Check_target",0);     
     }
     }     

void Get_position()
{
if (Target=="BUY") 
{
Print("Buy"); 
         if(spread()<0.0005)
         {
         tiket=OrderSend(Symbol(),OP_BUY,LOTS,Ask,10,stop,target,"Afsaneh",Magic_NO_Generator(Symbol()),0,Blue);
         GlobalVariableSet("Get_position_tag",0);
         //Target="UP";
         }
}
if (Target=="SELL") 
{
Print("Sell"); 

         if (spread()<0.0005)
         {
         tiket=OrderSend(Symbol(),OP_SELL,LOTS,Bid,10,stop,target,"Afsaneh",Magic_NO_Generator(Symbol()),0,Red);
         GlobalVariableSet("Get_position_tag",0);
         //Target="DOWN";
         }
}
}




double spread()
{
double S=MarketInfo(Symbol(),MODE_SPREAD)*MarketInfo(Symbol(),MODE_POINT);
return S;
}

void comment()
{

bool e=GlobalVariableGet("Check_target",Ch_t);

if (Ch_t==1) {Comment("Wating for Neural net answer .....");}
if (Target=="BUY") {Comment("Expert got BUY position .....");}
if (Target=="SELL") {Comment("Expert got SELL position .....");}
if ((Target=="NAN") && (Ch_t==0)) {Comment("Neural net did not answer to get position .....");}
//Comment(Check_target,"\n",Target,"\n",signal);

   string text=("SMART FORCAST EXPERT"); 
   ObjectCreate("comment_label1",OBJ_LABEL,0,0,0);
   ObjectSet("comment_label1",OBJPROP_XDISTANCE,300);
   ObjectSet("comment_label1",OBJPROP_YDISTANCE,5);
   ObjectSetText("comment_label1",text,25,"Arial",MathRand());
   WindowRedraw(); 
   
   
   string magic_no=("Magic Number is :"+IntegerToString(Magic_NO_Generator(Symbol()))); 
   ObjectCreate("comment_label2",OBJ_LABEL,0,0,0);
   ObjectSet("comment_label2",OBJPROP_XDISTANCE,900);
   ObjectSet("comment_label2",OBJPROP_YDISTANCE,50);
   ObjectSetText("comment_label2",magic_no,9,"Arial",Yellow);
   WindowRedraw();
}


void risk_free()
{
   if(Orders_total()>0)
   {
               for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                   if(OrderMagicNumber()==Magic_NO_Generator(Symbol()))
                   if(OrderType()==OP_BUY)
                   if((Ask-OrderOpenPrice())>((Risk_free_Pips*MarketInfo(Symbol(),MODE_POINT))*10))
                   if(OrderOpenPrice()>OrderStopLoss())
                   {
                    bool m=OrderModify(OrderTicket(),OrderOpenPrice(),(OrderOpenPrice()+(Risk_free_Pips*MarketInfo(Symbol(),MODE_POINT))),OrderTakeProfit(),0,Yellow);
                   }
                   
               }  
               
               for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                   if(OrderMagicNumber()==Magic_NO_Generator(Symbol()))
                   if(OrderType()==OP_SELL)
                   if((OrderOpenPrice()-Bid)>((Risk_free_Pips*MarketInfo(Symbol(),MODE_POINT))*10))
                   if(OrderOpenPrice()<OrderStopLoss())
                   {
                    bool m=OrderModify(OrderTicket(),OrderOpenPrice(),(OrderOpenPrice()-(Risk_free_Pips*MarketInfo(Symbol(),MODE_POINT))),OrderOpenPrice()-0.91,0,Yellow);
                   }
                   
               }                 
               
               
      
   }
}

int Orders_total()
{
            int cunt=0;
            for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                   if(OrderMagicNumber()==Magic_NO_Generator(Symbol()))
                   cunt++;
               }  
               return cunt;
}

int Magic_NO_Generator()
{
return 0;
}

int Magic_NO_Generator(string symbol)
{ 


      if (symbol=="USDCHF"+MarketPrefix) 
         {return 101;} 
      if (symbol=="GBPUSD"+MarketPrefix) 
         {return 102;} 
      if (symbol=="EURUSD"+MarketPrefix) 
         {return 103;} 
      if (symbol=="USDJPY"+MarketPrefix) 
         {return 104;} 
      if (symbol=="USDCAD"+MarketPrefix) 
         {return 105;} 
      if (symbol=="AUDUSD"+MarketPrefix) 
         {return 106;} 
      if (symbol=="EURGBP"+MarketPrefix) 
         {return 107;} 
      if (symbol=="EURAUD"+MarketPrefix) 
         {return 108;} 
      if (symbol=="EURCHF"+MarketPrefix)
         {return 109;} 
      if (symbol=="GBPCHF"+MarketPrefix)
         {return 110;} 
      if (symbol=="CADJPY"+MarketPrefix)
         {return 111;} 
      if (symbol=="GBPJPY"+MarketPrefix)
         {return 112;} 
      if (symbol=="AUDNZD"+MarketPrefix) 
         {return 113;} 
      if (symbol=="AUDCAD"+MarketPrefix) 
         {return 114;} 
      if (symbol=="AUDCHF"+MarketPrefix) 
         {return 115;} 
      if (symbol=="AUDJPY"+MarketPrefix) 
         {return 116;} 
      if (symbol=="CHFJPY"+MarketPrefix) 
         {return 117;} 
      if (symbol=="EURNZD"+MarketPrefix) 
         {return 118;} 
      if (symbol=="EURCAD"+MarketPrefix) 
         {return 119;} 
      if (symbol=="CADCHF"+MarketPrefix) 
         {return 120;} 
      if (symbol=="NZDJPY"+MarketPrefix) 
         {return 121;} 
      if (symbol=="NZDUSD"+MarketPrefix) 
         {return 122;} 
      if (symbol=="EURSGD"+MarketPrefix)
         {return 123;} 
      if (symbol=="GBPAUD"+MarketPrefix) 
         {return 124;} 
      if (symbol=="GBPCAD"+MarketPrefix) 
         {return 125;} 
      if (symbol=="GBPSGD"+MarketPrefix) 
         {return 126;} 
      if (symbol=="NZDCAD"+MarketPrefix)
         {return 127;} 
      if (symbol=="NZDCHF"+MarketPrefix) 
         {return 128;} 
      if (symbol=="NZDSGD"+MarketPrefix) 
         {return 129;} 
      if (symbol=="USDSGD"+MarketPrefix) 
         {return 130;} 
      if (symbol=="EURNOK"+MarketPrefix) 
         {return 131;} 
      if (symbol=="EURSEK"+MarketPrefix) 
         {return 132;} 
      if (symbol=="USDNOK"+MarketPrefix) 
         {return 133;} 
      if (symbol=="EURDKK"+MarketPrefix) 
         {return 134;} 
      if (symbol=="USDPLN"+MarketPrefix) 
         {return 135;} 
      if (symbol=="USDMXN"+MarketPrefix) 
         {return 136;} 
      if (symbol=="USDZAR"+MarketPrefix) 
         {return 137;} 
      if (symbol=="XAGUSD"+MarketPrefix) 
         {return 138;} 
      if (symbol=="XAUUSD"+MarketPrefix) 
         {return 139;} 
      if (symbol=="USDRUB"+MarketPrefix) 
         {return 140;} 
      if (symbol=="GBPNZD"+MarketPrefix) 
         {return 141;} 

return 0;


}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
