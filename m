Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1A1rvL9009093
	for <selinux@tycho.nsa.gov>; Wed, 9 Feb 2005 20:53:57 -0500 (EST)
Received: from rotorua.reisse.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1A1pRQY029856
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 01:51:32 GMT
Date: Wed, 9 Feb 2005 20:55:08 -0500
From: Andrew Reisse <selinux@reisse.net>
To: selinux@tycho.nsa.gov
Subject: policy for afs server
Message-ID: <20050210015508.GA16473@rotorua.mm.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IpbVkmxF4tDyP/Kb"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Here is a policy for an afs fileserver.

Only bosserver, fileserver, volserver, salvager, kaserver, vlserver, and
ptserver processes are supported. Labelling rules are included only for the
"traditional" (/usr/afs) layout; sites using the "openafs" layout
will need different labelling rules.

The types defined for the kaserver ports may conflict with policies for other
kerberos servers. Also, the policy has never been used during the 
installation and configuration of a server. 

--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="afs.te"

#
# Policy for AFS server
#

type afs_files_t, file_type;
type afs_kadb_t, file_type;
type afs_vldb_t, file_type;
type afs_ptsdb_t, file_type;
type afs_config_t, file_type, sysadmfile;
type afs_logfile_t, file_type, logfile;
type afs_dbdir_t, file_type;

allow afs_files_t afs_files_t:filesystem associate;

# bosserver
type afs_bosserver_t, domain;
type afs_bosserver_exec_t, file_type, sysadmfile;
type afs_bos_port_t, port_type;

role system_r types afs_bosserver_t;
role system_r types afs_kaserver_t;
role system_r types afs_ptserver_t;
role system_r types afs_vlserver_t;
role system_r types afs_fs_t;

dontaudit afs_bosserver_t sysadm_devpts_t:chr_file rw_file_perms;
dontaudit afs_kaserver_t sysadm_devpts_t:chr_file rw_file_perms;
dontaudit afs_ptserver_t sysadm_devpts_t:chr_file rw_file_perms;
dontaudit afs_vlserver_t sysadm_devpts_t:chr_file rw_file_perms;
dontaudit afs_fs_t console_device_t:chr_file rw_file_perms;
dontaudit afs_fs_t initrc_t:fd use;
dontaudit afs_fs_t mnt_t:dir search;

domain_auto_trans(initrc_t, afs_bosserver_exec_t, afs_bosserver_t)
domain_auto_trans(sysadm_t, afs_bosserver_exec_t, afs_bosserver_t)
allow initrc_t afs_bosserver_exec_t:file rx_file_perms;
allow sysadm_t afs_bosserver_exec_t:file rx_file_perms;

allow afs_bosserver_t afs_config_t:file create_file_perms;
allow afs_bosserver_t afs_config_t:dir create_dir_perms;
allow afs_bosserver_t afs_logfile_t:file create_file_perms;
allow afs_bosserver_t afs_logfile_t:dir create_dir_perms;
allow afs_bosserver_t afs_bos_port_t:udp_socket name_bind;
uses_shlib(afs_bosserver_t)
can_network(afs_bosserver_t)
allow afs_bosserver_t afs_dbdir_t:dir { search read getattr };
allow afs_bosserver_t afs_bosserver_t:process { fork setsched signal_perms };
allow afs_bosserver_t afs_kaserver_t:process { signal_perms };
allow afs_bosserver_t afs_ptserver_t:process { signal_perms };
allow afs_bosserver_t afs_vlserver_t:process { signal_perms };
allow afs_bosserver_t afs_fs_t:process { signal_perms };
allow afs_bosserver_t afs_bosserver_exec_t:file { execute_no_trans rx_file_perms };

