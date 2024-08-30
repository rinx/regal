# METADATA
# description: Test outside of test package
package regal.rules.testing["test-outside-test-package"]

import rego.v1

import data.regal.ast
import data.regal.result

report contains violation if {
	not _is_test_package(ast.package_name)

	some rule in ast.tests

	violation := result.fail(rego.metadata.chain(), result.ranged_location_from_text(rule.head))
}

_is_test_package(package_name) if endswith(package_name, "_test")

# Styra DAS convention considered OK
_is_test_package("test")