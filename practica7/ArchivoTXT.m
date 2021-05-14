classdef ArchivoTXT
    properties
      idArchivo
      format = '%s %s\n'
    end
    methods
        function r = estaVacio(obj)
            formatSpec = '%s %s';
            X = fscanf(obj.idArchivo, formatSpec);
            r = isempty(X);
        end
        function escribir(obj, texto, nrows)
            for row = 1:nrows
                fprintf(obj.idArchivo,obj.format,texto{row,:});
            end
        end
    end
end