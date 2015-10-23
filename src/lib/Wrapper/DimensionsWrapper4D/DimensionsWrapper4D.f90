module DimensionsWrapper4D

USE DimensionsWrapper

implicit none
private

    type, extends(DimensionsWrapper_t), abstract :: DimensionsWrapper4D_t
    private
    contains
        procedure(DimensionsWrapper4D_Set),            deferred :: Set
        procedure(DimensionsWrapper4D_Get),            deferred :: Get
        procedure(DimensionsWrapper4D_GetPolymorphic), deferred :: GetPolymorphic
    end type

    abstract interface
        subroutine DimensionsWrapper4D_Set(this, Value)
            import DimensionsWrapper4D_t
            class(DimensionsWrapper4D_t), intent(INOUT) :: this
            class(*),                     intent(IN)    :: Value(:,:,:,:)
        end subroutine

        subroutine DimensionsWrapper4D_Get(this, Value)
            import DimensionsWrapper4D_t
            class(DimensionsWrapper4D_t), intent(IN)    :: this
            class(*),                     intent(INOUT) :: Value(:,:,:,:)
        end subroutine

        subroutine DimensionsWrapper4D_GetPolymorphic(this, Value)
            import DimensionsWrapper4D_t
            class(DimensionsWrapper4D_t), intent(IN)    :: this
            class(*), allocatable,        intent(OUT) :: Value(:,:,:,:)
        end subroutine
    end interface

public :: DimensionsWrapper4D_t

end module DimensionsWrapper4D
