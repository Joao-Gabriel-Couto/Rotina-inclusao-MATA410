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

    //itens
    data    cFilItem
    data    cNItem
    data    cProduto
    data    cUnidade
    data    nQuant
    data    nPrcVen
    data    nVlrTotal
    data    cTipoSaida


    data    nOpc
    data    OPC_INCLUIR
    data    OPC_ALTERAR
    data    OPC_EXCLUIR

    data    aCabec
    data    aItAuto
    data    aItens
    data    aItem

    data    cResult
    data    cError
    data    aArea 

    method New_PedidoV()  constructor
    method execInc_PedidoV()
    method execExcl_PedidoV()
    method prepDados_PedidoV()
    method PrepCab_PedidoV()
    method PrepItem_PedidoV()
    method Incluir_PedidoV()
    method Excluir_PedidoV()
    method retCabec_PedidoV()
    method retItens_PedidoV()
    
endclass
/*/{Protheus.doc} 
Método new - identacao de atributos
@author    Joao Couto 
@since     09/03/2024
/*/
method New_PedidoV() class PedidoV

        ::nQuant        := 0
        ::nPrcVen       := 0
        ::nVlrTotal     := 0

        ::OPC_INCLUIR   := 3
        ::OPC_ALTERAR   := 4
        ::OPC_EXCLUIR   := 5

        ::cResult         := ""
        ::cError          := ""

        ::aCabec          := {}
        ::aItAuto         := {}
        ::aItens          := {}
        ::aItem           := {}
        ::aArea           := {}  
        
return
/*/{Protheus.doc} 
Método Exec. - exec. métodos em sequencia devida
@author    Joao Couto 
@since     09/03/2024
/*/

method execInc_PedidoV() class PedidoV

    if( Empty(::cError) )
        ::prepDados_PedidoV()
    endIf

     if( Empty(::cError) )
        ::Incluir_PedidoV()
    endIf
return 
method execExcl_PedidoV() class PedidoV

    if( Empty(::cError) )
        ::prepDados_PedidoV()
    endIf

     if( Empty(::cError) )
        ::Excluir_PedidoV()
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

/*/{Protheus.doc} 
Método  - Prepara os atributos Cabec
@author    Joao Couto 
@since     09/03/2024
/*/

method PrepCab_PedidoV() class PedidoV
     local  aArea := {}
    aArea      := GetArea()
    //::cNumPed  := GetSXENum("SC5", "C5_NUM")
    ::cFilCab  := xFilial("SC5")

  
    if( !Empty(::cFilCab) )
        AAdd(::aCabec, {"C5_FILIAL"    , ::cFilCab          , nil})
    endIf

    if( !Empty(::cNumPed) )
        AAdd(::aCabec, {"C5_NUM	"      , ::cNumPed          , nil})
    endIf

    if( !Empty(::cTipPedido) )
        AAdd(::aCabec, {"C5_TIPO"      , ::cTipPedido       , nil})
    endIf
    
    if( !Empty(::cCliente) )
        AAdd(::aCabec, {"C5_CLIENTE"   , ::cCliente         , nil})
    endIf
     if( !Empty(::cLoja) )
        AAdd(::aCabec, {"C5_LOJACLI"    , ::cLoja           , nil})
    endIf
    
    if( !Empty(::cCliEntrg) )
        AAdd(::aCabec, {"C5_CLIENT"     , ::cCliEntrg       , nil})
    endIf
    
    if( !Empty(::cLojEntrg) )
        AAdd(::aCabec, {"C5_LOJAENT"    , ::cLojEntrg       , nil})
    endIf
     if( !Empty(::cTipCliente) )
        AAdd(::aCabec, {"C5_TIPOCLI"    , ::cTipCliente     , nil})
    endIf
     if( !Empty(::cCondPgto) )
        AAdd( ::aCabec, {"C5_CONDPAG"   , PadR(::cCondPgto  , TamSx3("C5_CONDPAG")[1]), nil})
    endIf
    
    if( !Empty(::cTabela) )
        AAdd(::aCabec, {"C5_TABELA"     , ::cTabela         , nil})
    endIf
    
    if( !Empty(::cVendedor) )
        AAdd(::aCabec, {"C5_VEND1"      , ::cVendedor       , nil})
    endIf

    if( !Empty(::cComissao) )
        AAdd(::aCabec, {"C5_COMIS1"     , ::cComissao [1]   , nil})
    endIf

    FwVetByDic( ::aCabec, "SC5", .F. )
 RestArea(aArea)
