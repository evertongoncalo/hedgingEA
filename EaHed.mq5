//+------------------------------------------------------------------+
//|                                                                  |
//|                                    Copyright 2023, Everton Alex. |
//|                    https://www.instagram.com/viking.on.the.road/ |
//+------------------------------------------------------------------+


//TODO 


#property copyright "Copyright 2023, Everton Alex"
#property link      ""
#property version   "1.00"
#property description "Manual Hedging Ea"

input double lot = 0.01;
input double StopLoss = 100;
input double TakeProfit = 250;
string ativos[] = {"EURUSD", "GBPUSD", "USDJPY", "USDCHF", "AUDUSD", "USDCAD", "NZDUSD", "EURGBP", "EURJPY", "GBPJPY", "AUDJPY", "CHFJPY", "CADJPY", "NZDJPY", "GBPCHF", "EURCHF", "AUDCHF", "CADCHF", "NZDCHF", "EURAUD", "GBPAUD", "AUDCAD", "AUDNZD", "GBPNZD", "EURNZD", "USDSGD"};
double compra = 0; double SLcompra = 0; double TPcompra = 0;
double venda = 0; double SLvenda = 0; double TPvenda = 0;


#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Trade\Trade.mqh>

//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- indents and gaps
#define INDENT_LEFT                         (11)      // indent from left (with allowance for border width)
#define INDENT_TOP                          (11)      // indent from top (with allowance for border width)
#define INDENT_RIGHT                        (11)      // indent from right (with allowance for border width)
#define INDENT_BOTTOM                       (11)      // indent from bottom (with allowance for border width)
#define CONTROLS_GAP_X                      (5)       // gap by X coordinate
#define CONTROLS_GAP_Y                      (5)       // gap by Y coordinate
//--- for buttons
#define BUTTON_WIDTH                        (150)     // size by X coordinate
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate
//--- for the indication area
#define EDIT_HEIGHT                         (20)      // size by Y coordinate
//--- for group controls
#define GROUP_WIDTH                         (150)     // size by X coordinate
#define LIST_HEIGHT                         (179)     // size by Y coordinate
#define RADIO_HEIGHT                        (56)      // size by Y coordinate
#define CHECK_HEIGHT                        (93)      // size by Y coordinate
//+------------------------------------------------------------------+
//| Class CControlsDialog                                            |
//| Usage: main dialog of the Controls application                   |
//+------------------------------------------------------------------+
 CTrade            trade;

class CControlsDialog : public CAppDialog
  {
private:
   CButton           m_button1;                       // the button object
   CButton           m_button2;                       // the button object
   CButton           m_button3;                       // the button object
   CButton           m_button4;
public:
                     CControlsDialog(void);
                    ~CControlsDialog(void);
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   //--- chart event handler
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
 
protected:
   //--- create dependent controls
   bool              CreateButton1(void);
   bool              CreateButton2(void);
   bool              CreateButton3(void);
   bool              CreateButton4(void);
   
   //--- handlers of the dependent controls events
   void              OnClickButton1(void);
   void              OnClickButton2(void);
   void              OnClickButton3(void);
   void              OnClickButton4(void);
  
                 
   
  };
  
  



//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CControlsDialog)
ON_EVENT(ON_CLICK,m_button1,OnClickButton1)
ON_EVENT(ON_CLICK,m_button2,OnClickButton2)
ON_EVENT(ON_CLICK,m_button3,OnClickButton3)
ON_EVENT(ON_CLICK,m_button4,OnClickButton4)

EVENT_MAP_END(CAppDialog)
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CControlsDialog::CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CControlsDialog::~CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool CControlsDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
//--- create dependent controls
   if(!CreateButton1())
      return(false);
   if(!CreateButton2())
      return(false);
   if(!CreateButton3())
      return(false);
   if(!CreateButton4())
      return(false);
      
   
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button1" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton1(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button1.Create(m_chart_id,m_name+"Button1",m_subwin,x1,y1,x2,y2))
      return(false);
   m_button1.ColorBackground(0x00FF00);
   if(!m_button1.Text("HEDGE"))
      return(false);
   if(!Add(m_button1))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button2" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton2(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+(BUTTON_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button2.Create(m_chart_id,m_name+"Button2",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button2.Text("HEDGE 26 pares"))
      return(false);
   if(!Add(m_button2))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button3" fixed button                                |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton3(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+2*(BUTTON_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button3.Create(m_chart_id,m_name+"Button3",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button3.Text("PAYROLL (XAU)"))
      return(false);
   if(!Add(m_button3))
      return(false);
   m_button3.Locking(true);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button4" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton4(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+3*(BUTTON_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button4.Create(m_chart_id,m_name+"Button4",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button4.Text("26 HedgePendentes"))
      return(false);
   if(!Add(m_button4))
      return(false);
   m_button4.Locking(true);
