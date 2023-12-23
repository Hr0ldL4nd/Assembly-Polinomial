#código - produto polinomial - Orlando Moreira de Melo Neto - Matrícula 539268

#coeficientes do polinômio fixo dado pelo prof
#estão em ordem do menor expoente pro maior
addi s0, zero, 1 #1
addi s1, zero, 3 #3x
addi s2, zero, 1 #x²
addi s3, zero, 2 #2x³

#vamos botar isso num array
addi t0, zero, 0x100

#armazenando os valores em diferentes posições do array
sw s0, 0(t0)
addi t0, t0, 4
sw s1, 0(t0)
addi t0, t0, 4
sw s2, 0(t0)
addi t0, t0, 4
sw s3, 0(t0)

addi t0, t0, -12 #coloca t0 para apontar pra posição de início do array
add s0, zero, t0 #será o auxiliar que se desloca ao longo do array

#coeficientes do polinômio dada a minha matrícula (539268)
#estão em ordem do menor expoente pro maior 
addi a0, zero, 8 #8
addi a1, zero, 6 #6x
addi a2, zero, 2 #2x²
addi a3, zero, 9 #9x³
addi a4, zero, 3 #3x^4
addi a5, zero, 5 #5x^5

#novo vetor, mas agora para o segundo polinômio
addi t1, zero, 0x200

sw a0, 0(t1)
addi t1, t1, 4
sw a1, 0(t1)
addi t1, t1, 4
sw a2, 0(t1)
addi t1, t1, 4
sw a3, 0(t1)
addi t1, t1, 4
sw a4, 0(t1)
addi t1, t1, 4
sw a5, 0(t1)

addi t1, t1, -20 #vamos colocar pra t1 apontar para o início do vetor
add s1, zero, t1 #vamos usar s1 como um ponteiro auxiliar que se deslocará no vetor ao longo de cada ciclo

#o polinômio resultante será de grau 8, tendo 9 valores. Vamos deixar ele mais distante do resto
addi t2, zero, 0x400
add s2, zero, t2 #ponteiro para apontar as posições do array final

#a ideia é termos um contador que irá determinar quais casas do array serão usadas por ciclo.
#como temos um polinômio de 6 termos, então 6 casas do array serão usadas por ciclo
#como o registrador a1 armazena o valor 6, devido a minha matrícula, então utilizarei ele como referêncial
addi a6, zero, 4 #registrador para limitar o ciclo 1 (4-1)
addi a7, zero, 6 #registrador para limitar o ciclo 2 (6-1)

addi a1, zero, 0 #registrador contador 1 (para os 4 ciclos externos)
addi a2, zero, 0 #registrador contador 2 (para os 6 ciclos internos)

addi a3, zero, 0 #registrador auxiliar para receber o valor da multiplicação dos termos dos polinômios
addi a4, zero, 0 #registrador auxiliar para resgatar o valor anteriormente armazenado na posição do polinômio final
addi a5, zero, 0 #registrador auxiliar para fazer a soma desses dois valores, atualizando a posição no polinômio


ciclo:
    add s1, zero, t1 #resetando o ponteiro que se desloca nos valores do 2° polinômio
    add a2, zero, zero  #resetando o contador que controla o subciclo
	bne a1, a6, sub_ciclo # se ainda não tivermos feito a multiplicação de todos os termos, vai
    beq a1, a6, done      #caso contrário, acabou :)
	

sub_ciclo:
	lw t3, 0(s0) #termo fixo do 1°
    lw t4, 0(s1) #termo móvel do 2°
	mul a3, t3, t4 #termo fixo do 1° x termo móvel do 2°
    lw a4, 0(t2)   #carregando valor atual da posição do polinômio final
    add a5, a3, a4 #realizando a soma
    sw a5, 0(t2)   #atualizando o valor
    
    addi a2, a2, 1 #incrementando o contador do polinômio de 6 termos
    addi s1, s1, 4 #preparando próximo termo do polinômio de 6 termos
    addi t2, t2, 4 #preparando próxima casa do polinômio resultante
    
    bne a2, a7, sub_ciclo # se ainda houverem termos para serem multiplicados, vamos pra outro ciclo
    
    addi t2, t2, -20 #coloca para s2 apontar para o termo com coeficiente n+1
    addi a1, a1, 1 #aumenta o contador do ciclo externo
    addi s0, s0, 4 #apontar para próximo termo do polinômio de 4 termos
    
    beq a1, a1, ciclo #vamos agora ir para o próximo ciclo, usando o próximo coeficiente do polinômio de 4 termos
    
done:
	# no final, a partir da posição 0x400, teremos os valores dos coeficientes de cada posição do polinômio resultante, de menor expoente para maior expoente
    # é esperado ver a sequência 8 30 28 37 44 27 36 11 10, sendo o 8x^0 + 30x^1 e por aí vai até 10x^8