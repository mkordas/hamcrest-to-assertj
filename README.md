# Hamcrest to AssertJ Converter

### Supported Hamcrest Matchers:
```java
    @Test
    public void simple() {
        assertThat(1, equalTo(1));
        assertThat(1, is(1));
        assertThat(1, is(equalTo(1)));

        assertThat(1, is(not(2)));
        assertThat(1, not(2));
        assertThat(1, not(equalTo(2)));
        assertThat(1, is(not(equalTo(2))));
    }

    @Test
    public void numbers() {
        assertThat(2, lessThan(3));
        assertThat(2, is(lessThan(3)));
        assertThat(2, not(lessThan(1)));
        assertThat(2, is(not(lessThan(2))));

        assertThat(3, greaterThan(2));
        assertThat(3, is(greaterThan(2)));
        assertThat(3, not(greaterThan(4)));
        assertThat(3, is(not(greaterThan(4))));

        assertThat(1.0, is(closeTo(2.0, 1.0)));
        assertThat(1.0, closeTo(2.0, 1.0));

        assertThat(2, lessThanOrEqualTo(2));
        assertThat(2, is(lessThanOrEqualTo(3)));
        assertThat(4, not(lessThanOrEqualTo(3)));
        assertThat(4, is(not(lessThanOrEqualTo(3))));

        assertThat(3, greaterThanOrEqualTo(3));
        assertThat(3, is(greaterThanOrEqualTo(2)));
        assertThat(1, not(greaterThanOrEqualTo(2)));
        assertThat(1, is(not(greaterThanOrEqualTo(2))));
    }

    @Test
    public void strings() {
        assertThat("string", equalToIgnoringCase("STRING"));
        assertThat("string", is(equalToIgnoringCase("STRING")));

        assertThat("string", startsWith("s"));

        assertThat("string", endsWith("g"));

        assertThat("string", containsString("i"));
        assertThat("string", not(containsString("q")));
    }

    @Test
    public void emptyStrings() {
        assertThat("", isEmptyString());
        assertThat("a", not(isEmptyString()));

        assertThat(NULL_STRING, isEmptyOrNullString());
        assertThat("a", not(isEmptyOrNullString()));
    }

    @Test
    public void values() {
        assertThat(NULL_STRING, nullValue());
        assertThat(NULL_STRING, is(nullValue()));
        assertThat("", not(nullValue()));
        assertThat("", is(not(nullValue())));

        assertThat("", notNullValue());
        assertThat("", is(notNullValue()));

        assertThat("", instanceOf(String.class));
        assertThat("", is(instanceOf(String.class)));
        assertThat("", not(instanceOf(Math.class)));
        assertThat("", is(not(instanceOf(Math.class))));

        assertThat("", isA(String.class));

        assertThat("", sameInstance(""));
        assertThat("", is(sameInstance("")));
        assertThat("", not(sameInstance("a")));
        assertThat("", is(not(sameInstance("a"))));

        assertThat("", theInstance(""));
        assertThat("", is(theInstance("")));
        assertThat("", not(theInstance("a")));
        assertThat("", is(not(theInstance("a"))));

        assertThat("", isIn(asList("", "a")));
        assertThat("", not(isIn(asList("a", "b"))));

        assertThat("", isOneOf("", "a"));
        assertThat("", not(isOneOf("a", "b")));
    }

    @Test
    public void iterables() {
        assertThat(asList(0, 1), hasItem(0));
        assertThat(asList(0, 1), not(hasItem(2)));

        assertThat(asList(0, 1), hasItems(0, 1));
        assertThat(asList(0, 1), not(hasItems(2, 3)));

        assertThat(emptyList(), emptyIterable());
        assertThat(emptyList(), is(emptyIterable()));
        assertThat(asList(0, 1), not(emptyIterable()));
        assertThat(asList(0, 1), is(not(emptyIterable())));

        assertThat(emptyList(), emptyIterableOf(Object.class));
        assertThat(emptyList(), is(emptyIterableOf(Object.class)));
        assertThat(asList(0, 1), not(emptyIterableOf(Integer.class)));
        assertThat(asList(0, 1), is(not(emptyIterableOf(Integer.class))));

        assertThat(asList(0, 1), contains(0, 1));
        assertThat(asList(0, 1), not(contains(2)));

        assertThat(asList(0, 1), containsInAnyOrder(1, 0));

        assertThat(asList(0, 1), iterableWithSize(2));
        assertThat(asList(0, 1), is(iterableWithSize(2)));
    }

    @Test
    public void collections() {
        assertThat(emptyList(), empty());
        assertThat(emptyList(), is(empty()));
        assertThat(asList(0, 1), not(empty()));
        assertThat(asList(0, 1), is(not(empty())));

        assertThat(emptyList(), emptyCollectionOf(Object.class));
        assertThat(emptyList(), is(emptyCollectionOf(Object.class)));
        assertThat(asList(0, 1), not(emptyCollectionOf(Integer.class)));
        assertThat(asList(0, 1), is(not(emptyCollectionOf(Integer.class))));

        assertThat(asList(0, 1), hasSize(2));
    }

    @Test
    public void maps() {
        assertThat(singletonMap(0, 1), hasEntry(0, 1));
        assertThat(singletonMap(0, 1), not(hasEntry(1, 1)));

        assertThat(singletonMap(0, 1), hasKey(0));
        assertThat(singletonMap(0, 1), not(hasKey(1)));

        assertThat(singletonMap(0, 1), hasValue(1));
        assertThat(singletonMap(0, 1), not(hasValue(0)));
    }

    @Test
    public void classes() {
        assertThat(String.class, typeCompatibleWith(Object.class));
        assertThat(String.class, is(typeCompatibleWith(Object.class)));
        assertThat(Object.class, not(typeCompatibleWith(String.class)));
        assertThat(Object.class, is(not(typeCompatibleWith(String.class))));
    }

    @Test
    public void arrays() {
        assertThat(new Object[]{}, emptyArray());
        assertThat(new Object[]{}, is(emptyArray()));
        assertThat(new Object[]{1}, not(emptyArray()));
        assertThat(new Object[]{1}, is(not(emptyArray())));

        assertThat(new Object[]{1}, arrayWithSize(1));
        assertThat(new Object[]{1}, is(arrayWithSize(1)));

        assertThat(new Object[]{1, 2}, hasItemInArray(1));
        assertThat(new Object[]{1}, not(hasItemInArray(2)));

        assertThat(new Object[]{1, 2}, arrayContaining(1, 2));
        assertThat(new Object[]{1, 2}, is(arrayContaining(1, 2)));

        assertThat(new Object[]{1, 2}, arrayContainingInAnyOrder(2, 1));
        assertThat(new Object[]{1, 2}, is(arrayContainingInAnyOrder(2, 1)));
    }

    @Test
    public void specialCases() {
        assertThat(true, is(true));
        assertThat(false, is(false));

        assertThat(NULL_STRING, equalTo(null));
        assertThat(emptyList(), not(equalTo(null)));

        assertThat(emptyList(), hasSize(0));
        assertThat(emptyList().size(), is(0));

        assertThat(new Object[]{}, arrayWithSize(0));
        assertThat(new Object[]{}.length, is(0));

        assertThat(singletonList("").size(), is(1));

        assertThat(0, is(0));
    }

    @Test
    public void multiline() {
        assertThat(
                1,
                is(equalTo(1))
        );

        assertThat(1,
                is(equalTo(1))
        );

        assertThat(1,
                is(equalTo(1)));

        assertThat(
                1,
                is(equalTo(1)));

        assertThat(
                1, is(equalTo(1)));
    }

    @Test
    public void noStaticImports() {
        Assert.assertThat(1, Is.is(1));
        assertThat(1, IsEqual.equalTo(1));
        assertThat(1, Matchers.is(1));
        assertThat(1, CoreMatchers.is(1));
    }
```

