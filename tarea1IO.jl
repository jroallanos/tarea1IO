# TAREA 1 --- INVESTIGACIÓN DE OPERACIONES, SECCIÓN 2
# MONSALVE, ROA & SEGURA

# Se define la función geométrica, que determina los toques al balón
# n es un entero positivo, la cantidad de éxitos antes del primer fallo.
# p es la probabilidad de tener un siguiente toque exitoso.
# (1-p) representa el fin de la serie de toques.
function geom(n,p)
    if (n<25 && n>=0) # se define un rango de toques
        return (p^(n))*(1-p) # distribución
    elseif n==25 # la geométrica se trunca al llegar a 25 toques
        return p^25
    else
       return 0
   end
end

# Se define la función principal "ntoques" (Número de Toques).
# La función cumple con maximizar la cantidad de toques esperados dada
# una muestra N y una probabilidad "p" de tener éxito en el siguiente toque.

function ntoques(N,p)

    toques=0  # se setea el contador en 0
    V=zeros(2,26,N+1) #Beneficio de cada etapa, ecuación de Bellman
    X=zeros(2,26,N) #Matrices que guardan iteradamente la variable de decisión X

    for n = N:-1:1 # Personas que se entrevistan, estudiadas de fin a principio
        for s = 0:1 # 1 si contraté a alguien antes de n o 0 si no
            for t=1:26  # número de toques que realizó el estudiante actual
                Vmax =-8000 # Valor arbitrariamente bajo para que podamos guardar el primer resultado
                for x = 0:1 # variable de decisión; 1 si contrato a estudiante n, 0 si no
                    Vsum = 0 # Variable para guardar la suma de valores de la esperanza
                    for y = 1:26 # calidad del estudiante que será entrevistado
                        Vsum = Vsum + V[s + (1-s)*x + 1, y,n+1]*geom(y,p) #Esperanza
                    end
                    Vsum = (1-s)*((x*t) + Vsum)
                    if Vsum > Vmax # Continuación de la ecuación de Bellman
                        Vmax = Vsum
                        V[s+1,t,n] = Vmax
                        X[s+1,t,n] = x
                    end
                end
            end
        end

    end

    for i = 1:26
        toques = toques + V[1,i,1]*geom(i,p)
    end
    return toques
end

# Gráfico de los toques esperados
xlab=[(i) for i=0.05:0.05:0.95] # Probabilidades
ylab=[(i) for i=10:10:100] # Cantidad de candidatos
#matriz de 19x10
Z = Array{Float64, 2}(19, 10) # Matriz que guarda los resultados
for i=1:1:19
    for j=1:1:10
        Z[i,j]=ntoques(ylab[j],xlab[i])
    end
end

#Pkg.add("Plots")
#Pkg.add("PyPlot")
#heatmap
using Plots
using PyPlot
pyplot()
heatmap(ylab,xlab,Z,title="Toques esperados",color=:plasma,clim=(0,125),xlabel = "Candidatos", ylabel = "Probabilidad",colorbar_title="Toques esperados")
