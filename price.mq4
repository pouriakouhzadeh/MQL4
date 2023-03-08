//+------------------------------------------------------------------+
//|                                                        price.mq4 |
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
double priceinit,pricecurent;
double temp;
int filehandle;
int lastcunter,cunter;

string symbol="USDJPYe";
int OnInit()
  {
//---
//Comment(priceusdchf,"\n",priceusdcad); 

   filehandle=FileOpen(symbol,FILE_WRITE|FILE_CSV);
  // priceinit=MarketInfo(symbol,MODE_BID);
  
 MqlDateTime s;
TimeToStruct(TimeCurrent(),s);
int m=TimeSeconds(TimeCurrent());
 

if (m==0)
{
//   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;
}
if (m==10)
{
  // FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==20)
{
//   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==30)
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==40)
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==50)
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;
   
}

if((m<=9)&&(m>=1))
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+10,Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+10;
}
if((m<=19)&&(m>=11))
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+20, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+20;
}
if((m<=29)&&(m>=21))
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+30, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+30;
}
if((m<=39)&&(m>=31))
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+40, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+40;
}
if((m<=49)&&(m>=41))
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+50, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+50;
}
if((m<=59)&&(m>=51))
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+60, pricecurent,Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+60;
}

lastcunter=cunter-10;  
  
  
  
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   FileClose(filehandle);
      
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {








//--- correct way of working in the "file sandbox"


   













//---


//priceusdchfcurent=((MarketInfo("USDCHFe",MODE_BID))-priceusdchf);
//priceusdcadcurent=(MarketInfo("USDCADe",MODE_BID))-priceusdcad;

//pricecurent=StrToDouble(DoubleToStr((((MarketInfo(symbol,MODE_BID))-priceinit)*100000),0));


MqlDateTime s;
TimeToStruct(TimeCurrent(),s);
int m=TimeSeconds(TimeCurrent());
//newcode=s.day_of_year*86400+s.hour*3600+s.min*60+m+s.year;
//Print(s.day_of_year*86400+s.hour*3600+s.min*60+s.sec+s.year,"====",TimeCurrent(),"---",s.day_of_year);



if (m==0)
{
//   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;
}
if (m==10)
{
  // FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==20)
{
//   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==30)
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==40)
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==50)
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;
   
}

if((m<=9)&&(m>=1))
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+10,Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+10;
}
if((m<=19)&&(m>=11))
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+20, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+20;
}
if((m<=29)&&(m>=21))
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+30, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+30;
}
if((m<=39)&&(m>=31))
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+40, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+40;
}
if((m<=49)&&(m>=41))
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+50, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+50;
}
if((m<=59)&&(m>=51))
{
 //  FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+60, pricecurent,Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+60;
}





if (lastcunter==cunter) return;


if ((cunter-lastcunter)>10)
{
      for (int i=1;i<((cunter-lastcunter)/10);i++)
            {
   FileWrite(filehandle,Symbol(),TimeCurrent(),(lastcunter+(10*i)), Bid);

           }


if (m==0)
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;
}
if (m==10)
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==20)
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==30)
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==40)
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==50)
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;
   
}

if((m<=9)&&(m>=1))
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+10,Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+10;
}
if((m<=19)&&(m>=11))
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+20, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+20;
}
if((m<=29)&&(m>=21))
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+30, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+30;
}
if((m<=39)&&(m>=31))
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+40, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+40;
}
if((m<=49)&&(m>=41))
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+50, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+50;
}
if((m<=59)&&(m>=51))
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+60, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+60;
}

lastcunter=cunter;
return;


}
else
{

if (m==0)
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;
}
if (m==10)
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==20)
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==30)
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==40)
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;

}
if (m==50)
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+s.min*60+m, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+m;
   
}

if((m<=9)&&(m>=1))
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+10,Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+10;
}
if((m<=19)&&(m>=11))
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+20, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+20;
}
if((m<=29)&&(m>=21))
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+30, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+30;
}
if((m<=39)&&(m>=31))
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+40, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+40;
}
if((m<=49)&&(m>=41))
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+50, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+50;
}
if((m<=59)&&(m>=51))
{
   FileWrite(filehandle,Symbol(),TimeCurrent(),s.day_of_year*86400+s.hour*3600+(s.min*60)+60, Bid);
   cunter=s.day_of_year*86400+s.hour*3600+s.min*60+60;
}





}
lastcunter=cunter;

  }
//+------------------------------------------------------------------+
