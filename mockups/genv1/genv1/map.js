


	// f | floor (making distinct "rooms" is pointless)
	// x | exit, basically a floor, entering tile = game win, map-gen starts here
	// w | wall, untraversable
	// p | puzzle, toggles d states
	// d | door, alternates between traversable and non-traversable
	// - | map border, outer border should be -
	// each row should be the same length



	m1 = ["-----------------------------------",
	      "-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-",
	      "-xwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwffpffdffpffdffpffdffpffdffpffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwwwdwwwwwdwwwwwdwwwwwdwwwwwdwwwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwffpffdffpffdffpffdffpffdffpffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwwwdwwwwwdwwwwwdwwwwwdwwwwwdwwwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwffpffdffpffdffpffdffpffdffpffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwwwdwwwwwdwwwwwdwwwwwdwwwwwdwwwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwffpffdffpffdffpffdffpffdffpffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwwwdwwwwwdwwwwwdwwwwwdwwwwwdwwwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwffpffdffpffdffpffdffpffdffpffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwfffffwfffffwfffffwfffffwfffffwx-",
	      "-xwwwwwwwwwwwwwwwdwwwwwwwwwwwwwwwx-",
	      "-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-",
	      "-----------------------------------"];



	m2 = ["-----------------------------------",
	      "-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-",
	      "-xwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwx-",
	      "-xwfffffffffffwfffffwfffffffffffwx-",
	      "-xwfffffffffffwfffffwfffffffffffwx-",
	      "-xwffpfffffpffdffpffdffpfffffpffwx-",
	      "-xwfffffffffffwfffffwfffffffffffwx-",
	      "-xwfffffffffffwfffffwfffffffffffwx-",
	      "-xwfffffwwwwwwwwwdwwwwwwwwwfffffwx-",
	      "-xwfffffwwwwwwwfffffwwwwwwwfffffwx-",
	      "-xwfffffwwwwwwwfffffwwwwwwwfffffwx-",
	      "-xwffpffwwwwwwwffpffwwwwwwwffpffwx-",
	      "-xwfffffwwwwwwwfffffwwwwwwwfffffwx-",
	      "-xwfffffwwwwwwwfffffwwwwwwwfffffwx-",
	      "-xwwwdwwwwwwwwwfffffwwwwwwwwwdwwwx-",
	      "-xwfffffwfffffffffffffffffwfffffwx-",
	      "-xwfffffwfffffffffffffffffwfffffwx-",
	      "-xwffpffdffpfffffpfffffpffdffpffwx-",
	      "-xwfffffwfffffffffffffffffwfffffwx-",
	      "-xwfffffwfffffffffffffffffwfffffwx-",
	      "-xwwwdwwwwwwwwwfffffwwwwwwwwwdwwwx-",
	      "-xwfffffwwwwwwwfffffwwwwwwwfffffwx-",
	      "-xwfffffwwwwwwwfffffwwwwwwwfffffwx-",
	      "-xwffpffwwwwwwwffpffwwwwwwwffpffwx-",
	      "-xwfffffwwwwwwwfffffwwwwwwwfffffwx-",
	      "-xwfffffwwwwwwwfffffwwwwwwwfffffwx-",
	      "-xwfffffwwwwwwwwwdwwwwwwwwwfffffwx-",
	      "-xwfffffffffffwfffffwfffffffffffwx-",
	      "-xwfffffffffffwfffffwfffffffffffwx-",
	      "-xwffpfffffpffdffpffdffpfffffpffwx-",
	      "-xwfffffffffffwfffffwfffffffffffwx-",
	      "-xwfffffffffffwfffffwfffffffffffwx-",
	      "-xwwwwwwwwwwwwwwwdwwwwwwwwwwwwwwwx-",
	      "-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-",
	      "-----------------------------------"];

	m3 = ["-------",
				"-wwdww-",
				"-wdpdw-",
				"-dpdpd-",
				"-wdpdw-",
				"-wwdww-",
				"-------"];


