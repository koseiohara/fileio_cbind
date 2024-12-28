#include <stdio.h>
#include <iostream>
#include <cstring>
#include <vector>
#include <string.h>

using namespace std;

extern void fopen(      int*  unit      ,
                  const char* file      ,
                  const int*  file_len  ,
                  const char* action    ,
                  const int*  action_len,
                  const char* endian    ,
                  const int*  endian_len,
                  const int*  recl      );

extern void fclose(const int* unit);

extern void fread_sp1(const int*    unit      ,
                      const int*    record    ,
                      const int*    nx        ,
                            float*  input_data);

extern void fread_dp1(const int*    unit      ,
                      const int*    record    ,
                      const int*    nx        ,
                            double* input_data);

extern void fread_sp2(const int*    unit      ,
                      const int*    record    ,
                      const int*    nx        ,
                      const int*    ny        ,
                            float*  input_data);

extern void fread_dp2(const int*    unit      ,
                      const int*    record    ,
                      const int*    nx        ,
                      const int*    ny        ,
                            double* input_data);

extern void fread_sp3(const int*    unit      ,
                      const int*    record    ,
                      const int*    nx        ,
                      const int*    ny        ,
                      const int*    nz        ,
                            float*  input_data);

extern void fread_dp3(const int*    unit      ,
                      const int*    record    ,
                      const int*    nx        ,
                      const int*    ny        ,
                      const int*    nz        ,
                            double* input_data);

extern void fwrite_sp1(const int*    unit       ,
                       const int*    record     ,
                       const int*    nx         ,
                             float*  output_data);

extern void fwrite_dp1(const int*    unit       ,
                       const int*    record     ,
                       const int*    nx         ,
                             double* output_data);

extern void fwrite_sp2(const int*    unit       ,
                       const int*    record     ,
                       const int*    nx         ,
                       const int*    ny         ,
                             float*  output_data);

extern void fwrite_dp2(const int*    unit       ,
                       const int*    record     ,
                       const int*    nx         ,
                       const int*    ny         ,
                             double* output_data);

extern void fwrite_sp3(const int*    unit       ,
                       const int*    record     ,
                       const int*    nx         ,
                       const int*    ny         ,
                       const int*    nz         ,
                             float*  output_data);

extern void fwrite_dp3(const int*    unit       ,
                       const int*    record     ,
                       const int*    nx         ,
                       const int*    ny         ,
                       const int*    nz         ,
                             double* output_data);




class fileio{
    private:
        int  unit;
        int  nx;
        int  ny;
        int  nz;
        int  kind;
        int  record;
        int  recstep;
        int  recl;
        int  dim;
        char file[256];
        char action[16];
        char endian[16];
        char order;

        //void checker(const int dim, const int  kind, const int record, const char order);
        void checker();

    public:
        void   open();
        void   close();
        float  read(float*  inputData);
        double read(double* inputData);
        void   write(float*  outputData);
        void   write(double* outputData);

        fileio(const char file[]       ,
               const char action[]     ,
               const vector<int>& shape, 
               const int  kind         , 
               const int  record       ,
               const int  recstep      ,
               const char endian[]     ,
                     char order        );

};

fileio :: fileio(const char file[]       ,
                 const char action[]     ,
                 const vector<int>& shape, 
                 const int  kind         , 
                 const int  record       ,
                 const int  recstep      ,
                 const char endian[]     ,
                       char order        ){

    int file_len;
    int action_len;
    int endian_len;

    file_len   = strlen(file);
    action_len = strlen(action);
    endian_len = strlen(endian);

    dim  = shape.size();
    recl = kind * shape[0];

    this->nx = shape[0];
    this->ny = 1;
    this->nz = 1;

    if (dim >= 2){
        this->ny = shape[1];
        recl = recl * shape[1];
    }
    if (dim == 3){
        this->nz = shape[2];
        recl = recl * shape[2];
    }
    
    this->kind    = kind;
    this->record  = record;
    this->recstep = recstep;
    this->order   = order;
    strcpy(this->file   , file   );
    strcpy(this->action , action );
    strcpy(this->endian , endian );

    checker();

    fopen(&unit, file, &file_len, action, &action_len, endian, &endian_len, &recl);

}


void fileio :: close(){
    fclose(&unit);

    unit = -999;
    r


//fileio :: checker(const int dim, const int kind, const int record, const char order){
void fileio :: checker(){
    if (dim > 3){
        printf("<ERROR STOP>\n");
        printf("Invalid data dimension specified in argument 'shape'\n");
        printf("Size of 'shape' must be between 1 and 3, but the input is %d\n", dim);
        exit(1);
    }

    if (kind != 4 && kind != 8){
        printf("<ERROR STOP>\n");
        printf("Invalid value specified for the 'kind' argument\n");
        printf("'kind' must be 4 or 8, but the input is %d\n", kind);
        exit(1);
    }

    if (record <= 0){
        printf("<ERROR STOP>\n");
        printf("Invalid value specified for the 'record' argument\n");
        printf("'record' must be equal of more than 1, but the input is %d\n", record);
        exit(1);
    }

    if (strcmp(endian, "little_endian") != 0 || strcmp(endian, "big_endian") != 0 || strcmp(endian, "native") != 0){
        printf("<ERROR STOP>\n");
        printf("Invalid string specified for the 'endian' argument\n");
        printf("'endian' must be 'little_endian', 'big_endian', or 'native'\n");
        exit(1);
    }

    if (order != 'C' && order != 'c' && order != 'F' && order != 'f'){
        printf("<ERROR STOP>\n");
        printf("Invalid character specified for the 'order' argument\n");
        printf("'order' must be 'C' or 'F', but the input is %c\n", order);
        exit(1);
    }
}


