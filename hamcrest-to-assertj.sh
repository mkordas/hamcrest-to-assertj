#!/usr/bin/env bash
git checkout src
files=$(grep -lR hamcrest src/test/java | grep java$)

BEGIN='s/(?:Assert\.)?assertThat\(([^X]*?),\s+(?:(?:Is|Matchers|CoreMatchers|IsEqual)\.)?'
END=');/gs'
IS='(is\()?'
END_FIND='\)+;'
REPLACE='/assertThat($1).'

for file in $files
do
  function replace() {
    grep -P "assertThat[^;X]+${1}" $file && perl -0777 -i -pe "${BEGIN}${IS}${1}${END_FIND}${REPLACE}${2}${END}" $file \
      && ! grep -q 'org.assertj.core.api.Assertions.assertThat' $file \
      && perl -0777 -i -pe 's/(package .*?\n)/$1\nimport static org.assertj.core.api.Assertions.assertThat;\n/gs' $file
  }

  function fix() {
    perl -0777 -i -pe "s/${1}/${2}/g" $file
  }

  replace 'hasSize\(0' 'isEmpty('
  replace 'hasSize\(([^;X]+)(?(2)\))\)' 'hasSize($3'
  replace 'iterableWithSize\(([^;X]+)(?(2)\))\)' 'hasSize($3'
  replace 'arrayWithSize\(([^;X]+)(?(2)\))\)' 'hasSize($3'
  replace 'emptyCollectionOf\([^)]+' 'isEmpty('
  replace 'not\(emptyCollectionOf\([^)]+' 'isNotEmpty('
  replace 'emptyIterableOf\([^)]+' 'isEmpty('
  replace 'not\(emptyIterableOf\([^)]+' 'isNotEmpty('
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
  replace 'nullValue\(([^;X]+)(?(2)\))\)' 'isNull('
  replace 'containsString\(([^;X]+)(?(2)\))\)' 'contains($3'
  replace 'not\(containsString\(([^;X]+)(?(2)\))\)\)' 'doesNotContain($3'
  replace 'startsWith\(([^;X]+)(?(2)\))\)' 'startsWith($3'
  replace 'endsWith\(([^;X]+)(?(2)\))\)' 'endsWith($3'
  replace 'containsInAnyOrder\(([^;X]+)(?(2)\))\)' 'containsOnly($3'
  replace 'arrayContaining\(([^;X]+)(?(2)\))\)' 'containsExactly($3'
  replace 'not\(arrayContaining\(([^;X]+)(?(2)\))\)\)' 'doesNotContain($3'
  replace 'arrayContainingInAnyOrder\(([^;X]+)(?(2)\))\)' 'containsOnly($3'
  replace 'hasItems\(([^;X]+)(?(2)\))\)' 'contains($3'
  replace 'not\(hasItems\(([^;X]+)(?(2)\))\)\)' 'doesNotContain($3'
  replace 'contains\(([^;X]+)(?(2)\))\)' 'containsExactly($3'
  replace 'not\(contains\(([^;X]+)(?(2)\))\)\)' 'doesNotContain($3'
  replace 'isIn\(([^;X]+)(?(2)\))\)' 'isIn($3'
  replace 'isOneOf\(([^;X]+)(?(2)\))\)' 'isIn($3'
  replace 'not\(isOneOf\(([^;X]+)(?(2)\))\)\)' 'isNotIn($3'
  replace 'not\(isIn\(([^;X]+)(?(2)\))\)\)' 'isNotIn($3'
  replace 'hasItem\(([^;X]+)(?(2)\))\)' 'contains($3'
  replace 'hasItemInArray\(([^;X]+)(?(2)\))\)' 'contains($3'
  replace 'not\(hasItemInArray\(([^;X]+)(?(2)\))\)\)' 'doesNotContain($3'
  replace 'not\(hasItem\(([^;X]+)(?(2)\))\)\)' 'doesNotContain($3'
  replace 'hasKey\(([^;X]+)(?(2)\))\)' 'containsKey($3'
  replace 'not\(hasKey\(([^;X]+)(?(2)\))\)\)' 'doesNotContainKey($3'
  replace 'hasValue\(([^;X]+)(?(2)\))\)' 'containsValue($3'
  replace 'not\(hasValue\(([^;X]+)(?(2)\))\)\)' 'doesNotContainValue($3'
  replace 'hasEntry\(([^;X]+)(?(2)\))\)' 'containsEntry($3'
  replace 'not\(hasEntry\(([^;X]+)(?(2)\))\)\)' 'doesNotContainEntry($3'
  replace 'equalToIgnoringCase\(([^;X]+)(?(2)\))\)' 'isEqualToIgnoringCase($3'
  replace 'sameInstance\(([^;X]+)(?(2)\))\)' 'isSameAs($3'
  replace 'not\(sameInstance\(([^;X]+)(?(2)\))\)\)' 'isNotSameAs($3'
  replace 'not\(is\(sameInstance\(([^;X]+)(?(2)\))\)\)\)' 'isNotSameAs($3'
  replace 'typeCompatibleWith\(([^;X]+)(?(2)\))\)' 'isInstanceOf($3'
  replace 'not\(typeCompatibleWith\(([^;X]+)(?(2)\))\)\)' 'isAssignableFrom($3'
  replace 'instanceOf\(([^;X]+)(?(2)\))\)' 'isInstanceOf($3'
  replace 'not\(instanceOf\(([^;X]+)(?(2)\))\)\)' 'isNotInstanceOf($3'
  replace 'isA\(([^;X]+)(?(2)\))\)' 'isInstanceOf($3'
  replace 'not\(isA\(([^;X]+)(?(2)\))\)\)' 'isNotInstanceOf($3'
  replace 'theInstance\(([^;X]+)(?(2)\))\)' 'isSameAs($3'
  replace 'not\(theInstance\(([^;X]+)(?(2)\))\)\)' 'isNotSameAs($3'
  replace 'closeTo\(([^,]+), ([^;X]+)(?(2)\))\)' 'isCloseTo($3, within($4)'
  replace 'lessThanOrEqualTo\(([^;X]+)(?(2)\))\)' 'isLessThanOrEqualTo($3'
  replace 'not\(lessThanOrEqualTo\(([^;X]+)(?(2)\))\)\)' 'isGreaterThan($3'
  replace 'lessThan\(([^;X]+)(?(2)\))\)' 'isLessThan($3'
  replace 'not\(lessThan\(([^;X]+)(?(2)\))\)\)' 'isGreaterThanOrEqualTo($3'
  replace 'greaterThanOrEqualTo\(([^;X]+)(?(2)\))\)' 'isGreaterThanOrEqualTo($3'
  replace 'not\(greaterThanOrEqualTo\(([^;X]+)(?(2)\))\)\)' 'isLessThan($3'
  replace 'greaterThan\(([^;X]+)(?(2)\))\)' 'isGreaterThan($3'
  replace 'not\(greaterThan\(([^;X]+)(?(2)\))\)\)' 'isLessThanOrEqualTo($3'
  replace 'equalTo\(true(?(2)\))\)' 'isTrue('
  replace 'equalTo\(false(?(2)\))\)' 'isFalse('
  replace 'not\(equalTo\(([^;X]+)(?(2)\))\)\)' 'isNotEqualTo($3'
  replace 'not\(([^;X]+)(?(2)\))\)' 'isNotEqualTo($3'
  replace 'equalTo\(([^;X]+)(?(2)\))\)' 'isEqualTo($3'
  replace 'is\(not\(([^;X]+)(?(2)\))\)\)' 'isNotEqualTo($3'
  replace 'not\(is\(([^;X]+)(?(2)\))\)\)' 'isNotEqualTo($3'
  replace 'is\(true' 'isTrue('
  replace 'is\(false' 'isFalse('
  replace 'is\(null' 'isNull('
  replace 'is\(0' 'isZero('
  replace 'is\(([^;X]+)(?(2)\))\)' 'isEqualTo($3'
  fix 'isEqualTo\(null\)' 'isNull()'
  fix 'isNotEqualTo\(null\)' 'isNotNull()'
  fix 'isEqualTo\(true\)' 'isTrue()'
  fix 'isEqualTo\(false\)' 'isFalse()'
  fix 'isEqualTo\(0\)' 'isZero()'
  fix 'hasSize\(0\)' 'isEmpty()'
  fix 'isEqualTo\(""\)' 'isEmpty()'
  fix '\.size\(\)\)\.isZero\(\)' ').isEmpty()'
  fix '\.length\)\.isZero\(\)' ').isEmpty()'
  fix '\.size\(\)\)\.isEqualTo\(([^;X]+)\)' ').hasSize($1)'

  grep -q 'within(' $file && ! grep -q 'org.assertj.core.api.Assertions.within' $file \
      && perl -0777 -i -pe 's/(package .*?\n)/$1\nimport static org.assertj.core.api.Assertions.within;/gs' $file
done

find . -name "*.bak*" -delete
