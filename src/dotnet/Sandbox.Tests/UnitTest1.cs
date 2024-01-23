using Sandbox.Console;

namespace Sandbox.Tests;

public class UnitTest1
{
    [Fact]
    public void Ctor()
    {
        var hoge = new Hoge()
        {
            Name = "hoge",
        };
        Assert.Equal("hoge", hoge.Name);
        Assert.False(hoge.FooBar);
    }

    [Fact]
    public void InitProperty()
    {
        var hoge = new Hoge(true);
        Assert.Equal("", hoge.Name);
        Assert.True(hoge.FooBar);
    }
}
