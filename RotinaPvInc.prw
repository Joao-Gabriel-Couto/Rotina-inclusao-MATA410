#include 'totvs.ch'
#include 'topconn.ch'
#include 'tbiconn.ch
/*/{Protheus.doc} 
Rotina para inclusão
pedido de venda via job
@author    Joao Couto 
@since     09/03/2024
/*/

User Function RotinaPvInc()
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
    data oItem
    data cError

    method new_pedidoInc() constructor
    method Exec_pedidoInc()
    method get_pedidoInc()

endclass

method new_pedidoInc() class RotinaIncPv

    ::oPedidoVCab := PedidoV():New_PedidoV()
    ::oItem       := PedidoV():New_PedidoV()
    ::cError      := ""  
return

method Exec_pedidoInc() class RotinaIncPv
    
    if (Empty(::cError))
        ::get_pedidoInc()
    endif   

return 

method get_pedidoInc() class RotinaIncPv

    ::oPedidoVCab:cFilCab           := xFilial("SC5")
    ::oPedidoVCab:cNumPed           := "000008"
    ::oPedidoVCab:cTipPedido        := "N"
    ::oPedidoVCab:cCliente          := "000002"
    ::oPedidoVCab:cLoja             := "01"
    ::oPedidoVCab:cCliEntrg         := "000001"    
    ::oPedidoVCab:cLojEntrg         := "01"
    ::oPedidoVCab:cTipCliente       := "F"
    ::oPedidoVCab:cCondPgto         := "002"
    ::oPedidoVCab:cTabela           := ""
    ::oPedidoVCab:cVendedor         := "000001"
    ::oPedidoVCab:cComissao         := 0  

    //Itens do pedido de venda
    ::oItem:ItemPv():new_ItemPv() 
    ::oItem:cFilItem                := xFilial("SC6")
    ::oItem:cNItem                  := "01"
    ::oItem:cProduto                := "000002"
    ::oItem:cUnidade                := ""
    ::oItem:cQuant                  := 10          
    ::oItem:cPrcVen                 := 55
    ::oItem:cVlrTotal               := 550
    ::oItem:cTipoSaida              := "513"

    AAdd( ::oPedidoVCab:aItens, ::oItem )    

    //Itens do pedido de venda
    ::oItem:ItemPv():new_ItemPv() 
    ::oItem:cFilItem                := xFilial("SC6")
    ::oItem:cNItem                  := "02"
    ::oItem:cProduto                := "000003"
    ::oItem:cUnidade                := ""
    ::oItem:cQuant                  := 20          
    ::oItem:cPrcVen                 := 10
    ::oItem:cVlrTotal               := 200
    ::oItem:cTipoSaida              := "513"

    AAdd( ::oPedidoVCab:aItens, ::oItem )    

    ::oPedidoVCab:execInc_PedidoV()
return 
