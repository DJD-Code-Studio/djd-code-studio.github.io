#!/bin/bash
###################################################################################################
###################################################################################################
###  Authors 						: debajyoti.dutta@hpe.com
###  Create Date 					: 2017-08-21-Monday
###  Team 							: indiabrazilmiddleware@hpe.com
###  Approved by 					: debajyoti.dutta@hpe.com
###  Comment 						: Script to run as cron job on every 15th and 45th minute of an hour.
###  									This script will check the usage percentage of /logs and compare with the 'safe threshold %'.
###										This script will simply trigger a manual call to the generic "rotatelog" script for web instances.
###										This script does not do any zipping or deleting of log files.
###  Script File Name 				: logCleaner_LANairlines_prod.sh
###  Script Log File Name 			: logCleaner_LANairlines_prod.sh.log
###  Script Log Backup File Name	 : logCleaner_LANairlines_prod.sh.log_old
###  Script Path      				: /app/scripts/
###  Last updated date				:
###  Last updated by				: debajyoti.dutta@hpe.com
###################################################################################################
###################################################################################################

### Global variable declaration and initialization
#================================================================================================================================#
		export script_parameter_count=$#
		export scan_location="/logsweblogic"
		export script_location="/app/"
		export script_file_name="logCleaner_LANairlines_prod.sh"
		export script_log_file="logCleaner_LANairlines_prod.log"
		export script_log_old_file="logCleaner_LANairlines_prod.log_old"
		export script_log_file_path=``
		export script_log_old_file_path=``
		export capture_scan_location_usage_value=``
		export safe_threshold_percentage_value=$1
		export min_retention_period=$2
		export file_count_in_scan_location=``
		export action_date_time=`/bin/date +"%F--%a--%r--%Z"`
		export USR=`id | grep wlsadm12`
		export logCleaner_lock_file="logCleaner_LANairlines_prod.lock"


#================================================================================================================================#
### Self Check - it checks the running processes to see if it is already running
#================================================================================================================================#
	function SelfCheck2
	{
		cd /app/scripts
		## Check if logCleaner is already running
		if [ -f "$script_location/$logCleaner_lock_file" ] ;
			then
				PID=$(cat $script_location/$logCleaner_lock_file)
				ps -p $PID > /dev/null 2>&1
					if [ $? -eq 0 ]; ## checks if the output of the last run command is successful (denoted by exit code 0)
					then
						echo -e "[ $action_date_time ] \t logCleaner_LANairlines_prod is already running ... Hence exiting ..." >> $script_log_file_path
						exit 1
					else
						## Process not found -- assumed "logCleaner" script not running
						sudo -u admweb chmod 666 $script_location/$logCleaner_lock_file
						echo $$ > $script_location/$logCleaner_lock_file   ## writes the process id of the current script run to the lock file
							if [ $? -ne 0 ]
							then
								echo -e "[ $action_date_time ] \t Could not start new process of logCleaner ... Hence exiting ..." >> $script_log_file_path
								exit 1
							fi
					fi
		else
		## LOCK file not found -- assumed "logCleaner" script not running
			sudo -u admweb touch $script_location/$logCleaner_lock_file
			sudo -u admweb chmod 666 $script_location/$logCleaner_lock_file
			echo $$ > $script_location/$logCleaner_lock_file
				if [ $? -ne 0 ]
				then
					echo -e "[ $action_date_time ] \t Could not start logCleaner ... Hence exiting ....	" >> $script_log_file_path
					exit 1
				fi
		fi

		## Check if rotatelog is already running
		##( discounting the rotatelogs bound to the apache httpd processes for example
		##admweb   22996 22995  0 Dec12 ?        00:00:00 /app/apache/httpd-2.2.13/bin/rotatelogs /logs/apache/error.log.%Y-%m-%d-%H_%M_%S 10M
		##admweb   22997 22995  0 Dec12 ?        00:00:00 /app/apache/producao/bin/rotatelogs /logs/apache/awstats/awstats_error.%Y-%m-%d-%H_%M_%S.log 10M
		##admweb   22998 22995  0 Dec12 ?        00:00:00 /app/apache/httpd-2.2.13/bin/rotatelogs /logs/apache/logviewer/logviewer_error.%Y-%m-%d-%H_%M_%S.log 1M
		##admweb   22999 22995  0 Dec12 ?        00:00:00 /app/apache/httpd-2.2.13/bin/rotatelogs /logs/apache/error_novaura.%Y-%m-%d-%H_%M_%S.log 10M
		##admweb   23000 22995  0 Dec12 ?        00:00:00 /app/apache/httpd-2.2.13/bin/rotatelogs /logs/apache/access.log.%Y-%m-%d-%H_%M_%S 10M
		##admweb   23001 22995  0 Dec12 ?        00:00:00 /app/apache/producao/bin/rotatelogs /logs/apache/awstats/awstats_access.%Y-%m-%d-%H_%M_%S.log 10M
		##admweb   23002 22995  0 Dec12 ?        00:00:01 /app/apache/httpd-2.2.13/bin/rotatelogs /logs/apache/logviewer/logviewer_access.%Y-%m-%d-%H_%M_%S.log 1M
		##admweb   23003 22995  0 Dec12 ?        00:02:50 /app/apache/httpd-2.2.13/bin/rotatelogs /logs/apache/access_novaura.%Y-%m-%d-%H_%M_%S.log 10M
		##)
		if [ `ps -ef | grep -i "rotatelog" | grep -v grep | grep -v "apache" | wc -l` -gt 1 ]
			then
				echo -e "[ $action_date_time ] \t Could not start logCleaner ... Since \"rotatelog\" is already running .... Hence ... exiting ...	" >> $script_log_file_path
				### correction needed here
		fi

		sudo -u admweb chmod 444 $script_location/$logCleaner_lock_file
	}

	function clean_up2
	{
		# removing the lock file to allow the next run of the script
		sleep 60s

		sudo -u admweb chmod 777 $script_location/$logCleaner_lock_file
		sudo -u admweb rm -f $script_location/$logCleaner_lock_file

	}
