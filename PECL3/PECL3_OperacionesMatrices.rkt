; PECL3 - CRA
; Marcos Barranquero Fernández y Eduardo Graván Serrano

(load "PECL3_OperacionesModulares.rkt")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Operaciones de matrices                                                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Función para crear matrices de 4 elementos (n1, n2, n3, n4).
(define crear_matriz (lambda (n1)
                         (lambda (n2)
                           (lambda (n3)
                             (lambda (n4)
                               ((par ((par n1) n2)) ((par n3) n4)))))))

; ----------------------------------
; Matrices para los test y ejemplos: 
; ----------------------------------

(define identidad ((((crear_matriz uno) cero) cero) uno))

(define matriz_nula ((((crear_matriz cero) cero) cero) cero))

(define matriz_prueba1 ((((crear_matriz dos) cuatro) -uno) cinco))

(define matriz_prueba2 ((((crear_matriz uno) dos) dos) tres))

(define matriz_prueba3 ((((crear_matriz dos) uno) -tres) dos))

(define matriz_prueba4 ((((crear_matriz uno) -tres) cero) cuatro))

; ----------------------------------
; Funciones de testeo:
; ----------------------------------

; Funcion que permite realizar las operaciones con las matrices y visualizar los resultados. 
(define testmatrices (lambda (m)
                        (list (list (testenteros (primero (primero m))) (testenteros (segundo (primero m))))
                              (list (testenteros (primero (segundo m))) (testenteros (segundo (segundo m))))
                        )
                      )
)
; Funcion que permite comprobar las operaciones con los arrays y visualizar los resultados. 
(define testarray (lambda (m)
                     (list (testenteros (primero m)) (testenteros (segundo m))))
)


; ----------------------------------
; Operaciones:
; ----------------------------------

; Apartado a: suma y producto. 

; Realiza la operación de suma de matrices con matriz_uno y matriz_dos en (módulo mod)
(define suma_matrices (lambda (matriz_uno)
                           (lambda (matriz_dos)
                             (lambda (mod)
                               ((((crear_matriz 
                               (((suma_modular (primero (primero matriz_uno))) (primero (primero matriz_dos))) mod))
                               (((suma_modular (segundo (primero matriz_uno))) (segundo (primero matriz_dos))) mod))
                               (((suma_modular (primero (segundo matriz_uno))) (primero (segundo matriz_dos))) mod))
                               (((suma_modular (segundo (segundo matriz_uno))) (segundo (segundo matriz_dos))) mod))))))

; Ejemplos:
; (testmatrices(((suma_matrices matriz_prueba1) matriz_prueba2) tres)) => ((0 0) (1 2))


; Realiza la operación de resta de matrices con matriz_uno y matriz_dos en (módulo mod)
(define resta_matrices (lambda (matriz_uno)
                           (lambda (matriz_dos)
                             (lambda (mod)
                               ((((crear_matriz 
                               (((resta_modular (primero (primero matriz_uno))) (primero (primero matriz_dos))) mod))
                               (((resta_modular (segundo (primero matriz_uno))) (segundo (primero matriz_dos))) mod))
                               (((resta_modular (primero (segundo matriz_uno))) (primero (segundo matriz_dos))) mod))
                               (((resta_modular (segundo (segundo matriz_uno))) (segundo (segundo matriz_dos))) mod))))))

; Ejemplo:
; ((2 4) (-1 5)) - ((1 2)(2 3))  (mod 5) => (testmatrices (((resta_matrices matriz_prueba1) matriz_prueba2) cinco)) => ((1 2) (2 2))
; ((2 1)(-3 2)) - ((1 -3) (0 4)) (mod 7) => (testmatrices (((resta_matrices matriz_prueba3) matriz_prueba4) siete)) => ((1 4) (4 5))

; Realiza la operación del producto escalar sobre una matriz en módulo mod. 
(define producto_escalar (lambda (matriz)
                           (lambda (escalar)
                             (lambda (mod)
                               ((((crear_matriz 
                               (((producto_modular (primero (primero matriz))) escalar) mod))
                               (((producto_modular (segundo (primero matriz))) escalar) mod))
                               (((producto_modular (primero (segundo matriz))) escalar) mod))
                               (((producto_modular (segundo (segundo matriz))) escalar) mod))))))

