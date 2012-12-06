/*
Autor: Willian.A.Mayan
Projeto: Biblioteca de movimentos e funções do Bender
Versão: 0.0.1
*/

#ifndef bender_h
#define bender_h
#include "WProgram.h"

class Bender
{
  public:
    Bender(int esq_neg, int esq_pos, int dir_neg, int dir_pos);
    void sul();
    void norte();
    void direita();
    void esquerda();
  
  private:
    int Besq_neg, Besq_pos, Bdir_neg, Bdir_pos, i;
};


#endif
