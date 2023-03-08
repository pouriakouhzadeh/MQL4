//+------------------------------------------------------------------+
//|                                              10_pips_scalper.mq4 |
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
static int  Last_pivot_candle=0;

int tiket;
extern double LOTS=0.1;
extern int Magic_NO=1000;
double p=0;
double d=0;
int OnInit()
  {
//---
  //Comment(Pivot()); 
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
 
 Close_Order(); 
 if(Total_Orders()>0) { Comment("One order in this symbol is open ...");return;} 
 if(spread()>20) {Comment("Due to spread is wide Expert forced to return ...","\n","Current Spread is : ",spread());return ;}
 p=Pivot();
 d=Dgree(p,(Last_pivot_candle+1));
 string stat="NAN";
 if(Bid-p>=0) {stat="BUY";} else {stat="SELL";}
 Comment("Current Spread = ",spread(),"\n","Last pivot = ",p,"\n","Last Pivot Candle Number = ",Last_pivot_candle+1,"\n","Current Dgree = ",d,"\n","Oriantation = ",stat); 


//---


         if(Bid-p>=0.001 &&  Bid-p<=0.0012)
            {
              // Print(Dgree(Pivot(),Last_pivot_candle),"\n","BUY");
               if(d>80)
                 { 
                  if (spread()<=20)
                     {
                         // -------------- BUY Condition ---------------------
                         tiket=OrderSend(Symbol(),OP_BUY,LOTS,Ask,10,0,0,"Afsaneh",Magic_NO,0,Blue);  
                          SendNotification("Position BUY opend");                        
                     }
                 }       
            }
            
         if(Bid-p<=-0.001  && Bid-p>=-0.0012)
            {
            
              // Print(Dgree(Pivot(),Last_pivot_candle),"\n","SELL");
               if(d<10)
                 { 
                  if (spread()<=20)
                     {
                         // -------------- SELL Condition ---------------------
                         tiket=OrderSend(Symbol(),OP_SELL,LOTS,Bid,10,0,0,"Afsaneh",Magic_NO,0,Red);   
                         SendNotification("Position SELL opend");                        
                     
                     }
                 }       
            
            }            

      
  
  }
//+------------------------------------------------------------------+

double Pivot()
{
double Last_pivot=0;
int find=0;
int i=1;
while(find==0) 
    {
        if (Bid<High[i])
      {
         if (High[i]>=Last_pivot || Last_pivot==0) {Last_pivot=High[i]; Last_pivot_candle=i;}
         int Aknwlage=0;
         int n=i+1;
         while (Aknwlage==0)
            {
               if(High[n]>=High[i]){Aknwlage=1;}
               if(Last_pivot-Low[n]>=0.001)
                  {
                     Aknwlage=1;
                     find=1;
                     return Last_pivot;
                  }
            n=n+1;      
            }  
      }

    
    
    if (Bid>=Low[i])
      {
         if (Low[i]<=Last_pivot || Last_pivot==0) {Last_pivot=Low[i]; Last_pivot_candle=i;}
         int Aknwlage=0;
         int n=i+1;
         while (Aknwlage==0)
            {
               if(Low[n]<=Low[i]){Aknwlage=1;}
               if(High[n]-Last_pivot>=0.001)
                  {
                     Aknwlage=1;
                     find=1;
                     return Last_pivot;
                  }
            n=n+1;      
            }  

      }



      
i=i+1;    
    }
return Last_pivot;
}

double Dgree(double L_P , int L_P_C)
//                  L_P for last pivot && L_P_C for last pivot candle number
{
double Dg=0;
if(Bid-L_P>0)
   {
   // -------------- BUY Pivot ---------------
     // Print("Last pivot-Bid = ",MathAbs(L_P-Bid));
     // Print("Last pivot candle = ",L_P_C);
      Dg = (((MathAbs((L_P-Bid))*10000)/(L_P_C) ));
     // Print ("Dgree = ",((MathArctan((Dg))*180)/3.14159265359 ));
      return (((MathArctan((Dg))*180)/3.14159265359 )); 
   }
if(Bid-L_P<0)
   {
   // -------------- SELL Pivot ---------------
     // Print("Last pivot-Bid = ",MathAbs(L_P-Bid));
     // Print("Last pivot candle = ",L_P_C);
      Dg = (((L_P_C)/(MathAbs((L_P-Bid))*10000) ));
     // Print ("Dgree = ",((MathArctan((Dg))*180)/3.14159265359 ));
      return (((MathArctan((Dg))*180)/3.14159265359 ));     
   }

return 0;
}

double spread()
{
return(MarketInfo(Symbol(),MODE_SPREAD));
}

void Close_Order()
{
            for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                   if(OrderMagicNumber()==Magic_NO)
                              if ( (Bid<=OrderOpenPrice()-100*Point) || (Bid>=OrderOpenPrice()+100*Point) )
                                    {
                                     SendNotification("Position Closed and profit was : "+DoubleToStr(OrderProfit(),10));                        
                                     bool y=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,Gold);
                                    }   
                                       
               } 
               

}

int Total_Orders()
{
int sum=0;
            for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                   if(OrderMagicNumber()==Magic_NO)
                                    {
                                          sum=sum+1;
                                    }   
               }

return sum;
}