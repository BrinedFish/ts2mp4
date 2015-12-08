#!/bin/sh

cd $(dirname $0)/..

find queue_finished -mmin +720 -exec rm {} \;
find ts_finished -mmin +720 -exec rm {} \;

