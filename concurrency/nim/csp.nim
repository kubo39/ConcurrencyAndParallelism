import threadpool # spawn

type StringChannel = Channel[string]
var channel: StringChannel

proc seek(name: string) {.thread.} =
  while true:
    let (ready, peer) = channel.tryRecv()
    if ready:
      echo name & " received message from " & peer
      break
    channel.send(name)
    break

proc main =
  const people = ["Anna", "Bob", "Cody", "Dave", "Eva"]
  channel.open()
  for name in people:
    spawn seek(name)
  let (ready, name) = channel.tryRecv()
  if ready:
    echo "No one received " & name & "'s message."
  sync()
  channel.close()

when isMainModule:
  main()
