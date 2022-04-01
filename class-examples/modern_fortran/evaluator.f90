module evaluator
implicit none
private
public evaluate_age
integer, parameter :: best_age_ever = 34
contains
    
subroutine evaluate_age(age, response)
    implicit none
    integer, intent(in) :: age
    character(*), intent(out) :: response

    if (age == best_age_ever) then
        response = "WOW, that's a great age!"
    else
        response = "That's a nice age"
    endif
    
end subroutine evaluate_age
end module evaluator