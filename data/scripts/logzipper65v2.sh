#!/bin/bash
###################################################################################################
###################################################################################################
###  Authors 						: viswanath.udayagiri@hpe.com; debajyoti.dutta@hpe.com 
###  Create Date 					: 2016-12-07-Wednesday 
###  Team 							: indiabrazilmiddleware@hpe.com	
###  Approved by 					: debajyoti.dutta@hpe.com	
###  Comment 						: Script to run as cron job on every 15th and 45th minute of an hour.
###  									This script will check the usage percentage of /logs and compare with the 'safe threshold %'.
###										The script will also compare with retention period of files for /log and will quit when that retention period is reached
### 									The script will only zip files and not delete them
### 									Deletion will be handled by the rotatelog or rotateout script prepared by the team 				
### 									AMS.Run.Center.Brazil.Web.Middleware@hpe.com		
###  Script File Name 				: logzipper65.sh			
###  Script Log File Name 			: logzipper65.log
###  Script Log Backup File Name	 : logzipper65.log_old
###  Script Path      				: /app/scripts/                  
###  Last updated date				: 2016-12-18
###  Last updated by				: debajyoti.dutta@hpe.com
###################################################################################################
###################################################################################################

### Global variable declaration and initialization
#================================================================================================================================#
		export script_parameter_count=$#
		export scan_location="/logs"
		export script_location="/app/scripts"
		export script_file_name="logzipper65.sh"
		export script_log_file="logzipper65.log"
		export script_log_old_file="logzipper65.log_old"
		export script_log_file_path=``
		export script_log_old_file_path=``
		export capture_scan_location_usage_value=``
		export safe_threshold_percentage_value=$1
		export min_retention_period=$2
		export file_count_in_scan_location=``
		export action_date_time=`/bin/date +"%F--%a--%r--%Z"`
		export find_pointer=1
		export filename_to_zip=``
		export zipping_skipped=0
		export zipping_success=0
		export zipping_failed=0
		export USR=`id | grep admweb`
		export logzipper65_lock_file="logzipper65.lock"
		

#================================================================================================================================#
### Self Check - it checks the running processes to see if it is already running
#================================================================================================================================#
	function SelfCheck
	{
		cd /app/scripts
		if [ -f "$script_location/$logzipper65_lock_file" ] ;
			then
				PID=$(cat $script_location/$logzipper65_lock_file)
				ps -p $PID > /dev/null 2>&1
					if [ $? -eq 0 ];
					then
						echo "logzipper65 is already running... Hence exiting ..."
						exit 1
					else
						## Process not found -- assumed "logzipper65" script not running
						echo $$ > $script_location/$logzipper65_lock_file
							if [ $? -ne 0 ]
							then
								echo "Could not start new process of logzipper65.... Hence exiting ...." 
								exit 1
							fi
					fi	
		else
		## LOCK file not found -- assumed "logzipper65" script not running
			sudo -u admweb touch $script_location/$logzipper65_lock_file
			sudo -u admweb chmod 666 $script_location/$logzipper65_lock_file
			echo $$ > $script_location/$logzipper65_lock_file
				if [ $? -ne 0 ]
				then
					echo "Could not start logzipper65.... Hence exiting ....	"
					exit 1
				fi
		fi
		
		sudo -u admweb chmod 444 $script_location/$logzipper65_lock_file
	}

	function clean_up
	{
		# removing the lock file to allow the next run of the script
		sleep 60s
		
		sudo -u admweb chmod 777 $script_location/$logzipper65_lock_file
		sudo -u admweb rm -f $script_location/$logzipper65_lock_file
	
	}
