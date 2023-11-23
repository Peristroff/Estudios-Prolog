% Regla para obtener el peso ideal según el sexo y la altura
pesoIdeal(Altura, Edad, PesoIdeal) :-
    PesoIdeal is ((Altura - 100) + ((Edad/10) * (0.9))).

% Regla para calcular el IMC
calcular_imc(Peso, Altura, IMC) :-
    AlturaMetros is (Altura / 100),
    IMC is (Peso / (AlturaMetros * AlturaMetros)).

% Regla para obtener el estado del IMC
estado_imc(IMC, 'Le falta peso') :- IMC < (18.5).
estado_imc(IMC, 'Peso ideal') :- IMC >= (18.5), IMC =< (24.9).
estado_imc(IMC, 'Tiene sobrepeso') :- IMC > (24.9), IMC =< 30.
estado_imc(IMC, 'Tiene obesidad') :- IMC > 30.

% Menú para calcular el peso ideal
calcular_peso_ideal :-
    write('--- Calcular peso ideal ---'), nl,
    write('Ingrese su nombre: '),
    read_line_to_codes(user_input, NombreCodes),
    string_codes(Nombre, NombreCodes),
    repeat,
    write('Ingrese su edad: '),
    read_line_to_codes(user_input, EdadCodes),
    string_codes(EdadInput, EdadCodes),
    (
        validar_numero_no_negativo(EdadInput, Edad) -> true;
        write('Edad invalida. Por favor, ingrese una edad valida.'), nl,
        fail
    ),
    repeat,
    write('Ingrese su altura (en cm): '),
    read_line_to_codes(user_input, AlturaCodes),
    string_codes(AlturaInput, AlturaCodes),
    (
        validar_numero_no_negativo(AlturaInput, Altura) -> true;
        write('Altura invalida. Por favor, ingrese una altura valida.'), nl,
        fail
    ),
    repeat,
    write('Ingrese su peso (en kg): '),
    read_line_to_codes(user_input, PesoCodes),
    string_codes(PesoInput, PesoCodes),
    (
        validar_numero_no_negativo(PesoInput, Peso) -> true;
        write('Peso invalido. Por favor, ingrese un peso valido.'), nl,
        fail
    ),
    repeat,
    write('Ingrese su sexo (m/f -> masculino/femenino): '),
    read_line_to_codes(user_input, SexoCodes),
    string_codes(SexoInput, SexoCodes),
    (
        (SexoInput = "m"; SexoInput = "M") -> Sexo = 'hombre', !;
        (SexoInput = "f"; SexoInput = "F") -> Sexo = 'mujer', !;
        write('Sexo invalido. Por favor, ingrese "m" para masculino o "f" para femenino.'), nl,
        fail
    ),
    pesoIdeal(Altura, Edad, PesoIdeal),
    write('--- Resultado ---'), nl,
    mostrar_resultado(Nombre, Edad, Peso, Altura, Sexo, PesoIdeal),
    menu. % Agregado para volver al menú principal

validar_numero_no_negativo(String, Numero) :-
    catch(number_codes(Numero, String), _, fail),
    Numero >= 0.

validar_edad(Edad) :-
    integer(Edad),
    Edad >= 0, !. % Verifica que la edad sea un número entero no negativo

validar_edad(_) :-
    write('Edad inválida. Por favor, ingrese una edad válida.'), nl,
    fail.

validar_altura(Altura) :-
    integer(Altura),
    Altura >= 0, !. % Verifica que la altura sea un número entero no negativo

validar_altura(_) :-
    write('Altura inválida. Por favor, ingrese una altura válida.'), nl,
    fail.

validar_peso(Peso) :-
    number(Peso),
    Peso >= 0, !. % Verifica que el peso sea un número no negativo

validar_peso(_) :-
    write('Peso inválido. Por favor, ingrese un peso válido.'), nl,
    fail.


% Regla para mostrar el resultado del peso ideal
mostrar_resultado(Nombre, Edad, Peso, Altura, Sexo, PesoIdeal) :-
    calcular_imc(Peso, Altura, IMC),
    estado_imc(IMC, Estado),
    write('Nombre: '), write(Nombre), nl,
    write('Edad: '), write(Edad), nl,
    write('Peso: '), write(Peso), write(' kg'), nl,
    write('Altura: '), write(Altura), write(' cm'), nl,
    write('Sexo: '), write(Sexo), nl,
    write('Peso ideal: '), write(PesoIdeal), write(' kg'), nl,
    write('IMC: '), format('~2f', [IMC]), nl, % Modificación para mostrar el IMC con 2 decimales
    write('Estado: '), write(Estado), nl.

% Predicado para terminar el programa de manera controlada
salir :- 
    write('¡Hasta luego!'), nl,
    abort.

% Menú principal
menu :-
    repeat,
    write(''), nl,
    write('--- Menu ---'), nl,
    write('1. Calcular peso ideal'), nl,
    write('2. Salir'), nl,
    repeat,
    write('Ingrese su opcion: '),
    read_line_to_codes(user_input, OpcionCodes),
    string_codes(OpcionInput, OpcionCodes),
    (
        OpcionInput = "1" -> calcular_peso_ideal;
        OpcionInput = "2" -> salir;
        write('Opción inválida. Por favor, ingrese una opción válida.'), nl,
        fail
    ).

% Ejecutar el menú principal
:- initialization(menu).
