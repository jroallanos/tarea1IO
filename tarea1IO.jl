function geom(n,p)#funcion que se le entrega probabilidad de exito p, donde n es
    #la cantidad de fallos antes del exito
    P=(1-p)^n*p
    return P
end

function NumerodeToques(N,p)
    V=zeros(2,25,N+1)
    X=zeros(2,25,N)
    for n = N:-1:1 #Personas que se entrevistan
        for s=0:1# 1 Si contraté a alguien antes de n o 0 si no
            for t=0:1:25  #numero de toques que realizó el estudiante actual
                Vmax =-100000# Valor arbitrariamente bajo para que podamos guardar el primer resultado
                 # Si fuese minimización, fijaríamos un valor arbitrariamente alto
                for x = 0:1 # 1 si contrato a estudiante n, 0 si no
                    Vsum = 0#Variable para guardar la suma de valores de la esperanza
                    for y = 0:1:25#calidad del estudiante que sera entrevistado
                        Vsum = Vsum + V[s + (1-s)*x + 1, y+1,n+1]*geom(y,p)## formulacion de aguayo mejol , ESPERANZA
                    end
                    Vsum = (1-s)*((x*t) + Vsum)
                    if Vsum > Vmax
                        Vmax = Vsum
                        V[s+1,t+1,n] = Vmax
                        X[s+1,t+1,n] = x
                    end
                end
            end
        end
    end
    #en el primer "nodo"
    probExito=0  #dsde 18-1
    for i = 1:25
        ProbExito = ProbExito + V[1,i,1]*geom(i,p)
    end
    return ProbExito
end
NumerodeToques(12,0.3)
