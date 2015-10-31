package io.github.mkordas;

import org.hamcrest.CoreMatchers;
import org.hamcrest.Matchers;
import org.hamcrest.core.Is;
import org.hamcrest.core.IsEqual;
import org.hamcrest.core.IsNot;
import org.hamcrest.core.IsNull;
import org.junit.Assert;
import org.junit.Test;

public class HamcrestAssertionsNoStaticImportsTest {
    @Test
    public void noStaticImports() {
        Assert.assertThat(1, Is.is(1));
        Assert.assertThat(2, IsEqual.equalTo(2));
        Assert.assertThat(3, Matchers.is(3));
        Assert.assertThat(4, CoreMatchers.is(4));
        Assert.assertThat(5, IsNot.not(6));
        Assert.assertThat(6, IsNull.notNullValue());
    }
}
