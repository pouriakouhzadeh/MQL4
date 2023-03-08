//+------------------------------------------------------------------+
//|                                                     Ekhtelaf.mq4 |
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
//extern string First_Currency="EURUSD";
//extern string Second_Currency="GBPUSD";
extern string MarketPrefix="";

double aarray[20000];
double barray[20000];

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
//for(int i=1;i<42;i++)
//   for(int j=i+1;j<=42;j++)
//      Calc(resolve(i),resolve(j));
      
Calc("USDCAD","NZDCAD");      
      

  }
//+------------------------------------------------------------------+


double  Correolation(string A,string B,int time , int P,int shift)
{
double suma=0;
double sumb=0;
for (int i=shift;i<=P+shift;i++)  
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

void Calc(string First_Currency,string Second_Currency)
{
if (Correolation(First_Currency+MarketPrefix,Second_Currency+MarketPrefix,60,50,1)>0.90)
{ 
double ekhtelaf2=iClose(First_Currency+MarketPrefix,5,2)-iClose(Second_Currency+MarketPrefix,5,2);
double ekhtelaf1=iClose(First_Currency+MarketPrefix,5,1)-iClose(Second_Currency+MarketPrefix,5,1);
   if ((ekhtelaf1-ekhtelaf2>0.001) || (ekhtelaf1-ekhtelaf2>0.001))
    Alert(First_Currency,"-----",Second_Currency,"Ekhtelaf =",ekhtelaf1-ekhtelaf2);
}   
}  


string resolve(int i)
{ 
   switch(i) 
     { 
      case 1: 
         return("USDCHF"+MarketPrefix);break; 
      case 2: 
         return("GBPUSD"+MarketPrefix);break; 
      case 3: 
         return("EURUSD"+MarketPrefix);break; 
      case 4: 
         return("USDJPY"+MarketPrefix);break; 
      case 5: 
         return("USDCAD"+MarketPrefix);break; 
      case 6: 
         return("AUDUSD"+MarketPrefix);break; 
      case 7: 
         return("EURGBP"+MarketPrefix);break; 
      case 8: 
         return("EURAUD"+MarketPrefix);break; 
      case 9: 
         return("EURCHF"+MarketPrefix);break; 
      case 10: 
         return("GBPCHF"+MarketPrefix);break; 
      case 11: 
         return("CADJPY"+MarketPrefix);break; 
      case 12: 
         return("GBPJPY"+MarketPrefix);break; 
      case 13: 
         return("AUDNZD"+MarketPrefix);break; 
      case 14: 
         return("AUDCAD"+MarketPrefix);break; 
      case 15: 
         return("AUDCHF"+MarketPrefix);break; 
      case 16: 
         return("AUDJPY"+MarketPrefix);break; 
      case 17: 
         return("CHFJPY"+MarketPrefix);break; 
      case 18: 
         return("EURNZD"+MarketPrefix);break; 
      case 19: 
         return("EURCAD"+MarketPrefix);break; 
      case 20: 
         return("CADCHF"+MarketPrefix);break; 
      case 21: 
         return("NZDJPY"+MarketPrefix);break; 
      case 22: 
         return("NZDUSD"+MarketPrefix);break; 
      case 23: 
         return("EURSGD"+MarketPrefix);break; 
      case 24: 
         return("GBPAUD"+MarketPrefix);break; 
      case 25: 
         return("GBPCAD"+MarketPrefix);break; 
      case 26: 
         return("GBPSGD"+MarketPrefix);break; 
      case 27: 
         return("NZDCAD"+MarketPrefix);break; 
      case 28: 
         return("NZDCHF"+MarketPrefix);break; 
      case 29: 
         return("NZDSGD"+MarketPrefix);break; 
      case 30: 
         return("USDSGD"+MarketPrefix);break; 
      case 31: 
         return("EURNOK"+MarketPrefix);break; 
      case 32: 
         return("EURSEK"+MarketPrefix);break; 
      case 33: 
         return("USDNOK"+MarketPrefix);break; 
      case 34: 
         return("EURDKK"+MarketPrefix);break; 
      case 35: 
         return("USDPLN"+MarketPrefix);break; 
      case 36: 
         return("USDMXN"+MarketPrefix);break; 
      case 37: 
         return("USDZAR"+MarketPrefix);break; 
      case 38: 
         return("XAGUSD"+MarketPrefix);break; 
      case 39: 
         return("XAUUSD"+MarketPrefix);break; 
      case 40: 
         return("USDRUB"+MarketPrefix);break; 
      case 41: 
         return("GBPNZD"+MarketPrefix);break; 


     } 
return ("Not in range");
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
   