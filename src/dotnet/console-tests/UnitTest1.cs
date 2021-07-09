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
    }
}
