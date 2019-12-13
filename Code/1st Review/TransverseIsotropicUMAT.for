      SUBROUTINE UMAT(STRESS,STATEV,DDSDDE,SSE,SPD,SCD,
     1 RPL,DDSDDT,DRPLDE,DRPLDT,
     2 STRAN,DSTRAN,TIME,DTIME,TEMP,DTEMP,PREDEF,DPRED,CMNAME,
     3 NDI,NSHR,NTENS,NSTATV,PROPS,NPROPS,COORDS,DROT,PNEWDT,
     4 CELENT,DFGRD0,DFGRD1,NOEL,NPT,LAYER,KSPT,JSTEP,KINC)
C
      INCLUDE 'ABA_PARAM.INC'
C
      CHARACTER*80 CMNAME
      DIMENSION STRESS(NTENS),STATEV(NSTATV),
     1 DDSDDE(NTENS,NTENS),DDSDDT(NTENS),DRPLDE(NTENS),
     2 STRAN(NTENS),DSTRAN(NTENS),TIME(2),PREDEF(1),DPRED(1),
     3 PROPS(NPROPS),COORDS(3),DROT(3,3),DFGRD0(3,3),DFGRD1(3,3),
     4 JSTEP(4)
	 
	       
C  	TRANSVERSE ISOTROPIC X-Y PLNAE ELASTIC USER SUBROUTINE

      PARAMETER(ONE=1.0D0, TWO=2.0D0)
	  	  	 
C ELASTIC PROPERTIES

      Ep=PROPS(1)
      Et=PROPS(2)
      NUp=PROPS(3)
      NUpt=PROPS(4)
      Gt=PROPS(5)

      NUtp=(Et*NUpt)/Ep
      Gp=(Ep)/TWO*(ONE+NUp)
      Upsilon=(ONE)/(ONE+NUp)*(ONE-NUp-TWO*NUpt*NUtp)  
	    

C 	ELASTIC STIFFNESS
C
      DO I=1,NTENS
       DO J=1,NTENS
       DDSDDE(I,J)=0.0D0       
	   ENDDO
      ENDDO	  
C
C CALCULATE STRESS
C
      DDSDDE(1,1)=Ep*Upsilon*(ONE-NUpt*NUtp)
      DDSDDE(1,2)=Ep*Upsilon*(NUp+NUtp*NUpt)
      DDSDDE(1,3)=Ep*Upsilon*(NUtp+NUp*NUtp)
      DDSDDE(2,1)=Ep*Upsilon*(NUp+NUtp*NUpt)
      DDSDDE(2,2)=Ep*Upsilon*(ONE-NUtp*NUpt)
      DDSDDE(2,3)=Ep*Upsilon*(NUtp+NUp*NUtp)
      DDSDDE(3,1)=E11*Upsilon*(NUtp+NUp*NUtp)
      DDSDDE(3,2)=Ep*Upsilon*(NUtp+NUp*NUtp)
      DDSDDE(3,3)=Et*Upsilon*(ONE-NUp*NUp)
      DDSDDE(4,4)=Gp
      DDSDDE(5,5)=Gt
      DDSDDE(6,6)=Gt
	   DO I=1,NTENS
		DO J=1,NTENS
		
		STRESS(I)=STRESS(I)+DDSDDE(I,J)*DSTRAN(J)
          END DO
      END DO
C
	
      
      RETURN
      END
	  
      