return
/*/{Protheus.doc} 
Método  - Prepara os atributos items
@author    Joao Couto 
@since     09/03/2024
/*/
method PrepItem_PedidoV() class PedidoV
    
    local nI    := 1
    local aItem := {}
    for nI      := 1 to Len(::aItens)
        aItem       := {}
        //::cFilItem        := xFilial("SC6") 
        //::cNItem  := GetSXENum("SC6", "C6_ITEM")
        if( !Empty(::cFilItem) )
            aadd(aItem    , {"C6_FILIAL" , PadR(::cFilItem , TamSx3("C6_FILIAL")[1])            , nil})
        endIf
        
        if( !Empty(::aItens[nI]:cNItem) )
            aadd(aItem    , {"C6_ITEM"   , PadR(::aItens[nI]:cNItem , TamSx3("C6_ITEM")[1])     , nil})
        endIf

        if( !Empty(::aItens[nI]:cProduto) )
            aadd(aItem    , {"C6_PRODUTO", PadR(::aItens[nI]:cProduto , TamSx3("C6_PRODUTO")[1]), nil})
        endIf

        if( !Empty(::aItens[nI]:cUnidade) )
            aadd(aItem    , {"C6_UM"     , PadR(::aItens[nI]:cUnidade , TamSx3("C6_UM")[1])     , nil})
        endIf

        if( !Empty(::aItens[nI]:nQuant) )
            aadd(aItem    , {"C6_QTDVEN" , ::aItens[nI]:nQuant                                  , nil})
        endIf

        if( !Empty(::aItens[nI]:nPrcVen) )
            aadd(aItem    , {"C6_PRCVEN" , ::aItens[nI]:nPrcVen                                 , nil})
        endIf

         if( !Empty(::aItens[nI]:nVlrTotal) )
            aadd(aItem    , {"C6_VALOR"  , ::aItens[nI]:nVlrTotal                               , nil})
        endIf

        if( !Empty(::aItens[nI]:cTipoSaida) )
            aadd(aItem    , {"C6_TES"    , PadR(::aItens[nI]:cTipoSaida , TamSx3("C6_TES")[1])  , nil})
        endIf

        aadd(::aItAuto, aItem)
    
    next
    
return
/*/{Protheus.doc} 
Método  - exec. MsExecAuto
@author    Joao Couto 
@since     09/03/2024
/*/
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
                conout("Sucesso MSExecAuto MATA410 !")
             
            ENDIF
    endif

return
method Excluir_PedidoV() class PedidoV

    local aCabec   := ::retCabec_PedidoV()
    local aItAuto  := ::retItens_PedidoV() 

    private lMsHelpAuto     := .T.
    private lMsErroAuto     := .F.
    private lAutoErrNoFile  := .F.
    default ::nOpc := ::OPC_INCLUIR

   if( Empty(::cError) ) 
        MsExecAuto({|x,y,z| MATA410(x,y,z)}, aCabec, aItAuto, ::nOpc)

            if(lMsErroAuto)            
                ::cError := Alltrim( u_MsgErroAuto() )
            else
                 conout("Sucesso MSExecAuto MATA410 !")
             
            ENDIF
    endif
return

method retCabec_PedidoV() class PedidoV

    local aCab := {}

    AAdd(aCab, {"C5_COD"      , ::cNumPed      , nil})
    AAdd(aCab, {"C5_TIPO"     , ::cTipPedido    , nil})
    AAdd(aCab, {"C5_CLIENTE"  , ::cCliente     , nil})
    AAdd(aCab, {"C5_CLIENT"   , ::cCliEntrg    , nil})
    AAdd(aCab, {"C5_LOJAENT"  , ::cLojEntrg    , nil})
    

return aCab
  
method retItens_PedidoV() class PedidoV
    local cQuery    := ""
    local cAliasQry := GetNextAlias()
    local aItem     := {}
    local aItens    := {}

    cQuery := CRLF + " SELECT * "
    cQuery := CRLF + " FROM "+ RetSqlName("SC6") +" (NOLOCK) SC6 "
    cQuery := CRLF + " WHERE "
    cQuery := CRLF + " SC6.C6_FILIAL        = '"+ ::cFilItem      +"' "
    cQuery := CRLF + " AND SC6.C6_ITEM      = '"+ ::cNItem        +"' "
    cQuery := CRLF + " AND SC6.C6_PRODUTO   = '"+ ::cProduto      +"' "
    cQuery := CRLF + " AND SC6.C6_UM        = '"+ ::cUnidade      +"' "
    cQuery := CRLF + " AND SC6.C6_QTDVEN    = '"+ ::nQuant        +"' "
    cQuery := CRLF + " AND SC6.C6_PRCVEN    = '"+ ::nPrcVen       +"' "
    cQuery := CRLF + " AND SC6.C6_VALOR     = '"+ ::nVlrTotal     +"' "
    cQuery := CRLF + " AND SC6.C6_TES       = '"+ ::cTipoSaida    +"' "
    cQuery := CRLF + " AND SC6.D_E_L_E_T_ = '' "

    TcQuery cQuery New Alias (cAliasQry)

    while(!(cAliasQry)->(Eof()))
        aItem := {}

        AAdd(aItem, {"C6_FILIAL"     , (cAliasQry)->C6_FILIAL      , nil})
        AAdd(aItem, {"C6_ITEM"       , (cAliasQry)->C6_ITEM        , nil})
        AAdd(aItem, {"C6_PRODUTO"    , (cAliasQry)->C6_PRODUTO     , nil})
        AAdd(aItem, {"C6_UM"         , (cAliasQry)->C6_UM          , nil})
        AAdd(aItem, {"C6_QTDVEN"     , (cAliasQry)->C6_QTDVEN      , nil})
        AAdd(aItem, {"C6_PRCVEN"     , (cAliasQry)->C6_PRCVEN      , nil})
        AAdd(aItem, {"C6_VALOR"      , (cAliasQry)->C6_VALOR       , nil})
        AAdd(aItem, {"C6_TES"        , (cAliasQry)->C6_TES         , nil})

        AAdd(aItens, aItem)

        (cAliasQry)->(DbSkip())
    endDo

    if(Select(cAliasQry) > 0)
        (cAliasQry)->(DbCloseArea())
    endIf

return aItens

