Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2M1N0Do011229
	for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2005 20:23:01 -0500 (EST)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2M1NHIn017008
	for <selinux@tycho.nsa.gov>; Tue, 22 Mar 2005 01:23:18 GMT
Subject: New policy for DCC
From: David Hampton <hampton-rh@rainbolthampton.net>
To: selinux@tycho.nsa.gov
Cc: fedora-selinux-list@redhat.com
Content-Type: multipart/mixed; boundary="=-pJfEnsBuVdhPOfpbgYn7"
Date: Mon, 21 Mar 2005 20:23:18 -0500
Message-Id: <1111454598.18940.57.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-pJfEnsBuVdhPOfpbgYn7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is a new strict policy for the DCC spam filter.  It is based on the
selinux-policy-strict-sources-1.23.2-1 fedora RPM.  This policy requires
the definition of dcc reserved ports that were in the net_contexts diff
I sent last Wednesday.  Please let me know if there are any problems
with or changes needed to this policy.

David


--=-pJfEnsBuVdhPOfpbgYn7
Content-Disposition: attachment; filename=dcc.fc
Content-Type: text/plain; name=dcc.fc; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# DCC
/etc/dcc(/.*)?				system_u:object_r:dcc_var_t
/etc/dcc/map			--	system_u:object_r:dcc_client_map_t
/etc/dcc/dccifd			-s	system_u:object_r:dccifd_sock_t
/usr/bin/cdcc				system_u:object_r:cdcc_exec_t
/usr/bin/dccproc			system_u:object_r:dcc_client_exec_t
/usr/libexec/dcc/dbclean		system_u:object_r:dcc_dbclean_exec_t
/usr/libexec/dcc/dccd			system_u:object_r:dccd_exec_t
/usr/libexec/dcc/dccifd			system_u:object_r:dccifd_exec_t
/usr/libexec/dcc/dccm			system_u:object_r:dccm_exec_t
/usr/libexec/dcc/start-.*		system_u:object_r:dcc_script_exec_t
/usr/libexec/dcc/stop-.*		system_u:object_r:dcc_script_exec_t
/var/dcc(/.*)?				system_u:object_r:dcc_var_t
/var/dcc/map			--	system_u:object_r:dcc_client_map_t
/var/run/dcc				system_u:object_r:dcc_var_run_t
/var/run/dcc/map		--	system_u:object_r:dcc_client_map_t
/var/run/dcc/dccifd		-s	system_u:object_r:dccifd_sock_t

--=-pJfEnsBuVdhPOfpbgYn7
Content-Disposition: attachment; filename=dcc.te
Content-Type: text/plain; name=dcc.te; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#
# DCC - Distributed Checksum Clearinghouse
# Author:  David Hampton <hampton@employees.org>
#
#
# NOTE: DCC has writeable files in /etc/dcc that should probably be in
# /var/lib/dcc.  For now this policy supports both directories being
# writable.

# Ports used by dcc
type dcc_port_t, port_type, reserved_port_type;

# Files common to all dcc programs
type dcc_client_map_t, file_type, sysadmfile;
type dcc_var_t, file_type, sysadmfile;
type dcc_var_run_t, file_type, sysadmfile;


##########
##########

