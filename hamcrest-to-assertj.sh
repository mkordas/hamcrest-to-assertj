#!/usr/bin/env bash
git checkout src
files=$(grep -lR hamcrest src/test/java | grep .java$)

BEGIN='s/(?:Assert\.)?assertThat\(\s*([^;]*?),\s+(?:(?:Is|Matchers|CoreMatchers|IsEqual|IsNot|IsNull)\.)?'
END=');/gs'
IS='(is\()?'
END_FIND='\s*\)+;'
REPLACE='/assertThat($1).'

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

  replace 'hasSize\(([^;]+)(?(2)\))\)' 'hasSize($3'
  replace 'iterableWithSize\(([^;]+)(?(2)\))\)' 'hasSize($3'
  replace 'arrayWithSize\(([^;]+)(?(2)\))\)' 'hasSize($3'
  replace 'emptyCollectionOf\(([^;]+)(?(2)\))\)' 'isEmpty('
  replace 'not\(emptyCollectionOf\(([^;]+)(?(2)\))\)\)' 'isNotEmpty('
  replace 'emptyIterableOf\(([^;]+)(?(2)\))\)' 'isEmpty('
  replace 'not\(emptyIterableOf\(([^;]+)(?(2)\))\)\)' 'isNotEmpty('
  replace 'emptyIterable\(' 'isEmpty('
  replace 'not\(emptyIterable\(' 'isNotEmpty('
  replace 'emptyArray\(' 'isEmpty('
  replace 'not\(emptyArray\(' 'isNotEmpty('
  replace 'empty\(' 'isEmpty('
  replace 'isEmptyString\(' 'isEmpty('
  replace 'not\(isEmptyString\(' 'isNotEmpty('
  replace 'isEmptyOrNullString\(' 'isNullOrEmpty('
  replace 'not\(isEmptyOrNullString\(' 'isNotEmpty('
  replace 'not\(empty\(' 'isNotEmpty('
  replace 'notNullValue\(' 'isNotNull('
  replace 'not\(nullValue\(' 'isNotNull('
  replace 'nullValue\(' 'isNull('
  replace 'nullValue\(([^;]+)(?(2)\))\)' 'isNull('
  replace 'containsString\(([^;]+)(?(2)\))\)' 'contains($3'
  replace 'not\(containsString\(([^;]+)(?(2)\))\)\)' 'doesNotContain($3'
  replace 'startsWith\(([^;]+)(?(2)\))\)' 'startsWith($3'
  replace 'endsWith\(([^;]+)(?(2)\))\)' 'endsWith($3'
  replace 'containsInAnyOrder\(([^;]+)(?(2)\))\)' 'containsOnly($3'
  replace 'arrayContaining\(([^;]+)(?(2)\))\)' 'containsExactly($3'
  replace 'not\(arrayContaining\(([^;]+)(?(2)\))\)\)' 'doesNotContain($3'
  replace 'arrayContainingInAnyOrder\(([^;]+)(?(2)\))\)' 'containsOnly($3'
  replace 'hasItems\(([^;]+)(?(2)\))\)' 'contains($3'
  replace 'not\(hasItems\(([^;]+)(?(2)\))\)\)' 'doesNotContain($3'
  replace 'contains\(([^;]+)(?(2)\))\)' 'containsExactly($3'
  replace 'not\(contains\(([^;]+)(?(2)\))\)\)' 'doesNotContain($3'
  replace 'isIn\(([^;]+)(?(2)\))\)' 'isIn($3'
  replace 'isOneOf\(([^;]+)(?(2)\))\)' 'isIn($3'
  replace 'not\(isOneOf\(([^;]+)(?(2)\))\)\)' 'isNotIn($3'
  replace 'not\(isIn\(([^;]+)(?(2)\))\)\)' 'isNotIn($3'
  replace 'hasItem\(([^;]+)(?(2)\))\)' 'contains($3'
  replace 'hasItemInArray\(([^;]+)(?(2)\))\)' 'contains($3'
  replace 'not\(hasItemInArray\(([^;]+)(?(2)\))\)\)' 'doesNotContain($3'
  replace 'not\(hasItem\(([^;]+)(?(2)\))\)\)' 'doesNotContain($3'
  replace 'hasKey\(([^;]+)(?(2)\))\)' 'containsKey($3'
  replace 'not\(hasKey\(([^;]+)(?(2)\))\)\)' 'doesNotContainKey($3'
  replace 'hasValue\(([^;]+)(?(2)\))\)' 'containsValue($3'
  replace 'not\(hasValue\(([^;]+)(?(2)\))\)\)' 'doesNotContainValue($3'
  replace 'hasEntry\(([^;]+)(?(2)\))\)' 'containsEntry($3'
  replace 'not\(hasEntry\(([^;]+)(?(2)\))\)\)' 'doesNotContainEntry($3'
  replace 'equalToIgnoringCase\(([^;]+)(?(2)\))\)' 'isEqualToIgnoringCase($3'
  replace 'sameInstance\(([^;]+)(?(2)\))\)' 'isSameAs($3'
  replace 'not\(sameInstance\(([^;]+)(?(2)\))\)\)' 'isNotSameAs($3'
  replace 'not\(is\(sameInstance\(([^;]+)(?(2)\))\)\)\)' 'isNotSameAs($3'
  replace 'typeCompatibleWith\(([^;]+)(?(2)\))\)' 'isInstanceOf($3'
  replace 'not\(typeCompatibleWith\(([^;]+)(?(2)\))\)\)' 'isAssignableFrom($3'
  replace 'instanceOf\(([^;]+)(?(2)\))\)' 'isInstanceOf($3'
  replace 'not\(instanceOf\(([^;]+)(?(2)\))\)\)' 'isNotInstanceOf($3'
  replace 'isA\(([^;]+)(?(2)\))\)' 'isInstanceOf($3'
  replace 'not\(isA\(([^;]+)(?(2)\))\)\)' 'isNotInstanceOf($3'
  replace 'theInstance\(([^;]+)(?(2)\))\)' 'isSameAs($3'
  replace 'not\(theInstance\(([^;]+)(?(2)\))\)\)' 'isNotSameAs($3'
  replace 'closeTo\(([^,]+), ([^;]+)(?(2)\))\)' 'isCloseTo($3, within($4)'
  replace 'lessThanOrEqualTo\(([^;]+)(?(2)\))\)' 'isLessThanOrEqualTo($3'
  replace 'not\(lessThanOrEqualTo\(([^;]+)(?(2)\))\)\)' 'isGreaterThan($3'
  replace 'lessThan\(([^;]+)(?(2)\))\)' 'isLessThan($3'
  replace 'not\(lessThan\(([^;]+)(?(2)\))\)\)' 'isGreaterThanOrEqualTo($3'
  replace 'greaterThanOrEqualTo\(([^;]+)(?(2)\))\)' 'isGreaterThanOrEqualTo($3'
  replace 'not\(greaterThanOrEqualTo\(([^;]+)(?(2)\))\)\)' 'isLessThan($3'
  replace 'greaterThan\(([^;]+)(?(2)\))\)' 'isGreaterThan($3'
  replace 'not\(greaterThan\(([^;]+)(?(2)\))\)\)' 'isLessThanOrEqualTo($3'
  replace 'not\(equalTo\(([^;]+)(?(2)\))\)\)' 'isNotEqualTo($3'
  replace 'not\(([^;]+)(?(2)\))\)' 'isNotEqualTo($3'
  replace 'equalTo\(([^;]+)(?(2)\))\)' 'isEqualTo($3'
  replace 'is\(not\(([^;]+)(?(2)\))\)\)' 'isNotEqualTo($3'
  replace 'not\(is\(([^;]+)(?(2)\))\)\)' 'isNotEqualTo($3'
  replace 'is\(([^;]+)(?(2)\))\)' 'isEqualTo($3'
  fix 'isEqualTo\(null\)' 'isNull()'
  fix 'isNotEqualTo\(null\)' 'isNotNull()'
  fix 'isEqualTo\(true\)' 'isTrue()'
  fix 'isEqualTo\(false\)' 'isFalse()'
  fix 'isEqualTo\(0\)' 'isZero()'
  fix 'hasSize\(0\)' 'isEmpty()'
  fix 'isEqualTo\(""\)' 'isEmpty()'
  fix '\.size\(\)\)\.isZero\(\)' ').isEmpty()'
  fix '\.length\)\.isZero\(\)' ').isEmpty()'
  fix '\.size\(\)\)\.isEqualTo\(([^;]+)\)' ').hasSize($1)'

  grep -q 'within(' $file && ! grep -q 'org.assertj.core.api.Assertions.within' $file \
      && perl -0777 -i -pe 's/(package .*?\n)/$1\nimport static org.assertj.core.api.Assertions.within;/gs' $file
done

find . -name "*.bak*" -delete
