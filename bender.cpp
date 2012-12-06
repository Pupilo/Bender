/*
Autor: Willian.A.Mayan
Projeto: Biblioteca de movimentos e funções do Bender
Versão: 0.0.1
*/

#include "WProgram.h"
#include "bender.h"

//Variaveis para inversão de polaridade do motor da esquerda
//#define esq_neg = 5 //Esquerda Negativo -> INI2 do relé
//#define esq_pos = 4 //Esquerda Positivo -> INI1 do relé

//Variaveis para inversão de polaridade do motor da direita
//#define dir_neg = 2 //Direita Negativo -> INI4 do relé
//#define dir_pos = 3 //Direita Positivo -> INI3 do relé
//--------------------- Funções ------------------------
Bender::Bender(int e_neg, int e_pos, int d_neg, int d_pos)
{
  //pinMode(pin, OUTPUT);
  //_pin = pin;
  //Pinos do motor da esquerda
  pinMode(e_pos, OUTPUT);
  pinMode(e_neg, OUTPUT);
  //Pinos do motor da direita
  pinMode(d_pos, OUTPUT);
  pinMode(d_neg, OUTPUT);
  //for(i = 0; i <= 3; i++){
  //  digitalWrite(i, HIGH);
  //}
 Besq_neg = e_neg;
 Besq_pos = e_pos;
 Bdir_neg = d_neg;
 Bdir_pos = d_pos;
}

//Função que move o robo para tras
void Bender::sul(){
  //Serial.print("Sul\n");
  digitalWrite(Besq_pos, LOW); //Ligar rotação do motor
  digitalWrite(Bdir_pos, LOW); //Ligar rotação do motor
  delay(2200);                 //Tempo de espera para desligar o motor
  digitalWrite(Besq_pos, HIGH);  //Desligar rotação do motor
  digitalWrite(Bdir_pos, HIGH);  //Desligar rotação do motor
  delay(2200);                 //Tempo de espera para desligar o motor
  digitalWrite(Besq_pos, LOW); //Ligar rotação do motor
  digitalWrite(Bdir_pos, LOW); //Ligar rotação do motor
}

//Função que move o robo para tras
void Bender::norte(){
  //Serial.println("Norte\n"); 
  digitalWrite(Besq_neg, LOW); //Ligar rotação do motor
  digitalWrite(Bdir_neg, LOW); //Ligar rotação do motor
  delay(2200);                 //Tempo de espera para desligar o motor
  digitalWrite(Besq_neg, HIGH);  //Desligar rotação do motor
  digitalWrite(Bdir_neg, HIGH);  //Desligar rotação do motor
  delay(2200);                 //Tempo de espera para desligar o motor
  digitalWrite(Besq_neg, LOW); //Ligar rotação do motor
  digitalWrite(Bdir_neg, LOW); //Ligar rotação do motor
  
}

//Função que move o robo para direita
void Bender::direita(){
  //Serial.println("Direita\n");
  digitalWrite(Besq_pos, LOW); //Ligar rotação do motor
  digitalWrite(Bdir_neg, LOW); //Ligar rotação do motor
  delay(1200);                 //Tempo de espera para desligar o motor
  digitalWrite(Besq_pos, HIGH);  //Desligar rotação do motor
  digitalWrite(Bdir_neg, HIGH);  //Desligar rotação do motor
  delay(1200); 
  digitalWrite(Besq_pos, LOW); //Ligar rotação do motor
  digitalWrite(Bdir_neg, LOW); //Ligar rotação do motor
}

//Função que move o robo para esquerda
void Bender::esquerda(){
  //Serial.println("Esquerda\n");
  digitalWrite(Besq_neg, LOW); //Ligar rotação do motor
  digitalWrite(Bdir_pos, LOW); //Ligar rotação do motor
  delay(1200);                 //Tempo de espera para desligar o motor
  digitalWrite(Besq_neg, HIGH);  //Desligar rotação do motor
  digitalWrite(Bdir_pos, HIGH);  //Desligar rotação do motor
  delay(1200); 
  digitalWrite(Besq_neg, LOW); //Ligar rotação do motor
  digitalWrite(Bdir_pos, LOW); //Ligar rotação do motor
}
