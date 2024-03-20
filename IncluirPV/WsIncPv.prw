#include 'Protheus.ch'
#include 'Totvs.ch'
#include 'RestFul.ch'
#include 'Parmtype.ch'
#include "tbiconn.ch"
/*/{Protheus.doc} Job para buscar
pedidos de venda
    @type  Function
    @author João Couto
    @since 28/12/2023
    @version version
    @see (links_or_references)
    /*/

user function jBuscaPV()
    
    RPCSetType(3)
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
	
	    u_uBuscaPvWs()

	RESET ENVIRONMENT

return
/*/{Protheus.doc} 
Função para execurtar o método 
de busca em conexão com API
    @type  Function
    @author João Couto
    @since 28/12/2023
    @version version
    @see (links_or_references)
    /*/
user function uBuscaPvWs()

    local oTst := BuscaPV():New_BuscaPV()
    oTst:exec_WsBuscaPV()
return
/*/{Protheus.doc} 
Estrutura da classe e método
    @type  Function
    @author João Couto
    @since 28/12/2023
    @version version
    @see (links_or_references)
    /*/
Class BuscaPV

    data cError
    data cResult
    data oJson
    method New_BuscaPV() Constructor 
    method WsBuscaPV() 
    method exec_WsBuscaPV()
endclass
/*/{Protheus.doc} Estancimento 
do método
    @type  Function
    @author João Couto
    @since 28/12/2023
    @version version
    @see (links_or_references)
    /*/
method New_BuscaPV() class BuscaPV
    
    ::cError    := ""
    ::cResult   := ""   
    ::oJson     := JsonObject():New()
return
/*/{Protheus.doc} Estrutura 
de execução do método
    @type  Function
    @author João Couto
    @since 28/12/2023
    @version version
    @see (links_or_references)
    /*/
method exec_WsBuscaPV() Class BuscaPV

    if( Empty( ::cError ) )
            ::WsBuscaPV()
    endIf 

return

method WsBuscaPV() Class BuscaPV

    local aHeader   := {}
    local oRest     := nil
    local nStatus   := 0
    local cError    := ""
    
    oRest := FWRest():New("https://bbee4269-e0f9-40ec-b645-a49a8196adb3-00-3ot0ojtpprab0.riker.replit.dev/PedidoVenda")
    oRest:setPath( "" )
   
    if( oRest:Get( aHeader ) )
     cError  := ""
     nStatus := HTTPGetStatus(@cError)

        if( nStatus >= 200 .AND. nStatus <= 299 )

            if( !Empty( oRest:getResult() ) )
                ::cResult := DecodeUtf8( oRest:getResult() )
                

                 
            endif
        else
            ::cError := cError
        endif
    else
        ::cError := DecodeUtf8( oRest:getLastError() ) + iif( !Empty( oRest:getResult() ), CRLF + DecodeUtf8( oRest:getResult() ) , "" )
    endif




::oJson:fromjson(::cResult) 

return ::oJson
