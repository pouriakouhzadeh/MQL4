//+------------------------------------------------------------------+
//|                                              NNA_FIBO_EXPERT.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
string terminal_data_path=TerminalInfoString(TERMINAL_COMMONDATA_PATH);
static datetime Last_Answer_Read;
int Candle_QTY=10000;
int filehandle_ALL,filehandle_answer;

static datetime lastbar;
static int Net_qty;
double A_R=-1;
double G_P=-1;
string An[5000];
int Magic_No=20;
static string Market[800];
static string Posi[800];
static string oriantation[800];
static double target[800];
static int MD[800];
static string CR[800];
int tiket=0;
static double NNA_Answer[800];
int Answer_file_counter;
static int B_C_T,W_C_T;
static int min;
static int File_Delete_Cunt=0;
extern string Broker_Name="Alpari";
extern string Market_prifix="";

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(1);
   Last_Answer_Read=0;  
   GlobalVariableSet("Answer_read",0);
   //Data_generator();   
 My_print2( "Next bar " ,830,35,"201",15,"Yellow");
 My_print2( "Spread " ,830,75,"200",15,"Yellow");
 My_print2( "Open Orders " ,830,115,"202",15,"Yellow");
 My_print2( "Open Files " ,830,155,"203",15,"Yellow");
 My_print2( "Accunt Balance " ,830,195,"204",15,"Yellow");   

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
     Comment(File_Delete_Cunt);
      if(FileIsExist("Answer_"+Broker_Name+".txt",FILE_COMMON|FILE_TXT)){ File_Delete_Cunt=File_Delete_Cunt+1;}
      
      if(File_Delete_Cunt>10)
      {
               Answer_read();
               FileDelete("Answer_"+Broker_Name+".txt",FILE_COMMON|FILE_TXT);
               File_Delete_Cunt=0;
      }
  MqlDateTime t;
TimeToStruct(TimeCurrent(),t);

My_print2( IntegerToString((60-t.sec)) ,950,20,"100",30,"clrGold");

My_print2( DoubleToStr(spread(Symbol())/100000,5) ,950,60,"102",30,"clrGold");

My_print2( IntegerToString(OrdersTotal()) ,950,100,"103",30,"clrGold");

My_print( DoubleToString(AccountBalance(),2)+"$" ,960,190,"109",20,"clrGold");

My_print1( "Best and Worst CALC Time:"+IntegerToString(B_C_T)+" & "+IntegerToString(W_C_T)+" Seconds" ,770,250,"110",12,"clrGold");

int files_open=0;
if(FileIsExist("EURUSD.csv",FILE_COMMON|FILE_CSV)) files_open=files_open+1;
if(FileIsExist("USDCHF.csv",FILE_COMMON|FILE_CSV)) files_open=files_open+1;
if(FileIsExist("EURCHF.csv",FILE_COMMON|FILE_CSV)) files_open=files_open+1;
if(FileIsExist("Answer_"+Broker_Name+".txt",FILE_COMMON|FILE_TXT)) 
{
files_open=files_open+1;

}


My_print2( IntegerToString(files_open) ,950,140,"104",30,"clrGold");
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

if(t.sec==1)
{  
            min=t.min;
      Data_generator();
      Close_orders();
      GlobalVariableSet("Answer_read",1);
      GlobalVariableSet("Get_position",0);

     }
    
