jmeter_server_pid=""

start_server_pid=""
start_jmeter() {
 echo "Starting jmeter server process..."
 jmeter-server & jmeter_server_pid=${echo $!}
}
start_jmeter

echo "More commands running here..."
echo "Termination jmeter server by using ${jmeter_server_pid} Process ID."
kill -SIGTERM "${jmeter_server_pid}"

