
from sys import argv

if __name__ == "__main__":
	argc = len( argv )
	if argc != 3:
		print( "usage: gensv <pkg_name> <className>" )
		exit( 2 )

	pkg_name, cls_name = argv[ 1 ], argv[ 2 ]

	lines = [ \
		"", 
		f"package { pkg_name }", 
		"", 
		"import circt.stage.ChiselStage", 
		"", 
		f"object { cls_name }V extends App", 
		"{", 
		"\tChiselStage.emitSystemVerilogFile(", 
		f"\t\tnew { cls_name },", 
		"\t\tArray( \"--target-dir\", \"generated\" ),", 
		"\t\tArray( \"--strip-debug-info\" ),", 
		"\t)", 
		"}",
		"",
	]

	for l in lines:
		print( l )

"""
// See LICENSE.txt for license details.
package examples
//import chisel3.stage.ChiselStage
import /*_root_.*/circt.stage.ChiselStage

object FullAdderV extends App
{
	ChiselStage.emitSystemVerilogFile(
		new FullAdder,
		Array( "--target-dir", "generated" ),
		Array( "--strip-debug-info" )
	)
}

"""


