extends Node

signal bit_consumed(value: int)

func emit_bit_consumed(value: int):
	bit_consumed.emit(value)
	print("WAKKA ", value)
