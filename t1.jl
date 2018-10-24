function NumerodeToques(N,p)
    #probexito=0  #dsde 18-1
    V= zeros(2,26,N+1)
    X=zeros(2,26,N)
    for i = N:-1:1
        for s=0:1
            for c=0:25  #numero de toques que puede realizar, estudiar caso 0
                Vmax =25
                for x = 0:1 #Si entrevisto a i o no
                    Vsum = 0
                    for y = 0:25
                        Vsum = Vsum + V[c*(1-x), y,n+1]
                    end
                    Vsum = (1-s)*((x*c)/7 + Vsum)
                    if Vsum > Vmax
                        Vmax = Vsum
                        V[s+1,c,n] = Vmax
                        X[s+1,c,n] = x
                    end
                end
            end
        end
    end
end
# el evento aleatorio es w_i = min( 25,geom(1-p) )
