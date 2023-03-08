//+------------------------------------------------------------------+
//|                                                          ADX.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
//mod 2008fxtsd    ki
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"

#property indicator_separate_window
#property indicator_buffers 5
#property indicator_color1 Gray
#property indicator_color2 DarkGreen
#property indicator_color3 LimeGreen
#property indicator_color4 Maroon
#property indicator_color5 Red

//---- input parameters
extern int ADXPeriod=14, DiPlusPeriod = 21, DiMinusPeriod=21;
extern int ma_method=3;
extern int DSma_period=8;
extern int DSma_method=3;

//#property indicator_style3 2

#property indicator_level1 20
#property indicator_levelcolor SlateGray

//---- buffers
double ADXBuffer[];
double PlusDiBuffer[];
double MinusDiBuffer[];
double PlusSdiBuffer[];
double MinusSdiBuffer[];
double TempBuffer[];

double PlusDiBuffer1[];
double MinusDiBuffer1[];


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- 3 additional buffers are used for counting.
   IndicatorBuffers(8);
//---- indicator buffers
   SetIndexBuffer(0,ADXBuffer);
   SetIndexBuffer(1,PlusDiBuffer);
   SetIndexBuffer(2,PlusDiBuffer1);
   SetIndexBuffer(3,MinusDiBuffer);
   SetIndexBuffer(4,MinusDiBuffer1);
   SetIndexBuffer(5,PlusSdiBuffer);
   SetIndexBuffer(6,MinusSdiBuffer);
   SetIndexBuffer(7,TempBuffer);



//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("ADX ("+ADXPeriod+", +DI: "+DiPlusPeriod+", -DI: "+DiMinusPeriod+
                              ")"+ma_method+" DS ("+DSma_period+","+DSma_method+")");


   SetIndexLabel(0,"ADX");
   SetIndexLabel(1,"+DI");
   SetIndexLabel(2,"");
   SetIndexLabel(3,"-DI");
   SetIndexLabel(4,"");
   SetIndexLabel(5,"");
   SetIndexLabel(6,"");
   SetIndexLabel(7,"");



//----
   SetIndexDrawBegin(0,ADXPeriod);
   SetIndexDrawBegin(1,ADXPeriod);
   SetIndexDrawBegin(2,ADXPeriod);
   SetIndexDrawBegin(3,ADXPeriod);
   SetIndexDrawBegin(4,ADXPeriod);

//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Average Directional Movement Index                               |
//+------------------------------------------------------------------+
int start()
  {
   double pdm,mdm,tr;
   double price_high,price_low;
   int    starti,i,counted_bars=IndicatorCounted();
//----
   i=Bars-2;
   PlusSdiBuffer[i+1]=0;
   MinusSdiBuffer[i+1]=0;
   if(counted_bars>=i) i=Bars-counted_bars-1;
   starti=i;
//----
   while(i>=0)
     {
      price_low=Low[i];
      price_high=High[i];
      //----
      pdm=price_high-High[i+1];
      mdm=Low[i+1]-price_low;
      if(pdm<0) pdm=0;  // +DM
      if(mdm<0) mdm=0;  // -DM
      if(pdm==mdm) { pdm=0; mdm=0; }
      else if(pdm<mdm) pdm=0;
           else if(mdm<pdm) mdm=0;
      //---- вычисляем истинный интервал
      double num1=MathAbs(price_high-price_low);
      double num2=MathAbs(price_high-Close[i+1]);
      double num3=MathAbs(price_low-Close[i+1]);
      tr=MathMax(num1,num2);
      tr=MathMax(tr,num3);
      //---- counting plus/minus direction
      if(tr==0) { PlusSdiBuffer[i]=0; MinusSdiBuffer[i]=0; }
      else      { PlusSdiBuffer[i]=100.0*pdm/tr; MinusSdiBuffer[i]=100.0*mdm/tr; }
      //----
      i--;
     }
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   int limit=Bars-counted_bars;
//---- apply EMA to +DI
   for(i=0; i<=limit; i++)
      PlusDiBuffer[i]=iMAOnArray(PlusSdiBuffer,Bars,DiPlusPeriod,0,ma_method,i);
//---- apply EMA to -DI
   for(i=0; i<=limit; i++)
      MinusDiBuffer[i]=iMAOnArray(MinusSdiBuffer,Bars,DiMinusPeriod,0,ma_method,i);
//---- Directional Movement (DX)
   i=Bars-2;
   TempBuffer[i+1]=0;
   i=starti;
   while(i>=0)
     {
      double div=MathAbs(PlusDiBuffer[i]+MinusDiBuffer[i]);
      if(div==0.00) TempBuffer[i]=0;
      else TempBuffer[i]=100*(MathAbs(PlusDiBuffer[i]-MinusDiBuffer[i])/div);
      i--;
     }
//---- ADX is exponential moving average on DX
   for(i=0; i<limit; i++)
      ADXBuffer[i]=iMAOnArray(TempBuffer,Bars,ADXPeriod,0,ma_method,i);
//----
   
   for(i=0; i<=limit; i++)
      PlusDiBuffer1[i]=iMAOnArray(PlusDiBuffer,Bars,DSma_period,0,DSma_method,i);
   
   for(i=0; i<=limit; i++)
      MinusDiBuffer1[i]=iMAOnArray(MinusDiBuffer,Bars,DSma_period,0,DSma_method,i);



   return(0);
  }
//+------------------------------------------------------------------+