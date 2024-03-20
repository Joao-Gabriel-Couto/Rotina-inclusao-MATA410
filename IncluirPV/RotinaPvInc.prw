#include 'totvs.ch'
#include 'topconn.ch'
#include 'tbiconn.ch
/*/{Protheus.doc} 
Rotina para inclusão
pedido de venda via job
@author    Joao Couto 
@since     09/03/2024
/*/

User Function jRotinaPvInc()
    RPCSetType(3)
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
    SetModulo("SIGAFAT","FAT")

	    u_uRotinaPvInc()

	RESET ENVIRONMENT

return

User Function uRotinaPvInc()

    local oPvInc 
    oPvInc := RotinaIncPv():new_pedidoInc()
    oPvInc:Exec_pedidoInc()
return

class RotinaIncPv

    data oPedidoVCab
    

    data cError

    data oRet
    data oExeWs
    data oRetItens

    method new_pedidoInc() constructor
    method Exec_pedidoInc()
    method get_pedidoInc()
    method Exec_getPv()
endclass

method new_pedidoInc() class RotinaIncPv

    ::oPedidoVCab := PedidoV():New_PedidoV()
   
    ::cError      := ""  

    ::oRet        := JsonObject():New()
    ::oExeWs      := BuscaPV():New_BuscaPV()
    ::oRetItens   := JsonObject():New()
return

method Exec_pedidoInc() class RotinaIncPv

    if (Empty(::cError))
        ::Exec_getPv()
    endif 

    if (Empty(::cError))
        ::get_pedidoInc()
    endif   

return 

method Exec_getPv() class RotinaIncPv

    ::oRet := ::oExeWs:WsBuscaPV()
    ::oRetItens := ::oRet["Itens"]
return 

method get_pedidoInc() class RotinaIncPv

    local oItem := JsonObject():New()
    local nI
    ::oPedidoVCab:cFilCab           := xFilial("SC5")
    ::oPedidoVCab:cNumPed           := ::oRet["NumPedido"]
    ::oPedidoVCab:cTipPedido        := ::oRet["TipPedido"]
    ::oPedidoVCab:cCliente          := ::oRet["Cliente"]
    ::oPedidoVCab:cLoja             := ::oRet["Loja"]
    ::oPedidoVCab:cCliEntrg         := ::oRet["CliEntrega"]  
    ::oPedidoVCab:cLojEntrg         := ::oRet["LojaEntrega"]
    ::oPedidoVCab:cTipCliente       := ::oRet["TipCliente"]
    ::oPedidoVCab:cCondPgto         := ::oRet["CondPgto"]
    ::oPedidoVCab:cTabela           := ::oRet["Tabela"]
    ::oPedidoVCab:cVendedor         := ::oRet["Vendedor"]
    ::oPedidoVCab:cComissao         := ::oRet["Comissao"]

    //Itens do pedido de venda
    for nI := 1 to Len(::oRetItens)
        oItem   := ItemPv():new_ItemPv() 
        oItem:cFilItem                := xFilial("SC6")
        oItem:cNItem                  := ::oRetItens[nI]["NumItem"]
        oItem:cProduto                := ::oRetItens[nI]["Produto"]
        oItem:cUnidade                := ::oRetItens[nI]["Unidade"]
        oItem:cQuant                  := Val(::oRetItens[nI]["Quantidade"])         
        oItem:cPrcVen                 := Val(::oRetItens[nI]["PrecVen"])
        oItem:cVlrTotal               := Val(::oRetItens[nI]["ValorTotal"])
        oItem:cTipoSaida              := ::oRetItens[nI]["TES"]

        AAdd( ::oPedidoVCab:aItens, oItem ) 
    Next nI
     
    ::oPedidoVCab:execInc_PedidoV()
return 
