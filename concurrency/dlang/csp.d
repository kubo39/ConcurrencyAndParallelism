import core.thread : thread_joinAll;
import std.concurrency;
import std.stdio;

void main()
{
    immutable people = ["Anna", "Bob", "Cody", "Dave", "Eva"];

    auto receiver = spawn(() {
            foreach (_; 0 .. 5)
                writeln(receiveOnly!string);
        });

    foreach (name; people)
    {
        spawn((Tid receiver, string name) {
                send(receiver, name);
            }, receiver, name);
    }

    thread_joinAll;
}
