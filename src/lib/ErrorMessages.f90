module ErrorMessages

USE iso_fortran_env, only: OUTPUT_UNIT, ERROR_UNIT
USE IR_Precision,    only: I4P, str

implicit none
private

    integer(I4P), public, parameter :: FPLSuccess             = 0
    integer(I4P), public, parameter :: FPLWrapperFactoryError = -1
    integer(I4P), public, parameter :: FPLWrapperError        = -2
    integer(I4P), public, parameter :: FPLSublistError        = -3

    type :: MessageHandler_t
    private
        character(len=5) :: prefix = '[FPL]'
    contains
        procedure :: Print => MessageHandler_Print
        procedure :: Warn  => MessageHandler_Warn
        procedure :: Error => MessageHandler_Error
    end type

    type(MessageHandler_t) :: msg

public :: msg

contains


    subroutine MessageHandler_Print(this, txt, unit, iostat, iomsg)
    !-----------------------------------------------------------------
    !< Print a txt message preceding for prefix
    !-----------------------------------------------------------------
        class(MessageHandler_t),  intent(IN)  :: this                 !< Message handler
        character(len=*),         intent(IN)  :: txt                  !< Text to print
        integer(I4P),   optional, intent(IN)  :: unit                 !< Unit where to print
        integer(I4P),   optional, intent(OUT) :: iostat               !< IO error.
        character(*),   optional, intent(OUT) :: iomsg                !< IO error message.
        integer(I4P)                          :: iostatd              !< Real IO error.
        integer(I4P)                          :: u                    !< Real unit
        character(500)                        :: iomsgd               !< Real IO error message.          
    !-----------------------------------------------------------------
        u = OUTPUT_UNIT; if(present(unit)) u = unit; iostatd = 0 ; iomsgd = ''
        write(unit=u, fmt='(A)',iostat=iostatd,iomsg=iomsgd) this%Prefix//' '//txt
        if (present(iostat)) iostat = iostatd
        if (present(iomsg))  iomsg  = iomsgd
    end subroutine


    subroutine MessageHandler_Warn(this, txt, unit, file, line, iostat, iomsg)
    !-----------------------------------------------------------------
    !< Warn a with txt message preceding for WARNING!
    !-----------------------------------------------------------------
        class(MessageHandler_t),  intent(IN)  :: this                 !< Message handler
        character(len=*),         intent(IN)  :: txt                  !< Text to print
        integer(I4P),   optional, intent(IN)  :: unit                 !< Unit where to print
        character(*),   optional, intent(IN)  :: file                 !< Source file
        integer(I4P),   optional, intent(IN)  :: line                 !< Number of line in source file
        integer(I4P),   optional, intent(OUT) :: iostat               !< IO error.
        character(*),   optional, intent(OUT) :: iomsg                !< IO error message.
        character(len=:), allocatable         :: loc                  !< Warning location string
        integer(I4P)                          :: iostatd              !< Real IO error.
        integer(I4P)                          :: u                    !< Real unit
        character(500)                        :: iomsgd               !< Real IO error message.          
    !-----------------------------------------------------------------
        u = ERROR_UNIT; if(present(unit)) u = unit; iostatd = 0 ; iomsgd = ''; loc=''
        if(present(file) .and. present(line)) &
            loc='('//file//':'//trim(str(no_sign=.true.,n=line))//') '
        call this%Print('WARNING! '//trim(adjustl(loc//txt)), unit=u, iostat=iostatd, iomsg=iomsgd)
        if (present(iostat)) iostat = iostatd
        if (present(iomsg))  iomsg  = iomsgd
    end subroutine


    subroutine MessageHandler_Error(this, txt, unit, file, line, iostat, iomsg)
    !-----------------------------------------------------------------
    !< Print a txt message preceding for ERROR!
    !-----------------------------------------------------------------
        class(MessageHandler_t),  intent(IN)  :: this                 !< Message handler
        character(len=*),         intent(IN)  :: txt                  !< Text to print
        integer(I4P),   optional, intent(IN)  :: unit                 !< Unit where to print
        character(*),   optional, intent(IN)  :: file                 !< Source file
        integer(I4P),   optional, intent(IN)  :: line                 !< Number of line in source file
        integer(I4P),   optional, intent(OUT) :: iostat               !< IO error.
        character(*),   optional, intent(OUT) :: iomsg                !< IO error message.
        character(len=:), allocatable         :: loc                  !< Error location string
        integer(I4P)                          :: iostatd              !< Real IO error.
        integer(I4P)                          :: u                    !< Real unit
        character(500)                        :: iomsgd               !< Real IO error message.          
    !-----------------------------------------------------------------
        u = ERROR_UNIT; if(present(unit)) u = unit; iostatd = 0 ; iomsgd = ''
        loc = ''
        if(present(file) .and. present(line)) &
            loc='('//file//':'//trim(str(no_sign=.true.,n=line))//') '
        call this%Print('ERROR! '//trim(adjustl(loc//txt)), unit=u, iostat=iostatd, iomsg=iomsgd)
        if (present(iostat)) iostat = iostatd
        if (present(iomsg))  iomsg  = iomsgd
    end subroutine


end module
