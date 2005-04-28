Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3SNE2gA028702
	for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2005 19:14:04 -0400 (EDT)
Received: from rotorua.reisse.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3SNDaZb014995
	for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2005 23:13:36 GMT
Date: Thu, 28 Apr 2005 19:15:20 -0400
From: selinux@reisse.net
To: selinux@tycho.nsa.gov
Subject: policy for afs server (v2)
Message-ID: <20050428231520.GA17384@rotorua.mm.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Here is a policy for an afs fileserver, with changes suggested by
James Carter and Russel Coker.

Changes from James and Russel's version:
-Use domain names that match the executables.
-Don't grant write access to afs_config_t to all servers.
-Move the dontaudit rules to the afs_server_domain macro.


Only bosserver, fileserver, volserver, salvager, kaserver, vlserver, and
ptserver processes are supported. Labelling rules are included only for the
"traditional" (/usr/afs) layout; sites using the "openafs" layout
will need different labelling rules.

The types defined for the kaserver ports may conflict with policies for other
kerberos servers. Also, the policy has never been used during the
installation and configuration of a server.


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="afs.te"

#
# Policy for AFS server
#

type afs_files_t, file_type;
type afs_config_t, file_type, sysadmfile;
type afs_logfile_t, file_type, logfile;
type afs_dbdir_t, file_type;

allow afs_files_t afs_files_t:filesystem associate;
# df should show sizes
allow sysadm_t afs_files_t:filesystem getattr;

#
# Macros for defining AFS server domains
#

