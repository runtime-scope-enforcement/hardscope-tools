#!/bin/bash

set -u

fancy=1

# Reliable way to get full path to script
# http://stackoverflow.com/questions/4774054/
TESTDIR=$(cd $(dirname ${BASH_SOURCE[0]}) > /dev/null; pwd -P )
REGRESSIONFILE=${TESTDIR}/regress
SUCCESSFILE=${TESTDIR}/success
SUCCESSFILE_NEW=${TESTDIR}/success.new
expectret="test_buffer_overflow255x test_stack_sub255x test_stack_sub_pointer255x test_return_55x test_oneoff_stack255x"

printred(){
  echo -ne '\e[91m'
}
printgreen(){
  echo -ne '\e[32m'
}
nocolor() {
  echo -ne '\e[0m'
}
report() {
  if [ $1 -ne 0 ]; then
    printred
    printf %-12s "fail $1"
  else
    printgreen
    printf %-12s pass
  fi
  nocolor
}

spiketest() {
  wait #clean
  if [[ $1 =~ .*pulpino.bin ]]; then
    $RISCV/bin/spike-pulp "$1" &
  else
    $RISCV/bin/spike pk "$1" &
  fi
  spikepid=$!
  sleep 3 &
  sleeppid=$!
  wait -n
  ret=$?
  if [ $ret -gt 0 ]; then
    kill $spikepid $sleeppid &>/dev/null
    kill $sleeppid
    wait
    return $ret
  fi
  if kill -0 $spikepid &>/dev/null; then
    kill $spikepid &>/dev/null
    kill $sleeppid
    wait
    return 1
  fi
  kill $sleeppid
  wait
  return 0
}

test_regress() {
  grep -q "$1"'$' ${SUCCESSFILE}
}

regression_report() {
  if grep -q "$1"'$' ${SUCCESSFILE} ${REGRESSIONFILE}; then
    report $2
  else
    report 0
  fi
}

touch ${SUCCESSFILE_NEW}
touch ${REGRESSIONFILE}

tests=${TESTDIR}/test_*.c
printf %-40s%-24s%-24s%-12s\\n "--------" "###### build ######" "######## run #########" "----------"
printf %-40s%-12s%-12s%-12s%-12s%-12s\\n "testname" "riscv" "pulpino" "spike" "spike-pulp" "regression"
printf %-40s%-12s%-12s%-12s%-12s%-12s\\n "testname" "riscv" "pulpino" "spike" "spike-pulp" "regression" | tr 'a-z' '-'
for t in $tests; do
  [ -e "${t}" ] || continue
  tput sc
  testname=$(basename -s .c $t)
  printf %-40s "$testname"
  $TESTDIR/compile_test.sh "${testname}" &>/dev/null
  cret=$?
  report $cret
  
  make -B ${TESTDIR}/${testname}-pulpino.bin &>/dev/null
  pret=$?
  report $pret

  spiketest "${TESTDIR}/${testname}.o" &>/dev/null
  rret=$?

  spiketest "${TESTDIR}/${testname}-pulpino.bin" &>/dev/null
  rpret=$?
  #echo ${testname} $ret >&2
  exp=$(echo $expectret | grep -o ${testname}'[0-9]*'x | sed s/${testname}// | tr -cd '0-9')
  if ! [ -z $exp ]; then
    if [ $exp -eq $rpret ]; then
      rpret=0
    else
      rpret=-1
    fi
    if [ $exp -eq $rret ]; then
      rret=0
    else
      rret=-1
    fi
    #echo ${testname} $exp >&2
  fi

  if [ $rret -eq 0 ] && [ $cret -eq 0 ]; then
    echo ${testname} >>${SUCCESSFILE_NEW}
  elif test_regress ${testname}; then
    echo ${testname} >>${REGRESSIONFILE}
  fi

  report $rret
  regression_report "$testname" 0

  if [ $fancy -ne 0 ] && [ $rret -ne 0 ] || [ $pret -ne 0 ] || [ $cret -ne 0 ] || [ $rpret -ne 0 ]; then
    tput el1
    tput rc
    tput bold
    printf %-40s "$testname"
    tput sgr0
    report $cret
    report $pret
    report $rret
    report $rpret
    regression_report "$testname" 1
  fi
  echo
done
mv ${SUCCESSFILE_NEW} ${SUCCESSFILE}