if(t.sec==2  &&  min!=t.min)
{
            min=t.min;
      if(FileIsExist("EURUSD.csv",FILE_COMMON|FILE_CSV)){return;}
      if(FileIsExist("USDCHF.csv",FILE_COMMON|FILE_CSV)){return;}
      if(FileIsExist("EURCHF.csv",FILE_COMMON|FILE_CSV)){return;} 
      if(FileIsExist("GBPUSD.csv",FILE_COMMON|FILE_CSV)){return;} 
      if(FileIsExist("GBPCHF.csv",FILE_COMMON|FILE_CSV)){return;} 
      if(FileIsExist("EURGBP.csv",FILE_COMMON|FILE_CSV)){return;} 

      Data_generator();
      Close_orders();
      GlobalVariableSet("Answer_read",1);
      GlobalVariableSet("Get_position",0);
}     
if(t.sec==3  &&  min!=t.min)
{
            min=t.min;
      if(FileIsExist("EURUSD.csv",FILE_COMMON|FILE_CSV)){return;}
      if(FileIsExist("USDCHF.csv",FILE_COMMON|FILE_CSV)){return;}
      if(FileIsExist("EURCHF.csv",FILE_COMMON|FILE_CSV)){return;} 
      if(FileIsExist("GBPUSD.csv",FILE_COMMON|FILE_CSV)){return;} 
      if(FileIsExist("GBPCHF.csv",FILE_COMMON|FILE_CSV)){return;} 
      if(FileIsExist("EURGBP.csv",FILE_COMMON|FILE_CSV)){return;} 


      Data_generator();
      Close_orders();
      GlobalVariableSet("Answer_read",1);
      GlobalVariableSet("Get_position",0);

}        
if(t.sec==4  &&  min!=t.min)
{
            min=t.min;
      if(FileIsExist("EURUSD.csv",FILE_COMMON|FILE_CSV)){return;}
      if(FileIsExist("USDCHF.csv",FILE_COMMON|FILE_CSV)){return;}
      if(FileIsExist("EURCHF.csv",FILE_COMMON|FILE_CSV)){return;} 
      if(FileIsExist("GBPUSD.csv",FILE_COMMON|FILE_CSV)){return;} 
      if(FileIsExist("GBPCHF.csv",FILE_COMMON|FILE_CSV)){return;} 
      if(FileIsExist("EURGBP.csv",FILE_COMMON|FILE_CSV)){return;} 

      Data_generator();
      Close_orders();
      GlobalVariableSet("Answer_read",1);
      GlobalVariableSet("Get_position",0);

}        
  Close_orders();
  }
