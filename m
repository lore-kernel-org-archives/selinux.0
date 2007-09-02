Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l82D52eN005534
	for <selinux@tycho.nsa.gov>; Sun, 2 Sep 2007 09:05:02 -0400
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l82D50o7017563
	for <selinux@tycho.nsa.gov>; Sun, 2 Sep 2007 13:05:00 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
To: "Christopher PeBenito J." <cpebenito@tresys.com>
Message-Id: <F132C258-18C1-456D-8679-430EE55597A9@sf-net.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-1--22303198
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: [refpolicy] updated awstats policy
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Date: Sun, 2 Sep 2007 15:04:54 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-1--22303198
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

After reading Dan's article about writing SELinux policies I decided  
to remove the awstats_conf_t type. He suggests to only declare an  
extra type if there is something to protect. The config files of  
awstats do not include any sensitive data. The default installation  
even permit unix world readable permissions.

Second (the most important bug I wrote ;-)) the awstats cgi script  
was allowed to manage awstats_lib_t files which is _not_ necessary. I  
allowed that because awstats_t executes the  
httpd_awstats_script_exec_t to update the statistic files. But the  
cgi script called from a web interface only needs read permissions so  
I added an interface awstats_cgi_exec to handle this situation. Now  
awstats_t executes httpd_awstats_script_exec_t in its domain which is  
the preferred and more secure way.
In the end the untrustworthy cgi script has only read access to  
awstats_lib_t and awstats_t which is called from a trustworthy cron- 
job has write permissions to awstats_lib_t

Please substitute the old ("insecure") awstats policy with the new one.


--Apple-Mail-1--22303198
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=awstats.fc
Content-Disposition: attachment;
	filename=awstats.fc

/usr/share/awstats/tools/.+\.pl			gen_context(system_u:object_r:awstats_exec_t,s0)
/usr/share/awstats/wwwroot(/.*)?		gen_context(system_u:object_r:httpd_awstats_content_t,s0)
/usr/share/awstats/wwwroot/cgi-bin(/.*)?	gen_context(system_u:object_r:httpd_awstats_script_exec_t,s0)

/var/lib/awstats(/.*)?				gen_context(system_u:object_r:awstats_var_lib_t,s0)

--Apple-Mail-1--22303198
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=awstats.if
Content-Disposition: attachment;
	filename=awstats.if

########################################
## <summary>
##      Read and write awstats unnamed pipes.
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`awstats_rw_pipes',`
	gen_require(`
		type awstats_t;
	')

#	allow $1 awstats_t:fifo_file rw_fifo_file_perms;
	allow $1 awstats_t:fifo_file { getattr read write append ioctl lock };
')

########################################
### <summary>
###      Execute awstats cgi scripts in the caller domain.
### </summary>
### <param name="domain">
###      <summary>
###      Domain allowed access.
###      </summary>
### </param>
##
interface(`awstats_cgi_exec',`
	gen_require(`
		type httpd_awstats_script_exec_t;
	')

	allow $1 httpd_awstats_content_t:dir search;
	allow $1 httpd_awstats_script_exec_t:dir search;
	can_exec($1,httpd_awstats_script_exec_t)
')

--Apple-Mail-1--22303198
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=awstats.te
Content-Disposition: attachment;
	filename=awstats.te


policy_module(awstats,1.1.0)

########################################
#
# Declarations
#

type awstats_t;
type awstats_exec_t;
domain_type(awstats_t)
domain_entry_file(awstats_t,awstats_exec_t)
role system_r types awstats_t;

type awstats_tmp_t;
files_tmp_file(awstats_tmp_t)

type awstats_var_lib_t;
files_type(awstats_var_lib_t)

########################################
#
# awstats policy
#

files_tmp_filetrans(awstats_t,awstats_tmp_t,{ dir file })
manage_dirs_pattern(awstats_t,awstats_tmp_t,awstats_tmp_t)
manage_files_pattern(awstats_t,awstats_tmp_t,awstats_tmp_t)

files_var_lib_filetrans(awstats_t,awstats_var_lib_t,file)
manage_files_pattern(awstats_t,awstats_var_lib_t,awstats_var_lib_t)

files_read_etc_files(awstats_t)
# e.g. /usr/share/awstats/lang/awstats-en.txt
files_read_usr_files(awstats_t)

apache_content_template(awstats)

awstats_cgi_exec(awstats_t)
awstats_rw_pipes(awstats_t)

apache_read_log(awstats_t)

libs_read_lib_files(awstats_t)
libs_use_ld_so(awstats_t)
libs_use_shared_libs(awstats_t)

corecmd_exec_bin(awstats_t)
corecmd_exec_shell(awstats_t)

# awstats_t needs rights for reverse dns resolution
sysnet_dns_name_resolve(awstats_t)

miscfiles_read_localization(awstats_t)

dev_read_urand(awstats_t)

corecmd_dontaudit_search_sbin(awstats_t)
# dontaudit access to /proc/meminfo
kernel_dontaudit_read_system_state(awstats_t)
# dontaudit searching nscd's pid directory
nscd_dontaudit_search_pid(awstats_t)

optional_policy(`
	cron_system_entry(awstats_t, awstats_exec_t)
')

########################################
#
# awstats cgi script policy
#

allow httpd_awstats_script_t awstats_var_lib_t:dir read;

files_search_var_lib(httpd_awstats_script_t)
read_files_pattern(httpd_awstats_script_t,awstats_var_lib_t,awstats_var_lib_t)


--Apple-Mail-1--22303198--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
