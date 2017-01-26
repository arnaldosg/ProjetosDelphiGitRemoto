unit ClienteVo;

interface

{$M+}
Type
  TClienteVo = class
  private
    FID: integer;
    FCLIENTE: String;
    FENDERECO: String;
  published
    property ID: integer read FID write FID;
    property CLIENTE: String read FCLIENTE write FCLIENTE;
    property ENDERECO: String read FENDERECO write FENDERECO;
 end;
{$M-}

implementation

end.
 