//+------------------------------------------------------------------+

  
//+---------------------------------------------------------------------------+
bool isNewBar(string CURRENCY)
  {
   datetime curbar=iTime(CURRENCY+Market_prifix,1,0);
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
void Data_generator()
  {
   if(isNewBar("EURUSD")) { Data_Write("EURUSD"); } else { Data_Write_BID("EURUSD");}
   if(isNewBar("EURCHF")) { Data_Write("EURCHF"); } else { Data_Write_BID("EURCHF");}
   if(isNewBar("GBPUSD")) { Data_Write("GBPUSD"); } else { Data_Write_BID("GBPUSD");}
   if(isNewBar("EURGBP")) { Data_Write("EURGBP"); } else { Data_Write_BID("EURGBP");}
   if(isNewBar("GBPCHF")) { Data_Write("GBPCHF"); } else { Data_Write_BID("GBPCHF");}
   if(isNewBar("USDCHF")) { Data_Write("USDCHF"); } else { Data_Write_BID("USDCHF");}
   

  }
//--------------------------------------------------------------------------------

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

  double spread(string MARKET)
  {
   return(MarketInfo(MARKET,MODE_SPREAD));
  }
//+------------------------------------------------------------------+

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
  
  //*-----------------------------------------------------------------+
  void Answer_read()
  {

  
      for(int k=1;k<=Net_qty;k++)
      {
      An[k]=NULL;
      }
      

      for(int k=1;k<=Net_qty;k++)
      {
      
         NNA_Answer[k]=NULL;
         Market[k]=NULL;
         oriantation[k]=NULL;
         Posi[k]=NULL;
         CR[k]=NULL;

      }

   filehandle_answer=FileOpen("Answer_"+Broker_Name+".txt",FILE_READ|FILE_COMMON|FILE_TXT);
   if(filehandle_answer<0)
     {
     

      for(int i=1;i<=50;i++)
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
      Net_qty=Net_qty/7;
      My_print2("Nets Qty : "+IntegerToString(Net_qty),850,320,"300",15,"Yellow");
//------------------Answer reading  read --------------- 
      int n=1;
      for(int k=1;k<=Net_qty;k++)
      {
         Market[k]=StringSubstr(An[n],0,6);
         n=n+1;
         NNA_Answer[k]=StrToDouble(StringSubstr(An[n],0,7));
         n=n+1;
         oriantation[k]=StringSubstr(An[n],0,2);
         n=n+1;
         target[k]=StrToDouble(StringSubstr(An[n],0,7));
         n=n+1;
         MD[k]=StrToDouble(StringSubstr(An[n],0,7));
         n=n+1;
         Posi[k]=StringSubstr(An[n],0,2);
         n=n+1;
         CR[k]=StringSubstr(An[n],0,2);
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
   Close_orders_revers();     
     
     
      if(An[1]!=NULL)
       {
         
         FileDelete("Answer_"+Broker_Name+".txt",FILE_COMMON|FILE_TXT);
         GlobalVariableSet("Answer_read",0);
         File_Delete_Cunt=0;         
       }

          



//-------------------------------------------------------





   if(An[1]!="NO_ANSWER")
     {
                   My_print("",20,200,"1",30,"Green");
      My_print1("  Market            ans            U/D             target            SL              Order        CR",5,35,"2",7,"clrGold");     
      int m=50; 
      for(int i=1;i<=Net_qty;i++)
      {
        // if(NNA_Answer[i]!=0)
        // {
            if(Posi[i]=="BY" || Posi[i]=="SL" || CR[i]=="UP" || CR[i]=="DN")
                    My_print2(Market[i]+"  "+DoubleToStr(NNA_Answer[i],5)+"    "+oriantation[i]+"    "+DoubleToStr(target[i])+"     "+IntegerToString(MD[i])+"     "+Posi[i]+"     "+CR[i],9,m,IntegerToString(i,5),7,"Green");
            
            if(Posi[i]!="BY" && Posi[i]!="SL"    || CR[i]!="UP" || CR[i]!="DN")
                    My_print1(Market[i]+"  "+DoubleToStr(NNA_Answer[i],5)+"    "+oriantation[i]+"    "+DoubleToStr(target[i])+"     "+IntegerToString(MD[i])+"     "+Posi[i]+"     "+CR[i],9,m,IntegerToString(i,5),7,"Green");
            
            
            m=m+11;
        // }

      }
   
     }
         if(An[1]=="NO_ANSWER")
         {
              My_print("",9,50,"2",7,"Green");
              My_print(" << There is No Network Answer at this time >>",20,200,"1",30,"Green");
              FileDelete("Answer_"+Broker_Name+".txt",FILE_COMMON|FILE_TXT);
                 GlobalVariableSet("Answer_read",0);
         }       

 }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Get_Position()
  {
 


   for(int i=1;i<=Net_qty;i++)
   {
  
   if(Posi[i]=="BY")
     {



         if(spread(Market[i]+Market_prifix)<20)
           {
  Alert("Get position");
            double Lots=((round(AccountBalance()/500)*0.01)*((100-MD[i])/100));
            if((AccountBalance()/2)>AccountFreeMargin()){Lots=0.01;}
            if(OrdersTotal()>10){Lots=0.01;}
            if(Lots==0){Lots=0.01;}
            tiket=OrderSend(Market[i]+Market_prifix,OP_BUY,Lots,MarketInfo(Market[i]+Market_prifix,MODE_ASK),10,0,0,DoubleToStr(target[i],8),MD[i],0,Blue);
            Posi[i]="-$$$-";
            SendNotification("BY position in "+Market[i]+" Opend successfully target is " +DoubleToStr(target[i],8));

           }
     
     }




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(Posi[i]=="SL")
     {

   

         if(spread(Market[i]+Market_prifix)<20)
           {
  Alert("Get position");
            double Lots=((round(AccountBalance()/500)*0.01)*((100-MD[i])/100));
            if((AccountBalance()/2)>AccountFreeMargin()){Lots=0.01;}
            if(OrdersTotal()>10){Lots=0.01;}
            if(Lots==0){Lots=0.01;}
            tiket=OrderSend(Market[i]+Market_prifix,OP_SELL,Lots,MarketInfo(Market[i]+Market_prifix,MODE_BID),10,0,0,DoubleToStr(target[i],8),MD[i],0,Red);
            Posi[i]="-$$$-";
            SendNotification("SL position in "+Market[i]+" Opend successfully target is " +DoubleToStr(target[i],8));

           }
           

        
     
        }
  }

  }

//+------------------------------------------------------------------+
void Close_orders()
  {
 
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

                     if(OrderMagicNumber()!=0)
                     {
                     if(OrderType()==OP_BUY)
                     {  
                     
                        if( StrToDouble(OrderComment()) <= MarketInfo(OrderSymbol(),MODE_BID))                        
                           {
                             bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Red);                          
                             Alert("Balance is : "+AccountBalance()+" Order closed BY Close_order function");
                           }
                     }

     

                     if(OrderType()==OP_SELL)
                     {
                     
                       
                           if( StrToDouble(OrderComment())>= MarketInfo(OrderSymbol(),MODE_BID) )                     
                           {
                             bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Red);                          
                             Alert("Balance is : "+AccountBalance()+" Order closed BY Close_order function");
                           }
                    }

        }

}
}