; Ejemplos:
; matriz_prueba3 * 2 (mod 3) => (testmatrices(((producto_escalar matriz_prueba3) dos) tres)) => ((1 2) (0 1))
; matriz_prieba1 * 7 (mod 8) => (testmatrices(((producto_escalar matriz_prueba1) siete) ocho)) => ((6 4) (1 3)) 



; Realiza la operación del producto vectorial sobre una matriz en módulo mod. 
(define producto_vectorial (lambda (matriz)
                           (lambda (vector)
                             (lambda (mod)
                               ((par (((suma_modular (((producto_modular (primero (primero matriz))) (primero vector)) mod))
                                       (((producto_modular (primero (segundo matriz))) (segundo vector)) mod))mod))
                                (((suma_modular (((producto_modular (segundo (primero matriz))) (primero vector)) mod))
                                       (((producto_modular (segundo (segundo matriz))) (segundo vector)) mod))mod))))))

;Realiza la operación de producto de matrices con matriz_uno y matriz_dos en (módulo mod)
(define producto_matrices (lambda (matriz_uno)
                           (lambda (matriz_dos)
                             (lambda (mod)
                               ((par (((producto_vectorial matriz_uno)(primero matriz_dos)) mod))
                                (((producto_vectorial matriz_uno)(segundo matriz_dos)) mod))))))

; Ejemplos: 
; matriz_prueba1 * matriz_prueba2 (mod 5)=> (testmatrices (((producto_matrices matriz_prueba1) matriz_prueba2) cinco)) => ((0 4) (1 3))
; matriz_prueba3 * matriz_nula (mod 7) => (testmatrices (((producto_matrices matriz_prueba3) matriz_nula) siete)) => ((0 0) (0 0))

; -----------------------------------
; Operaciones de determinante y rango
; -----------------------------------

; Apartado b: determinante. 


;Realiza el cálculo del determinante de una matriz en módulo mod. 
(define calcula_determinante (lambda (matriz)
                           (lambda (mod)
                             (((resta_modular (((producto_modular (primero (primero matriz))) (segundo (segundo matriz))) mod))(((producto_modular (segundo (primero matriz))) (primero (segundo matriz))) mod))mod))))

; Ejemplos:
; det(matriz_prueba1) (mod 3) => (testenteros((calcula_determinante matriz_prueba1) tres)) => 2
; det(matriz_prueba3) (mod 4) => (testenteros((calcula_determinante matriz_prueba3) cuatro)) => 3


; Dada una matriz, devuelve True si es la matriz nula. 
(define es_matriz_nula? (lambda (matriz)
                          (lambda (mod)
                            ((esceroent ((modulo_canonico (primero (primero matriz))) mod))
                             ((esceroent ((modulo_canonico (segundo (primero matriz))) mod))
                              ((esceroent ((modulo_canonico (primero (segundo matriz))) mod))
                               ((esceroent ((modulo_canonico (segundo (segundo matriz))) mod)) true false) false) false) false))))


; Dada una matriz en módulo mod, devuelve si el rango es uno o dos.
; Usada para calcular el rango.
(define rango_aux (lambda (matriz)
                     (lambda (mod)
                       ((esceroent ((calcula_determinante matriz)mod)) uno dos))))


; Dada una matriz en módulo mod, calcula el rango de esta. 
; Si es matriz nula devuelve cero directamente. 
(define calcula_rango (lambda (matriz)
                  (lambda (mod)
                    (((es_matriz_nula? matriz)mod) cero ((rango_aux matriz)mod)))))

; Ejemplos:
; rango(matriz_prueba1) (mod 6) => (testenteros((calcula_rango matriz_prueba3) seis)) => 2
; rango(matriz_prueba2) (mod 3) => (testenteros((calcula_rango matriz_prueba2) tres)) => 2





