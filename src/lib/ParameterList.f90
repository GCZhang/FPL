!-----------------------------------------------------------------
! FPL (Fortran Parameter List)
! Copyright (c) 2015 Santiago Badia, Alberto F. Martín, 
! Javier Principe and Víctor Sande.
! All rights reserved.
!
! This library is free software; you can redistribute it and/or
! modify it under the terms of the GNU Lesser General Public
! License as published by the Free Software Foundation; either
! version 3.0 of the License, or (at your option) any later version.
!
! This library is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
! Lesser General Public License for more details.
!
! You should have received a copy of the GNU Lesser General Public
! License along with this library.
!-----------------------------------------------------------------

module ParameterList

USE iso_fortran_env, only: OUTPUT_UNIT
USE ErrorMessages
USE IR_Precision
USE ParameterEntryDictionary
USE ParameterRootEntry
USE ParameterEntry
USE WrapperFactoryListSingleton
USE WrapperFactory
USE DimensionsWrapper
USE DimensionsWrapper0D
USE DimensionsWrapper1D
USE DimensionsWrapper2D
USE DimensionsWrapper3D
USE DimensionsWrapper4D
USE DimensionsWrapper5D
USE DimensionsWrapper6D
USE DimensionsWrapper7D
USE ListIterator

implicit none
private
save

    type :: ParameterList_t
    private
        type(ParameterEntryDictionary_t) :: Dictionary
    contains
    private
        procedure, non_overridable         ::                   ParameterList_Set0D
        procedure, non_overridable         ::                   ParameterList_Set1D
        procedure, non_overridable         ::                   ParameterList_Set2D
        procedure, non_overridable         ::                   ParameterList_Set3D
        procedure, non_overridable         ::                   ParameterList_Set4D
        procedure, non_overridable         ::                   ParameterList_Set5D
        procedure, non_overridable         ::                   ParameterList_Set6D
        procedure, non_overridable         ::                   ParameterList_Set7D
        procedure, non_overridable         ::                   ParameterList_Get0D
        procedure, non_overridable         ::                   ParameterList_Get1D
        procedure, non_overridable         ::                   ParameterList_Get2D
        procedure, non_overridable         ::                   ParameterList_Get3D
        procedure, non_overridable         ::                   ParameterList_Get4D
        procedure, non_overridable         ::                   ParameterList_Get5D
        procedure, non_overridable         ::                   ParameterList_Get6D
        procedure, non_overridable         ::                   ParameterList_Get7D
        procedure, non_overridable         ::                   ParameterList_GetPointer0D
        procedure, non_overridable         ::                   ParameterList_GetPointer1D
        procedure, non_overridable         ::                   ParameterList_GetPointer2D
        procedure, non_overridable         ::                   ParameterList_GetPointer3D
        procedure, non_overridable         ::                   ParameterList_GetPointer4D
        procedure, non_overridable         ::                   ParameterList_GetPointer5D
        procedure, non_overridable         ::                   ParameterList_GetPointer6D
        procedure, non_overridable         ::                   ParameterList_GetPointer7D
        procedure, non_overridable         ::                   ParameterList_IsOfDataType0D
        procedure, non_overridable         ::                   ParameterList_IsOfDataType1D
        procedure, non_overridable         ::                   ParameterList_IsOfDataType2D
        procedure, non_overridable         ::                   ParameterList_IsOfDataType3D
        procedure, non_overridable         ::                   ParameterList_IsOfDataType4D
        procedure, non_overridable         ::                   ParameterList_IsOfDataType5D
        procedure, non_overridable         ::                   ParameterList_IsOfDataType6D
        procedure, non_overridable         ::                   ParameterList_IsOfDataType7D
        generic,   public :: Set            => ParameterList_Set0D, &
                                               ParameterList_Set1D, &
                                               ParameterList_Set2D, &
                                               ParameterList_Set3D, &
                                               ParameterList_Set4D, &
                                               ParameterList_Set5D, &
                                               ParameterList_Set6D, &
                                               ParameterList_Set7D
        generic,   public :: Get            => ParameterList_Get0D, &
                                               ParameterList_Get1D, &
                                               ParameterList_Get2D, &
                                               ParameterList_Get3D, &
                                               ParameterList_Get4D, &
                                               ParameterList_Get5D, &
                                               ParameterList_Get6D, &
                                               ParameterList_Get7D
        generic,   public :: GetPointer     => ParameterList_GetPointer0D, &
                                               ParameterList_GetPointer1D, &
                                               ParameterList_GetPointer2D, &
                                               ParameterList_GetPointer3D, &
                                               ParameterList_GetPointer4D, &
                                               ParameterList_GetPointer5D, &
                                               ParameterList_GetPointer6D, &
                                               ParameterList_GetPointer7D
        generic,   public :: isOfDataType   => ParameterList_IsOfDataType0D, &
                                               ParameterList_IsOfDataType1D, &
                                               ParameterList_IsOfDataType2D, &
                                               ParameterList_IsOfDataType3D, &
                                               ParameterList_IsOfDataType4D, &
                                               ParameterList_IsOfDataType5D, &
                                               ParameterList_IsOfDataType6D, &
                                               ParameterList_IsOfDataType7D
        procedure, non_overridable, public :: DataSizeInBytes=> ParameterList_DataSizeInBytes
        procedure, non_overridable, public :: Del            => ParameterList_RemoveEntry
        procedure, non_overridable, public :: Init           => ParameterList_Init
        procedure, non_overridable, public :: GetShape       => ParameterList_GetShape
        procedure, non_overridable, public :: NewSubList     => ParameterList_NewSubList
        procedure, non_overridable, public :: GetSubList     => ParameterList_GetSubList
        procedure, non_overridable, public :: isPresent      => ParameterList_isPresent
        procedure, non_overridable, public :: isSubList      => ParameterList_isSubList
        procedure, non_overridable, public :: Free           => ParameterList_Free
        procedure, non_overridable, public :: Print          => ParameterList_Print
        procedure, non_overridable, public :: Length         => ParameterList_Length
        procedure, non_overridable, public :: GetIterator    => ParameterList_GetIterator
        final             ::                   ParameterList_Finalize
    end type ParameterList_t


    type :: ParameterListIterator_t
    private
        type(ParameterRootEntry_t), pointer :: DataBase(:)  => NULL()
        type(ListIterator_t),       pointer :: ListIterator => NULL()
        integer(I4P)                        :: Index       = 0
        integer(I4P)                        :: UpperBound  = 0
    contains
    private
        procedure,         non_overridable ::                             ParameterListIterator_Get0D
        procedure,         non_overridable ::                             ParameterListIterator_Get1D
        procedure,         non_overridable ::                             ParameterListIterator_Get2D
        procedure,         non_overridable ::                             ParameterListIterator_Get3D
        procedure,         non_overridable ::                             ParameterListIterator_Get4D
        procedure,         non_overridable ::                             ParameterListIterator_Get5D
        procedure,         non_overridable ::                             ParameterListIterator_Get6D
        procedure,         non_overridable ::                             ParameterListIterator_Get7D
        procedure,         non_overridable ::                             ParameterListIterator_isOfDataType0D
        procedure,         non_overridable ::                             ParameterListIterator_isOfDataType1D
        procedure,         non_overridable ::                             ParameterListIterator_isOfDataType2D
        procedure,         non_overridable ::                             ParameterListIterator_isOfDataType3D
        procedure,         non_overridable ::                             ParameterListIterator_isOfDataType4D
        procedure,         non_overridable ::                             ParameterListIterator_isOfDataType5D
        procedure,         non_overridable ::                             ParameterListIterator_isOfDataType6D
        procedure,         non_overridable ::                             ParameterListIterator_isOfDataType7D
        procedure,         non_overridable :: GetEntry                 => ParameterListIterator_GetEntry
        procedure,         non_overridable :: GetIndex                 => ParameterListIterator_GetIndex
        procedure,         non_overridable :: GetKey                   => ParameterListIterator_GetKey
        procedure,         non_overridable :: PointToValue             => ParameterListIterator_PointToValue
        procedure,         non_overridable :: NextNotEmptyListIterator => ParameterListIterator_NextNotEmptyListIterator
        procedure, public, non_overridable :: Init                     => ParameterListIterator_Init
        procedure, public, non_overridable :: Next                     => ParameterListIterator_Next
        procedure, public, non_overridable :: HasFinished              => ParameterListIterator_HasFinished
        procedure, public, non_overridable :: GetShape                 => ParameterListIterator_GetShape
        procedure, public, non_overridable :: DataSizeInBytes          => ParameterListIterator_DataSizeInBytes
        procedure, public, non_overridable :: GetSubList               => ParameterListIterator_GetSubList
        procedure, public, non_overridable :: isSubList                => ParameterListIterator_isSubList
        procedure, public, non_overridable :: Print                    => ParameterListIterator_Print
        procedure, public, non_overridable :: Free                     => ParameterListIterator_Free
        generic,   public                  :: Get                      => ParameterListIterator_Get0D, &
                                                                          ParameterListIterator_Get1D, &
                                                                          ParameterListIterator_Get2D, &
                                                                          ParameterListIterator_Get3D, &
                                                                          ParameterListIterator_Get4D, &
                                                                          ParameterListIterator_Get5D, &
                                                                          ParameterListIterator_Get6D, &
                                                                          ParameterListIterator_Get7D
        generic,   public                  :: isOfDataType             => ParameterListIterator_IsOfDataType0D, &
                                                                          ParameterListIterator_IsOfDataType1D, &
                                                                          ParameterListIterator_IsOfDataType2D, &
                                                                          ParameterListIterator_IsOfDataType3D, &
                                                                          ParameterListIterator_IsOfDataType4D, &
                                                                          ParameterListIterator_IsOfDataType5D, &
                                                                          ParameterListIterator_IsOfDataType6D, &
                                                                          ParameterListIterator_IsOfDataType7D
        final                              ::                             ParameterListIterator_Final
    end type

