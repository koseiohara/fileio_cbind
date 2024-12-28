module cbind_test
    use iso_c_binding

    implicit none

    private
    public :: mytype
    public :: mysub

    type, bind(c) :: mytype
        character(kind=c_char) :: string(128)
        integer(kind=c_int)    :: number
    end type mytype


    contains


    subroutine mysub(testtype) bind(c)
        type(mytype), intent(out) :: testtype

        testtype%string = 'vaerbuiv;earv'
        testtype%number = 234786

    end subroutine mysub

end module cbind_test

