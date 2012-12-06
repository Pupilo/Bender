/*
Autor: Willian.A.Mayan
Projeto: Robo inteligente
Versão: 0.0.1
*/
//Bibliotecas
#include <Servo.h> //Para movimentação do servo motor
#include "bender.h"

//######################
#include "Ultrasonic.h"
#define echoPin 13 //Pino 13 recebe o pulso do echo
#define trigPin 12 //Pino 12 envia o pulso para gerar o echo
//iniciando a função e passando os pinos
Ultrasonic ultrasonic(12,13);

//lib bender
Bender bender(5,4,2,3);

//####################
#define led 10

//######################

//Variaveis auxiliares
int i; //uso em laços de repetição
Servo myservo;
int pos; //variavel para posição do servo motor
long proximidade;
char caminho[3];
char rota[60];  //caminho a ser traçado
char aux[20];  //Armazena o check point
char escolhas[10];      //armazena a escolha

int cont = 0;  //Contador principal
int chpo = 0; //Contador do check point
int esco = 0; //contador de escolhas 

//--------------------- Funções ------------------------

//Função para olhar para esquerda
void olhar(){
  //Chamar sensor
  //Ultrasonico();
  
  myservo.write(90);     //Testar se achou a saida         
  delay(1000);
  proximidade = Ultrasonico();
  if(proximidade <= 70){
    
        //Direita                              
        myservo.write(0);              // tell servo to go to position in variable 'pos' 
        delay(1000);
        proximidade = Ultrasonico();
        if (proximidade <= 15){
          caminho[0] = '*' ;
          //Serial.print("Esquerda Bate\n");
        }
        else
          caminho[0] = 'D';
      //#################
  
      //Esuerda                              
      myservo.write(179);              // tell servo to go to position in variable 'pos' 
      delay(1000);
      proximidade = Ultrasonico();
      if (proximidade <= 15){
        caminho[1] = '*' ;
        //Serial.print("Direita Bate\n");
      }
      else
        caminho[1] = 'E';
      //#################

      //Acertar visÃ£o -Norte
      myservo.write(90);              // tell servo to go to position in variable 'pos' 
      delay(1000);
      proximidade = Ultrasonico();  
      if(proximidade <= 15){
        caminho[2] = '*' ;
        //Serial.print("Norte Bate\n");
      }
      else
        caminho[2] = 'N';
  }
  else
    achou();
}
//-------------------------------------------------------

long Ultrasonico(){
  //seta o pino 12 com um pulso baixo "LOW" ou desligado ou ainda 0
    digitalWrite(trigPin, LOW);
  // delay de 2 microssegundos
    delayMicroseconds(2);
  //seta o pino 12 com pulso alto "HIGH" ou ligado ou ainda 1
    digitalWrite(trigPin, HIGH);
  //delay de 10 microssegundos
    delayMicroseconds(10);
  //seta o pino 12 com pulso baixo novamente
    digitalWrite(trigPin, LOW);
  // função Ranging, faz a conversão do tempo de
  //resposta do echo em centimetros, e armazena
  //na variavel distancia
    int distancia = (ultrasonic.Ranging(CM));

    Serial.print("Distancia em CM: ");
    Serial.println(distancia);
    delay(1000); //espera 1 segundo para fazer a leitura novamente
    return distancia;
}

//-------------------------------------------------------
void preecher(){
      rota[cont] = caminho[0];
      Serial.println(rota[cont]);
  
      cont++;
      rota[cont] = caminho[1];
      Serial.println(rota[cont]);
  
      cont++;
      rota[cont] = caminho[2];
      Serial.println(rota[cont]);
}

