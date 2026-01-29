extends Resource
class_name Character


enum RELATIONSHIP {BAD, NEUTRAL, GOOD, SAME}

@export var name : String

@export_category("Relationships")
@export var Estella : RELATIONSHIP
@export var Jack : RELATIONSHIP
@export var Bailey : RELATIONSHIP
@export var Simon : RELATIONSHIP
@export var Carmen : RELATIONSHIP
@export var Steve : RELATIONSHIP
@export var Kleptos : RELATIONSHIP

@export_category("Information")
@export var has_location : bool
@export var has_code : int
