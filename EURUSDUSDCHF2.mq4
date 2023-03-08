//+------------------------------------------------------------------+
//|                                                EURUSDUSDCHF1.mq4 |
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
double Last_Close_EURUSD;
double Last_Close_USDCHF;
extern string Market_Prefix="";
extern double Take_Profit=5;
extern double LOTs=0.1;
extern int Magic_NO=1000;
extern int Extra_Magic_NO=2000;
double Spreads;
int ticket;

double USDCHF;
double EURUSD;


double aarray[20000];
double barray[20000];

double Profit;

double min;
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
      Profit=Take_Profit;
      Last_Close_EURUSD=iClose("EURUSD"+Market_Prefix,60,1);
      Last_Close_USDCHF=iClose("USDCHF"+Market_Prefix,60,1); 
      Spreads=(((MarketInfo("USDCHF"+Market_Prefix,MODE_SPREAD)+MarketInfo("EURUSD"+Market_Prefix,MODE_SPREAD))*MarketInfo("EURUSD"+Market_Prefix,MODE_POINT))*10000);      
      USDCHF=((Last_Close_USDCHF-MarketInfo("USDCHF"+Market_Prefix,MODE_BID))*10000);
      EURUSD=((Last_Close_EURUSD-MarketInfo("EURUSD"+Market_Prefix,MODE_BID))*10000);
    
//      Comment(EURUSD,"\n",USDCHF,"\n",MathAbs(USDCHF)/MathAbs(EURUSD),"\n",MathAbs(EURUSD)/MathAbs(USDCHF),"\n","Spread= ",Spreads/*,"\n","\n","Correlation = ",Correolation("USDCHF"+Market_Prefix,"EURUSD"+Market_Prefix,60,200)*/);
      info();
      closeposition();
      ordergetmangment();
      getposition_extra();
      
  }
//+------------------------------------------------------------------+

void closeposition()
{

double orderprofit=0;
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if (OrderMagicNumber()==Magic_NO)
      orderprofit=orderprofit+(OrderProfit()+OrderCommission()+OrderSwap());
   }      
   
double orderprofit_extra=0;
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Extra_Magic_NO)
      orderprofit_extra=orderprofit_extra+(OrderProfit()+OrderCommission()+OrderSwap());
   }     
   
if(orderstotal()==4) Profit=Profit*1.8;
if(orderstotal()==6) Profit=Profit*2.6;
if(orderstotal()==8) Profit=Profit*3.4;
if(orderstotal()==10) Profit=Profit*4.2;
if(orderstotal()==12) Profit=Profit*5;
if(orderstotal()==14) Profit=Profit*5.8;
if(orderstotal()==16) Profit=Profit*6.6;
if(orderstotal()==18) Profit=Profit*7.4;







if (GlobalVariableGet("Minimum",min))
if (orderprofit<min) GlobalVariableSet("Minimum",orderprofit);



   string currentprofit=("Profit = "+DoubleToStr(orderprofit,2)+"<"+DoubleToStr(Profit,2)); 
   ObjectCreate("comment_label",OBJ_LABEL,0,0,0);
   ObjectSet("comment_label",OBJPROP_XDISTANCE,360);
   ObjectSet("comment_label",OBJPROP_YDISTANCE,60);
   ObjectSetText("comment_label",currentprofit,8,"Arial",Red);
   WindowRedraw();
   


if(orderprofit>=Profit)
{
//close all
   
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
               if(OrderMagicNumber()==Magic_NO)
               bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),6,Gold);
   }   
}




if(orderprofit_extra>=Take_Profit)
{
//close all
   
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
               if(OrderMagicNumber()==Extra_Magic_NO)
               bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),6,Gold);
   }   
}



}