//-------------------------------------------------------
void corrigir(){ //Funçao de correção
  int p1, p2, p3, c1, c2, c3, var = 0;
  p1 = cont; //N
  p2 = cont -1; //E
  p3 = cont -2; //D
  c1 = chpo ;
  c2 = chpo -1;
  c3 = chpo -2;
  
  while (var == 0) {
    if( ( aux[c1] == rota[p1] ) || ( aux[c2] == rota[p2] ) || ( aux[c3] == rota[p3] )  ){ //posição = ao check point
      
      //Norte
      if( (rota[p1]) == (escolhas[esco]) ){
        rota[p1] = '*';
        esco--;
      } 
      else //Direita
      if( (rota[p2]) == (escolhas[esco]) ){
        rota[p2] = '*';
        esco--;
      }
      else //Esquerda
      if( (rota[p3]) == (escolhas[esco]) ){
        rota[p3] = '*';
        esco--;
      }
      
      cont = p3; //definir rota
      chpo = c3; //definir check point
      //tratar posição
      var = 1;
    }
    else{
      bender.norte();//sul
      p1--;
      p2--;
      p3--;
      c1--;
      c2--;
      c3--;
    }
  }
}
//-------------------------------------------------------
void chechkPoint(){
  
  aux[chpo] = caminho[0]; //D
  chpo++;
  aux[chpo] = caminho[1]; //E
  chpo++;
  aux[chpo] = caminho[2]; //N
  chpo++;
}
//-------------------------------------------------------
void seguir(){
int j;
  
for(i = 0; i <= 60; i++){
  switch(rota[i]){
    case 'N':
          bender.sul(); //circuito trocado
        break;
    case 'E':
          bender.esquerda();
        break;
        
    case 'D':
          bender.direita();
        break;
  }
}

}
//-------------------------------------------------------
void achou(){
  digitalWrite(led, HIGH);
  delay(3000);
  digitalWrite(led, LOW);
  int vz;
  
  for(vz =0 ; vz <= 10 ; vz++){
    digitalWrite(led, HIGH);
    delay(300);
    digitalWrite(led, LOW);
    delay(300);
  } 
  seguir();
}
//################## INICIO ################## 
void setup(){
  myservo.attach(9); //Pino do servo 
  Serial.begin(9600); //inicia a porta serial
  pinMode(echoPin, INPUT); // define o pino 13 como entrada (recebe)
  pinMode(trigPin, OUTPUT); // define o pino 12 como saida (envia)
  pinMode(led,OUTPUT);
}

void loop(){
  //Lib bender
  olhar();
  //   Direita                Esquerda              Norte  
  if( (caminho[0] == '*') && (caminho[1] == '*') && (caminho[2] != '*') ){
    preecher();
    bender.sul();
    //preecher();
    //bender.norte();
    //Serial.print("Norte");
  }
  else 
  if( (caminho[0] == '*') && (caminho[1] != '*') && (caminho[2] == '*') ){
    preecher();
    bender.direita();
    //Serial.print("Esquerda");
  }
  else
  if( (caminho[0] != '*') && (caminho[1] == '*') && (caminho[2] == '*') ){
    preecher();
    bender.esquerda();
    //Serial.print("Direita");
  }
  else
  if( (caminho[0] == '*') && (caminho[1] == '*') && (caminho[2] == '*') ){ //Função de corrigir
    corrigir();
    //bender.norte();
    //Serial.print("Sul");
  }
  else //Check point implementação
  //   Esquerda ou DIreita => Esquerda
  if( (caminho[0] != '*') && (caminho[1] != '*') && (caminho[2] == '*') ){
      chechkPoint();
      bender.esquerda();
      escolhas[esco] ='E';
      esco++;
  }
  else//   Esquerda ou Norte => Esquerda
  if( (caminho[0] == '*') && (caminho[1] != '*') && (caminho[2] != '*') ){
      chechkPoint();
      bender.esquerda();
      escolhas[esco] ='E';
      esco++;
  }
  else//   Direita ou Norte => Norte
  if( (caminho[0] == '*') && (caminho[1] != '*') && (caminho[2] != '*') ){
      chechkPoint();
      bender.sul();
      escolhas[esco] ='N';
      esco++;
  }

  //Serial.println(caminho[0]);
  //Serial.println(caminho[1]);
  //Serial/.println(caminho[2]);
  //bender.sul();
  //bender.norte();
  //bender.esquerda();
  //bender.direita();

  /*
  bender.direita();
  bender.norte();
  bender.esquerda();
  bender.norte();
  bender.norte();
  bender.norte();
  bender.direita();
  bender.norte();
*/
}
