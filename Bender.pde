/*
Autor: Willian.A.Mayan
Projeto: Robo inteligente
Versão: 0.0.2
*/
//Bibliotecas
#include <Servo.h> //Para movimentação do servo motor

//######################
#include "Ultrasonic.h"
#define echoPin 13 //Pino 13 recebe o pulso do echo
#define trigPin 12 //Pino 12 envia o pulso para gerar o echo
//iniciando a função e passando os pinos
Ultrasonic ultrasonic(12,13);

//###########################    MOTORES    ###########################################
//Variaveis para inversão de polaridade do motor da esquerda
#define esq_neg = 5 //Esquerda Negativo -> INI2 do relé
#define esq_pos = 4 //Esquerda Positivo -> INI1 do relé

//Variaveis para inversão de polaridade do motor da direita
#define dir_neg = 2 //Direita Negativo -> INI4 do relé
#define dir_pos = 3 //Direita Positivo -> INI3 do relé
 
void esquerda(){
  digitalWrite(4, HIGH);
  digitalWrite(4, HIGH);
  delay(1000);           
  digitalWrite(4, LOW); 
  digitalWrite(4, LOW);
}


void direita(){
  digitalWrite(4, HIGH);
  digitalWrite(4, HIGH);
  delay(1000);           
  digitalWrite(4, LOW); 
  digitalWrite(4, LOW);
}

void frente(){ //OK
  digitalWrite(4, HIGH);
  digitalWrite(4, HIGH);
  delay(1000);           
  digitalWrite(4, LOW); 
  digitalWrite(4, LOW);
}
/*
void tras(){ //OK
  digitalWrite(esq_pos, HIGH);
  digitalWrite(dir_pos, HIGH);
  delay(1000);           
  digitalWrite(esq_pos, LOW); 
  digitalWrite(dir_pos, LOW);
}*/
//#################################################################################################

void setup() {                
  //Pinos do motor da esquerda
  pinMode(esq_pos, OUTPUT);
  pinMode(esq_neg, OUTPUT);
  //Pinos do motor da direita
  pinMode(dir_pos, OUTPUT);
  pinMode(dir_neg, OUTPUT);    
}

void loop(){
  frente();

}
