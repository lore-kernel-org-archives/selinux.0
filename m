Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA17615
	for <selinux@tycho.nsa.gov>; Thu, 14 Nov 2002 17:16:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA10594
	for <selinux@tycho.nsa.gov>; Thu, 14 Nov 2002 22:14:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA10588
	for <selinux@tycho.nsa.gov>; Thu, 14 Nov 2002 22:14:28 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 819AC92668
	for <selinux@tycho.nsa.gov>; Fri, 15 Nov 2002 09:16:20 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E2C24A82C
	for <selinux@tycho.nsa.gov>; Thu, 14 Nov 2002 23:16:11 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux <selinux@tycho.nsa.gov>
Subject: cron/fcron policy
Date: Thu, 14 Nov 2002 23:16:11 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_Z67LNXLAVDAO6PW751BH"
Message-Id: <200211142316.11495.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_Z67LNXLAVDAO6PW751BH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have made significant changes to the policy for cron.

I have made crond be based on daemon_domain(), and I have made fcron run in 
the same domain as crond (using a separate domain offered little benefit and 
lots of pain).

I have attached the following three files:
domains/misc/fcron.te
domains/program/crond.te
file_contexts/program/crond.fc

I attached the files instead of using a diff because the changes are too 
great, 90% of the contents changed.

There are a few other changes that this change requires, I'll send a patch 
soon.

I've updated http://www.coker.com.au/selinux/policy.tgz with all my policy 
related to this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_Z67LNXLAVDAO6PW751BH
Content-Type: text/plain;
  charset="us-ascii";
  name="crond.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="crond.fc"

# crond
/etc/crontab			system_u:object_r:system_crond_script_t
/etc/cron.d(/.*)?		system_u:object_r:system_crond_script_t
/usr/sbin/cron(d)?		system_u:object_r:crond_exec_t
/usr/sbin/anacron		system_u:object_r:anacron_exec_t
/var/spool/cron			system_u:object_r:cron_spool_t
/var/spool/cron/crontabs	system_u:object_r:cron_spool_t
/var/spool/cron/crontabs/.*	system_u:object_r:user_cron_spool_t
/var/spool/cron/crontabs/root	system_u:object_r:sysadm_cron_spool_t
/var/log/cron			system_u:object_r:cron_log_t
/var/log/mrtg(/.*)?		system_u:object_r:cron_log_t
/var/run/crond.reboot		system_u:object_r:var_run_crond_t
/var/run/crond.pid		system_u:object_r:var_run_crond_t
# fcron
/usr/sbin/fcron			system_u:object_r:crond_exec_t
/var/spool/fcron		system_u:object_r:cron_spool_t
/var/spool/fcron/.*		<<none>>
/var/spool/fcron/systab.orig	system_u:object_r:sysadm_cron_spool_t
/var/run/fcron.fifo		system_u:object_r:var_run_crond_t

--------------Boundary-00=_Z67LNXLAVDAO6PW751BH
Content-Type: text/plain;
  charset="us-ascii";
  name="crond.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="crond.te"

#
# Domains for the top-level crond daemon process and
# for system cron jobs.  The domains for user cron jobs
# are in macros/program/crond_macros.te.
#

#
# Authors:  Jonathan Crowley (MITRE) <jonathan@mitre.org>,
#	    Stephen Smalley <sds@tislabs.com> (NAI Labs) and Timothy Fraser
#

