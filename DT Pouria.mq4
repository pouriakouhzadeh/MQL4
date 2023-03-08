//+------------------------------------------------------------------+
//|                                                       #dtosc.mq4 |
//|                                                           mladen |
//+------------------------------------------------------------------+
#property copyright "Pouria Kouhzadeh"
#property link      "pouria.kouhzadeh@gmail.com"


#property indicator_separate_window
#property indicator_buffers 2
#property indicator_minimum 0
#property indicator_maximum 100
#property indicator_color1 Pink
#property indicator_color2 Yellow
#property indicator_width1 2
#property indicator_width2 2
#property indicator_level1 20
#property indicator_level2 80

//
//
//
//
//

   extern string TimeFrame  = "Current time frame";
   extern int    PeriodRSI  =13;
   extern int    PriceRSI   = 0;
      // 0=PRICE_CLOSE
      // 1=PRICE_OPEN
      // 2=PRICE_HIGH
      // 3=PRICE_LOW
      // 4=PRICE_MEDIAN
      // 5=PRICE_TYPICAL
   // 6=PRICE_WEIGHTED
   extern int    PeriodStoch= 8;
   extern int    PeriodSK   = 5;
   extern int    PeriodSD   = 3;
   extern int MAMode=0;
         //    0 = SMA
         //    1 - EMA
         //    2 - SMMA
         //    3 - LWMA
//
//
//
//
//
//


double SK[];
double SD[];
double StoRSI[];
double RSI[];
string IndicatorFileName;
int    timeFrame;
bool   returnBars=false;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

int init()
{
   IndicatorBuffers(4);
      SetIndexBuffer(0,SK);
      SetIndexBuffer(1,SD);
      SetIndexBuffer(2,StoRSI);
      SetIndexBuffer(3,RSI);

   //
   //
   //
   //
   //
   
   if (TimeFrame == "getBarsCount")
   {
      returnBars=true;
      return(0);
   }   
   timeFrame = stringToTimeFrame(TimeFrame);   

   //
   //
   //
   //
   //
   
   IndicatorShortName("PK_OSC("+PeriodRSI+","+PeriodStoch+","+PeriodSK+","+PeriodSD+")"+"->"+timeFrame);
   IndicatorFileName = WindowExpertName();
return(0);
}
int deinit() { return(0); }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

int start()
{
   int i,limit;
   int counted_bars = IndicatorCounted();

   if(counted_bars < 0) return(-1);
   if(counted_bars > 0) counted_bars--;
             limit=Bars-counted_bars;

   //
   //
   //
   //
   //
   
   if (returnBars) { SK[0] = limit; return(0); }
   if (timeFrame != Period())
   {
      limit = MathMax(limit,MathMin(Bars,iCustom(NULL,timeFrame,IndicatorFileName,"getBarsCount",0,0)*timeFrame/Period()));
         
      //
      //
      //
      //
      //
         
      for(i=0; i<limit; i++)
      {
         int y = iBarShift(NULL,timeFrame,Time[i]);
            SK[i] = iCustom(NULL,timeFrame,IndicatorFileName,"",PeriodRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,0,y);
            SD[i] = iCustom(NULL,timeFrame,IndicatorFileName,"",PeriodRSI,PeriodStoch,PeriodSK,PeriodSD,MAMode,1,y);
      }               
      return(0);         
   }
   //
   //
   //
   //
   //
             
   for(i=limit; i>=0; i--)
   {
      RSI[i] = iRSI(NULL,0,PeriodRSI,PriceRSI,i);
      double LLV = RSI[ArrayMinimum(RSI,PeriodStoch,i)];
      double HHV = RSI[ArrayMaximum(RSI,PeriodStoch,i)];
      if ((HHV-LLV)!=0)
            StoRSI[i] = 100.0*((RSI[i] - LLV)/(HHV - LLV));
      else  StoRSI[i] = 0;
   }   
   for(i=limit; i>=0; i--) SK[i]=iMAOnArray(StoRSI,0,PeriodSK,0,MAMode,i);
   for(i=limit; i>=0; i--) SD[i]=iMAOnArray(    SK,0,PeriodSD,0,MAMode,i);
   return(0);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

int stringToTimeFrame(string tfs)
{
   for(int l = StringLen(tfs)-1; l >= 0; l--)
   {
      int char1 = StringGetChar(tfs,l);
          if((char1 > 96 && char1 < 123) || (char1 > 223 && char1 < 256))
               tfs = StringSetChar(tfs, l, char1 - 32);
          else 
              if(char1 > -33 && char1 < 0)
                  tfs = StringSetChar(tfs, l, char1 + 224);
   }

   //
   //
   //
   //
   //
   
   int tf=0;
         if (tfs=="M1" || tfs=="1")     tf=PERIOD_M1;
         if (tfs=="M5" || tfs=="5")     tf=PERIOD_M5;
         if (tfs=="M15"|| tfs=="15")    tf=PERIOD_M15;
         if (tfs=="M30"|| tfs=="30")    tf=PERIOD_M30;
         if (tfs=="H1" || tfs=="60")    tf=PERIOD_H1;
         if (tfs=="H4" || tfs=="240")   tf=PERIOD_H4;
         if (tfs=="D1" || tfs=="1440")  tf=PERIOD_D1;
         if (tfs=="W1" || tfs=="10080") tf=PERIOD_W1;
         if (tfs=="MN" || tfs=="43200") tf=PERIOD_MN1;
         if (tf<Period())               tf=Period();
   return(tf);
}