### Results of conversion:
```java
    @Test
    public void simple() {
        assertThat(1).isEqualTo(1);
        assertThat(1).isEqualTo(1);
        assertThat(1).isEqualTo(1);

        assertThat(1).isNotEqualTo(2);
        assertThat(1).isNotEqualTo(2);
        assertThat(1).isNotEqualTo(2);
        assertThat(1).isNotEqualTo(2);
    }

    @Test
    public void numbers() {
        assertThat(2).isLessThan(3);
        assertThat(2).isLessThan(3);
        assertThat(2).isGreaterThanOrEqualTo(1);
        assertThat(2).isGreaterThanOrEqualTo(2);

        assertThat(3).isGreaterThan(2);
        assertThat(3).isGreaterThan(2);
        assertThat(3).isLessThanOrEqualTo(4);
        assertThat(3).isLessThanOrEqualTo(4);

        assertThat(1.0).isCloseTo(2.0, within(1.0));
        assertThat(1.0).isCloseTo(2.0, within(1.0));

        assertThat(2).isLessThanOrEqualTo(2);
        assertThat(2).isLessThanOrEqualTo(3);
        assertThat(4).isGreaterThan(3);
        assertThat(4).isGreaterThan(3);

        assertThat(3).isGreaterThanOrEqualTo(3);
        assertThat(3).isGreaterThanOrEqualTo(2);
        assertThat(1).isLessThan(2);
        assertThat(1).isLessThan(2);
    }

    @Test
    public void strings() {
        assertThat("string").isEqualToIgnoringCase("STRING");
        assertThat("string").isEqualToIgnoringCase("STRING");

        assertThat("string").startsWith("s");

        assertThat("string").endsWith("g");

        assertThat("string").contains("i");
        assertThat("string").doesNotContain("q");
    }

    @Test
    public void emptyStrings() {
        assertThat("").isEmpty();
        assertThat("a").isNotEmpty();

        assertThat(NULL_STRING).isNullOrEmpty();
        assertThat("a").isNotEmpty();
    }

    @Test
    public void values() {
        assertThat(NULL_STRING).isNull();
        assertThat(NULL_STRING).isNull();
        assertThat("").isNotNull();
        assertThat("").isNotNull();

        assertThat("").isNotNull();
        assertThat("").isNotNull();

        assertThat("").isInstanceOf(String.class);
        assertThat("").isInstanceOf(String.class);
        assertThat("").isNotInstanceOf(Math.class);
        assertThat("").isNotInstanceOf(Math.class);

        assertThat("").isInstanceOf(String.class);

        assertThat("").isSameAs("");
        assertThat("").isSameAs("");
        assertThat("").isNotSameAs("a");
        assertThat("").isNotSameAs("a");

        assertThat("").isSameAs("");
        assertThat("").isSameAs("");
        assertThat("").isNotSameAs("a");
        assertThat("").isNotSameAs("a");

        assertThat("").isIn(asList("", "a"));
        assertThat("").isNotIn(asList("a", "b"));

        assertThat("").isIn("", "a");
        assertThat("").isNotIn("a", "b");
    }

    @Test
    public void iterables() {
        assertThat(asList(0, 1)).contains(0);
        assertThat(asList(0, 1)).doesNotContain(2);

        assertThat(asList(0, 1)).contains(0, 1);
        assertThat(asList(0, 1)).doesNotContain(2, 3);

        assertThat(emptyList()).isEmpty();
        assertThat(emptyList()).isEmpty();
        assertThat(asList(0, 1)).isNotEmpty();
        assertThat(asList(0, 1)).isNotEmpty();

        assertThat(emptyList()).isEmpty();
        assertThat(emptyList()).isEmpty();
        assertThat(asList(0, 1)).isNotEmpty();
        assertThat(asList(0, 1)).isNotEmpty();

        assertThat(asList(0, 1)).containsExactly(0, 1);
        assertThat(asList(0, 1)).doesNotContain(2);

        assertThat(asList(0, 1)).containsOnly(1, 0);

        assertThat(asList(0, 1)).hasSize(2);
        assertThat(asList(0, 1)).hasSize(2);
    }

    @Test
    public void collections() {
        assertThat(emptyList()).isEmpty();
        assertThat(emptyList()).isEmpty();
        assertThat(asList(0, 1)).isNotEmpty();
        assertThat(asList(0, 1)).isNotEmpty();

        assertThat(emptyList()).isEmpty();
        assertThat(emptyList()).isEmpty();
        assertThat(asList(0, 1)).isNotEmpty();
        assertThat(asList(0, 1)).isNotEmpty();

        assertThat(asList(0, 1)).hasSize(2);
    }

    @Test
    public void maps() {
        assertThat(singletonMap(0, 1)).containsEntry(0, 1);
        assertThat(singletonMap(0, 1)).doesNotContainEntry(1, 1);

        assertThat(singletonMap(0, 1)).containsKey(0);
        assertThat(singletonMap(0, 1)).doesNotContainKey(1);

        assertThat(singletonMap(0, 1)).containsValue(1);
        assertThat(singletonMap(0, 1)).doesNotContainValue(0);
    }

    @Test
    public void classes() {
        assertThat(String.class).isInstanceOf(Object.class);
        assertThat(String.class).isInstanceOf(Object.class);
        assertThat(Object.class).isAssignableFrom(String.class);
        assertThat(Object.class).isAssignableFrom(String.class);
    }

    @Test
    public void arrays() {
        assertThat(new Object[]{}).isEmpty();
        assertThat(new Object[]{}).isEmpty();
        assertThat(new Object[]{1}).isNotEmpty();
        assertThat(new Object[]{1}).isNotEmpty();

        assertThat(new Object[]{1}).hasSize(1);
        assertThat(new Object[]{1}).hasSize(1);

        assertThat(new Object[]{1, 2}).contains(1);
        assertThat(new Object[]{1}).doesNotContain(2);

        assertThat(new Object[]{1, 2}).containsExactly(1, 2);
        assertThat(new Object[]{1, 2}).containsExactly(1, 2);

        assertThat(new Object[]{1, 2}).containsOnly(2, 1);
        assertThat(new Object[]{1, 2}).containsOnly(2, 1);
    }

    @Test
    public void specialCases() {
        assertThat(true).isTrue();
        assertThat(false).isFalse();

        assertThat(NULL_STRING).isNull();
        assertThat(emptyList()).isNotNull();

        assertThat(emptyList()).isEmpty();
        assertThat(emptyList()).isEmpty();

        assertThat(new Object[]{}).isEmpty();
        assertThat(new Object[]{}).isEmpty();

        assertThat(singletonList("")).hasSize(1);

        assertThat(0).isZero();
    }

    @Test
    public void multiline() {
        assertThat(
                1).isEqualTo(1);

        assertThat(1).isEqualTo(1);

        assertThat(1).isEqualTo(1);

        assertThat(1).isEqualTo(1);

        assertThat(1).isEqualTo(1);
    }

    @Test
    public void noStaticImports() {
        assertThat(1).isEqualTo(1);
        assertThat(1).isEqualTo(1);
        assertThat(1).isEqualTo(1);
        assertThat(1).isEqualTo(1);
    }
```
### Assertions that cannot be converted due to AssertJ limitations:
```java
    assertThat(2, comparesEqualTo(2));
    assertThat(2, not(comparesEqualTo(3)));
    assertThat(5.0, not(closeTo(2.0, 1.0)));
    assertThat(5.0, is(not(closeTo(2.0, 1.0))));
	
    assertThat("string", not(equalToIgnoringCase("STRIN")));
    assertThat("string", is(not(equalToIgnoringCase("STRIN"))));
    assertThat("string", equalToIgnoringWhiteSpace(" string"));
    assertThat("string", is(equalToIgnoringWhiteSpace(" string")));
    assertThat("string", not(equalToIgnoringWhiteSpace("tring")));
    assertThat("string", is(not(equalToIgnoringWhiteSpace("tring"))));
    assertThat("string", not(startsWith("g")));
    assertThat("string", not(endsWith("s")));
    assertThat("string", stringContainsInOrder(asList("s", "t")));
    assertThat("string", not(stringContainsInOrder(asList("t", "s"))));
	
    assertThat(asList(0, 1), not(containsInAnyOrder(2, 0)));
    assertThat(asList(0, 1, 3), not(iterableWithSize(2)));
    assertThat(asList(0, 1, 3), is(not(iterableWithSize(2))));
    assertThat(asList(0, 1, 3), not(hasSize(2)));
	
    assertThat(new Object[] {}, not(arrayWithSize(1)));
    assertThat(new Object[] {}, is(not(arrayWithSize(1))));
    assertThat(new Object[] { 2, 1 }, not(arrayContaining(1, 2)));
    assertThat(new Object[] { 2, 1 }, is(not(arrayContaining(1, 2))));
    assertThat(new Object[] { 2, 1 }, not(arrayContainingInAnyOrder(1)));
    assertThat(new Object[] { 2, 1 }, is(not(arrayContainingInAnyOrder(2))));
```
