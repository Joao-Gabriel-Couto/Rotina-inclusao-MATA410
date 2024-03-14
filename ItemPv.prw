#include 'protheus.ch'
#include 'topconn.ch'

class ItemPv

 //Item
    data    cFilItem
    data    cNItem
    data    cProduto
    data    cUnidade
    data    cQuant
    data    cPrecoUni
    data    cPrcVen
    data    cVlrTotal
    data    cTipoSaida

    method new_ItemPv() constructor
    method itemPv_SetAlias()

endclass

method new_ItemPv() class ItemPv

    ::cFilItem        := ""
    ::cNItem          := ""
    ::cProduto        := ""
    ::cUnidade        := ""
    ::cQuant          := 0
    ::cPrecoUni       := 0
    ::cPrcVen         := 0
    ::cVlrTotal       := 0
    ::cTipoSaida      := ""
return


method itemPv_SetAlias() class ItemPv
    ::cFilItem          := SC6->C6_FILIAL
    ::cNItem            := SC6->C6_ITEM
    ::cProduto          := SC6->C6_PRODUTO
    ::cUnidade          := SC6->C6_UM    
    ::cQuant            := SC6->C6_QTDVEN
    ::cPrcVen           := SC6->C6_PRCVEN
    ::cVlrTotal         := SC6->C6_VALOR
    ::cTipoSaida        := SC6->C6_TES
return