void Close_orders_revers()
{
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
            if(OrderType()==OP_BUY)
            {
               for(int j=1;j<=Net_qty;j++)
                  {
                     if(CR[j]=="DN"   && OrderMagicNumber()==MD[j] && OrderSymbol()==Market[j]+Market_prifix)
                        {
                                                     bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Red);                          
                                                     Alert("Balance is : "+AccountBalance()+" Order closed BY Close_order_revers function");
                        }
                  }
            }
            if(OrderType()==OP_SELL)
            {
               for(int j=1;j<=Net_qty;j++)
                  {
                        if(CR[j]=="UP"  && OrderMagicNumber()==MD[j]  && OrderSymbol()==Market[j]+Market_prifix)
                           {
                                                      bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Red);                          
                                                      Alert("Balance is : "+AccountBalance()+" Order closed BY Close_order_revers function");                          
                           }
                         
                  }
            }
     
     
     }

}

void Data_Write(string SYMBOL)
{
   filehandle_ALL=FileOpen(SYMBOL+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV);

      if(filehandle_ALL!=INVALID_HANDLE)
        {      
               for(int i=Candle_QTY-1; i>=1; i--)
                  {
                  FileWrite(filehandle_ALL,DoubleToStr(iOpen(SYMBOL+Market_prifix,1,i),10)+","+DoubleToStr(iHigh(SYMBOL+Market_prifix,1,i),10)+","+DoubleToStr(iLow(SYMBOL+Market_prifix,1,i),10)+","+DoubleToStr(iClose(SYMBOL+Market_prifix,1,i),10));
                  }
        }
   
   FileClose(filehandle_ALL);  
}
void Data_Write_BID(string SYMBOL)
{
   filehandle_ALL=FileOpen(SYMBOL+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV);

      if(filehandle_ALL!=INVALID_HANDLE)
        {      
               for(int i=Candle_QTY; i>=0; i--)
                  {
                  FileWrite(filehandle_ALL,DoubleToStr(iOpen(SYMBOL+Market_prifix,1,i),10)+","+DoubleToStr(iHigh(SYMBOL+Market_prifix,1,i),10)+","+DoubleToStr(iLow(SYMBOL+Market_prifix,1,i),10)+","+DoubleToStr(iClose(SYMBOL+Market_prifix,1,i),10));
                  }
        }
   
   FileClose(filehandle_ALL);  
}