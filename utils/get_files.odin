package get_files_line_by_line

import "core:fmt"
import "core:os"
import "core:strings"

get_files_line_by_line :: proc(filepath: string) -> [dynamic]string {
	input_data: [dynamic]string
	data, ok := os.read_entire_file(filepath, context.allocator)
	if !ok {
		// could not read file
		panic("paniquei")
	}
	defer delete(data, context.allocator)

	it := string(data)
	for line in strings.split_lines_iterator(&it) {
		// process line
		append(&input_data, line)
	}

	fmt.println(input_data)

	return input_data
}
