#!/bin/bash

day_now=
hr_now=
min_now=
sec_now=

day_old=
hr_old=
min_old=
sec_old=

screen_count=1
screen_last_time=""
first_run=1

user_path=`pwd`

if [ -f ${user_path}/screen_last_time ]; then
 screen_last_time=`cat ${user_path}/screen_last_time`
 first_run=0
fi

if [ -f ${user_path}/screen_count ]; then 
 screen_count=`cat ${user_path}/screen_count`
fi

count=`screen -rd | wc -l`
count=`expr $count - 2`

#getinfo now|old date
getinfo(){

echo "getinfo"
date=${2}

if [ "${1}" == "now" ]; then

day_now=`echo ${date} | cut -d ' ' -f '4'`
time_now=`echo ${date} | cut -d ' ' -f '5'`
hr_now=`echo ${time_now} | cut -d ':' -f '1'`
min_now=`echo ${time_now} | cut -d ':' -f '2'`
sec_now=`echo ${time_now} | cut -d ':' -f '3'`

else

day_old=`echo ${date} | cut -d ' ' -f '4'`
time_old=`echo ${date} | cut -d ' ' -f '5'`
hr_old=`echo ${time_old} | cut -d ':' -f '1'`
min_old=`echo ${time_old} | cut -d ':' -f '2'`
sec_old=`echo ${time_old} | cut -d ':' -f '3'`

fi

} ##end of getinfo

date_now=`date`

if [ "${first_run}" == "0" ]; then

 getinfo "now" ${date_now}
 getinfo "last_time" ${screen_last_time} 

 if [ ${day_now} == ${day_old} ] && [ ${hr_now} == ${hr_old}  ] && [ ${min_now} == ${min_old} ]; then      
    if [ ${screen_count} -ge ${count} ]; then

      echo "All screen session opened"
      rm ${user_path}/screen_last_time
      rm ${user_path}/screen_count
      exit;

    fi #endof count check
 fi#endof day hr min

fi #first_run check

#####login to screen
screen_count=`expr $screen_count + 1`
max_screen_exist=`screen -rd | wc -l`
max_screen_exist=`expr $max_screen_exist - 1`

echo "screen count: $screen_count - $max_screen_exist"
if [ ${max_screen_exist} -ge ${screen_count} ]; then
 
 next_screen=`screen -rd | awk NR==${screen_count} | cut -d '.' -f '1'`
 echo ${date_now}          >${user_path}/screen_last_time
 echo ${screen_count}     >${user_path}/screen_count

 echo "Screen Loged in: ${next_screen}"
 echo screen -rd ${next_screen}
 screen -rd ${next_screen}

else

 rm ${user_path}/screen_last_time
 rm ${user_path}/screen_count

fi