#================================================================================================================================#
###### The following only checckes the existence of the script log file - if found sets it mode. 
###### If not found creates it and sets it mode. Mode is 777 
#================================================================================================================================#
		
	function scriptLOGfile_self_maintain
	{	
		if [ -a "$script_location/$script_log_file" ];
			then
				script_log_file_path="$script_location/$script_log_file"
				sudo -u admweb chmod 666 $script_log_file_path
					#sudo -u admweb chown admweb:admweb $script_log_file_path ### commented due to conflict
		else
				sudo -u admweb touch $script_location/$script_log_file
				script_log_file_path="$script_location/logzipper65.log"
				sudo -u admweb chmod 666 $script_log_file
					#sudo -u admweb chown admweb:admweb $script_log_file ### commented due to conflict
		fi
		
		if [[ `sudo -u admweb du -m $script_log_file | /usr/bin/awk '{print $1}'` -gt 50 ]];
			then
				if [ -a "$script_location/$script_log_old_file" ];
					then 
						script_log_old_file_path=`$script_location/$script_log_old_file`
						sudo -u admweb chmod 666 $script_log_old_file_path
						sudo -u admweb cp /dev/null $script_log_old_file_path # this will flush the log_old file 
						sudo -u admweb cp -pv $script_log_file_path $script_log_old_file_path
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
	function check_for_parameters
	{
		
		
		if [ -z "$USR" ]
		then
		   
		   echo -e "[ $action_date_time ] \t logzipper65 was invoked with less permission. Use sudo -u admweb to invoke the script" >> $script_log_file_path
		   echo "########################################################################################################################" >> $script_log_file_path
		   clean_up
		   exit 1
		fi
		
		if [ $script_parameter_count -lt 2 ]
		then
			echo -e "[ $action_date_time ] \t logzipper65 was called but necessary parameters were missing. Script needs to be called by passing 2 parameters - 1st) the prescribed threshold df value of \"/logs\" and 2nd) the minimum file retention period for \"/logs\" in number of days" >> $script_log_file_path
			echo "########################################################################################################################" >> $script_log_file_path
			clean_up
			exit 1
		fi
	
	}
	

#================================================================================================================================#
###### This function receives the file path and name to be acted upon. 
###### If the file is already zipped, the script skips it. Otheerwise it zips the file. 
#================================================================================================================================#
	function check_and_zip_files
	{
		echo -en "[ $action_date_time ]\t $find_pointer )\t File found for zipping -- $filename_to_zip " >> $script_log_file_path
		
		if [[ $filename_to_zip =~ \.gz$ ]] || [[ $filename_to_zip =~ \.t?gz$ ]] || [[ $filename_to_zip =~ \.bz2$ ]];
		then
			echo "  -- already a zipped file. Hence skipping... " >> $script_log_file_path
			: $(( zipping_skipped++ ))
		else	
			if [ -a $filename_to_zip ];
			then 
				sudo -u admweb gzip $filename_to_zip
				echo "  -- zipping successfully done " >> $script_log_file_path
				: $(( zipping_success++ ))
				capture_scan_location_usage_value=`df -h | grep $scan_location | /usr/bin/awk '{print $4}' | cut -d"%" -f1`
			else
				echo "  Zipping	failed " >> $script_log_file_path
				: $(( zipping_failed++ ))
			fi # inner if ends here
		fi	# outer if ends here
		
		: $(( find_pointer++ )) 
	}
#================================================================================================================================#
###### This function does the threshold comparison again in loop 
###### and finds the list of polluting files and also triggers the 
###### zipping function "check_and_zip_files"
#================================================================================================================================#
	function compare_threshold_and_find_files
	{
		file_count_in_scan_location=`sudo -u admweb find $scan_location -type f -mtime +$min_retention_period ! -iname ".*" -exec ls -clh {} \; | wc -l`
		echo -e "[ $action_date_time ] \t No of files found for zipping --  $file_count_in_scan_location" >> $script_log_file_path
		## 2nd statement in the logs
		while [ $capture_scan_location_usage_value -gt $safe_threshold_percentage_value ] && [ $find_pointer -le $file_count_in_scan_location ]; 
		do			
			filename_to_zip=`sudo -u admweb find $scan_location -type f -mtime +$min_retention_period ! -iname ".*" -exec ls -clh {} \; | sed -n ${find_pointer}p | /usr/bin/awk '{print $9}'`
			check_and_zip_files			
		done
		sleep 120s
		echo -e "[ $action_date_time ] \t Size of \"/logs\" - $capture_scan_location_usage_value%." >> $script_log_file_path
		echo -e "[ $action_date_time ] \t $zipping_success  files have been zipped successfully" >> $script_log_file_path
		echo -e "[ $action_date_time ] \t $zipping_skipped  files have been skipped" >> $script_log_file_path
		echo -e "[ $action_date_time ] \t $zipping_failed  files failed to be zipped" >> $script_log_file_path
		echo -e "[ $action_date_time ] \t Hence NO MORE zipping required OR possible as per this script's policy" >> $script_log_file_path
		echo "########################################################################################################################" >> $script_log_file_path
		 
	}
#================================================================================================================================#
###### This function just checks the threshold value, compares and
###### triggers the control to the function for finding the 
###### polluter files "compare_threshold_and_find_files" 	
#================================================================================================================================#
	function start_and_end_logzipper65
	{
		echo "The current PID values is $$" >> script_log_file_path
		capture_scan_location_usage_value=`df -h | grep $scan_location | /usr/bin/awk '{print $4}' | cut -d"%" -f1`
		
		if [ $capture_scan_location_usage_value -gt $safe_threshold_percentage_value ];
		then
			echo " "
			echo -e "[ $action_date_time ] \t Size of \"/logs\" - $capture_scan_location_usage_value%. Hence  logzipper65 invoked" >> $script_log_file_path # new line added formatted with tab
			## 1st statement in the logs
			#scriptLOGfile_self_maintain
			
			compare_threshold_and_find_files
			
		else
			echo " "
			echo -e "[ $action_date_time ] \t Size of \"/logs\" - $capture_scan_location_usage_value%. Hence NO MORE zipping required OR possible as per this script's policy" >> $script_log_file_path # new line added formatted with tab
			echo "########################################################################################################################" >> $script_log_file_path
			
			## 1st statement in the logs
			
		fi
		
		
		
		
	}
	


#================================================================================================================================#
### Kick Starts the script 
#================================================================================================================================#
	
	SelfCheck
		
	scriptLOGfile_self_maintain
	
	check_for_parameters
	
	start_and_end_logzipper65
	
	clean_up