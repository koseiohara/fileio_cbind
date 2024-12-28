module dabin

    use iso_c_binding

    implicit none

    private

    public :: fopen
    public :: fclose
    public :: fread_sp1 , fread_dp1 , fread_sp2 , fread_dp2 , fread_sp3 , fread_dp3
    public :: fwrite_sp1, fwrite_dp1, fwrite_sp2, fwrite_dp2, fwrite_sp3, fwrite_dp3
    
    contains


    subroutine fopen(unit, file, file_len, action, action_len, endian, endian_len, recl) bind(C)
        integer(kind=c_int)   , intent(out) :: unit
        character(kind=c_char), intent(in)  :: file(*)
        integer(kind=c_int)   , intent(in)  :: file_len
        character(kind=c_char), intent(in)  :: action(*)
        integer(kind=c_int)   , intent(in)  :: action_len
        character(kind=c_char), intent(in)  :: endian
        integer(kind=c_int)   , intent(in)  :: endian_len
        integer(kind=c_int)   , intent(in)  :: recl

        character(256) :: work_file
        character(16)  :: work_action
        character(16)  :: work_endian
        character(256) :: iomsg
        integer        :: iostat
        
        call char_copy(file       , &  !! IN
                     & work_file  , &  !! OUT
                     & file_len     )  !! IN

        call char_copy(action     , &  !! IN
                     & work_action, &  !! OUT
                     & action_len   )  !! IN

        call char_copy(endian     , &  !! IN
                     & work_endian, &  !! OUT
                     & endian_len   )  !! IN

        open(NEWUNIT=unit         , &  !! OUT
           & FILE   =work_file    , &  !! IN
           & ACTION =work_action  , &  !! IN
           & FORM   ='UNFORMATTED', &  !! IN
           & ACCESS ='DIRECT'     , &  !! IN
           & RECL   =recl         , &  !! IN
           & CONVERT=work_endian  , &  !! IN
           & IOMSG  =iomsg        , &  !! OUT
           & IOSTAT =iostat         )  !! OUT

        if (iostat /= 0) then
            write(0,'(A)') '<ERROR STOP>'
            write(0,'(A)') trim(iomsg)
            ERROR STOP
        endif

    end subroutine fopen


    subroutine fclose(unit) bind(C)
        integer(kind=c_int), intent(in) :: unit

        logical :: is_opened

        INQUIRE(unit            , &  !! IN
              & OPENED=is_opened  )  !! OUT

        if (is_opened) then
            close(unit)
        endif

    end subroutine fclose


    subroutine fread_sp1(unit, record, nx, input_data) bind(C)
        integer(kind=c_int), intent(in)  :: unit
        integer(kind=c_int), intent(in)  :: record
        integer(kind=c_int), intent(in)  :: nx
        real(kind=c_float) , intent(out) :: input_data(nx)

        read(unit,rec=record) input_data(1:nx)

    end subroutine fread_sp1


    subroutine fread_dp1(unit, record, nx, input_data) bind(C)
        integer(kind=c_int), intent(in)  :: unit
        integer(kind=c_int), intent(in)  :: record
        integer(kind=c_int), intent(in)  :: nx
        real(kind=c_double), intent(out) :: input_data(nx)

        read(unit,rec=record) input_data(1:nx)

    end subroutine fread_dp1


    subroutine fread_sp2(unit, record, nx, ny, input_data) bind(C)
        integer(kind=c_int), intent(in)  :: unit
        integer(kind=c_int), intent(in)  :: record
        integer(kind=c_int), intent(in)  :: nx
        integer(kind=c_int), intent(in)  :: ny
        real(kind=c_float) , intent(out) :: input_data(nx,ny)

        read(unit,rec=record) input_data(1:nx,1:ny)

    end subroutine fread_sp2


    subroutine fread_dp2(unit, record, nx, ny, input_data) bind(C)
        integer(kind=c_int), intent(in)  :: unit
        integer(kind=c_int), intent(in)  :: record
        integer(kind=c_int), intent(in)  :: nx
        integer(kind=c_int), intent(in)  :: ny
        real(kind=c_double), intent(out) :: input_data(nx,ny)

        read(unit,rec=record) input_data(1:nx,1:ny)

    end subroutine fread_dp2


    subroutine fread_sp3(unit, record, nx, ny, nz, input_data) bind(C)
        integer(kind=c_int), intent(in)  :: unit
        integer(kind=c_int), intent(in)  :: record
        integer(kind=c_int), intent(in)  :: nx
        integer(kind=c_int), intent(in)  :: ny
        integer(kind=c_int), intent(in)  :: nz
        real(kind=c_float) , intent(out) :: input_data(nx,ny,nz)

        read(unit,rec=record) input_data(1:nx,1:ny,1:nz)

    end subroutine fread_sp3


    subroutine fread_dp3(unit, record, nx, ny, nz, input_data) bind(C)
        integer(kind=c_int), intent(in)  :: unit
        integer(kind=c_int), intent(in)  :: record
        integer(kind=c_int), intent(in)  :: nx
        integer(kind=c_int), intent(in)  :: ny
        integer(kind=c_int), intent(in)  :: nz
        real(kind=c_double), intent(out) :: input_data(nx,ny,nz)

        read(unit,rec=record) input_data(1:nx,1:ny,1:nz)

    end subroutine fread_dp3


    subroutine fwrite_sp1(unit, record, nx, output_data) bind(C)
        integer(kind=c_int), intent(in)  :: unit
        integer(kind=c_int), intent(in)  :: record
        integer(kind=c_int), intent(in)  :: nx
        real(kind=c_float) , intent(out) :: output_data(nx)

        write(unit,rec=record) output_data(1:nx)

    end subroutine fwrite_sp1


    subroutine fwrite_dp1(unit, record, nx, output_data) bind(C)
        integer(kind=c_int), intent(in)  :: unit
        integer(kind=c_int), intent(in)  :: record
        integer(kind=c_int), intent(in)  :: nx
        real(kind=c_double), intent(out) :: output_data(nx)

        write(unit,rec=record) output_data(1:nx)

    end subroutine fwrite_dp1


    subroutine fwrite_sp2(unit, record, nx, ny, output_data) bind(C)
        integer(kind=c_int), intent(in)  :: unit
        integer(kind=c_int), intent(in)  :: record
        integer(kind=c_int), intent(in)  :: nx
        integer(kind=c_int), intent(in)  :: ny
        real(kind=c_float) , intent(out) :: output_data(nx,ny)

        write(unit,rec=record) output_data(1:nx,1:ny)

    end subroutine fwrite_sp2


    subroutine fwrite_dp2(unit, record, nx, ny, output_data) bind(C)
        integer(kind=c_int), intent(in)  :: unit
        integer(kind=c_int), intent(in)  :: record
        integer(kind=c_int), intent(in)  :: nx
        integer(kind=c_int), intent(in)  :: ny
        real(kind=c_double), intent(out) :: output_data(nx,ny)

        write(unit,rec=record) output_data(1:nx,1:ny)

    end subroutine fwrite_dp2


    subroutine fwrite_sp3(unit, record, nx, ny, nz, output_data) bind(C)
        integer(kind=c_int), intent(in)  :: unit
        integer(kind=c_int), intent(in)  :: record
        integer(kind=c_int), intent(in)  :: nx
        integer(kind=c_int), intent(in)  :: ny
        integer(kind=c_int), intent(in)  :: nz
        real(kind=c_float) , intent(out) :: output_data(nx,ny,nz)

        write(unit,rec=record) output_data(1:nx,1:ny,1:nz)

    end subroutine fwrite_sp3


    subroutine fwrite_dp3(unit, record, nx, ny, nz, output_data) bind(C)
        integer(kind=c_int), intent(in)  :: unit
        integer(kind=c_int), intent(in)  :: record
        integer(kind=c_int), intent(in)  :: nx
        integer(kind=c_int), intent(in)  :: ny
        integer(kind=c_int), intent(in)  :: nz
        real(kind=c_double) , intent(out) :: output_data(nx,ny,nz)

        write(unit,rec=record) output_data(1:nx,1:ny,1:nz)

    end subroutine fwrite_dp3


    subroutine char_copy(input, output, len)
        character   , intent(in)  :: input(*)
        character(*), intent(out) :: output
        integer     , intent(in)  :: len

        integer :: i

        do i = 1, len
            output(i:i) = input(i)
        enddo

    end subroutine char_copy


end module dabin

