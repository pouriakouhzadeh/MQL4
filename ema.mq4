//+------------------------------------------------------------------+
//|                                                          EMA.mq4 |
//|                                         Copyright © 2010, LeMan. |
//|                                                 b-market@mail.ru |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2010, LeMAn."
#property link      "b-market@mail.ru"
 
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_color1 Red
//----
extern double MA_Period = 13;
extern double Coef = 0.0;
extern int MA_Shift = 0;
extern int SetPrice = 0;
//----
double ExtMapBuffer[];
//----
int ExtCountedBars=0;
//+------------------------------------------------------------------+
int init() {
   int draw_begin;
   IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS));   
//----
   SetIndexStyle(0, DRAW_LINE);
   SetIndexShift(0, MA_Shift);
   if (MA_Period < 2) MA_Period = 13;
   draw_begin = 0;
//----
   IndicatorShortName("EMA(" + MA_Period + ")");
   SetIndexDrawBegin(0, draw_begin);
//----
   SetIndexBuffer(0, ExtMapBuffer);
//----
   return(0);
}
//+------------------------------------------------------------------+
int start() {
   if (Bars <= MA_Period) return(0);
   ExtCountedBars = IndicatorCounted();
   if (ExtCountedBars < 0) return(-1);
   if (ExtCountedBars > 0) ExtCountedBars--;
//----
   ema();
//----
   return(0);
}
//----
void ema() {
   double pr;  
   if (Coef == 0.0) { 
      pr = 2.0/(MA_Period+1);
   } else {
      pr = Coef;
   }
   int pos = Bars-2;
   if (ExtCountedBars > 2) pos = Bars - ExtCountedBars - 1;
//---- main calculation loop
   while (pos >= 0) {
      if (pos == Bars - 2) 
         ExtMapBuffer[pos+1] = (Open[pos+1]+Close[pos+1])/2;
      ExtMapBuffer[pos] = GetPrice(pos)*pr+ExtMapBuffer[pos+1]*(1-pr);
        pos--;
   }
}
//+------------------------------------------------------------------+
double GetPrice(int Shift) {
   double price;
//----
   switch(SetPrice) {
      case 0:  price = Close[Shift]; break;
      case 1:  price = Open[Shift]; break;
      case 2:  price = High[Shift]; break;
      case 3:  price = Low[Shift]; break;
      case 4:  price = (High[Shift]+Low[Shift])/2.0; break;
      case 5:  price = (High[Shift]+Low[Shift]+Close[Shift])/3.0; break;
      case 6:  price = (High[Shift]+Low[Shift]+2*Close[Shift])/4.0; break;
      case 7:  price = (Open[Shift]+High[Shift]+Low[Shift]+Close[Shift])/4.0; break;
      case 8:  price = (Open[Shift]+Close[Shift])/2.0; break;
      default: price = 0.0;
   }
//----
   return(price);
}