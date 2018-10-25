function geom(n,p)#funcion que se le entrega probabilidad de exito p, donde n es
    #la cantidad de fallos antes del exito
    if (n<25 && n>=0)
        return (p^(n-1))*(1-p)
    elseif n==25
        return p^25
    else
        return 0
    end
end
function NumerodeToques(N,p)
    pExito=0  #dsde 18-1
    V=zeros(2,26,N+1)
    X=zeros(2,26,N)

    for n = N:-1:1 #Personas que se entrevistan
        for s=0:1# 1 Si contraté a alguien antes de n o 0 si no
            for t=1:26  #numero de toques que realizó el estudiante actual
                Vmax =-100000# Valor arbitrariamente bajo para que podamos guardar el primer resultado
                 # Si fuese minimización, fijaríamos un valor arbitrariamente alto
                for x = 0:1 # 1 si contrato a estudiante n, 0 si no
                    Vsum = 0 #Variable para guardar la suma de valores de la esperanza
                    for y = 1:26#calidad del estudiante que sera entrevistado
                        Vsum = Vsum + V[s + (1-s)*x + 1, y,n+1]*geom(y,p)## formulacion de aguayo mejol , ESPERANZA
                    end
                    Vsum = (1-s)*((x*t) + Vsum)
                    if Vsum > Vmax
                        Vmax = Vsum
                        V[s+1,t,n] = Vmax
                        X[s+1,t,n] = x
                    end
                end
            end
        end

    end
    #en el primer "nodo"

    for i = 1:26
        pExito = pExito + V[1,i,1]*geom(i,p)
    end
    return pExito
end

I=[10 20 30 40 50 60 70 80 90 100]
prob=[0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.70 0.75 0.8 0.85 0.9 0.95]


