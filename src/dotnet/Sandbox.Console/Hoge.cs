namespace Sandbox.Console;

public class Hoge
{
    public string Name { get; init; } = "";
    public bool FooBar => foobar;
    private readonly bool foobar;

    public Hoge() {}
    public Hoge(bool foobar)
    {
        this.foobar = foobar;
    }
}