; ----------------------------------
; Operaciones de inversibilidad
; ----------------------------------

; Apartado c: posibilidad de inversibilidad y cálculo de esta.

;Decision sobre inversibilidad de una matriz dependiendo de si el determinante es 0
(define hay_inversa? (lambda (matriz)
                     (lambda (mod)
                       ((esceroent ((calcula_determinante matriz)mod)) false true))))

; Ejemplos:
; ((hay_inversa? matriz_prueba1) tres) => #<procedure:true> (Si)

; Dada la matriz en módulo mod, calcula la inversa. 
; Hace uso del método calculo_inversa_aux.
(define calcula_inversa (lambda (matriz)
                  (lambda (mod)
                    ((esceroent ((calcula_determinante matriz)mod)) matriz_nula ((calcula_inversa_aux matriz)mod)))))

; Permite multiplicar el determinante por la matriz con la diagonal negada. 
(define calcula_inversa_aux (lambda (matriz)
                      (lambda (mod)
                        (((producto_escalar ((negar_diagonal_matriz matriz)mod)) ((calculo_inverso ((calcula_determinante matriz)mod)) mod) )mod))))

; Dada una matriz, pone la diagonal secundaria con los mismos números
; en negativo. 
(define negar_diagonal_matriz (lambda (matriz)
                       (lambda (mod)
                         ((((crear_matriz
                             ((modulo_canonico (segundo (segundo matriz))) mod)) ; Dero la diagonal principal igual
                             (((resta_modular cero) (segundo (primero matriz))) mod)) ; cambio diagonal secundaria
                             (((resta_modular cero) (primero (segundo matriz))) mod)) ; cambio diagonal secundaria
                             ((modulo_canonico (primero (primero matriz))) mod))))); Dero la diagonal principal igual

; Ejemplos:
; Inversa(matriz_prueba1) (mod 3) => (testmatrices((calcula_inversa matriz_prueba1) tres)) => ((1 1) (2 1))
; Inversa(matriz_prueba2) (mod 2) => (testmatrices((calcula_inversa matriz_prueba2) dos)) => ((1 0) (0 1))


; ------------------------------------
; Operaciones de potencias de matrices
; ------------------------------------

; Apartado d

;Calcula el cuadrado de una matriz aplicandole una funcion de modulo
(define cuadrado_matrices (lambda (matriz)
                          (lambda (mod)
                            (((producto_matrices matriz) matriz) mod))))

; Dados la matriz, el exponente y el módulo, realiza la operación
;  de potencia sobre una matriz en módulo mod.
(define potencia_matrices_binario
    (lambda (matriz)
        (lambda (potencia)
          (lambda (mod)
            ; Comienzo de la llamada recursiva, pasando el exponente
            ; como índice. 
            ((Y (lambda (f)
                (lambda (exponente)
                  ;Si el exponente es cero
                    (((esceroent exponente)
                        (lambda (no_use)
                        ; se devuelve la matriz identidad
                            identidad
                        )
                        ;Si no es cero
                        (lambda (no_use)
                          ;Se comprueba si el exponente es par
                          (((esceroent ((restoent exponente)dos))
                            ;Si es par se calcula el cuadrado de la matriz y
                            ;se llama a recursion dividiendo entre 2 el exponente
                           (lambda (no_use1)
                              ((cuadrado_matrices (f ((cocienteent exponente) dos))) mod))
                           ;Si es impar se multiplica la matriz por el valor del exponente menos uno
                           (lambda (no_use1)
                             (((producto_matrices matriz)(f ((restaent exponente) uno)))mod))) cero)
                        )
                    )
                        cero)
                )
            ))
                potencia)
        ))
   )
)

; Ejemplos:
; Potencia(matriz_prueba1)**2 (mod 2) => (testmatrices(((potencia_matrices_binario matriz_prueba1) dos) dos)) => ((0 0) (1 1))
; Potencia(matriz_prueba2)**3 (mod 3) => (testmatrices(((potencia_matrices_binario matriz_prueba2) tres) tres)) => ((0 1) (1 1))
