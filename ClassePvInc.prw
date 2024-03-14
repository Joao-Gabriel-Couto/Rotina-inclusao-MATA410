#include 'totvs.ch'
#include 'topconn.ch'
#include 'tbiconn.ch'

/*/{Protheus.doc} 
Classe para inclusão
pedido de venda
@author    Joao Couto 
@since     09/03/2024
/*/


Class PedidoV

    //Cabecalho
    data    cFilCab
    data    cNumPed	
    data    cTipPedido
    data    cCliente
    data    cLoja
    data    cCliEntrg
    data    cLojEntrg
    data    cTipCliente
    data    cCondPgto
    data    cTabela
    data    cVendedor
    data    cComissao

   
    
    data    nOpc
    data    OPC_Incluir
    data    OPC_Atualizar
    data    OPC_Excluir

    data    aCabec
    data    aItAuto
    data    aItens
    data    aItem

    data    cResult
    data    cError
    data    aArea 

    method New_PedidoV()  constructor
    method execInc_PedidoV()
    method prepDados_PedidoV()
    method PrepCab_PedidoV()
    method PrepItem_PedidoV()
    method Incluir_PedidoV()
endclass

method New_PedidoV() class PedidoV

        ::OPC_Incluir    := 3
        ::OPC_Atualizar  := 4
        ::OPC_Excluir    := 5

        ::cResult         := ""
        ::cError          := ""

        ::aCabec          := {}
        ::aItAuto         := {}
        ::aItens          := {}
        ::aItem           := {}
        ::aArea           := {}  

        ::cQuant          := 0
return
method execInc_PedidoV() class PedidoV

    if( Empty(::cError) )
        ::prepDados_PedidoV()
    endIf

     if( Empty(::cError) )
        ::Incluir_PedidoV()
    endIf
return 

method prepDados_PedidoV() class PedidoV

    if( Empty(::cError) )
        ::PrepCab_PedidoV()
    endIf

    if( Empty(::cError) )
        ::PrepItem_PedidoV()
    endif
return   

method PrepCab_PedidoV() class PedidoV
     local  aArea := {}
    aArea      := GetArea()
    ::cNumPed  := GetSXENum("SC5", "C5_NUM")
    ::cFilCab  := xFilial("SC5")
    
    if( !Empty(::cFilCab) )
        AAdd(::aCabec, {"C5_FILIAL"     , ::cFilCab     , nil})
    endIf

    if( !Empty(::cNumPed) )
        AAdd(::aCabec, {"C5_NUM	"     , ::cNumPed     , nil})
    endIf

    if( !Empty(::cTipPedido) )
        AAdd(::aCabec, {"C5_TIPO"     , ::cTipPedido     , nil})
    endIf
    
    if( !Empty(::cCliente) )
        AAdd(::aCabec, {"C5_CLIENTE"     , ::cCliente     , nil})
    endIf
     if( !Empty(::cLoja) )
        AAdd(::aCabec, {"C5_LOJACLI"     , ::cLoja     , nil})
    endIf
    
    if( !Empty(::cCliEntrg) )
        AAdd(::aCabec, {"C5_CLIENT"     , ::cCliEntrg     , nil})
    endIf
    
    if( !Empty(::cLojEntrg) )
        AAdd(::aCabec, {"C5_LOJAENT"     , ::cLojEntrg     , nil})
    endIf
     if( !Empty(::cTipCliente) )
        AAdd(::aCabec, {"C5_TIPOCLI"     , ::cTipCliente     , nil})
    endIf
     if( !Empty(::cCondPgto) )
        AAdd( ::aCabec, {"C5_CONDPAG"       , PadR(::cCondPgto  , TamSx3("C5_CONDPAG")[1]), nil})
    endIf
    
    if( !Empty(::cTabela) )
        AAdd(::aCabec, {"C5_TABELA"     , ::cTabela     , nil})
    endIf
    
    if( !Empty(::cVendedor) )
        AAdd(::aCabec, {"C5_VEND1"     , ::cVendedor     , nil})
    endIf

    if( !Empty(::cComissao) )
        AAdd(::aCabec, {"C5_COMIS1"     , ::cComissao [1]    , nil})
    endIf

    FwVetByDic( ::aCabec, "SC5" )
 RestArea(aArea)
return

method PrepItem_PedidoV() class PedidoV
    local  aArea :=  GetArea()
    
    local aItem
    aItem := {}
    local nI    := 1

    for nI := 1 to Len(::aItens)
        
        
        ::cFilItem        := xFilial("SC6") 
        ::cNItem  := GetSXENum("SC6", "C6_ITEM")
        if( !Empty(::cFilItem) )
            AAdd(aItem, {"C6_FILIAL"   , PadR(::cFilItem                 , TamSx3("D1_FILIAL")[1])               , nil})
        endIf
        
        if( !Empty(::aItens[nI]:cNItem) )            
            AAdd(aItem, {"C6_ITEM"    , PadR(::aItens[nI]:cNItem     , TamSx3("C6_ITEM")[1])   , nil})
        endIf

        if( !Empty(::aItens[nI]:cProduto) )            
            AAdd(aItem, {"C6_PRODUTO"  , PadR(::aItens[nI]:cProduto     , TamSx3("C6_PRODUTO")[1])   , nil})
        endIf

        if( !Empty(::aItens[nI]:cUnidade) )            
            AAdd(aItem, {"C6_UM"    , PadR(::aItens[nI]:cUnidade     , TamSx3("C6_UM")[1])   , nil})
        endIf

        if( !Empty(::aItens[nI]:cQuant) )            
            AAdd(aItem, {"C6_QTDVEN"    , ::aItens[nI]:cQuant   , nil})
        endIf

        if( !Empty(::aItens[nI]:cPrecoUni) )            
            AAdd(aItem, {"C6_PRUNIT"    , ::aItens[nI]:cPrecoUni       , nil})
        
        endIf

        if( !Empty(::aItens[nI]:cPrcVen) )            
            AAdd(aItem, {"C6_PRCVEN"    ,  ::aItens[nI]:cPrcVen      , nil})
        endIf

         if( !Empty(::aItens[nI]:cVlrTotal) )            
            AAdd(aItem, {"C6_VALOR"    , ::aItens[nI]:cVlrTotal       , nil})
        endIf

        if( !Empty(::aItens[nI]:cTipoSaida) )            
            AAdd(aItem, {"C6_TES"    , PadR(::aItens[nI]:cTipoSaida     , TamSx3("C6_TES")[1])   , nil})
        endIf
        AAdd(::aItAuto, aItem)
    next 
       
return

method Incluir_PedidoV() class PedidoV

    private lMsHelpAuto     := .T.
    private lMsErroAuto     := .F.
    private lAutoErrNoFile  := .F.
    default ::nOpc := ::OPC_INCLUIR

   if( Empty(::cError) ) 
        MsExecAuto({|x,y,z| MATA410(x,y,z)}, ::aCabec, ::aItAuto, ::nOpc)
            IF (lMsErroAuto)           
                 aResult := MostraErro()
            else
                conout("Pedido de venda incluido com sucesso!")
             
            ENDIF
    endif

return
