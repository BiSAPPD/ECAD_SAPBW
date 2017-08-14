select salon_id,special_programs.name, salons_special_programs.accepted_at
from salons_special_programs left join special_programs on salons_special_programs.special_program_id = special_programs.id
where (special_program_id = 13 or special_program_id = 14)