public :: ParameterList_t
public :: ParameterListIterator_t

contains

!---------------------------------------------------------------------
!< Parameter List Procedures
!---------------------------------------------------------------------

    subroutine ParameterList_Init(this,Size)
    !-----------------------------------------------------------------
    !< Initialize the dictionary
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(INOUT) :: this   !< Parameter List 
        integer(I4P), optional,               intent(IN)    :: Size   !< Dictionary Size
    !-----------------------------------------------------------------
        call this%Free()
        if (present(Size)) then
            call this%Dictionary%Init(Size = Size)
        else
            call this%Dictionary%Init()
        endif
    end subroutine ParameterList_Init


    function ParameterList_GetShape(this,Key, Shape) result(FPLError)
    !-----------------------------------------------------------------
    !< Return an allocatable array with the shape of the contained value
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        integer(I4P), allocatable,            intent(INOUT) :: Shape(:)       !< Shape of the stored value
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper_t)
                    call Wrapper%GetShape(Shape)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Unknown Wrapper. Shape was not modified.', &
                           file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Shape was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_GetShape


    subroutine ParameterList_Free(this)
    !-----------------------------------------------------------------
    !< Free the dictionary
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(INOUT) :: this   !< Parameter List 
    !-----------------------------------------------------------------
        call this%Dictionary%Free()
    end subroutine ParameterList_Free


    subroutine ParameterList_Finalize(this)
    !-----------------------------------------------------------------
    !< Destructor procedure
    !-----------------------------------------------------------------
        type(ParameterList_t),               intent(INOUT) :: this    !< Parameter List
    !-----------------------------------------------------------------
        call this%Free()
    end subroutine ParameterList_Finalize


    function ParameterList_NewSubList(this,Key, Size) result(SubListPointer)
    !-----------------------------------------------------------------
    !< Set a Key/Value pair into the dictionary
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(INOUT) :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        integer(I4P), optional,               intent(IN)    :: Size           !< Sublist Size
        class(*),                             pointer       :: Sublist        !< New Sublist
        class(ParameterList_t),               pointer       :: SublistPointer !< New Sublist pointer
    !-----------------------------------------------------------------
        allocate(ParameterList_t :: SubList)
        call this%Dictionary%Set(Key=Key,Value=Sublist)
        select type(SubList)
            class is (ParameterList_t)
                SublistPointer => SubList
                if(present(Size)) then
                    call Sublist%Init(Size=Size)
                else
                    call Sublist%Init(Size=Size)
                endif
        end select
    end function ParameterList_NewSubList


    function ParameterList_GetSublist(this,Key, Sublist) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a Unlimited polymorphic pointer to a Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this    !< Parameter List
        character(len=*),                     intent(IN)    :: Key     !< String Key
        class(ParameterList_t),      pointer, intent(INOUT) :: Sublist !< Wrapper
        class(*),                    pointer                :: Value   !< Returned pointer to value
        integer(I4P)                                        :: FPLerror!< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Value)
        call this%Dictionary%GetPointer(Key=Key, Value=Value)
        if(associated(Value)) then
            select type(Value)
                class is (ParameterList_t)
                    SubList => Value
                class Default
                    FPLerror = FPLSublistError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Is not a sublist.', &
                           file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLSublistError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_GetSubList


    function ParameterList_Set0D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Set a Key/Value pair into the Dictionary
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(INOUT) :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        class(*),                             intent(IN)    :: Value          !< Unlimited polymorphic Value
        class(WrapperFactory_t),    pointer                 :: WrapperFactory !< WrapperFactory
        class(*),                   pointer                 :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(WrapperFactory)
        nullify(Wrapper)
        WrapperFactory => TheWrapperFactoryList%GetFactory(Value=Value)
        if(associated(WrapperFactory)) then
            Wrapper => WrapperFactory%Wrap(Value=Value)
            if(associated(Wrapper)) then
                call this%Dictionary%Set(Key=Key,Value=Wrapper)
            else
                FPLerror = FPLWrapperError
                call msg%Error(txt='Setting [Key="'//Key//'"]: Nonexistent wrapper. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
            endif
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Setting [Key="'//Key//'"]: Unsupported data type. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Set0D


    function ParameterList_Set1D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Set a Key/Value pair into the DataBase
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(INOUT) :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        class(*),                             intent(IN)    :: Value(:)       !< Unlimited polymorphic 1D array Value
        class(WrapperFactory_t),    pointer                 :: WrapperFactory !< WrapperFactory
        class(*),                   pointer                 :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(WrapperFactory)
        nullify(Wrapper)
        WrapperFactory => TheWrapperFactoryList%GetFactory(Value=Value)
        if(associated(WrapperFactory)) then
            Wrapper => WrapperFactory%Wrap(Value=Value)
            if(associated(Wrapper)) then
                call this%Dictionary%Set(Key=Key,Value=Wrapper)
            else
                FPLerror = FPLWrapperError
                call msg%Error(txt='Setting [Key="'//Key//'"]: Nonexistent wrapper. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
            endif
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Setting [Key="'//Key//'"]: Unsupported data type. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Set1D


    function ParameterList_Set2D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Set a Key/Value pair into the DataBase
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(INOUT) :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        class(*),                             intent(IN)    :: Value(:,:)     !< Unlimited polymorphic 2D array value
        class(WrapperFactory_t),    pointer                 :: WrapperFactory !< WrapperFactory
        class(*),                   pointer                 :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(WrapperFactory)
        nullify(Wrapper)
        WrapperFactory => TheWrapperFactoryList%GetFactory(Value=Value)
        if(associated(WrapperFactory)) then
            Wrapper => WrapperFactory%Wrap(Value=Value)
            if(associated(Wrapper)) then
                call this%Dictionary%Set(Key=Key,Value=Wrapper)
            else
                FPLerror = FPLWrapperError
                call msg%Error(txt='Setting [Key="'//Key//'"]: Nonexistent wrapper. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
            endif
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Setting [Key="'//Key//'"]: Unsupported data type. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Set2D


    function ParameterList_Set3D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Set a Key/Value pair into the DataBase
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(INOUT) :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        class(*),                             intent(IN)    :: Value(:,:,:)   !< Unlimited Polimorphic 3D array Value
        class(WrapperFactory_t),    pointer                 :: WrapperFactory !< WrapperFactory
        class(*),                   pointer                 :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(WrapperFactory)
        nullify(Wrapper)
        WrapperFactory => TheWrapperFactoryList%GetFactory(Value=Value)
        if(associated(WrapperFactory)) then
            Wrapper => WrapperFactory%Wrap(Value=Value)
            if(associated(Wrapper)) then
                call this%Dictionary%Set(Key=Key,Value=Wrapper)
            else
                FPLerror = FPLWrapperError
                call msg%Error(txt='Setting [Key="'//Key//'"]: Nonexistent wrapper. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
            endif
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Setting [Key="'//Key//'"]: Unsupported data type. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Set3D


    function ParameterList_Set4D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Set a Key/Value pair into the DataBase
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(INOUT) :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        class(*),                             intent(IN)    :: Value(:,:,:,:) !< Unlimited Polymorphic 4D array Value
        class(WrapperFactory_t),    pointer                 :: WrapperFactory !< WrapperFactory
        class(*),                   pointer                 :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(WrapperFactory)
        nullify(Wrapper)
        WrapperFactory => TheWrapperFactoryList%GetFactory(Value=Value)
        if(associated(WrapperFactory)) then
            Wrapper => WrapperFactory%Wrap(Value=Value)
            if(associated(Wrapper)) then
                call this%Dictionary%Set(Key=Key,Value=Wrapper)
            else
                FPLerror = FPLWrapperError
                call msg%Error(txt='Setting [Key="'//Key//'"]: Nonexistent wrapper. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
            endif
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Setting [Key="'//Key//'"]: Unsupported data type. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Set4D


    function ParameterList_Set5D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Set a Key/Value pair into the DataBase
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(INOUT) :: this             !< Parameter List
        character(len=*),                     intent(IN)    :: Key              !< String Key
        class(*),                             intent(IN)    :: Value(:,:,:,:,:) !< Unlimited Polymorphic 5D array Value
        class(WrapperFactory_t),    pointer                 :: WrapperFactory   !< WrapperFactory
        class(*),                   pointer                 :: Wrapper          !< Wrapper
        integer(I4P)                                        :: FPLerror         !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(WrapperFactory)
        nullify(Wrapper)
        WrapperFactory => TheWrapperFactoryList%GetFactory(Value=Value)
        if(associated(WrapperFactory)) then
            Wrapper => WrapperFactory%Wrap(Value=Value)
            if(associated(Wrapper)) then
                call this%Dictionary%Set(Key=Key,Value=Wrapper)
            else
                FPLerror = FPLWrapperError
                call msg%Error(txt='Setting [Key="'//Key//'"]: Nonexistent wrapper. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
            endif
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Setting [Key="'//Key//'"]: Unsupported data type. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Set5D


    function ParameterList_Set6D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Set a Key/Value pair into the DataBase
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(INOUT) :: this               !< Parameter List
        character(len=*),                     intent(IN)    :: Key                !< String Key
        class(*),                             intent(IN)    :: Value(:,:,:,:,:,:) !< Unlimited Polymorphic 5D array Value
        class(WrapperFactory_t),    pointer                 :: WrapperFactory     !< WrapperFactory
        class(*),                   pointer                 :: Wrapper            !< Wrapper
        integer(I4P)                                        :: FPLerror           !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(WrapperFactory)
        nullify(Wrapper)
        WrapperFactory => TheWrapperFactoryList%GetFactory(Value=Value)
        if(associated(WrapperFactory)) then
            Wrapper => WrapperFactory%Wrap(Value=Value)
            if(associated(Wrapper)) then
                call this%Dictionary%Set(Key=Key,Value=Wrapper)
            else
                FPLerror = FPLWrapperError
                call msg%Error(txt='Setting [Key="'//Key//'"]: Nonexistent wrapper. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
            endif
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Setting [Key="'//Key//'"]: Unsupported data type. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Set6D


    function ParameterList_Set7D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Set a Key/Value pair into the DataBase
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(INOUT) :: this                 !< Parameter List
        character(len=*),                     intent(IN)    :: Key                  !< String Key
        class(*),                             intent(IN)    :: Value(:,:,:,:,:,:,:) !< Unlimited Polymorphic 7D array Value
        class(WrapperFactory_t),    pointer                 :: WrapperFactory       !< WrapperFactory
        class(*),                   pointer                 :: Wrapper              !< Wrapper
        integer(I4P)                                        :: FPLerror             !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(WrapperFactory)
        nullify(Wrapper)
        WrapperFactory => TheWrapperFactoryList%GetFactory(Value=Value)
        if(associated(WrapperFactory)) then
            Wrapper => WrapperFactory%Wrap(Value=Value)
            if(associated(Wrapper)) then
                call this%Dictionary%Set(Key=Key,Value=Wrapper)
            else
                FPLerror = FPLWrapperError
                call msg%Error(txt='Setting [Key="'//Key//'"]: Nonexistent wrapper. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
            endif
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Setting [Key="'//Key//'"]: Unsupported data type. Not added to the list.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Set7D


    function ParameterList_Get0D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a scalar Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        class(*),                             intent(INOUT) :: Value          !< Returned value
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper0D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Get0D


    function ParameterList_Get1D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a vector Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        class(*),                             intent(INOUT) :: Value(:)       !< Returned value
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper1D_t)
                call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Get1D


    function ParameterList_Get2D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a 2D array Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        class(*),                             intent(INOUT) :: Value(:,:)     !< Returned value
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper2D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Get2D


    function ParameterList_Get3D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a 3D array Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        class(*),                             intent(INOUT) :: Value(:,:,:)   !< Returned value
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper3D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Get3D


    function ParameterList_Get4D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a 4D array Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        class(*),                             intent(INOUT) :: Value(:,:,:,:) !< Returned value
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper4D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Get4D


    function ParameterList_Get5D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a 5D array Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this             !< Parameter List
        character(len=*),                     intent(IN)    :: Key              !< String Key
        class(*),                             intent(INOUT) :: Value(:,:,:,:,:) !< Returned value
        class(*), pointer                                   :: Node             !< Pointer to a Parameter List
        class(*),                    pointer                :: Wrapper          !< Wrapper
        integer(I4P)                                        :: FPLerror         !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper5D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Get5D


    function ParameterList_Get6D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a 6D array Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this               !< Parameter List
        character(len=*),                     intent(IN)    :: Key                !< String Key
        class(*),                             intent(INOUT) :: Value(:,:,:,:,:,:) !< Returned value
        class(*),                    pointer                :: Wrapper            !< Wrapper
        integer(I4P)                                        :: FPLerror           !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper6D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Get6D


    function ParameterList_Get7D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a 7D array Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this                 !< Parameter List
        character(len=*),                     intent(IN)    :: Key                  !< String Key
        class(*),                             intent(INOUT) :: Value(:,:,:,:,:,:,:) !< Returned value
        class(*),                    pointer                :: Wrapper              !< Wrapper
        integer(I4P)                                        :: FPLerror             !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper7D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_Get7D


    function ParameterList_GetPointer0D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a Unlimited polymorphic pointer to a Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this    !< Parameter List
        character(len=*),                     intent(IN)    :: Key     !< String Key
        class(*), pointer,                    intent(INOUT) :: Value   !< Returned pointer to value
        class(*),                    pointer                :: Wrapper !< Wrapper
        integer(I4P)                                        :: FPLerror!< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper0D_t)
                    Value => Wrapper%GetPointer()
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_GetPointer0D


    function ParameterList_GetPointer1D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a Unlimited polymorphic pointer to a Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this     !< Parameter List
        character(len=*),                     intent(IN)    :: Key      !< String Key
        class(*), pointer,                    intent(INOUT) :: Value(:) !< Returned pointer to value
        class(*),                    pointer                :: Wrapper  !< Wrapper
        integer(I4P)                                        :: FPLerror !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper1D_t)
                    Value => Wrapper%GetPointer()
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_GetPointer1D


    function ParameterList_GetPointer2D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a Unlimited polymorphic pointer to a Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this       !< Parameter List
        character(len=*),                     intent(IN)    :: Key        !< String Key
        class(*), pointer,                    intent(INOUT) :: Value(:,:) !< Returned pointer to value
        class(*),                    pointer                :: Wrapper    !< Wrapper
        integer(I4P)                                        :: FPLerror   !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper2D_t)
                    Value => Wrapper%GetPointer()
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_GetPointer2D


    function ParameterList_GetPointer3D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a Unlimited polymorphic pointer to a Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        class(*), pointer,                    intent(INOUT) :: Value(:,:,:)   !< Returned pointer to value
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper3D_t)
                    Value => Wrapper%GetPointer()
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_GetPointer3D


    function ParameterList_GetPointer4D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a Unlimited polymorphic pointer to a Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this           !< Parameter List
        character(len=*),                     intent(IN)    :: Key            !< String Key
        class(*), pointer,                    intent(INOUT) :: Value(:,:,:,:) !< Returned pointer to value
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper4D_t)
                    Value => Wrapper%GetPointer()
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_GetPointer4D


    function ParameterList_GetPointer5D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a Unlimited polymorphic pointer to a Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this             !< Parameter List
        character(len=*),                     intent(IN)    :: Key              !< String Key
        class(*), pointer,                    intent(INOUT) :: Value(:,:,:,:,:) !< Returned pointer to value
        class(*),                    pointer                :: Wrapper          !< Wrapper
        integer(I4P)                                        :: FPLerror         !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper5D_t)
                    Value => Wrapper%GetPointer()
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_GetPointer5D


    function ParameterList_GetPointer6D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a Unlimited polymorphic pointer to a Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this               !< Parameter List
        character(len=*),                     intent(IN)    :: Key                !< String Key
        class(*), pointer,                    intent(INOUT) :: Value(:,:,:,:,:,:) !< Returned pointer to value
        class(*),                    pointer                :: Wrapper            !< Wrapper
        integer(I4P)                                        :: FPLerror           !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper6D_t)
                    Value => Wrapper%GetPointer()
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_GetPointer6D


    function ParameterList_GetPointer7D(this,Key,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a Unlimited polymorphic pointer to a Value given the Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)    :: this                 !< Parameter List
        character(len=*),                     intent(IN)    :: Key                  !< String Key
        class(*), pointer,                    intent(INOUT) :: Value(:,:,:,:,:,:,:) !< Returned pointer to value
        class(*),                    pointer                :: Wrapper              !< Wrapper
        integer(I4P)                                        :: FPLerror             !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper7D_t)
                    Value => Wrapper%GetPointer()
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//Key//'"]: Dimensions do not match. Value was not modified.', &
                               file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//Key//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterList_GetPointer7D


    function ParameterList_isPresent(this,Key) result(isPresent)
    !-----------------------------------------------------------------
    !< Check if a Key is present at the DataBase
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN) :: this      !< Parameter List
        character(len=*),                     intent(IN) :: Key       !< String Key
        logical                                          :: isPresent !< Boolean flag to check if a Key is present
    !-----------------------------------------------------------------
        isPresent = this%Dictionary%IsPresent(Key=Key)
    end function ParameterList_isPresent


    function ParameterList_isSubList(this,Key) result(isSubList)
    !-----------------------------------------------------------------
    !< Check if a Key is a SubList
    !-----------------------------------------------------------------
        class(ParameterList_t), intent(IN) :: this                    !< Parameter List
        character(len=*), intent(IN)    :: Key                        !< String Key
        class(*), pointer               :: SubListPointer             !< Pointer to a SubList
        logical                         :: isSubList                  !< Check if is a SubList
    !-----------------------------------------------------------------
        isSubList = .false.
        nullify(SubListPointer)
        call this%Dictionary%GetPointer(Key=Key, Value=SubListPointer)
        if(associated(SubListPointer)) then
            select type (SubListPointer)
                class is (ParameterList_t)
                        isSubList =.true.
            end select
        endif
    end function ParameterList_isSubList


    function ParameterList_DataSizeInBytes(this,Key) result(DataSizeInBytes)
    !-----------------------------------------------------------------
    !< Return the data size in bytes of the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterList_t), intent(IN) :: this                    !< Parameter List
        character(len=*), intent(IN)    :: Key                        !< String Key
        class(*), pointer               :: Wrapper                    !< Wrapper
        integer(I4P)                    :: DataSizeInBytes            !< Size in bytes
    !-----------------------------------------------------------------
        DataSizeInBytes = 0
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type (Wrapper)
                class is (DimensionsWrapper_t)
                    DataSizeInBytes = Wrapper%DataSizeInBytes()
            end select
        endif
    end function ParameterList_DataSizeInBytes


    function ParameterList_isOfDataType0D(this,Key, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterList_t), intent(IN) :: this                    !< Parameter List
        character(len=*), intent(IN)    :: Key                        !< String Key
        class(*),         intent(IN)    :: Mold                       !< Mold
        class(*), pointer               :: Wrapper                    !< Wrapper
        logical                         :: isOfDataType               !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.
        nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type (Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold)
                class is (ParameterList_t)
                    select type (Mold)
                        class is (ParameterList_t)
                            isOfDataType = .true.
                    end select
            end select
        endif
    end function ParameterList_isOfDataType0D


    function ParameterList_isOfDataType1D(this,Key, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterList_t), intent(IN) :: this                    !< Parameter List
        character(len=*), intent(IN)    :: Key                        !< String Key
        class(*),         intent(IN)    :: Mold(1:)                   !< Mold
        class(*), pointer               :: Wrapper                    !< Wrapper
        logical                         :: isOfDataType               !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.; nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type (Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1))
            end select
        endif
    end function ParameterList_isOfDataType1D


    function ParameterList_isOfDataType2D(this,Key, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterList_t), intent(IN) :: this                    !< Parameter List
        character(len=*), intent(IN)    :: Key                        !< String Key
        class(*),         intent(IN)    :: Mold(1:,1:)                !< Mold
        class(*), pointer               :: Wrapper                    !< Wrapper
        logical                         :: isOfDataType               !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.; nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type (Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1,1))
            end select
        endif
    end function ParameterList_isOfDataType2D


    function ParameterList_isOfDataType3D(this,Key, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterList_t), intent(IN) :: this                    !< Parameter List
        character(len=*), intent(IN)    :: Key                        !< String Key
        class(*),         intent(IN)    :: Mold(1:,1:,1:)             !< Mold
        class(*), pointer               :: Wrapper                    !< Wrapper
        logical                         :: isOfDataType               !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.; nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        select type (Wrapper)
            class is (DimensionsWrapper_t)
                isOfDataType = Wrapper%isOfDataType(Mold=Mold(1,1,1))
        end select
    end function ParameterList_isOfDataType3D


    function ParameterList_isOfDataType4D(this,Key, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterList_t), intent(IN) :: this                    !< Parameter List
        character(len=*), intent(IN)    :: Key                        !< String Key
        class(*),         intent(IN)    :: Mold(1:,1:,1:,1:)          !< Mold
        class(*), pointer               :: Wrapper                    !< Wrapper
        logical                         :: isOfDataType               !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.; nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type (Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1,1,1,1))
            end select
        endif
    end function ParameterList_isOfDataType4D


    function ParameterList_isOfDataType5D(this,Key, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterList_t), intent(IN) :: this                    !< Parameter List
        character(len=*), intent(IN)    :: Key                        !< String Key
        class(*),         intent(IN)    :: Mold(1:,1:,1:,1:,1:)       !< Mold
        class(*),  pointer              :: Wrapper                    !< Wrapper
        logical                         :: isOfDataType               !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.; nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type (Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1,1,1,1,1))
            end select
        endif
    end function ParameterList_isOfDataType5D


    function ParameterList_isOfDataType6D(this,Key, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterList_t), intent(IN) :: this                    !< Parameter List
        character(len=*), intent(IN)    :: Key                        !< String Key
        class(*),         intent(IN)    :: Mold(1:,1:,1:,1:,1:,1:)    !< Mold
        class(*), pointer               :: Wrapper                    !< Wrapper
        logical                         :: isOfDataType               !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.; nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type (Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1,1,1,1,1,1))
            end select
        endif
    end function ParameterList_isOfDataType6D


    function ParameterList_isOfDataType7D(this,Key, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterList_t), intent(IN) :: this                    !< Parameter List
        character(len=*), intent(IN)    :: Key                        !< String Key
        class(*),         intent(IN)    :: Mold(1:,1:,1:,1:,1:,1:,1:) !< Mold
        class(*), pointer               :: Wrapper                    !< Wrapper
        logical                         :: isOfDataType               !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.; nullify(Wrapper)
        call this%Dictionary%GetPointer(Key=Key, Value=Wrapper)
        if(associated(Wrapper)) then
            select type (Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1,1,1,1,1,1,1))
            end select
        endif
    end function ParameterList_isOfDataType7D


    subroutine ParameterList_RemoveEntry(this, Key)
    !-----------------------------------------------------------------
    !< Remove an Entry given a Key
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(INOUT) :: this   !< Parameter List 
        character(len=*),                     intent(IN)    :: Key    !< String Key
    !-----------------------------------------------------------------
        call this%Dictionary%Del(Key=Key)
    end subroutine ParameterList_RemoveEntry


    function ParameterList_Length(this) result(Length)
    !-----------------------------------------------------------------
    !< Return the number of ParameterListEntries contained in the DataBase
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN) :: this       !< Parameter List 
        integer(I4P)                                     :: Length     !< Number of parameters in database
    !-----------------------------------------------------------------
        Length = this%Dictionary%Length()
    end function ParameterList_Length


    function ParameterList_GetIterator(this) result(Iterator)
    !-----------------------------------------------------------------
    !< Return a pointer to a Parameters Iterator 
    !-----------------------------------------------------------------
        class(ParameterList_t),     intent(IN) :: this                !< Parameter List Entry Container Type
        type(ParameterListIterator_t), pointer :: Iterator            !< Parameter List iterator
    !-----------------------------------------------------------------
        nullify(iterator)
        allocate(Iterator)
        call Iterator%Init(DataBase=this%Dictionary%GetDataBase())
    end function ParameterList_GetIterator


    recursive subroutine ParameterList_Print(this, unit, prefix, iostat, iomsg)
    !-----------------------------------------------------------------
    !< Print the content of the DataBase
    !-----------------------------------------------------------------
        class(ParameterList_t),               intent(IN)  :: this    !< Linked List
        integer(I4P), optional,               intent(IN)  :: unit    !< Logic unit.
        character(*), optional,               intent(IN)  :: prefix  !< Prefixing string.
        integer(I4P), optional,               intent(OUT) :: iostat  !< IO error.
        character(*), optional,               intent(OUT) :: iomsg   !< IO error message.
        character(len=:), allocatable                     :: prefd   !< Prefixing string.
        integer(I4P)                                      :: unitd   !< Logic unit.
        integer(I4P)                                      :: iostatd !< IO error.
        character(500)                                    :: iomsgd  !< Temporary variable for IO error message.
        type(ParameterListIterator_t), pointer            :: Iterator!< Dictionary Iterator
        class(*), pointer                                 :: Value
    !-----------------------------------------------------------------
        prefd = '' ; if (present(prefix)) prefd = prefix
        unitd = OUTPUT_UNIT; if(present(unit)) unitd = unit
        Nullify(Iterator)
        Iterator => this%GetIterator()
        if(associated(Iterator)) then
            do while(.not. Iterator%HasFinished())
                Nullify(Value)
                Value => Iterator%PointToValue()
                if(associated(Value)) then 
                    select type(Value)
                        class is (DimensionsWrapper_t) 
                            call Value%Print(unit=unitd,                                                  &
                                             prefix=prefd//                                               &
                                             '['//trim(str(no_sign=.true., n=Iterator%GetIndex()))//']'// &
                                             ' Key = '//Iterator%GetKey()//',',                           &
                                             iostat=iostatd,                                              &
                                             iomsg=iomsgd)
                        type is (ParameterList_t) 
                            write(unit=unitd, fmt='(A)') prefd//                                                      &
                                                         '['//trim(str(no_sign=.true., n=Iterator%GetIndex()))//']'// &
                                                         ' Key = '//Iterator%GetKey()//', Data Type = ParameterList'
                            call Value%Print(unit=unitd, prefix=prefd//'['//trim(str(no_sign=.true., n=Iterator%GetIndex()))//'] ', iostat=iostatd, iomsg=iomsgd)
                        class DEFAULT
                            write(unit=unitd, fmt='(A)') prefd//                                                      &
                                                         '['//trim(str(no_sign=.true., n=Iterator%GetIndex()))//']'// &
                                                         ' Key = '//Iterator%GetKey()//', Data Type = Unknown Data Type!'
                    end select
                endif
                call Iterator%Next()
            enddo
            call Iterator%Free()
            deallocate(Iterator)
        endif
        if (present(iostat)) iostat = iostatd
        if (present(iomsg))  iomsg  = iomsgd
    end subroutine ParameterList_Print


!---------------------------------------------------------------------
!< Parameter List Iterator Procedures
!---------------------------------------------------------------------

    subroutine ParameterListIterator_Free(this)
    !-----------------------------------------------------------------
    !< Free the dictionary iterator
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(INOUT) :: this         ! Dictionary iterator
    !-----------------------------------------------------------------
        this%Index      = 0
        this%UpperBound = 0
        nullify(this%DataBase)
        if(associated(this%ListIterator)) deallocate(this%ListIterator)
        nullify(this%ListIterator)
    end subroutine ParameterListIterator_Free


    subroutine ParameterListIterator_Final(this)
    !-----------------------------------------------------------------
    !< Free the dictionary iterator
    !-----------------------------------------------------------------
        type(ParameterListIterator_t), intent(INOUT) :: this          ! Dictionary iterator
    !-----------------------------------------------------------------
        call this%Free()
    end subroutine ParameterListIterator_Final


    subroutine ParameterListIterator_Init(this, DataBase)
    !-----------------------------------------------------------------
    !< Associate the iterator with a dictionary and rewind 
    !< to the first position
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),     intent(INOUT) :: this        ! Dictionary iterator
        type(ParameterRootEntry_t), target, intent(IN)    :: DataBase(:) ! Entries database
    !-----------------------------------------------------------------
        call this%Free()
        this%DataBase(0:) => DataBase(:)
        this%Index = 0
        this%UpperBound = size(this%DataBase)
        call this%Next()
    end subroutine ParameterListIterator_Init


    subroutine ParameterListIterator_NextNotEmptyListIterator(this)
    !-----------------------------------------------------------------
    !< The iterator points to the next associated entry
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),  intent(INOUT) :: this        ! Dictionary iterator
    !-----------------------------------------------------------------
        if(associated(this%ListIterator)) then
            call this%ListIterator%Free()
            deallocate(this%ListIterator)
            this%Index = this%Index + 1
        endif
        do while(this%Index < this%UpperBound)
            if(this%DataBase(this%Index)%HasRoot()) then 
                this%ListIterator => this%Database(this%Index)%GetIterator()
                exit
            endif
            this%Index = this%Index + 1
        enddo
    end subroutine ParameterListIterator_NextNotEmptyListIterator


    subroutine ParameterListIterator_Next(this)
    !-----------------------------------------------------------------
    !< The iterator points to the next associated entry
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),  intent(INOUT) :: this        ! Dictionary iterator
    !-----------------------------------------------------------------
        if(.not. this%HasFinished()) then
            if(associated(this%ListIterator)) then
                if(.not. this%ListIterator%HasFinished()) then
                    call this%ListIterator%Next()
                else
                    call this%NextNotEmptyListIterator()
                endif
            else ! First Entry
                call this%NextNotEmptyListIterator()
            endif 
        endif
    end subroutine ParameterListIterator_Next


    function ParameterListIterator_GetEntry(this) result(CurrentEntry)
    !-----------------------------------------------------------------
    !< Return the current Entry
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this            ! Dictionary iterator
        type(ParameterEntry_t),  pointer           :: CurrentEntry    ! Current entry
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        nullify(CurrentEntry)
        if(associated(this%ListIterator)) then
            CurrentEntry => this%ListIterator%GetEntry()
        else
            FPLerror = FPLParameterListIteratorError
            call msg%Error(txt='Current entry not associated. Shape was not modified.', &
                           file=__FILE__, line=__LINE__ )   
        endif
    end function ParameterListIterator_GetEntry


    function ParameterListIterator_PointToValue(this) result(Value)
    !-----------------------------------------------------------------
    !< Return a pointer to the value stored in the current Entry
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this            ! Dictionary iterator
        class(*), pointer                          :: Value           ! Unlimited polymorphic pointer
        type(ParameterEntry_t),  pointer           :: CurrentEntry    ! Current entry
    !-----------------------------------------------------------------
        nullify(CurrentEntry)
        nullify(Value)
        CurrentEntry => this%GetEntry()
        if(associated(CurrentEntry)) Value => CurrentEntry%PointToValue()
    end function ParameterListIterator_PointToValue


    function ParameterListIterator_GetKey(this) result(Key)
    !-----------------------------------------------------------------
    !< Return the Key of the current Entry
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this            ! Dictionary iterator
        character(len=:), allocatable              :: Key             ! Key
        type(ParameterEntry_t),  pointer           :: CurrentEntry    ! Current entry
    !-----------------------------------------------------------------
        nullify(CurrentEntry)
        CurrentEntry => this%GetEntry()
        if(associated(CurrentEntry)) Key = CurrentEntry%GetKey()
    end function ParameterListIterator_GetKey


    function ParameterListIterator_GetIndex(this) result(CurrentIndex)
    !-----------------------------------------------------------------
    !< Return the current Index
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this            ! Dictionary iterator
        integer(I4P)                               :: CurrentIndex    ! Current index
    !-----------------------------------------------------------------
        CurrentIndex = this%Index
    end function ParameterListIterator_GetIndex


    function ParameterListIterator_GetShape(this, Shape) result(FPLError)
    !-----------------------------------------------------------------
    !< Return an allocatable array with the shape of the contained value
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),       intent(IN)    :: this     !< Parameter List Iterator
        integer(I4P), allocatable,            intent(INOUT) :: Shape(:) !< Shape of the stored value
        class(*),                    pointer                :: Wrapper  !< Wrapper
        integer(I4P)                                        :: FPLerror !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper_t)
                    call Wrapper%GetShape(Shape)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Unknown Wrapper. Shape was not modified.', &
                                   file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Not present. Shape was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif         
    end function ParameterListIterator_GetShape


    function ParameterListIterator_Get0D(this,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a scalar Value given the Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),       intent(IN)    :: this           !< Parameter List Iterator
        class(*),                             intent(INOUT) :: Value          !< Returned value
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper0D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Dimensions do not match. Value was not modified.', &
                                   file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterListIterator_Get0D


    function ParameterListIterator_Get1D(this,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a vector Value given the Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),       intent(IN)    :: this           !< Parameter List Iterator
        class(*),                             intent(INOUT) :: Value(:)       !< Returned value
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper1D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Dimensions do not match. Value was not modified.', &
                                   file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterListIterator_Get1D


    function ParameterListIterator_Get2D(this,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return an array Value given the Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),       intent(IN)    :: this           !< Parameter List Iterator
        class(*),                             intent(INOUT) :: Value(:,:)     !< Returned value
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper2D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Dimensions do not match. Value was not modified.', &
                                   file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterListIterator_Get2D


    function ParameterListIterator_Get3D(this,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return an array Value given the Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),       intent(IN)    :: this           !< Parameter List Iterator
        class(*),                             intent(INOUT) :: Value(:,:,:)   !< Returned value
        type(ParameterEntry_t),      pointer                :: CurrentEntry   !< Current entry
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper3D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Dimensions do not match. Value was not modified.', &
                                   file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterListIterator_Get3D


    function ParameterListIterator_Get4D(this,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return an array Value given the Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),       intent(IN)    :: this           !< Parameter List Iterator
        class(*),                             intent(INOUT) :: Value(:,:,:,:) !< Returned value
        class(*),                    pointer                :: Wrapper        !< Wrapper
        integer(I4P)                                        :: FPLerror       !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper4D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Dimensions do not match. Value was not modified.', &
                                   file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterListIterator_Get4D


    function ParameterListIterator_Get5D(this,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return an array Value given the Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),       intent(IN)    :: this             !< Parameter List Iterator
        class(*),                             intent(INOUT) :: Value(:,:,:,:,:) !< Returned value
        type(ParameterEntry_t),      pointer                :: CurrentEntry     !< Current entry
        class(*),                    pointer                :: Wrapper          !< Wrapper
        integer(I4P)                                        :: FPLerror         !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper5D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Dimensions do not match. Value was not modified.', &
                                   file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterListIterator_Get5D


    function ParameterListIterator_Get6D(this,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return an array Value given the Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),       intent(IN)    :: this               !< Parameter List Iterator
        class(*),                             intent(INOUT) :: Value(:,:,:,:,:,:) !< Returned value
        type(ParameterEntry_t),      pointer                :: CurrentEntry       !< Current entry
        class(*),                    pointer                :: Wrapper            !< Wrapper
        integer(I4P)                                        :: FPLerror           !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper6D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Dimensions do not match. Value was not modified.', &
                                   file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterListIterator_Get6D


    function ParameterListIterator_Get7D(this,Value) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return an array Value given the Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),       intent(IN)    :: this                 !< Parameter List Iterator
        class(*),                             intent(INOUT) :: Value(:,:,:,:,:,:,:) !< Returned value
        type(ParameterEntry_t),      pointer                :: CurrentEntry         !< Current entry
        class(*),                    pointer                :: Wrapper              !< Wrapper
        integer(I4P)                                        :: FPLerror             !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper7D_t)
                    call Wrapper%Get(Value=Value)
                class Default
                    FPLerror = FPLWrapperError
                    call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Dimensions do not match. Value was not modified.', &
                                   file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLWrapperFactoryError
            call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Not present. Value was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterListIterator_Get7D


    function ParameterListIterator_GetSublist(this, Sublist) result(FPLerror)
    !-----------------------------------------------------------------
    !< Return a Unlimited polymorphic pointer to a Value given the Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),  intent(IN)    :: this          !< Parameter List
        class(ParameterList_t), pointer, intent(INOUT) :: Sublist       !< Wrapper
        class(*),               pointer                :: Value         !< Returned pointer to value
        integer(I4P)                                   :: FPLerror      !< Error flag
    !-----------------------------------------------------------------
        FPLerror = FPLSuccess
        nullify(Value)
        nullify(Sublist)
        Value => this%PointToValue()
        if(associated(Value)) then
            select type(Value)
                class is (ParameterList_t)
                    SubList => Value
                class Default
                    FPLerror = FPLSublistError
                    call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Is not a sublist.', &
                                   file=__FILE__, line=__LINE__ )
            end select
        else
            FPLerror = FPLSublistError
            call msg%Error(txt='Getting [Key="'//this%GetKey()//'"]: Not present. Sublist was not modified.', &
                           file=__FILE__, line=__LINE__ )
        endif
    end function ParameterListIterator_GetSubList


    function ParameterListIterator_isSubList(this) result(isSubList)
    !-----------------------------------------------------------------
    !< Check if a Key is a SubList
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this            !< Parameter List Iterator
        class(*), pointer                          :: SubList         !< Sublist pointer
        logical                                    :: isSubList       !< Check if is a SubList
    !-----------------------------------------------------------------
        isSubList = .false.
        nullify(Sublist)
        SubList => this%PointToValue()
        if(associated(Sublist)) then
            select type(Sublist)
                class is (ParameterList_t)
                    isSubList =.true.
            end select
        endif
    end function ParameterListIterator_isSubList


    function ParameterListIterator_DataSizeInBytes(this) result(DataSizeInBytes)
    !-----------------------------------------------------------------
    !< Return the data size in bytes of the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this            !< Parameter List Iterator
        type(ParameterEntry_t),      pointer       :: CurrentEntry    !< Current entry
        class(*), pointer                          :: Wrapper         !< Wrapper
        integer(I4P)                               :: DataSizeInBytes !< Size in bytes
    !-----------------------------------------------------------------
        DataSizeInBytes = 0
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper_t)
                    DataSizeInBytes = Wrapper%DataSizeInBytes()
            end select
        endif
    end function ParameterListIterator_DataSizeInBytes


    function ParameterListIterator_isOfDataType0D(this, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this            !< Parameter List Iterator
        class(*),                    intent(IN)    :: Mold            !< Mold
        class(*), pointer                          :: Wrapper         !< Wrapper
        logical                                    :: isOfDataType    !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold)
            end select
        endif
    end function ParameterListIterator_isOfDataType0D


    function ParameterListIterator_isOfDataType1D(this, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this            !< Parameter List Iterator
        class(*),                    intent(IN)    :: Mold(1:)        !< Mold
        class(*), pointer                          :: Wrapper         !< Wrapper
        logical                                    :: isOfDataType    !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1))
            end select
        endif
    end function ParameterListIterator_isOfDataType1D


    function ParameterListIterator_isOfDataType2D(this, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this            !< Parameter List Iterator
        class(*),                    intent(IN)    :: Mold(1:,1:)     !< Mold
        class(*), pointer                          :: Wrapper         !< Wrapper
        logical                                    :: isOfDataType    !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1,1))
            end select
        endif
    end function ParameterListIterator_isOfDataType2D


    function ParameterListIterator_isOfDataType3D(this, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this            !< Parameter List Iterator
        class(*),                    intent(IN)    :: Mold(1:,1:,1:)  !< Mold
        class(*), pointer                          :: Wrapper         !< Wrapper
        logical                                    :: isOfDataType    !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1,1,1))
            end select
        endif
    end function ParameterListIterator_isOfDataType3D


    function ParameterListIterator_isOfDataType4D(this, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this              !< Parameter List Iterator
        class(*),                    intent(IN)    :: Mold(1:,1:,1:,1:) !< Mold
        class(*), pointer                          :: Wrapper           !< Wrapper
        logical                                    :: isOfDataType      !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1,1,1,1))
            end select
        endif
    end function ParameterListIterator_isOfDataType4D


    function ParameterListIterator_isOfDataType5D(this, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this                 !< Parameter List Iterator
        class(*),                    intent(IN)    :: Mold(1:,1:,1:,1:,1:) !< Mold
        class(*), pointer                          :: Wrapper              !< Wrapper
        logical                                    :: isOfDataType         !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1,1,1,1,1))
            end select
        endif
    end function ParameterListIterator_isOfDataType5D


    function ParameterListIterator_isOfDataType6D(this, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this                    !< Parameter List Iterator
        class(*),                    intent(IN)    :: Mold(1:,1:,1:,1:,1:,1:) !< Mold
        class(*), pointer                          :: Wrapper                 !< Wrapper
        logical                                    :: isOfDataType            !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1,1,1,1,1,1))
            end select
        endif
    end function ParameterListIterator_isOfDataType6D


    function ParameterListIterator_isOfDataType7D(this, Mold) result(IsOfDataType)
    !-----------------------------------------------------------------
    !< Check if the data type of Mold agrees with the value associated with Key
    !-----------------------------------------------------------------
        class(ParameterListIterator_t), intent(IN) :: this                       !< Parameter List Iterator
        class(*),                    intent(IN)    :: Mold(1:,1:,1:,1:,1:,1:,1:) !< Mold
        class(*), pointer                          :: Wrapper                    !< Wrapper
        logical                                    :: isOfDataType               !< Check if has the same type
    !-----------------------------------------------------------------
        isOfDataType = .false.
        nullify(Wrapper)
        Wrapper => this%PointToValue()
        if(associated(Wrapper)) then
            select type(Wrapper)
                class is (DimensionsWrapper_t)
                    isOfDataType = Wrapper%isOfDataType(Mold=Mold(1,1,1,1,1,1,1))
            end select
        endif
    end function ParameterListIterator_isOfDataType7D


    recursive subroutine ParameterListIterator_Print(this, unit, prefix, iostat, iomsg)
    !-----------------------------------------------------------------
    !< Print the content of the DataBase
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),       intent(IN)  :: this    !< Parameter Iterator
        integer(I4P), optional,               intent(IN)  :: unit    !< Logic unit.
        character(*), optional,               intent(IN)  :: prefix  !< Prefixing string.
        integer(I4P), optional,               intent(OUT) :: iostat  !< IO error.
        character(*), optional,               intent(OUT) :: iomsg   !< IO error message.
        character(len=:), allocatable                     :: prefd   !< Prefixing string.
        integer(I4P)                                      :: unitd   !< Logic unit.
        integer(I4P)                                      :: iostatd !< IO error.
        character(500)                                    :: iomsgd  !< Temporary variable for IO error message.
        class(*), pointer                                 :: Value   !< Unlimited polymorphic value
    !-----------------------------------------------------------------
        prefd = '' ; if (present(prefix)) prefd = prefix
        unitd = OUTPUT_UNIT; if(present(unit)) unitd = unit
        nullify(Value)
        Value => this%PointToValue()
        if(associated(Value)) then
            select type(Value)
                class is (DimensionsWrapper_t)
                    call Value%Print(unit=unitd,                                              &
                                     prefix=prefd//                                           &
                                     '['//trim(str(no_sign=.true., n=this%GetIndex()))//']'// &
                                     ' Key = '//this%GetKey()//',',                           &
                                     iostat=iostatd,                                                &
                                     iomsg=iomsgd)
            end select
        endif
        if (present(iostat)) iostat = iostatd
        if (present(iomsg))  iomsg  = iomsgd
    end subroutine ParameterListIterator_Print


    function ParameterListIterator_HasFinished(this) result(HasFinished)
    !-----------------------------------------------------------------
    !< Check if Iterator has reached the end of the dictionary
    !-----------------------------------------------------------------
        class(ParameterListIterator_t),     intent(INOUT) :: this        ! Dictionary iterator
        logical                                           :: HasFinished
    !-----------------------------------------------------------------
        HasFinished = .false.
        if(this%Index==this%UpperBound) HasFinished = .true.
    end function ParameterListIterator_HasFinished

end module ParameterList