//--- succeed
   return(true);
  }

//+------------------------------------------------------------------+
//| Compra a mercado                                                 |
//+------------------------------------------------------------------+

void ordemCompra(string ativo = "")
{
   string simbolo;
   double point; 
   
   if (ativo == "") {
       simbolo = _Symbol;
   } else {
       simbolo = ativo;
   }
   
   long digits = SymbolInfoInteger(simbolo, SYMBOL_DIGITS); // obter o número de dígitos após o ponto decimal para o símbolo específico

    
   if (simbolo.Substr(3, 3) == "JPY") {
       point = 0.001;
   } 
   else {
       point = MathPow(10, -digits);
   }
   
   
   compra = SymbolInfoDouble(simbolo, SYMBOL_BID); // obter o preço Bid atual
   if (StopLoss == 0){
      SLcompra = 0;
   }
   else {
      SLcompra = compra - StopLoss * point; // definir o preço de stop loss em 100 pips abaixo do preço Bid
      }
   
   TPcompra = compra + TakeProfit * point; // definir o preço de take profit em 250 pips acima do preço Bid
    
   trade.Buy(lot, simbolo, 0, SLcompra, TPcompra, "Ordem de Compra a mercado"); // definir stops e takes
}


//+------------------------------------------------------------------+
//| Venda a mercado                                                  |
//+------------------------------------------------------------------+
void ordemVenda(string ativo = "")
{  

   string simbolo;
   double point;
   
   if (ativo == "") {
       simbolo = _Symbol;
   } else {
       simbolo = ativo;
   }
      
   long digits = SymbolInfoInteger(simbolo, SYMBOL_DIGITS); // obter o número de dígitos após o ponto decimal para o símbolo específico

    
   if (simbolo.Substr(3, 3) == "JPY") {
       point = 0.001;
   } 
   else {
       point = MathPow(10, -digits);
   }
   
   venda = SymbolInfoDouble(simbolo, SYMBOL_ASK);
   if (StopLoss == 0){
      SLvenda = 0;
   }
   else {
      SLvenda = venda + StopLoss * point; // definir o preço de stop loss em 100 pips abaixo do preço Bid
      }
   TPvenda = venda - TakeProfit * point;
   trade.Sell(lot, simbolo, 0, SLvenda, TPvenda, "Ordem de Venda a mercado");


 
}
//+------------------------------------------------------------------+
//| Hedge em todos os pares do array                                 |
//+------------------------------------------------------------------+
void hedgeAll()
{   
    
    for (int i = 0; i < ArraySize(ativos); i++)
    {
        
        ordemCompra(ativos[i] + ".a"); //tirar o ".a" caso a corretora não classifique o nome do ativo dessa forma..
        ordemVenda(ativos[i] + ".a");
    }
}

//+------------------------------------------------------------------+
//| Payroll XAU                                                      |
//+------------------------------------------------------------------+
void PayrollXAU()
{
   int magic = 123456; //Identificador único da ordem
   
   // Criação da ordem pendente de compra
   double buy_price = SymbolInfoDouble(_Symbol, SYMBOL_ASK) + 1.00;
   double buy_stop_loss = buy_price - 4.0;
   double buy_take_profit = buy_price + 3.0;
   int buy_ticket = trade.BuyStop(lot,buy_price,"XAUUSD.a",buy_stop_loss,buy_take_profit,ORDER_TIME_DAY,0,"");
   
   // Criação da ordem pendente de venda
   double sell_price = SymbolInfoDouble(_Symbol, SYMBOL_BID) - 1.00;
   double sell_stop_loss = sell_price + 4.0;
   double sell_take_profit = sell_price - 3.0;
   int sell_ticket = trade.SellStop(lot,sell_price,"XAUUSD.a",sell_stop_loss,sell_take_profit,ORDER_TIME_DAY,0,"");
   
   
}