void getposition(string kind,int Magic)
{

 


if ((USDCHF>0) && (EURUSD<0))
{

   if((MathAbs(USDCHF)/MathAbs(EURUSD))>=5)
      {
        //-------BUY------ 
        //Print("BUY");
        if ((MathAbs(USDCHF)-MathAbs(EURUSD)) > Spreads+7 )
        if ((kind=="BUY") || (kind=="ANY"))
            {
                       ticket=OrderSend("EURUSD"+Market_Prefix,OP_BUY,LOTs,MarketInfo("EURUSD"+Market_Prefix,MODE_ASK),3,0,0,"AFSANEH",Magic,0,Blue);
                       ticket=OrderSend("USDCHF"+Market_Prefix,OP_BUY,LOTs,MarketInfo("USDCHF"+Market_Prefix,MODE_ASK),3,0,0,"AFSANEH",Magic,0,Blue);
            }
      }
   if((MathAbs(EURUSD)/MathAbs(USDCHF))>=5)
      {
        //-------SELL------
        //Print("SELL"); 
        if ((MathAbs(EURUSD)-MathAbs(USDCHF)) > Spreads+7 )
        if ((kind=="SELL") || (kind=="ANY"))

            {
                       ticket=OrderSend("EURUSD"+Market_Prefix,OP_SELL,LOTs,MarketInfo("EURUSD"+Market_Prefix,MODE_BID),3,0,0,"AFSANEH",Magic,0,Blue);
                       ticket=OrderSend("USDCHF"+Market_Prefix,OP_SELL,LOTs,MarketInfo("USDCHF"+Market_Prefix,MODE_BID),3,0,0,"AFSANEH",Magic,0,Blue);
            
            }        
}
}
 
 
 
 
 
 
 
if ((USDCHF<0) && (EURUSD>0))
{
// Comment("USDCHF is up","\n",EURUSD,"\n",USDCHF,"\n",MathAbs(USDCHF)/MathAbs(EURUSD),"\n",MathAbs(EURUSD)/MathAbs(USDCHF),"\n","Spread= ",Spreads);

   if((MathAbs(USDCHF)/MathAbs(EURUSD))>=5)
      {
        //-------SELL------ 
        //Print("SELL");
        if ((MathAbs(USDCHF)-MathAbs(EURUSD)) > Spreads+7 )
        if ((kind=="SELL") || (kind=="ANY"))
        
            {

                       ticket=OrderSend("EURUSD"+Market_Prefix,OP_SELL,LOTs,MarketInfo("EURUSD"+Market_Prefix,MODE_BID),3,0,0,"AFSANEH",Magic,0,Blue);
                       ticket=OrderSend("USDCHF"+Market_Prefix,OP_SELL,LOTs,MarketInfo("USDCHF"+Market_Prefix,MODE_BID),3,0,0,"AFSANEH",Magic,0,Blue);
            }
      }
   if((MathAbs(EURUSD)/MathAbs(USDCHF))>=5)
      {
        //-------BUY------
        //Print("BUY"); 
        if ((MathAbs(EURUSD)-MathAbs(USDCHF)) > Spreads+7 )
        if ((kind=="BUY") || (kind=="ANY"))

            {
                       ticket=OrderSend("EURUSD"+Market_Prefix,OP_BUY,LOTs,MarketInfo("EURUSD"+Market_Prefix,MODE_ASK),3,0,0,"AFSANEH",Magic,0,Blue);
                       ticket=OrderSend("USDCHF"+Market_Prefix,OP_BUY,LOTs,MarketInfo("USDCHF"+Market_Prefix,MODE_ASK),3,0,0,"AFSANEH",Magic,0,Blue);
           
            }        
}
}









if ((USDCHF<0) && (EURUSD<0))
{
 Comment("USDCHF is down","\n",EURUSD,"\n",USDCHF,"\n",MathAbs(USDCHF)/MathAbs(EURUSD),"\n",MathAbs(EURUSD)/MathAbs(USDCHF),"\n","Spread= ",Spreads);

   if((MathAbs(USDCHF)+MathAbs(EURUSD))>=(Spreads+7))
   if ((kind=="SELL") || (kind=="ANY"))

      {
        //-------SELL------ 
        //Print("SELL");
                       ticket=OrderSend("EURUSD"+Market_Prefix,OP_SELL,LOTs,MarketInfo("EURUSD"+Market_Prefix,MODE_BID),3,0,0,"AFSANEH",Magic,0,Blue);
                       ticket=OrderSend("USDCHF"+Market_Prefix,OP_SELL,LOTs,MarketInfo("USDCHF"+Market_Prefix,MODE_BID),3,0,0,"AFSANEH",Magic,0,Blue);
      }
 
}






if ((USDCHF>0) && (EURUSD>0))
{
 Comment("USDCHF is down","\n",EURUSD,"\n",USDCHF,"\n",MathAbs(USDCHF)/MathAbs(EURUSD),"\n",MathAbs(EURUSD)/MathAbs(USDCHF),"\n","Spread= ",Spreads);

   if((MathAbs(USDCHF)+MathAbs(EURUSD))>=(Spreads+7))
   if ((kind=="BUY") || (kind=="ANY"))

      {
        //-------BUY------ 
        //Print("BUY");
                      ticket=OrderSend("EURUSD"+Market_Prefix,OP_BUY,LOTs,MarketInfo("EURUSD"+Market_Prefix,MODE_ASK),3,0,0,"AFSANEH",Magic,0,Blue);
                      ticket=OrderSend("USDCHF"+Market_Prefix,OP_BUY,LOTs,MarketInfo("USDCHF"+Market_Prefix,MODE_ASK),3,0,0,"AFSANEH",Magic,0,Blue);
      }

}

}