base_file_read_access(afs_bosserver_t)
allow afs_bosserver_t {etc_t locale_t}:{file lnk_file} r_file_perms;
allow afs_bosserver_t locale_t:dir r_dir_perms;
allow afs_bosserver_t { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
allow afs_bosserver_t device_t:dir r_dir_perms;

# allow sysadm to use bos
allow afs_bosserver_t sysadm_t:udp_socket { sendto recvfrom };
allow sysadm_t afs_bosserver_t:udp_socket { recvfrom sendto };

# kaserver
type afs_kaserver_t, domain;
type afs_kaserver_exec_t, file_type, sysadmfile;
type afs_ka_port_t, port_type;

domain_auto_trans(afs_bosserver_t, afs_kaserver_exec_t, afs_kaserver_t)
allow afs_bosserver_t afs_kaserver_exec_t:file { rx_file_perms };
can_network(afs_kaserver_t)
uses_shlib(afs_kaserver_t)
allow afs_kaserver_t afs_config_t:file create_file_perms;
allow afs_kaserver_t afs_config_t:dir rw_dir_perms;
allow afs_kaserver_t afs_logfile_t:file create_file_perms;
allow afs_kaserver_t afs_logfile_t:dir create_dir_perms;
allow afs_kaserver_t afs_kadb_t:file create_file_perms;
allow afs_kaserver_t afs_ka_port_t:udp_socket name_bind;
allow afs_kaserver_t self:capability { net_bind_service };
allow afs_kaserver_t self:unix_stream_socket { create connect read write };
allow afs_kaserver_t { etc_t resolv_conf_t }:{ file lnk_file } r_file_perms;
dontaudit afs_kaserver_t { var_t var_run_t }:file r_file_perms;
dontaudit afs_kaserver_t { var_t var_run_t }:dir r_dir_perms;

base_file_read_access(afs_kaserver_t)
allow afs_kaserver_t locale_t:{file lnk_file} r_file_perms;
allow afs_kaserver_t locale_t:dir r_dir_perms;
file_type_auto_trans(afs_kaserver_t, afs_dbdir_t, afs_kadb_t, file);

# allow sysadm to use kas
allow afs_kaserver_t sysadm_t:udp_socket { sendto recvfrom };
allow sysadm_t afs_kaserver_t:udp_socket { recvfrom sendto };

# fileserver,volserver,salvager
type afs_fs_t, domain;
type afs_fs_exec_t, file_type, sysadmfile;
type afs_fs_port_t, port_type;

allow afs_fs_t self:process { fork sigchld setsched signal_perms };
allow afs_fs_t self:capability { kill dac_override chown fowner };
allow afs_fs_t self:fifo_file { rw_file_perms };
allow afs_fs_t afs_fs_exec_t:file { execute_no_trans rx_file_perms };

domain_auto_trans(afs_bosserver_t, afs_fs_exec_t, afs_fs_t)
file_type_auto_trans(afs_fs_t, afs_config_t, afs_files_t)
allow afs_bosserver_t afs_fs_exec_t:file { rx_file_perms };
allow afs_fs_t self:capability { sys_nice };
allow afs_fs_t afs_config_t:file create_file_perms;
allow afs_fs_t afs_config_t:dir create_dir_perms;
allow afs_fs_t afs_files_t:file create_file_perms;
allow afs_fs_t afs_files_t:dir create_dir_perms;
allow afs_fs_t afs_logfile_t:dir create_dir_perms;
allow afs_fs_t afs_logfile_t:file create_file_perms;
can_network(afs_fs_t)
uses_shlib(afs_fs_t)
base_file_read_access(afs_fs_t)
allow afs_fs_t afs_fs_port_t:udp_socket name_bind;
allow afs_fs_t afs_fs_port_t:tcp_socket name_bind;
allow afs_fs_t locale_t:{file lnk_file} r_file_perms;
allow afs_fs_t locale_t:dir r_dir_perms;
allow afs_fs_t { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
allow afs_fs_t device_t:dir r_dir_perms;
allow afs_fs_t { resolv_conf_t etc_runtime_t etc_t }:{file lnk_file} r_file_perms;
allow afs_fs_t { var_run_t var_t } :dir r_dir_perms;

allow afs_fs_t { afs_files_t fs_t }:filesystem getattr;
allow afs_fs_t proc_t:dir r_dir_perms;
allow afs_fs_t { self proc_t } : {file lnk_file} r_file_perms;
allow afs_fs_t { self proc_t } : dir r_dir_perms;

# fs communicates with other servers
allow afs_fs_t self:unix_stream_socket { create connect read write };
allow afs_fs_t self:unix_dgram_socket { create connect read write };
allow afs_fs_t self:tcp_socket { connectto acceptfrom recvfrom };
allow afs_fs_t self:udp_socket { sendto recvfrom };
allow afs_fs_t { afs_vlserver_t afs_ptserver_t }:udp_socket { recvfrom };
allow { afs_ptserver_t afs_vlserver_t } afs_fs_t:udp_socket { recvfrom };

allow afs_fs_t devlog_t:sock_file write;
allow afs_fs_t syslogd_t:unix_dgram_socket { sendto };

dontaudit afs_fs_t self:capability { fsetid };

# ptserver
type afs_ptserver_t, domain;
type afs_ptserver_exec_t, file_type, sysadmfile;
type afs_pts_port_t, port_type;
         
domain_auto_trans(afs_bosserver_t, afs_ptserver_exec_t, afs_ptserver_t)
allow afs_bosserver_t afs_ptserver_exec_t:file { rx_file_perms };
can_network(afs_ptserver_t)
allow afs_ptserver_t afs_config_t:file r_file_perms;
allow afs_ptserver_t afs_config_t:dir r_dir_perms;
allow afs_ptserver_t afs_ptsdb_t:file create_file_perms;
allow afs_ptserver_t afs_pts_port_t:udp_socket name_bind;
allow afs_ptserver_t afs_logfile_t:file create_file_perms;
allow afs_ptserver_t afs_logfile_t:dir create_dir_perms;
uses_shlib(afs_ptserver_t)
allow afs_ptserver_t self:unix_stream_socket { create connect read write };
allow afs_ptserver_t { etc_t resolv_conf_t }:{ file lnk_file } r_file_perms;
dontaudit afs_ptserver_t { var_t var_run_t }:file r_file_perms;
dontaudit afs_ptserver_t { var_t var_run_t }:dir r_dir_perms;
file_type_auto_trans(afs_ptserver_t, afs_dbdir_t, afs_ptsdb_t, file);

# allow users to use pts
allow afs_ptserver_t { userdomain }:udp_socket { sendto recvfrom };
allow { userdomain } afs_ptserver_t:udp_socket { recvfrom sendto };

# vlserver
type afs_vlserver_t, domain;
type afs_vlserver_exec_t, file_type, sysadmfile;
type afs_vl_port_t, port_type;
         
domain_auto_trans(afs_bosserver_t, afs_vlserver_exec_t, afs_vlserver_t)
allow afs_bosserver_t afs_vlserver_exec_t:file { rx_file_perms };
can_network(afs_vlserver_t)
allow afs_vlserver_t afs_config_t:file r_file_perms;
allow afs_vlserver_t afs_config_t:dir r_dir_perms;
allow afs_vlserver_t afs_vldb_t:file create_file_perms;
allow afs_vlserver_t afs_vl_port_t:udp_socket name_bind;
allow afs_vlserver_t afs_logfile_t:file create_file_perms;
allow afs_vlserver_t afs_logfile_t:dir create_dir_perms;
uses_shlib(afs_vlserver_t)
allow afs_vlserver_t { etc_t resolv_conf_t }:{ file lnk_file } r_file_perms;
allow afs_vlserver_t locale_t:{file lnk_file} r_file_perms;
allow afs_vlserver_t locale_t:dir r_dir_perms;
allow afs_vlserver_t self:unix_stream_socket { create connect read write };
dontaudit afs_vlserver_t { var_t var_run_t }:file r_file_perms;
dontaudit afs_vlserver_t { var_t var_run_t }:dir r_dir_perms;
file_type_auto_trans(afs_vlserver_t, afs_dbdir_t, afs_vldb_t, file);

# allow sysadm to use vos
allow { afs_fs_t afs_vlserver_t } sysadm_t:udp_socket { sendto recvfrom };
allow sysadm_t { afs_fs_t afs_vlserver_t }:udp_socket { recvfrom sendto };

# df should show sizes
allow sysadm_t afs_files_t:filesystem getattr;

--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="afs.fc"

# afs
/usr/afs/bin/bosserver		system_u:object_r:afs_bosserver_exec_t
/usr/afs/bin/kaserver		system_u:object_r:afs_kaserver_exec_t
/usr/afs/bin/vlserver		system_u:object_r:afs_vlserver_exec_t
/usr/afs/bin/ptserver		system_u:object_r:afs_ptserver_exec_t
/usr/afs/bin/fileserver		system_u:object_r:afs_fs_exec_t
/usr/afs/bin/volserver		system_u:object_r:afs_fs_exec_t
/usr/afs/bin/salvager		system_u:object_r:afs_fs_exec_t

/usr/afs/logs(/.*)?		system_u:object_r:afs_logfile_t
/usr/afs/etc(/.*)?		system_u:object_r:afs_config_t		
/usr/afs/local(/.*)?		system_u:object_r:afs_config_t
/usr/afs/db			system_u:object_r:afs_dbdir_t
/usr/afs/db/pr.*		system_u:object_r:afs_ptsdb_t
/usr/afs/db/ka.*		system_u:object_r:afs_kadb_t
/usr/afs/db/vl.*		system_u:object_r:afs_vldb_t

/vicep.*			system_u:object_r:afs_files_t

--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="afs.net_contexts"

ifdef(`afs.te', `
portcon udp 88   system_u:object_r:afs_ka_port_t
portcon udp 750  system_u:object_r:afs_ka_port_t
portcon tcp 2040 system_u:object_r:afs_fs_port_t
portcon udp 7000 system_u:object_r:afs_fs_port_t
portcon udp 7002 system_u:object_r:afs_pts_port_t
portcon udp 7003 system_u:object_r:afs_vl_port_t
portcon udp 7004 system_u:object_r:afs_ka_port_t
portcon udp 7005 system_u:object_r:afs_fs_port_t
portcon udp 7007 system_u:object_r:afs_bos_port_t
')


--IpbVkmxF4tDyP/Kb--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