//+------------------------------------------------------------------+
//| Função ordem pendente Compra                                     |
//+------------------------------------------------------------------+

void ordemPendenteCompra(string ativo = "")
{
   string simbolo;
   double point; 
   
   if (ativo == "") {
       simbolo = _Symbol;
   } else {
       simbolo = ativo;
   }
   
   long digits = SymbolInfoInteger(simbolo, SYMBOL_DIGITS); // obter o número de dígitos após o ponto decimal para o símbolo específico

    
   if (simbolo.Substr(3, 3) == "JPY") {
       point = 0.001;
       compra = SymbolInfoDouble(simbolo, SYMBOL_BID) + 0.1;
   } 
   else {
       point = MathPow(10, -digits);
       compra = SymbolInfoDouble(simbolo, SYMBOL_BID) + 0.001; // obter o preço Bid atual
   }
   
   
   
   SLcompra = compra - StopLoss * point; // definir o preço de stop loss em 100 pips abaixo do preço Bid
   TPcompra = compra + TakeProfit * point; // definir o preço de take profit em 250 pips acima do preço Bid
    
   trade.BuyStop(lot,compra,simbolo,SLcompra,TPcompra,ORDER_TIME_DAY,0,""); // definir stops e takes
}




//+------------------------------------------------------------------+
//| Função ordem pendente vENDA                                     |
//+------------------------------------------------------------------+

void ordemPendenteVenda(string ativo = "")
{
   string simbolo;
   double point; 
   
   if (ativo == "") {
       simbolo = _Symbol;
   } else {
       simbolo = ativo;
   }
   
   long digits = SymbolInfoInteger(simbolo, SYMBOL_DIGITS); // obter o número de dígitos após o ponto decimal para o símbolo específico

    
   if (simbolo.Substr(3, 3) == "JPY") {
       point = 0.001;
       venda = SymbolInfoDouble(simbolo, SYMBOL_ASK) - 0.1;
   } 
   else {
       point = MathPow(10, -digits);
       venda = SymbolInfoDouble(simbolo, SYMBOL_ASK) - 0.001; // obter o preço Bid atual
   }
   
   
   
   SLvenda = venda + StopLoss * point; // definir o preço de stop loss em 100 pips abaixo do preço Bid
   TPvenda = venda - TakeProfit * point; // definir o preço de take profit em 250 pips acima do preço Bid
    
   trade.SellStop(lot,venda,simbolo,SLvenda,TPvenda,ORDER_TIME_DAY,0,""); // definir stops e takes
}
//+------------------------------------------------------------------+
//| Função Hedge ordens pendentes                                    |
//+------------------------------------------------------------------+
void HedgePendentes()
{  

   for (int i = 0; i < ArraySize(ativos); i++)
    {
        
      ordemPendenteCompra(ativos[i] + ".a");
      ordemPendenteVenda(ativos[i] + ".a");
        
    }
    
   
   
   
   
}

//+------------------------------------------------------------------+
//| Função Hedge ordens pendentes                                    |
//+------------------------------------------------------------------+

/*

void fecharTodasOrdens()
{
   
}

*/




  

//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton1(void)
  {
  ordemCompra();
  ordemVenda();
  
  
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton2(void)
  {
   hedgeAll();
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton3(void)
  {
   PayrollXAU();
  }
  
void CControlsDialog::OnClickButton4(void)
  {
   HedgePendentes();
  }
  
  
//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
CControlsDialog ExtDialog;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create application dialog
   if(!ExtDialog.Create(0,"EA Manual Hedging",0,80,80,730,200)) //muda tamanhod a caixa
      return(INIT_FAILED);
//--- run application
   ExtDialog.Run();
//--- succeed
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- limpamos os comentários
   Comment("");
//--- destroy dialog
   ExtDialog.Destroy(reason);
  }
//+------------------------------------------------------------------+
//| Expert chart event function                                      |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,         // event ID  
                  const long& lparam,   // event parameter of the long type
                  const double& dparam, // event parameter of the double type
                  const string& sparam) // event parameter of the string type
  {
   ExtDialog.ChartEvent(id,lparam,dparam,sparam);
   }
   
   