#================================================================================================================================#
###### The following only checckes the existence of the script log file - if found sets it mode.
###### If not found creates it and sets it mode. Mode is 777
#================================================================================================================================#

	function scriptLOGfile_self_maintain2
	{
		if [ -a "$script_location/$script_log_file" ];
			then
				script_log_file_path="$script_location/$script_log_file"
				sudo -u admweb chmod 666 $script_log_file_path
					#sudo -u admweb chown admweb:admweb $script_log_file_path ### commented due to conflict
		else
				sudo -u admweb touch $script_location/$script_log_file
				script_log_file_path="$script_location/$script_log_file"
				sudo -u admweb chmod 666 $script_log_file
					#sudo -u admweb chown admweb:admweb $script_log_file ### commented due to conflict
		fi

		if [[ `sudo -u admweb du -m $script_log_file_path | /usr/bin/awk '{print $1}'` -gt 50 ]];
			then
				if [ -a "$script_location/$script_log_old_file" ];
					then
						script_log_old_file_path=`$script_location/$script_log_old_file`
						sudo -u admweb chmod 666 $script_log_old_file_path
						sudo -u admweb cp /dev/null $script_log_old_file_path 	# this will flush the log_old file
						sudo -u admweb cp -pv $script_log_file_path $script_log_old_file_path
						sudo -u admweb cp /dev/null $script_log_file_path 	# this will flush the contents of the current log file
						sleep 60s
					else
						sudo -u admweb touch $script_location/$script_log_old_file
						script_log_old_file_path=`$script_location/$script_log_old_file`
						sudo -u admweb chmod 666 $script_log_old_file_path
						sudo -u admweb cp -pv $script_log_file_path $script_log_old_file_path
				fi


		fi
	}

#================================================================================================================================#
### Function to check if it was called using the required number of parameters
#================================================================================================================================#
	function check_for_parameters2
	{


		if [ -z "$USR" ]
		then

		   echo -e "[ $action_date_time ] \t logCleaner was invoked with less permission. Use sudo -u wlsadm12 to invoke the script" >> $script_log_file_path
		   echo "########################################################################################################################" >> $script_log_file_path
		   clean_up2
		   exit 1
		fi

		if [ $script_parameter_count -lt 1 ]
		then
			echo -e "[ $action_date_time ] \t logCleaner was called but necessary parameters were missing. Script needs to be called by passing 2 parameters - 1st) the prescribed threshold df value of \"/logweblogic\" and 2nd) the minimum file retention period for \"/logweblogic\" in number of days" >> $script_log_file_path
			echo "########################################################################################################################" >> $script_log_file_path
			clean_up2
			exit 1
		fi

	}


#================================================================================================================================#
###### This function just checks the threshold value, compares and
###### invokes the necessary actions. It will first search the location specified by $scan_location and check for  
###### After the rotatelog has finished running it checks the value of df again and logs the result and closes the script
#================================================================================================================================#
	function start_and_end_logCleaner
	{
		echo "[ $action_date_time ] \t The current PID values is $$" >> script_log_file_path
		capture_scan_location_usage_value=`df -h | grep $scan_location | /usr/bin/awk '{print $4}' | cut -d"%" -f1`

		if [ $capture_scan_location_usage_value -gt $safe_threshold_percentage_value ];
		then
			echo " "
			echo -e "[ $action_date_time ] \t Size of \"/logweblogic\" - $capture_scan_location_usage_value%. Hence taking necessary actions" >> $script_log_file_path # new line added formatted with tab


			### calling the generic rotatelog script for web instances for a manual cleanup
			/app/scripts/rotatelog
			### rechecking the df value after the manual cleanup
			capture_scan_location_usage_value=`df -h | grep $scan_location | /usr/bin/awk '{print $4}' | cut -d"%" -f1`

			echo -e "[ $action_date_time ] \t Size of \"/logs\" - $capture_scan_location_usage_value%." >> $script_log_file_path
			echo -e "[ $action_date_time ] \t Hence NO MORE action required OR possible as per this script's policy" >> $script_log_file_path
			echo "########################################################################################################################" >> $script_log_file_path

		else
			echo " "
			echo -e "[ $action_date_time ] \t Size of \"/logs\" - $capture_scan_location_usage_value%. Hence NO action required OR possible as per this script's policy" >> $script_log_file_path # new line added formatted with tab
			echo "########################################################################################################################" >> $script_log_file_path



		fi




	}

    function zipfiles
    {



    }


#================================================================================================================================#
### Kick Starts the script
#================================================================================================================================#

	scriptLOGfile_self_maintain2

	SelfCheck2

	check_for_parameters2

	start_and_end_logCleaner

	clean_up2

##########################################################################################################################################
