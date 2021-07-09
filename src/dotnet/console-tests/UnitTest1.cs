using System;
using console;
using Xunit;

namespace console_tests
{
    public class UnitTest1
    {
        [Fact]
        public void Test1()
        {
            var hoge = new Hoge()
            {
                Name = "hoge",
            };
            Assert.Equal("hoge", hoge.Name);
        }

        [Fact]
        public void Test2() => Assert.True(1 == 2, "Let's Fail!!");
    }
}
