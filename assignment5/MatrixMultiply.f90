!compute C=AB
program MatrixMultiply
implicit none

! initialize variable
integer :: i, j, n
real :: start, finish, time
real(8), dimension(:,:), allocatable       :: A, B, C
integer, parameter :: out_unit=20

! decide the size of matrix !    
print*,"enter the matrix size n"
read (*,*) n 

!allocate matrices!
allocate(A(n,n), B(n,n), C(n,n))
A = 1
B = 1

!start doing the multiplication and record the corresponding start and end time !
call cpu_time(start)

do i = 1,n
	do j =1,n
		C(i,j)=sum( A(i,:) * B(:,j) )
	enddo
enddo

call cpu_time(finish)

time = finish-start
!stop doing the multiplication !

!output to shell!
write(*,'(a,i4,2x,a,i4)') "The matrix size is", n,"x",n
write(*,'(a,1x,e9.2,1x,a)') "The computation time is", time,"second"

!output to file C.txt!
open (unit=out_unit,file="C.txt",action="write",status="replace")
do i=1,10
	write (out_unit,*) (C(i,j), j=1,5)
enddo
close (out_unit)

end program MatrixMultiply