#
# common to all dcc variants
#
define(`dcc_common',`
# Access files in /var/dcc. The map file can be updated
r_dir_file($1_t, dcc_var_t)
allow $1_t dcc_client_map_t:file rw_file_perms;

# Read mtab, nsswitch and locale
allow $1_t { etc_t etc_runtime_t }:file { getattr read };
read_locale($1_t)

#Networking
can_resolve($1_t)
ifelse($2, `server', `
can_network_udp($1_t)
', `
can_network_udp($1_t, `dcc_port_t')
')
allow $1_t self:unix_dgram_socket create_socket_perms;

# Create private temp files
tmp_domain($1)

# Triggered by a call to gethostid(2) in dcc client libs
allow $1_t self:unix_stream_socket { connect create };

allow $1_t sysadm_su_t:process { sigchld };
allow $1_t dcc_script_t:fd use;

dontaudit $1_t kernel_t:fd use;
dontaudit $1_t root_t:file read;
')


##########
##########

#
# dccd - Server daemon that can be accessed over the net
#
daemon_domain(dccd, `, privlog, nscd_client_domain')
dcc_common(dccd, server);

# Runs the dbclean program
allow dccd_t bin_t:dir search;
domain_auto_trans(dccd_t, dcc_dbclean_exec_t, dcc_dbclean_t)
#can_exec(dccd_t, dcc_dbclean_t)

# The daemon needs to listen on the dcc ports
allow dccd_t dcc_port_t:udp_socket name_bind;

# Updating dcc_db, flod, ...
create_dir_file(dccd_t, dcc_var_t);

allow dccd_t self:capability net_admin;
allow dccd_t self:netlink_route_socket { bind create getattr nlmsg_read read write };

# Reading /proc/meminfo
allow dccd_t proc_t:file { getattr read };


#
# cdcc - control dcc daemon
#
application_domain(cdcc, `, nscd_client_domain')
role system_r types cdcc_t;
dcc_common(cdcc)

# suid program
allow cdcc_t self:capability setuid;

# Running from the command line
allow cdcc_t sshd_t:fd use;
allow cdcc_t sysadm_devpts_t:chr_file rw_file_perms;



##########
##########

#
# DCC Clients
#

#
# dccifd  - Spamassassin and general MTA persistent client
#
daemon_domain(dccifd, `, privlog, nscd_client_domain')
dcc_common(dccifd);
file_type_auto_trans(dccifd_t, dcc_var_run_t, dccifd_var_run_t, file)

# Allow the domain to communicate with other processes
allow dccifd_t self:unix_stream_socket create_stream_socket_perms;

# Updating dcc_db, flod, ...
create_dir_notdevfile(dccifd_t, dcc_var_t);

# Updating map, ...
allow dccifd_t dcc_client_map_t:file rw_file_perms;

# dccifd communications socket
type dccifd_sock_t, file_type, sysadmfile;
file_type_auto_trans(dccifd_t, dcc_var_t, dccifd_sock_t, sock_file)


#
# dccm  - sendmail milter client
#
daemon_domain(dccm, `, privlog, nscd_client_domain')
dcc_common(dccm);
file_type_auto_trans(dccm_t, dcc_var_run_t, dccm_var_run_t, file)

# Allow the domain to communicate with other processes
allow dccm_t self:unix_stream_socket create_stream_socket_perms;

# Updating map, ...
create_dir_notdevfile(dccm_t, dcc_var_t);
allow dccm_t dcc_client_map_t:file rw_file_perms;

# dccm communications socket
type dccm_sock_t, file_type, sysadmfile;
file_type_auto_trans(dccm_t, dcc_var_run_t, dccm_sock_t, sock_file)


#
# dccproc - dcc procmail interface
#
application_domain(dcc_client, `, privlog, nscd_client_domain')
role system_r types dcc_client_t;
dcc_common(dcc_client)

# suid program
allow dcc_client_t self:capability setuid;

# Running from the command line
allow dcc_client_t sshd_t:fd use;
allow dcc_client_t sysadm_devpts_t:chr_file rw_file_perms;


##########
##########

#
# DCC Utilities
#

#
# dbclean - database cleanup tool
#
application_domain(dcc_dbclean, `, nscd_client_domain')
dcc_common(dcc_dbclean)

# Updating various files.
create_dir_file(dcc_dbclean_t, dcc_var_t);

# wants to look at /proc/meminfo
allow dcc_dbclean_t proc_t:dir search;
allow dcc_dbclean_t proc_t:file { getattr read };

# Running from the command line
allow dcc_dbclean_t sshd_t:fd use;
allow dcc_dbclean_t sysadm_devpts_t:chr_file rw_file_perms;

##########
##########

#
# DCC Startup scripts
#
# These are shell sccripts that start/stop/restart the various dcc
# programs.
#
init_service_domain(dcc_script, `, nscd_client_domain')
general_domain_access(dcc_script_t)
general_proc_read_access(dcc_script_t)
can_exec_any(dcc_script_t)
dcc_common(dcc_script)

# Allow calling the script from an init script (initrt_t) or from
# rc.local (staff_t)
domain_auto_trans({ initrc_t staff_t }, dcc_script_exec_t, dcc_script_t)

# Start up the daemon process.  These scripts run 'su' to change to
# the dcc user (even though the default dcc user is root).
allow dcc_script_t self:capability setuid;
su_restricted_domain(dcc_script, system)
role system_r types dcc_script_su_t;
domain_auto_trans(dcc_script_su_t, dccd_exec_t, dccd_t)
domain_auto_trans(dcc_script_su_t, dccm_exec_t, dccm_t)
domain_auto_trans(dcc_script_su_t, dccifd_exec_t, dccifd_t)

# Stop the daemon process
allow dcc_script_t { dccifd_t dccm_t }:process { sigkill signal };

# Access various DCC files
allow dcc_script_t { var_t var_run_t dcc_var_run_t}:dir { getattr search };
allow dcc_script_t { dccifd_var_run_t dccm_var_run_t }:file { getattr read };

allow { dcc_script_t dcc_script_su_t } initrc_t:fd use;
allow { dcc_script_t dcc_script_su_t } devpts_t:dir search;
allow { dcc_script_t dcc_script_su_t } initrc_devpts_t:chr_file rw_file_perms;
allow dcc_script_t devtty_t:chr_file { read write };
allow dcc_script_su_t sysadm_home_dir_t:dir search;
allow dcc_script_su_t sysadm_t:process { noatsecure rlimitinh siginh transition };
allow dcc_script_su_t initrc_devpts_t:chr_file { relabelfrom relabelto };

dontaudit dcc_script_su_t kernel_t:fd use;
dontaudit dcc_script_su_t root_t:file read;
dontaudit dcc_script_t { home_root_t user_home_dir_t}:dir { getattr search };

allow sysadm_t dcc_script_t:fd use;

##########
##########

#
# External spam checkers need to run and/or talk to DCC
#
define(`access_dcc',`
domain_auto_trans($1_t, dcc_client_exec_t, dcc_client_t);
allow $1_t dcc_var_t:dir search;
allow $1_t dccifd_sock_t:sock_file { getattr write };
allow $1_t dccifd_t:unix_stream_socket connectto;
allow $1_t dcc_script_t:unix_stream_socket connectto;
')

ifdef(`amavis.te',`access_dcc(amavisd)')
ifdef(`spamd.te',`access_dcc(spamd)')

--=-pJfEnsBuVdhPOfpbgYn7--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
