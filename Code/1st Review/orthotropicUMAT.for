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
	 
	       
!C  	ORTHOTROPIC ELASTIC USER SUBROUTINE

      PARAMETER(ONE=1.0D0, TWO=2.0D0)
      
!DIR$ FREEFORM 
	  	  	 
!C ELASTIC PROPERTIES

      E11=PROPS(1)
      E22=PROPS(2)
      E33=PROPS(3)
      NU12=PROPS(4)
      NU13=PROPS(5)
      NU23=PROPS(6)   
      G12=PROPS(7)
      G13=PROPS(8)
      G23=PROPS(9)
	  
      NU21=(E22*NU12)/E11
      NU31=(E33*NU13)/E11
      NU32=(E33*NU23)/E22
	  Upsilon=(ONE)/(ONE-NU12*NU21-NU23*NU32-NU13*NU31-TWO*NU21*NU32*NU13)
	  
	  

!C 	ELASTIC STIFFNESS
!C
      DO I=1,NTENS
       DO J=1,NTENS
       DDSDDE(I,J)=0.0D0       
	   ENDDO
      ENDDO	  
!C
!C CALCULATE STRESS
!C
      DDSDDE(1,1)=E11*Upsilon*(ONE-NU23*NU32)
      DDSDDE(1,2)=E11*Upsilon*(NU21+NU31*NU23)
      DDSDDE(1,3)=E11*Upsilon*(NU31+NU21*NU32)
      DDSDDE(2,1)=E11*Upsilon*(NU21+NU31*NU23)
      DDSDDE(2,2)=E22*Upsilon*(ONE-NU13*NU31)
      DDSDDE(2,3)=E22*Upsilon*(NU32+NU12*NU31)
      DDSDDE(3,1)=E11*Upsilon*(NU31+NU21*NU32)
      DDSDDE(3,2)=E22*Upsilon*(NU32+NU12*NU31)
      DDSDDE(3,3)=E33*Upsilon*(ONE-NU12*NU21)
      DDSDDE(4,4)=G12
      DDSDDE(5,5)=G13
      DDSDDE(6,6)=G23
	   DO I=1,NTENS
		DO J=1,NTENS
		
		STRESS(I)=STRESS(I)+DDSDDE(I,J)*DSTRAN(J)
          END DO
      END DO
!C
	
      
      RETURN
      END
	  
      
