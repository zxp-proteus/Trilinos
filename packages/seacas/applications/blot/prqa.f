C Copyright(C) 2009-2017 National Technology & Engineering Solutions of
C Sandia, LLC (NTESS).  Under the terms of Contract DE-NA0003525 with
C NTESS, the U.S. Government retains certain rights in this software.
C 
C Redistribution and use in source and binary forms, with or without
C modification, are permitted provided that the following conditions are
C met:
C 
C     * Redistributions of source code must retain the above copyright
C       notice, this list of conditions and the following disclaimer.
C 
C     * Redistributions in binary form must reproduce the above
C       copyright notice, this list of conditions and the following
C       disclaimer in the documentation and/or other materials provided
C       with the distribution.
C     * Neither the name of NTESS nor the names of its
C       contributors may be used to endorse or promote products derived
C       from this software without specific prior written permission.
C 
C THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
C "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
C LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
C A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
C OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
C SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
C LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
C DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
C THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
C (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
C OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

C $Log: prqa.f,v $
C Revision 1.2  2009/03/25 12:36:46  gdsjaar
C Add copyright and license notice to all files.
C Permission to assert copyright has been granted; blot is now open source, BSD
C
C Revision 1.1  1994/04/07 20:08:02  gdsjaar
C Initial checkin of ACCESS/graphics/blotII2
C
c Revision 1.2  1990/12/14  08:55:20  gdsjaar
c Added RCS Id and Log to all files
c
C=======================================================================
      SUBROUTINE PRQA (OPTION, NOUT, NQAREC, QAREC, NINFO, INFO)
C=======================================================================

C   --*** PRQA *** (BLOT) Display QA and information records
C   --   Written by Amy Gilkey - revised 11/05/87
C   --
C   --PRQA displays the QA records and the information records.
C   --
C   --Parameters:
C   --   OPTION - IN - '*' to print all, else print options:
C   --      'Q' to print QA records
C   --      'I' to print information records
C   --   NOUT - IN - the output file, <=0 for standard
C   --   NQAREC - IN - the number of QA records (must be at least one)
C   --   QAREC - IN - the QA records containing:
C   --      (1) - the analysis code name
C   --      (2) - the analysis code QA descriptor
C   --      (3) - the analysis date
C   --      (4) - the analysis time
C   --   NINFO - IN - the number of information records
C   --   INFO - IN - the information records

      CHARACTER*(*) OPTION
      CHARACTER*(*) QAREC(4,*)
      CHARACTER*(*) INFO(*)

      LOGICAL ISABRT
      CHARACTER*5 STR5

      IF (NOUT .GT. 0) WRITE (*, 10000)

      IF ((OPTION .EQ. '*') .OR. (INDEX (OPTION, 'Q') .GT. 0)) THEN
         IF (NQAREC .GT. 0) THEN
            IF (NOUT .GT. 0) THEN
               WRITE (NOUT, *)
            ELSE
               WRITE (*, *)
            END IF

            IF (NOUT .GT. 0) THEN
               CALL INTSTR (1, 0, NQAREC, STR5, LSTR)
               WRITE (NOUT, 10010) STR5(:LSTR)
            END IF

            DO 100 IQA = 1, NQAREC
               IF (ISABRT ()) RETURN
               IF (NOUT .GT. 0) THEN
                  WRITE (NOUT, 10020)
     *             (QAREC(I,IQA)(:LENSTR(QAREC(I,IQA))), I=1,4)
               ELSE
                  WRITE (*, 10020)
     *             (QAREC(I,IQA)(:LENSTR(QAREC(I,IQA))), I=1,4)
               END IF
  100       CONTINUE
         END IF
      END IF

      IF ((OPTION .EQ. '*') .OR. (INDEX (OPTION, 'I') .GT. 0)) THEN
         IF (NINFO .GT. 0) THEN
            IF (NOUT .GT. 0) THEN
               WRITE (NOUT, *)
            ELSE
               WRITE (*, *)
            END IF

            IF (NOUT .GT. 0) THEN
               CALL INTSTR (1, 0, NINFO, STR5, LSTR)
               WRITE (NOUT, 10030) STR5(:LSTR)
            END IF

            DO 110 I = 1, NINFO
               IF (ISABRT ()) RETURN
               IF (NOUT .GT. 0) THEN
                  WRITE (NOUT, 10040) INFO(I)(:LENSTR(INFO(I)))
               ELSE
                  WRITE (*, 10040) INFO(I)(:LENSTR(INFO(I)))
               END IF
  110       CONTINUE
         END IF
      END IF

      RETURN

10000  FORMAT (/, 1X, 'QA AND INFORMATION RECORDS')
10010  FORMAT (/, 1X, 'Number of QA Records = ', A)
10020  FORMAT (1X, 'Code:  ', A, '  version  ', A,
     &   '  on  ', A, '  at  ', A)
10030  FORMAT (/, 1X, 'Number of Information Records = ', A)
10040  FORMAT (1X, A)
      END
