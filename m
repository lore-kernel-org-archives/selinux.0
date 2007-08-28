Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SMTwGE014893
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 18:29:58 -0400
Received: from e35.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SMTvKY025884
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 22:29:57 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7SMTvYT023362
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 18:29:57 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7SMTu3V441694
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 16:29:57 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7SMTuil013225
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 16:29:56 -0600
Subject: integrity.te
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: selinux@tycho.nsa.gov
Cc: zohar@us.ibm.com, safford@watson.ibm.com, sailer@us.ibm.com
Content-Type: text/plain
Date: Tue, 28 Aug 2007 18:35:34 -0400
Message-Id: <1188340534.11528.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

policy_module(integrity,1.0.0)

# NEW: add rule in application_executable_file

# Don't explicitly define every *_exec_t here, bound 
# to leave something out. Add rules in
# 'corecmd_executable_file' and 'corecmd_bin_alias'
# (corecommands.if)
# 	'allow domain $1:integrity measure'
allow domain bin_t:integrity measure;

# After adding rule above, 
# 	remove the following rules 
allow domain auditctl_exec_t:integrity measure;
allow domain cpuspeed_exec_t:integrity measure;
allow domain dhcpc_exec_t:integrity measure;
allow domain fsadm_exec_t:integrity measure;
allow domain hplip_exec_t:integrity measure;
allow domain ifconfig_exec_t:integrity measure;
allow domain initrc_exec_t:integrity measure;
allow domain insmod_exec_t:integrity measure;
allow domain hostname_exec_t:integrity measure;
allow domain kudzu_exec_t:integrity measure;
allow domain lvm_exec_t:integrity measure;
allow domain mount_exec_t:integrity measure;
allow domain pam_console_exec_t:integrity measure;
allow domain netutils_exec_t:integrity measure;
allow domain readahead_exec_t:integrity measure;
allow domain shell_exec_t:integrity measure;

# Don't measure all etc_t, but only those open 
# for read. Add rule in # 'files_read_etc_files' 
# (files.if) and measure etc_runtime_t files
allow domain etc_runtime_t:integrity measure;

# After adding rule above, 
# 	remove the following rules 
allow domain etc_t:integrity measure;
allow domain auditd_etc_t:integrity measure;
allow domain cupsd_etc_t:integrity measure;
allow domain dbusd_etc_t:integrity measure;
allow domain etc_aliases_t:integrity measure;
allow domain etc_mail_t:integrity measure;
allow domain hplip_etc_t:integrity measure;
allow domain lvm_etc_t:integrity measure;

# Don't explicitly define every *_conf_t here, 
# add rule in 'files_config_file' (files.if)
# 	'allow domain $1:integrity measure'
 
# These domains don't call files_config_file
allow domain modules_conf_t:integrity measure;
allow domain net_conf_t:integrity measure;

# Measure libraries, kernel modules, etc...
allow domain lib_t:integrity measure;
allow domain ld_so_cache_t:integrity measure;
allow domain ld_so_t:integrity measure;
allow domain modules_object_t:integrity measure;

# Necessary when call to AVC_AUDIT_DATA_INIT in
# selinux_measure is uncommented. 
#dontaudit domain auditd_log_t:integrity measure;
#dontaudit domain fonts_t:integrity measure;
#dontaudit domain hwdata_t:integrity measure;
#dontaudit domain klogd_var_run_t:integrity measure;
#dontaudit domain lib_t:integrity measure;
#dontaudit domain proc_net_t:integrity measure;
#dontaudit domain proc_t:integrity measure;
#dontaudit domain sysfs_t:integrity measure;
#dontaudit domain usr_t:integrity measure;
#dontaudit domain initrc_var_run_t:integrity measure;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
