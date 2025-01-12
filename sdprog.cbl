       IDENTIFICATION DIVISION.
       PROGRAM-ID. FBBAT01.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CLIWORK ASSIGN TO '/home/kikos/ENT001' 
               FILE STATUS IS WS-FS-CLIWORK.

       DATA DIVISION.
       FILE SECTION.
       FD  CLIWORK.
       01 CLIWORK-REGISTO.
           05 CLIWORK-NUMCLI      PIC 9(07).
           05 CLIWORK-NOME        PIC X(49).
           05 CLIWORK-IDADE       PIC 9(02).
           05 CLIWORK-MORADA      PIC X(16).
           05 CLIWORK-CPOSTAL     PIC 9(08).
           05 CLIWORK-IBAN        PIC X(25).

       WORKING-STORAGE SECTION.
       01 WS-FIM-CLIWORK           PIC X VALUE SPACES.
           88 FIM-CLIWORK           VALUE 'S'.
       01 WS-FS-CLIWORK            PIC X(02).
           88 OK-CLIWORK            VALUE '00', '10'.
       01 WS-READ-CLIWORK          PIC 9(09) VALUE ZEROS.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT CLIWORK
           IF NOT OK-CLIWORK
               DISPLAY 'ERRO NO FICHERO CLIWORK' WS-FS-CLIWORK
               STOP RUN
           END-IF.

           PERFORM R100-LER-CLIWORK THRU R100-LER-CLIWORK-FIM.

           CLOSE CLIWORK.
           IF NOT OK-CLIWORK
               DISPLAY 'ERRO AO FECHAR O FICHERO CLIWORK' WS-FS-CLIWORK
               STOP RUN
           END-IF.

           STOP RUN.

       R100-LER-CLIWORK.
           READ CLIWORK
               AT END
                   MOVE 'S' TO WS-FIM-CLIWORK
               NOT AT END
                   ADD 1 TO WS-READ-CLIWORK
                   DISPLAY 'NUMCLI: ' CLIWORK-NUMCLI
                   DISPLAY 'NOME: ' CLIWORK-NOME
                   DISPLAY 'IDADE: ' CLIWORK-IDADE
                   DISPLAY 'MORADA: ' CLIWORK-MORADA
                   DISPLAY 'CPOSTAL: ' CLIWORK-CPOSTAL
                   DISPLAY 'IBAN: ' CLIWORK-IBAN
                   DISPLAY '----------------------------------------'
           END-READ.
       R100-LER-CLIWORK-FIM.
           EXIT.