# Domain for crond.  Does it really need auth?
daemon_domain(crond, `, privrole, privmail, auth, privfd')

# This domain is granted permissions common to most domains (including can_net)
general_domain_access(crond_t)

# Type for the anacron executable.
type anacron_exec_t, file_type, sysadmfile, exec_type;

# Type for temporary files.
tmp_domain(crond)

# Domain for system cron jobs.
type system_crond_t, domain, privlog, privmail;

ifdef(`mta.te', `
allow mta_user_agent system_crond_t:fd use;
')

# to stop killall type operations from filling our logs
dontaudit system_crond_t domain:dir search;

# Type for log files.
type cron_log_t, file_type, sysadmfile, logfile;
# Use this type when creating files in /var/log.
file_type_auto_trans(crond_t, var_log_t, cron_log_t)

# Use capabilities.
allow crond_t crond_t:capability { setgid setuid net_bind_service };

# Check entrypoint permission on crontab files.
allow crond_t security_t:security compute_av;

# for finding binaries and /bin/sh
allow crond_t { bin_t sbin_t }:dir search;
allow crond_t bin_t:lnk_file read;

# Read from /var/spool/cron.
allow crond_t { var_lib_t var_spool_t }:dir search;
allow crond_t cron_spool_t:dir r_dir_perms;
allow crond_t cron_spool_t:file r_file_perms;

# Read system crontabs
allow crond_t system_crond_script_t:file r_file_perms;
allow crond_t system_crond_script_t:dir r_dir_perms;

# Read /etc/security/default_contexts.
allow crond_t default_context_t:file r_file_perms;

allow crond_t etc_t:file { getattr read };
allow crond_t etc_t:lnk_file read;

# crond tries to search /root.  Not sure why.
allow crond_t sysadm_home_dir_t:dir r_dir_perms;

# to search /home
allow crond_t home_root_t:dir { getattr search };
allow crond_t user_home_dir_type:dir r_dir_perms;

# Run a shell.
can_exec(crond_t, shell_exec_t)

allow crond_t fs_t:filesystem getattr;

ifdef(`rpm.te',
`# Run the rpm program in the rpm_t domain. Allow creation of RPM log files
# via redirection of standard out.
domain_auto_trans(crond_t, rpm_exec_t, rpm_t)
allow crond_t var_log_rpm_t: file create_file_perms;

domain_auto_trans(system_crond_t, rpm_exec_t, rpm_t)
allow system_crond_t var_log_rpm_t: file create_file_perms;')

# This system_r role is authorized for this domain.
role system_r types system_crond_t;

# This domain is granted permissions common to most domains.
every_domain(system_crond_t)
allow system_crond_t var_log_t:file r_file_perms;

# Type for system crontab files.
type system_crond_script_t, file_type, sysadmfile;

# Permit crond_t to transition to this domain.
# The transition is requested explicitly by the modified crond 
# via execve_secure.  There is no way to set up an automatic
# transition, since crontabs are configuration files, not executables.
domain_trans(crond_t, shell_exec_t, system_crond_t)

# Transition to this domain for anacron as well.
# Still need to study anacron.
domain_auto_trans(initrc_t, anacron_exec_t, system_crond_t)
type_transition init_t anacron_exec_t:process system_crond_t;

# Access log files
file_type_auto_trans(system_crond_t, var_log_t, cron_log_t)

# Inherit and use descriptors from init.
allow system_crond_t init_t:fd use;

# Inherit and use descriptors from initrc.
allow system_crond_t initrc_t:fd use;

# Write to a socket from initrc.
allow system_crond_t initrc_t:udp_socket rw_socket_perms;

# Use capabilities.
allow system_crond_t system_crond_t:capability { setgid setuid dac_override fowner net_bind_service fsetid };

# Read the system crontabs.
allow system_crond_t system_crond_script_t:file r_file_perms;

# 
# Since crontab files are not directly executed,
# crond must ensure that the crontab file has
# a type that is appropriate for the domain of
# the system cron job.  It performs an entrypoint
# permission check for this purpose.
#
allow system_crond_t system_crond_script_t:file entrypoint;
ifdef(`fcron.te', `
allow system_crond_t sysadm_cron_spool_t:file entrypoint;
')

# Run helper programs in the system_crond_t domain.
can_exec_any(system_crond_t)

# Read from /var/spool/cron.
allow system_crond_t cron_spool_t:dir r_dir_perms;
allow system_crond_t cron_spool_t:file r_file_perms;

# Write to /var/lib/slocate.db.
allow system_crond_t var_lib_t:dir rw_dir_perms;
allow system_crond_t var_lib_t:file create_file_perms;

# Update whatis files.
allow system_crond_t catman_t:dir rw_dir_perms;
allow system_crond_t catman_t:file create_file_perms;

# Write /var/lock/makewhatis.lock.
allow system_crond_t var_lock_t:dir rw_dir_perms;
allow system_crond_t var_lock_t:file create_file_perms;

# Modutils are now combined, so we can no longer distinguish them.
# Let crond run the insmod executable in the insmod_t domain.
ifdef(`modutil.te', `
system_crond_entry(insmod_exec_t, insmod_t)
')

# Run logrotate in the logrotate_t domain.
ifdef(`logrotate.te', `
system_crond_entry(logrotate_exec_t, logrotate_t)
')

ifdef(`mta.te', `
r_dir_file(system_mail_t, crond_tmp_t)
')

# Stat any file and search any directory for find.
allow system_crond_t file_type:file_class_set getattr;
allow system_crond_t file_type:dir { read search getattr };

# Create temporary files.
type system_crond_tmp_t, file_type, sysadmfile, tmpfile;
file_type_auto_trans(system_crond_t, { tmp_t crond_tmp_t }, system_crond_tmp_t)

# /sbin/runlevel ask for w access to utmp, but will operate
# correctly without it.  Do not audit write denials to utmp.
dontaudit system_crond_t initrc_var_run_t:file { read write };

# Access accounting summary files.
allow system_crond_t var_log_sa_t:file create_file_perms;
allow system_crond_t var_log_sa_t:dir rw_dir_perms;

# Access other spool directories like
# /var/spool/anacron and /var/spool/slrnpull.
allow system_crond_t var_spool_t:file create_file_perms;
allow system_crond_t var_spool_t:dir rw_dir_perms;

# Do not audit attempts to search unlabeled directories (e.g. slocate).
dontaudit system_crond_t unlabeled_t:dir r_dir_perms;
dontaudit system_crond_t unlabeled_t:file r_file_perms;

# Determine the set of legal user SIDs that can be reached.
allow crond_t security_t:security { sid_to_context context_to_sid get_user_sids };

--------------Boundary-00=_Z67LNXLAVDAO6PW751BH
Content-Type: text/plain;
  charset="us-ascii";
  name="fcron.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fcron.te"

#DESC fcron - additions to cron policy for a more powerful cron program
#
# Domain for fcron, a more powerful cron program.
#
# Needs cron.te installed.
#
# Author: Russell Coker <russell@coker.com.au>

# Use capabilities.
allow crond_t self:capability { dac_override dac_read_search };

# differences betweenr_dir_perms and rw_dir_perms
allow crond_t cron_spool_t:dir { add_name remove_name write };

ifdef(`mta.te', `
# not sure why we need write access, but Postfix does not work without it
# I will have to change fcron to avoid the need for this
allow { system_mail_t mta_user_agent } cron_spool_t:file { read write getattr };
')

ifdef(`dpkg.te', `
can_exec(dpkg_t, crontab_exec_t)
file_type_auto_trans(dpkg_t, cron_spool_t, sysadm_cron_spool_t)
')

rw_dir_create_file(crond_t, cron_spool_t)


--------------Boundary-00=_Z67LNXLAVDAO6PW751BH--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