string position_detecting()
{

string kind="";
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if (OrderType()==OP_BUY) kind="BUY";
      if (OrderType()==OP_SELL) kind="SELL";
   }      
if (kind=="") return ("ANY");   
return kind;
}



double  Correolation(string A,string B,int time , int P)
{
double suma=0;
double sumb=0;
for (int i=1;i<=P;i++)  
   {
      aarray[i]=((iHigh(A,time,i)+iLow(A,time,i)+iClose(A,time,i))/3);
      barray[i]=((iHigh(B,time,i)+iLow(B,time,i)+iClose(B,time,i))/3);
      suma=suma+((iHigh(A,time,i)+iLow(A,time,i)+iClose(A,time,i))/3);
      sumb=sumb+((iHigh(B,time,i)+iLow(B,time,i)+iClose(B,time,i))/3);
  }
double averagea=suma/P;
double averageb=sumb/P;


double correlatin=0;
double sumup=0;
double sumdownx=0;
double sumdowny=0;

for (int i=1;i<=P;i++)
      {
       sumup=sumup+((aarray[i]-averagea)*(barray[i]-averageb));
       
       sumdownx=sumdownx+MathPow((aarray[i]-averagea),2);  
       sumdowny=sumdowny+MathPow((barray[i]-averageb),2);  

      }

correlatin=sumup/(MathSqrt(sumdownx*sumdowny));

//Print("sumup=",sumup,"down =",(MathSqrt(sumdownx*sumdowny)),"SUMDOWNX=",sumdownx,"SUMDOWNY",sumdowny);


return correlatin;
}



