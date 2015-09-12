set PATH=%PATH%;C:\cygwin64\bin

echo '-------' >> C:\TV\log.txt
for %%f in (%*) do (
  echo %%f >> C:\TV\log.txt
)

bash -c '/home/jnakano/scripts/copy_ts.sh %1 %2 %3'