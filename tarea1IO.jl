# Declaracion de Variables #

N=20 # Cantidad de Etapas
Etapas = 1:1:N # Vector de todas las etapas
X=zeros(2,26,N) # Variable de decision (1 si se contrata i, 0 si no)
S=0:1 # Variable de Estado (1 si no queda capacidad, 0 si aun hay cupos)
T=0:1:25 # Variable de Estado (cantidad de toques realizados por el candidato)
W=0:1:25 # Variable Aleatoria (cantidad de toques exitosos registrados: min{25,theta})
theta=1:1:25 # Variable Aleatoria (cantidad de toques realizados exitosamente)
p=0.3 # Probabilidad de exito
V=zeros(2,26,N+1) # Variable que guardara las iteraciones de la ecuacion de Bellman

# Creacion de las funciones de probabilidad #

# Funcion de probabilidad de la variable w (cantidad de toques exitosos registrados)
function probw(wi,p)
    if (wi<25 && wi>=0)
        return (1-p)*(p^wi)
    elseif wi==25
        return p^25
    else
        return 0
    end
end

# Iteracion #

for n = N:-1:1 #Personas que se entrevistan
    for s = S #Si se escoge a alguien hasta n o no
        for t = T # Cantidad de toques de la persona n
            Vmax = -10000000
            for x = 0:1 #Si contrato a n o no
                Vsum = 0
                for w = W
                    Vsum = Vsum + (V[s + (1-s)*x + 1, w + 1,n + 1])*probw(w,p) # Calculo de la esperanza de V*
                end
                Vsum = (1-s)*((x*t) + Vsum)
                if Vsum > Vmax
                    Vmax = Vsum
                    V[s+1,t+1,n] = Vmax #
                    X[s+1,t+1,n] = x
                end
            end
        end
    end
end

pe=0
for t=T
    pe = pe + V[1,t+1,1]*probw(t,p)
end
print(pe)
