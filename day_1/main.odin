package main

import "core:fmt"
import "core:strconv"
import "core:testing"

import "../utils"

dial_start_position := 50

get_password :: proc(input: [dynamic]string) -> int {

	fmt.println(input[0])
	i := 0
	dial_current_position := dial_start_position
	total_zeros := 0


	for i < len(input) {
		rotation := input[i]
		rotation_direction := rotation[0:1]
		rotation_range, ok := strconv.parse_int(rotation[1:])

		if rotation_direction == "L" {
			dial_current_position = (dial_current_position - rotation_range) % 100
		}

		if rotation_direction == "R" {
			dial_current_position = (dial_current_position + rotation_range) % 100
		}


		if dial_current_position == 0 {
			total_zeros += 1
		}
		i += 1
	}
	return total_zeros
}

main :: proc() {
	rotations := utils.get_files_line_by_line("./input.txt")
	result := get_password(rotations)
	fmt.printfln("Resultado 1: %d", result)
}


@(test)
password_test :: proc(t: ^testing.T) {
	fmt.println("Iniciando teste")
	test_rotations := utils.get_files_line_by_line("./input_example.txt")
	expected_password := 3
	testing.expect_value(t, get_password(test_rotations), expected_password)
}
