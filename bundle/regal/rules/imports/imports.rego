package regal.rules.imports

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.regal.config
import data.regal.result

# METADATA
# title: implicit-future-keywords
# description: Use explicit future keyword imports
# related_resources:
# - description: documentation
#   ref: https://docs.styra.com/regal/rules/implicit-future-keywords
# custom:
#   category: imports
report contains violation if {
	config.for_rule(rego.metadata.rule()).enabled == true

	some imported in input.imports

	imported.path.type == "ref"

	count(imported.path.value) == 2

	imported.path.value[0].type == "var"
	imported.path.value[0].value == "future"
	imported.path.value[1].type == "string"
	imported.path.value[1].value == "keywords"

	violation := result.fail(rego.metadata.rule(), {"location": imported.path.value[0].location})
}

# METADATA
# title: avoid-importing-input
# description: Avoid importing input
# related_resources:
# - description: documentation
#   ref: https://docs.styra.com/regal/rules/avoid-importing-input
# custom:
#   category: imports
report contains violation if {
	config.for_rule(rego.metadata.rule()).enabled == true

	some imported in input.imports

	imported.path.value[0].value == "input"

	# If we want to allow aliasing input, eg `import input as tfplan`:
	# count(imported.path.value) == 1
	# imported.alias

	violation := result.fail(rego.metadata.rule(), {"location": imported.path.value[0].location})
}

# METADATA
# title: redundant-data-import
# description: Redundant import of data
# related_resources:
# - description: documentation
#   ref: https://docs.styra.com/regal/rules/redundant-data-import
# custom:
#   category: imports
report contains violation if {
	config.for_rule(rego.metadata.rule()).enabled == true

	some imported in input.imports

	count(imported.path.value) == 1

	imported.path.value[0].value == "data"

	violation := result.fail(rego.metadata.rule(), {"location": imported.path.value[0].location})
}