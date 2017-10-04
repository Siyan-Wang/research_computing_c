!compute C=AB
program hw5partc
implicit none

! initialize variable
integer :: i, j, n
real :: start, finish, time
real(8), dimension(:,:), allocatable       :: A, B, C
integer, parameter :: out_unit=10

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

!output to file!
!first create a file as requirement!
open (unit=out_unit,file="MatrixMultiplyTimers.txt",action="write",position="append",status="old")
write (out_unit,'(i6,2x,e10.4)') n,time
close (out_unit)

end program hw5partc