namespace Sandbox.Console;

public record class Hoge
{
    public string Name { get; init; } = "";
    public bool FooBar => field;

    public Hoge() { }
    public Hoge(bool foobar)
    {
        FooBar = foobar;
    }
}
