; PECL3 - CRA
; Marcos Barranquero Fernández y Eduardo Graván Serrano

(load "PECL3_OperacionesBasicas.rkt")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Operaciones de enteros modulares                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



; Apartado a: reducción a representante canónico.

; Dado un numero y un módulo, reduce a la representación canónica,
; es decir, a el equivalente en el anillo determinado por el módulo.
(define modulo_canonico(lambda (numero)
                    (lambda (mod) ((restoent numero) mod))))

; Ejemplos:
; 9 (mod 5) => (testenteros ((modulo_canonico nueve) cinco)) => 4 
; 12 (mod 7) => (testenteros ((modulo_canonico doce) siete)) => 5

; También puedes directamente hacer la operación desde testenteros.
; Ejemplo: (testeneros ((reduccion((sument nueve) cero)) cinco))
                   

; Apartado b: aritmética, suma, resta y producto.

;Suma numero_uno + numero_dos (modulo mod)
(define suma_modular (lambda (numero_uno)
                     (lambda (numero_dos)
                       (lambda (mod) ((modulo_canonico ((sument numero_uno)numero_dos)) mod)))))

; Ejemplos:
; 9 + 3 (mod 5) => (testenteros(((suma_modular nueve) tres) cinco)) => 2 
; 5 + 8 (mod 7) => (testenteros(((suma_modular cinco) ocho) siete)) => 6 

;Resta numero_uno - numero_dos (modulo mod)
(define resta_modular (lambda (numero_uno)
                     (lambda (numero_dos)
                       (lambda (mod) ((modulo_canonico ((restaent numero_uno)numero_dos)) mod)))))
;Ejemplos:
; 10 - 3 (mod 3) => (testenteros(((resta_modular diez) tres) tres)) => 1 
; -5 - 2 (mod 5) => (testenteros(((resta_modular -cinco) dos) cinco)) => 3

;Producto numero_uno * numero_dos (modulo mod) 
(define producto_modular (lambda (numero_uno)
                     (lambda (numero_dos)
                       (lambda (mod) ((modulo_canonico ((prodent numero_uno)numero_dos)) mod)))))

; Ejemplos:
; 7 * 4 (mod 3) => (testenteros(((producto_modular siete) cuatro) tres)) => 1 
; 3 * 6 (mod 5) => (testenteros(((producto_modular tres) seis) cinco)) => 1 

; Apartado c: posibilidad de inversibilidad y cálculo de esta.

; Dado un numero en modulo mod, devuelve true si tiene inverso, 
; es decir, si el mcd del modulo y el numero es 1 (son coprimos).
(define tiene_inverso? (lambda (numero)
                     (lambda (mod)
                       (((esigualent((mcdent numero)mod))uno) true false))))


; Ejemplos:
; inversa 3 (mod 5) => ((tiene_inverso? tres) cinco) => #<procedure:true>
; inversa 3 (mod 6) => ((tiene_inverso? tres) seis) => #<procedure:false>


;Dado un numero en módulo mod, calcula su inverso.
; Para ello, realiza un bucle (llama recursiva) donde
; multiplica el número por el contador de iteraciones
; y lo pone en módulo mod. Si es igual a 1, ese es el inverso.
; Si no se puede invertir, se devuelve 0.  
; Ejemplo: inverso(3 (mod 5)):
; 3 * 0 = 0 (mod 5); 0 != 1
; 3 * 1 = 3 (mod 5); 3 != 1
; 3 * 2 = 1 (mod 5); 1 == 1 => Devuelvo contador. (2).
(define calculo_inverso
  ; Dado un numero
    (lambda (numero)
    ; en modulo mod
        (lambda (mod)
        ; Comienzo del bucle recursivo.
            ((Y (lambda (f)
                (lambda (contador_iteracion)
                ;Si no se puede invertir 
                    (((neg((esigualent((mcdent numero)mod))uno))
                        (lambda (no_use)
                        ; Devolvemos 0
                            cero
                        )
                        ; Si es invertible, empezamos a hacer llamadas recursivas.
                        ; Si numero * contador_iteracion = 1 (modulo mod), devuelvo
                        ; contador de iteraciones. 
                        (lambda (no_use)
                        ; Si numero * contador_iteracion = 1 (modulo mod)
                          ((((esigualent (((producto_modular contador_iteracion) numero) mod))uno)
                           (lambda (no_use1)
                           ; Devuelvo contador
                             contador_iteracion)
                          ; Si no, incremento en 1 el contador y vuelvo a comprobar, recursivamente. 
                           (lambda (no_use1)
                             (f ((sument contador_iteracion) uno)))) cero)
                        )
                    )
                        cero)    ; argumento de no_use
                )
            ))
                zero) 
        )
    )
)

; Ejemplos:
; Inverso (5 (mod 9)) => (testenteros((calculo_inverso cinco) nueve)) => 2
; Inverso (4 (mod 4)) => (testenteros((calculo_inverso cuatro) cuatro)) => 0 ( Error! )


