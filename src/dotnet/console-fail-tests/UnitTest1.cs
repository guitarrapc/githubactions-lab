using System;
using Xunit;

namespace console_fail_test
{
    public class UnitTest1
    {
        [Fact]
        public void Test1() => Assert.True(1 == 1);

        [Fact]
        public void Test2() => Assert.True(1 == 2, "Let's Fail!!");
        private void ThrowException() => throw new InvalidOperationException("test fail");
        [Fact]
        public void Test3() => ThrowException();
        [Fact]
        public void Test4() => Assert.Contains(new[] { 1, 2, 3 }, i => i == 4);
    }
}
