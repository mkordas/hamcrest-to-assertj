#!/usr/bin/env bash
git checkout src
files=$(grep -lR hamcrest src/test/java | grep .java$)

BEGIN='s/(?:Assert\.)?assertThat\(\s*([^;]*?),\s+(?:(?:Is|Matchers|CoreMatchers|IsEqual|IsNot|IsNull)\.)?'
END=');/gs'
IS='(is\()?'
END_FIND='\s*\)+;'
REPLACE='/assertThat($1).'

ARGUMENT_MATCHER='\(([^;]+)(?(2)\))\)'

for file in $files
do
  function replace() {
    grep -P "assertThat[^;]+${1}" $file && perl -0777 -i -pe "${BEGIN}${IS}${1}${END_FIND}${REPLACE}${2}${END}" $file \
      && ! grep -q 'org.assertj.core.api.Assertions.assertThat' $file \
      && perl -0777 -i -pe 's/(package .*?\n)/$1\nimport static org.assertj.core.api.Assertions.assertThat;\n/gs' $file
  }

  function fix() {
    perl -0777 -i -pe "s/${1}/${2}/g" $file
  }

  replace "hasSize${ARGUMENT_MATCHER}" "hasSize($3"
  replace "iterableWithSize${ARGUMENT_MATCHER}" "hasSize($3"
  replace "arrayWithSize${ARGUMENT_MATCHER}" "hasSize($3"
  replace "emptyCollectionOf${ARGUMENT_MATCHER}" "isEmpty("
  replace "not\(emptyCollectionOf${ARGUMENT_MATCHER}\)" "isNotEmpty("
  replace "emptyIterableOf${ARGUMENT_MATCHER}" "isEmpty("
  replace "not\(emptyIterableOf${ARGUMENT_MATCHER}\)" "isNotEmpty("
  replace "emptyIterable\(" "isEmpty("
  replace "not\(emptyIterable\(" "isNotEmpty("
  replace "emptyArray\(" "isEmpty("
  replace "not\(emptyArray\(" "isNotEmpty("
  replace "empty\(" "isEmpty("
  replace "isEmptyString\(" "isEmpty("
  replace "not\(isEmptyString\(" "isNotEmpty("
  replace "isEmptyOrNullString\(" "isNullOrEmpty("
  replace "not\(isEmptyOrNullString\(" "isNotEmpty("
  replace "not\(empty\(" "isNotEmpty("
  replace "notNullValue\(" "isNotNull("
  replace "not\(nullValue\(" "isNotNull("
  replace "nullValue\(" "isNull("
  replace "nullValue${ARGUMENT_MATCHER}" "isNull("
  replace "containsString${ARGUMENT_MATCHER}" "contains($3"
  replace "not\(containsString${ARGUMENT_MATCHER}\)" "doesNotContain($3"
  replace "startsWith${ARGUMENT_MATCHER}" "startsWith($3"
  replace "not\(startsWith${ARGUMENT_MATCHER}\)" "doesNotStartWith($3"
  replace "endsWith${ARGUMENT_MATCHER}" "endsWith($3"
  replace "not\(endsWith${ARGUMENT_MATCHER}\)" "doesNotEndWith($3"
  replace "containsInAnyOrder${ARGUMENT_MATCHER}" "containsOnly($3"
  replace "arrayContaining${ARGUMENT_MATCHER}" "containsExactly($3"
  replace "not\(arrayContaining${ARGUMENT_MATCHER}\)" "doesNotContain($3"
  replace "arrayContainingInAnyOrder${ARGUMENT_MATCHER}" "containsOnly($3"
  replace "hasItems${ARGUMENT_MATCHER}" "contains($3"
  replace "not\(hasItems${ARGUMENT_MATCHER}\)" "doesNotContain($3"
  replace "contains${ARGUMENT_MATCHER}" "containsExactly($3"
  replace "not\(contains${ARGUMENT_MATCHER}\)" "doesNotContain($3"
  replace "isIn${ARGUMENT_MATCHER}" "isIn($3"
  replace "isOneOf${ARGUMENT_MATCHER}" "isIn($3"
  replace "not\(isOneOf${ARGUMENT_MATCHER}\)" "isNotIn($3"
  replace "not\(isIn${ARGUMENT_MATCHER}\)" "isNotIn($3"
  replace "hasItem${ARGUMENT_MATCHER}" "contains($3"
  replace "hasItemInArray${ARGUMENT_MATCHER}" "contains($3"
  replace "not\(hasItemInArray${ARGUMENT_MATCHER}\)" "doesNotContain($3"
  replace "not\(hasItem${ARGUMENT_MATCHER}\)" "doesNotContain($3"
  replace "hasKey${ARGUMENT_MATCHER}" "containsKey($3"
  replace "not\(hasKey${ARGUMENT_MATCHER}\)" "doesNotContainKey($3"
  replace "hasValue${ARGUMENT_MATCHER}" "containsValue($3"
  replace "not\(hasValue${ARGUMENT_MATCHER}\)" "doesNotContainValue($3"
  replace "hasEntry${ARGUMENT_MATCHER}" "containsEntry($3"
  replace "not\(hasEntry${ARGUMENT_MATCHER}\)" "doesNotContainEntry($3"
  replace "equalToIgnoringCase${ARGUMENT_MATCHER}" "isEqualToIgnoringCase($3"
  replace "sameInstance${ARGUMENT_MATCHER}" "isSameAs($3"
  replace "not\(sameInstance${ARGUMENT_MATCHER}\)" "isNotSameAs($3"
  replace "not\(is\(sameInstance${ARGUMENT_MATCHER}\)\)" "isNotSameAs($3"
  replace "typeCompatibleWith${ARGUMENT_MATCHER}" "isInstanceOf($3"
  replace "not\(typeCompatibleWith${ARGUMENT_MATCHER}\)" "isAssignableFrom($3"
  replace "instanceOf${ARGUMENT_MATCHER}" "isInstanceOf($3"
  replace "not\(instanceOf${ARGUMENT_MATCHER}\)" "isNotInstanceOf($3"
  replace "isA${ARGUMENT_MATCHER}" "isInstanceOf($3"
  replace "not\(isA${ARGUMENT_MATCHER}\)" "isNotInstanceOf($3"
  replace "theInstance${ARGUMENT_MATCHER}" "isSameAs($3"
  replace "not\(theInstance${ARGUMENT_MATCHER}\)" "isNotSameAs($3"
  replace "closeTo\(([^,]+), ([^;]+)(?(2)\))\)" "isCloseTo($3, within($4)"
  replace "lessThanOrEqualTo${ARGUMENT_MATCHER}" "isLessThanOrEqualTo($3"
  replace "not\(lessThanOrEqualTo${ARGUMENT_MATCHER}\)" "isGreaterThan($3"
  replace "lessThan${ARGUMENT_MATCHER}" "isLessThan($3"
  replace "not\(lessThan${ARGUMENT_MATCHER}\)" "isGreaterThanOrEqualTo($3"
  replace "greaterThanOrEqualTo${ARGUMENT_MATCHER}" "isGreaterThanOrEqualTo($3"
  replace "not\(greaterThanOrEqualTo${ARGUMENT_MATCHER}\)" "isLessThan($3"
  replace "greaterThan${ARGUMENT_MATCHER}" "isGreaterThan($3"
  replace "not\(greaterThan${ARGUMENT_MATCHER}\)" "isLessThanOrEqualTo($3"
  replace "not\(equalTo${ARGUMENT_MATCHER}\)" "isNotEqualTo($3"
  replace "not${ARGUMENT_MATCHER}" "isNotEqualTo($3"
  replace "equalTo${ARGUMENT_MATCHER}" "isEqualTo($3"
  replace "is\(not${ARGUMENT_MATCHER}\)" "isNotEqualTo($3"
  replace "not\(is${ARGUMENT_MATCHER}\)" "isNotEqualTo($3"
  replace "is${ARGUMENT_MATCHER}" "isEqualTo($3"
  fix "isEqualTo\(null\)" "isNull()"
  fix "isNotEqualTo\(null\)" "isNotNull()"
  fix "isEqualTo\(true\)" "isTrue()"
  fix "isEqualTo\(false\)" "isFalse()"
  fix "isEqualTo\(0\)" "isZero()"
  fix "hasSize\(0\)" "isEmpty()"
  fix "isEqualTo\(\"\"\)" "isEmpty()"
  fix "\.size\(\)\)\.isZero\(\)" ").isEmpty()"
  fix "\.length\)\.isZero\(\)" ").isEmpty()"
  fix "\.size\(\)\)\.isEqualTo\(([^;]+)\)" ").hasSize($1)"

  grep -q 'within(' $file && ! grep -q 'org.assertj.core.api.Assertions.within' $file \
      && perl -0777 -i -pe 's/(package .*?\n)/$1\nimport static org.assertj.core.api.Assertions.within;/gs' $file
done

find . -name "*.bak*" -delete