define(`afs_server_domain',`
type afs_$1server_t, domain $2;
type afs_$1server_exec_t, file_type, sysadmfile;
type afs_$1_port_t, port_type;

role system_r types afs_$1server_t;

allow afs_$1server_t afs_config_t:file r_file_perms;
allow afs_$1server_t afs_config_t:dir r_dir_perms;
allow afs_$1server_t afs_logfile_t:file create_file_perms;
allow afs_$1server_t afs_logfile_t:dir create_dir_perms;
allow afs_$1server_t afs_$1_port_t:udp_socket name_bind;
uses_shlib(afs_$1server_t)
can_network(afs_$1server_t)
read_locale(afs_$1server_t)

dontaudit afs_$1server_t { var_t var_run_t }:file r_file_perms;
dontaudit afs_$1server_t { var_t var_run_t }:dir r_dir_perms;
dontaudit afs_$1server_t admin_tty_type:chr_file rw_file_perms;
')

define(`afs_under_bos',`
domain_auto_trans(afs_bosserver_t, afs_$1server_exec_t, afs_$1server_t)
allow afs_$1server_t self:unix_stream_socket create_stream_socket_perms;
allow afs_$1server_t etc_t:{ file lnk_file } r_file_perms;
allow afs_$1server_t net_conf_t:file r_file_perms;
allow afs_bosserver_t afs_$1server_t:process signal_perms;
')

define(`afs_server_db',`
type afs_$1_db_t, file_type;

allow afs_$1server_t afs_$1_db_t:file create_file_perms;
file_type_auto_trans(afs_$1server_t, afs_dbdir_t, afs_$1_db_t, file);
')


#
# bosserver
#

afs_server_domain(`bos')
base_file_read_access(afs_bosserver_t)

domain_auto_trans(initrc_t, afs_bosserver_exec_t, afs_bosserver_t)

allow afs_bosserver_t self:process { fork setsched signal_perms };
allow afs_bosserver_t afs_bosserver_exec_t:file { execute_no_trans rx_file_perms };
allow afs_bosserver_t afs_dbdir_t:dir { search read getattr };
allow afs_bosserver_t afs_config_t:file create_file_perms;
allow afs_bosserver_t afs_config_t:dir create_dir_perms;

allow afs_bosserver_t etc_t:{file lnk_file} r_file_perms;
allow afs_bosserver_t { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
allow afs_bosserver_t device_t:dir r_dir_perms;

# allow sysadm to use bos
allow afs_bosserver_t sysadm_t:udp_socket { sendto recvfrom };
allow sysadm_t afs_bosserver_t:udp_socket { recvfrom sendto };

#
# fileserver, volserver, and salvager
#

afs_server_domain(`fs',`,privlog')
afs_under_bos(`fs')

base_file_read_access(afs_fsserver_t)
file_type_auto_trans(afs_fsserver_t, afs_config_t, afs_files_t)

allow afs_fsserver_t self:process { fork sigchld setsched signal_perms };
allow afs_fsserver_t self:capability { kill dac_override chown fowner sys_nice };
allow afs_fsserver_t self:fifo_file { rw_file_perms };
can_exec(afs_fsserver_t, afs_fsserver_exec_t)
allow afs_fsserver_t afs_files_t:file create_file_perms;
allow afs_fsserver_t afs_files_t:dir create_dir_perms;
allow afs_fsserver_t afs_config_t:file create_file_perms;
allow afs_fsserver_t afs_config_t:dir create_dir_perms;

allow afs_fsserver_t afs_fs_port_t:tcp_socket name_bind;
allow afs_fsserver_t { afs_files_t fs_t }:filesystem getattr;

allow afs_fsserver_t { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
allow afs_fsserver_t device_t:dir r_dir_perms;
allow afs_fsserver_t etc_runtime_t:{file lnk_file} r_file_perms;
allow afs_fsserver_t { var_run_t var_t } :dir r_dir_perms;

allow afs_fsserver_t proc_t:dir r_dir_perms;
allow afs_fsserver_t { self proc_t } : { file lnk_file } r_file_perms;
allow afs_fsserver_t { self proc_t } : dir r_dir_perms;

# fs communicates with other servers
allow afs_fsserver_t self:unix_dgram_socket create_socket_perms;
allow afs_fsserver_t self:tcp_socket { connectto acceptfrom recvfrom };
allow afs_fsserver_t self:udp_socket { sendto recvfrom };
allow afs_fsserver_t { afs_vlserver_t afs_ptserver_t }:udp_socket { recvfrom };
allow afs_fsserver_t sysadm_t:udp_socket { sendto recvfrom };
allow sysadm_t afs_fsserver_t:udp_socket { recvfrom sendto };

dontaudit afs_fsserver_t self:capability fsetid;
dontaudit afs_fsserver_t console_device_t:chr_file rw_file_perms;
dontaudit afs_fsserver_t initrc_t:fd use;
dontaudit afs_fsserver_t mnt_t:dir search;


#
# kaserver
#

afs_server_domain(`ka')
afs_under_bos(`ka')
afs_server_db(`ka')

base_file_read_access(afs_kaserver_t)

allow afs_kaserver_t self:capability { net_bind_service };
allow afs_kaserver_t afs_config_t:file create_file_perms;
allow afs_kaserver_t afs_config_t:dir rw_dir_perms;

# allow sysadm to use kas
allow afs_kaserver_t sysadm_t:udp_socket { sendto recvfrom };
allow sysadm_t afs_kaserver_t:udp_socket { recvfrom sendto };


#
# ptserver
#

afs_server_domain(`pt')
afs_under_bos(`pt')
afs_server_db(`pt')

# allow users to use pts
allow afs_ptserver_t userdomain:udp_socket { sendto recvfrom };
allow userdomain afs_ptserver_t:udp_socket { recvfrom sendto };
allow afs_ptserver_t afs_fsserver_t:udp_socket { recvfrom };


#
# vlserver
#

afs_server_domain(`vl')
afs_under_bos(`vl')
afs_server_db(`vl')

allow afs_vlserver_t sysadm_t:udp_socket { sendto recvfrom };
allow sysadm_t afs_vlserver_t:udp_socket { recvfrom sendto };
allow afs_vlserver_t afs_fsserver_t:udp_socket { recvfrom };



--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="afs.fc"

# afs
/usr/afs/bin/bosserver	--	system_u:object_r:afs_bosserver_exec_t
/usr/afs/bin/kaserver	--	system_u:object_r:afs_kaserver_exec_t
/usr/afs/bin/vlserver	--	system_u:object_r:afs_vlserver_exec_t
/usr/afs/bin/ptserver	--	system_u:object_r:afs_ptserver_exec_t
/usr/afs/bin/fileserver	--	system_u:object_r:afs_fsserver_exec_t
/usr/afs/bin/volserver	--	system_u:object_r:afs_fsserver_exec_t
/usr/afs/bin/salvager	--	system_u:object_r:afs_fsserver_exec_t

/usr/afs/logs(/.*)?		system_u:object_r:afs_logfile_t
/usr/afs/etc(/.*)?		system_u:object_r:afs_config_t		
/usr/afs/local(/.*)?		system_u:object_r:afs_config_t
/usr/afs/db		-d	system_u:object_r:afs_dbdir_t
/usr/afs/db/pr.*	--	system_u:object_r:afs_pt_db_t
/usr/afs/db/ka.*	--	system_u:object_r:afs_ka_db_t
/usr/afs/db/vl.*	--	system_u:object_r:afs_vl_db_t

/vicepa				system_u:object_r:afs_files_t
/vicepb				system_u:object_r:afs_files_t
/vicepc				system_u:object_r:afs_files_t


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="afs.net_contexts"

ifdef(`afs.te', `
portcon udp 88   system_u:object_r:afs_ka_port_t
portcon udp 750  system_u:object_r:afs_ka_port_t
portcon tcp 2040 system_u:object_r:afs_fs_port_t
portcon udp 7000 system_u:object_r:afs_fs_port_t
portcon udp 7002 system_u:object_r:afs_pt_port_t
portcon udp 7003 system_u:object_r:afs_vl_port_t
portcon udp 7004 system_u:object_r:afs_ka_port_t
portcon udp 7005 system_u:object_r:afs_fs_port_t
portcon udp 7007 system_u:object_r:afs_bos_port_t
')


--Kj7319i9nmIyA2yE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
