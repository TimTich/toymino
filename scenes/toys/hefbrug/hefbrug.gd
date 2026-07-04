class_name Hefbrug
extends Toy

@onready var brug_collider: CollisionShape2D = %BrugCollider
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func enter_play() -> void:
	super()
	brug_collider.disabled = false


func _on_activation_area_body_entered(_body: Node2D) -> void:
	animation_player.play("open")
