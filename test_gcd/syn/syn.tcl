
# Vivado driver template: https://medium.com/@abdulbasit.shaz/automate-your-fpga-workflow-vivado-tcl-scripting-for-beginners-45244f7cbb05

# Define variables for easy configuration
set project_name "gcd"
set part         "xc7z020clg400-1"
set src_dir      "../src"
set constr_dir   "./cons"

# Create a new project
create_project -force $project_name ./$project_name -part $part

# Add source and constraint files
#add_files [glob $src_dir/*.v]
add_files -force [glob $src_dir/*.sv]
add_files -force -fileset constrs_1 [glob $constr_dir/*.xdc]

# Update compile order
update_compile_order -fileset sources_1

# Set the implementation strategy for better results (optional)
set_property strategy Performance_Explore [get_runs impl_1]

# Run the full implementation flow
launch_runs synth_1
wait_on_run synth_1

# Check if synthesis was successful before proceeding
if { [get_property PROGRESS [get_runs synth_1]] != "100%" }
{
  error "synthesis failed - check log files."
}

launch_runs impl_1
wait_on_run impl_1

if { [get_property PROGRESS [get_runs impl_1]] != "100%" }
{
  error "implementation failed - check log files."
}

launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

# Generate reports
open_run impl_1
report_timing_summary -file ./$project_name/timing_report.txt
report_utilization -hierarchical -file ./$project_name/utilization_report.txt

puts "success: bitstream and reports generated"

