using System;

namespace console
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine($"Hello World! {args}");
        }
    }

    public class Hoge
    {
        public string Name { get; set; }
        private readonly bool foobar = true;

        public Hoge (bool foobar)
        {
            this.foobar = foobar;
        }
    }
}
