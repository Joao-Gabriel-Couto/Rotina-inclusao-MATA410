#include "topconn.ch"
#include "totvs.ch"
#include "tbiconn.ch"

user function jPVClass()
    RPCSetType(3)
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
          
	    u_uPVClass()

	RESET ENVIRONMENT

return
user function uPVClass()
    local oExePV
    
          oExePV := TestPV():new()
 
          oExePV:TstdadosPV()  
    
         
return

class TestPV

    data oPedidoV

    method new() constructor
    method TstdadosPV() 
    method get_dadosPV()
endclass


method new() class TestPV
    ::oPedidoV := PedidoV():New_PedidoV()
return
method TstdadosPV() class TestPV

     if ::get_dadosPV()

     endif
return 
method get_dadosPV() class TestPV

    local oItem   := nil
    local oItens  := nil
    local nI
    local aLinha := {}
    ::oPedidoV:cFilCab           := xFilial("SC5")
    ::oPedidoV:cNumPed           := "000039"
    ::oPedidoV:cTipPedido        := "N"
    ::oPedidoV:cCliente          := "000001"
    ::oPedidoV:cLoja             := "01"
    ::oPedidoV:cCliEntrg         := "000001"  
    ::oPedidoV:cLojEntrg         := "01"
    ::oPedidoV:cTipCliente       := "F"
    ::oPedidoV:cCondPgto         := "01"
    ::oPedidoV:cTabela           := ""
    ::oPedidoV:cVendedor         := "000001"
    ::oPedidoV:cComissao         := 0

    //Itens do pedido de venda
    
        oItem   := ItemPv():new_ItemPv() 
        oItem:cFilItem                := xFilial("SC6")
        oItem:cNItem                  := "01"
        oItem:cProduto                := "PIP000002"
        oItem:cUnidade                := "CX"
        oItem:nQuant                  := 100        
        oItem:nPrcVen                 := 18
        oItem:nVlrTotal               := 1800
        oItem:cTipoSaida              := "513"

        AAdd( ::oPedidoV:aItens, oItem ) 

        oItem   := ItemPv():new_ItemPv() 
        oItem:cFilItem                := xFilial("SC6")   
        oItem:cNItem                  := "02"
        oItem:cProduto                := "000001" 
        oItem:cUnidade                := "CX"
        oItem:nQuant                  := 40        
        oItem:nPrcVen                 := 18
        oItem:nVlrTotal               := 720
        oItem:cTipoSaida              := "513"

        AAdd( ::oPedidoV:aItens, oItem ) 
    ::oPedidoV:nOpc                := 5
    ::oPedidoV:execExcl_PedidoV()
return 