void info()
{
double corr=Correolation("EURUSD"+Market_Prefix,"USDCHF"+Market_Prefix,60,48);


   string correlatin=("Correlation = "+DoubleToStr(corr,2)); 
   ObjectCreate("comment_label1",OBJ_LABEL,0,0,0);
   ObjectSet("comment_label1",OBJPROP_XDISTANCE,360);
   ObjectSet("comment_label1",OBJPROP_YDISTANCE,30);
   ObjectSetText("comment_label1",correlatin,8,"Arial",Yellow);
   WindowRedraw();
   
double spreads=(((MarketInfo("USDCHF"+Market_Prefix,MODE_SPREAD)+MarketInfo("EURUSD"+Market_Prefix,MODE_SPREAD))*MarketInfo("EURUSD"+Market_Prefix,MODE_POINT)));


   string spreads1=("Spreads = "+DoubleToStr(Spreads,2)); 
   ObjectCreate("comment_label2",OBJ_LABEL,0,0,0);
   ObjectSet("comment_label2",OBJPROP_XDISTANCE,360);
   ObjectSet("comment_label2",OBJPROP_YDISTANCE,45);
   ObjectSetText("comment_label2",spreads1,8,"Arial",Yellow);
   WindowRedraw();      


bool x=GlobalVariableGet("Minimum",min);

   string minimum=("Min Drowdown = "+DoubleToStr(min,2)); 
   ObjectCreate("comment_label3",OBJ_LABEL,0,0,0);
   ObjectSet("comment_label3",OBJPROP_XDISTANCE,360);
   ObjectSet("comment_label3",OBJPROP_YDISTANCE,75);
   ObjectSetText("comment_label3",spreads1,8,"Arial",Yellow);
   WindowRedraw();      




   string ordertotal=("TotalOrders = "+DoubleToStr(orderstotal(),2)); 
   ObjectCreate("comment_label4",OBJ_LABEL,0,0,0);
   ObjectSet("comment_label4",OBJPROP_XDISTANCE,360);
   ObjectSet("comment_label4",OBJPROP_YDISTANCE,90);
   ObjectSetText("comment_label4",spreads1,8,"Arial",Yellow);
   WindowRedraw();      



   string ordertotal_extra=("Total Extra Orders = "+DoubleToStr(orderstotal_extra(),2)); 
   ObjectCreate("comment_label5",OBJ_LABEL,0,0,0);
   ObjectSet("comment_label5",OBJPROP_XDISTANCE,360);
   ObjectSet("comment_label5",OBJPROP_YDISTANCE,105);
   ObjectSetText("comment_label5",spreads1,8,"Arial",Yellow);
   WindowRedraw();      


}


void ordergetmangment()
{
double orderprofit=0;
for (int i=OrdersTotal()-1;i>=0;i--)
   {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      orderprofit=orderprofit+(OrderProfit()+OrderCommission()+OrderSwap());
   }   
   
   
   
if ((orderprofit<=0)&&(orderprofit>-14)) 
if (orderstotal()==0)
getposition(position_detecting(),Magic_NO); 


if ((orderprofit<=-14)&&(orderprofit>-42)) 
if (orderstotal()<4)
getposition(position_detecting(),Magic_NO); 


if ((orderprofit<=-42)&&(orderprofit>-84)) 
if (orderstotal()<6)
getposition(position_detecting(),Magic_NO); 


if ((orderprofit<=-84)&&(orderprofit>-140)) 
if (orderstotal()<8)
getposition(position_detecting(),Magic_NO); 


if ((orderprofit<=-140)&&(orderprofit>-210)) 
if (orderstotal()<10)
getposition(position_detecting(),Magic_NO); 


if ((orderprofit<=-210)&&(orderprofit>-294)) 
if (orderstotal()<12)
getposition(position_detecting(),Magic_NO);


if ((orderprofit<=-294)&&(orderprofit>-392)) 
if (orderstotal()<14)
getposition(position_detecting(),Magic_NO);
 

if ((orderprofit<=-392)&&(orderprofit>-504)) 
if (orderstotal()<16)
getposition(position_detecting(),Magic_NO);
 
}





int orderstotal()
{

int cunt=0;
for (int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         {
            if (OrderMagicNumber()==Magic_NO) cunt++;
         }
         
     }   
return cunt;
}




int orderstotal_extra()
{

int cunt=0;
for (int i=OrdersTotal()-1;i>=0;i--)
     {
      bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         {
            if (OrderMagicNumber()==Extra_Magic_NO) cunt++;
         }
         
     }   
return cunt;
}


void getposition_extra()
{


      if ((orderstotal()>0)&& (orderstotal_extra()<=2)) getposition(position_detecting(),Extra_Magic_NO);


}