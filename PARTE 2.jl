#Exportar algunas cosas
#Primera pregunta
#Para los efectos del desarrollo,
# estamos contando las probabilidades del último entrevistado hasta el
# primero porque así es más fácil de ver
 #candidatos == 90  #candidatos
 #matriz = zeros(7,candidatos+1)

function pacha(i)
   NotasProbables = matri(7,i)
   probabilidades = NotasProbables./7
   return probabilidades
end



 function esperanza(X,fila,columna)        #saca la esperanza de las notas de las entrevistas
    acum = 0
   for i in 1:fila
        acum = X[i,columna] + acum
    end
 return acum/fila
end
function suma(X)        #saca la suma de las notas de las entrevistas
   acum = 0
   total =  length(X)
  for i in 1:total
       acum += X[i]
    end
   return acum
end

function matri(i,j)
   matriz = zeros(i,j+1)
   for p=1:1:i
      for k=1:1:j
         matriz[p,k]= p + matriz[p,k]
      end
   end
   return matriz
end



function contratar(candidatos)
   probabilidades = pacha(candidatos)      #La matriz que compone la esperanza
    entrevistas = candidatos+1              #Períodos
    valor = 0
   lema = probabilidades      #La matriz que compone la esperanza

   for j in candidatos:-1:2
       valor=esperanza(lema,7,j)  #la nota esperada de la entrevista N-i

       for i in 1:7
         if lema[i,j] < valor    #aquí es donde decide que el tipo que estamos entrevistando sea

            lema[i,j-1] = valor       #elegido solamente si tiene mejor nota que la esperanza del siguiente

         end

        end


  end
  return lema
   # return probabilidades     #Retorna el promedio de los valores esperados

end



function bellman(candidatos)
   V = zeros(candidatos,1)            #invariante en el tiempo inicial

   q = contratar(candidatos)
   for i in 1:candidatos
      V[i]=esperanza(q,7,i)*7
   end
   return maximum(V)
end


function FOREACH(N)
   b = zeros(N)
   for i in 1:1:N
      b[i]=bellman(i)

   end
   return b

end
