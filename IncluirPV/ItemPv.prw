#include 'totvs.ch'
#include 'topconn.ch'
#include 'tbiconn.ch'

class ItemPv

 //Item
    data    cFilItem
    data    cNItem
    data    cProduto
    data    cUnidade
    data    nQuant
    data    nPrcVen
    data    nVlrTotal
    data    cTipoSaida

    method new_ItemPv() constructor
    method itemPv_SetAlias()

endclass

method new_ItemPv() class ItemPv

    ::cFilItem        := ""
    ::cNItem          := ""
    ::cProduto        := ""
    ::cUnidade        := ""
    ::nQuant           := 0
    ::nPrcVen         := 0
    ::nVlrTotal       := 0
    ::cTipoSaida      := ""
return


method itemPv_SetAlias() class ItemPv
    ::cFilItem          := SC6->C6_FILIAL
    ::cNItem            := SC6->C6_ITEM
    ::cProduto          := SC6->C6_PRODUTO
    ::cUnidade          := SC6->C6_UM    
    ::nQuant            := SC6->C6_QTDVEN
    ::nPrcVen           := SC6->C6_PRCVEN
    ::nVlrTotal         := SC6->C6_VALOR
    ::cTipoSaida        := SC6->C6_TES
return
