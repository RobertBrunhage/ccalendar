###############################################################################
# common commands
###############################################################################
intl:
	dart run intl_utils:generate

generate:
	dart run build_runner build --delete-conflicting-outputs

watch:
	dart run build_runner watch --delete-conflicting-outputs
