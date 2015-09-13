set PATH=%PATH%;C:\cygwin64\bin

echo '-------' >> C:\TV\log.txt
for %%f in (%*) do (
  echo %%f >> C:\TV\log.txt
)

set TS_FILE=%3

bash -c '/home/jnakano/scripts/copy_ts.sh %1 %2 %TS_FILE:'=\'% 2^>^&1 ^>^> /home/jnakano/scripts/copy_ts.log'
