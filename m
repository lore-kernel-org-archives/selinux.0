Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3BHSAtA023120
	for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2005 13:28:10 -0400 (EDT)
Subject: Re: policy for afs server
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Andrew Reisse <selinux@reisse.net>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050210015508.GA16473@rotorua.mm.net>
References: <20050210015508.GA16473@rotorua.mm.net>
Content-Type: multipart/mixed; boundary="=-hjer7l73Vdl6p+BAu1Pj"
Date: Mon, 11 Apr 2005 10:49:21 -0400
Message-Id: <1113230961.26757.22.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-hjer7l73Vdl6p+BAu1Pj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I grouped common permissions into three macros and did some renaming,
but I didn't really look a lot at the permissions granted.  The only
permissions that I removed intentionally were for devlog_t and syslogd_t
(because they violated an assertion), I used the privlog attribute
instead.

Please take a look at macros/core_macros.te (r_dir_file and friends) and
macros/global_macros.te (read_locale, log_domain, application_domain,
and others) and try to use macros where possible.

I see that fileserver, volserver, and salvager all run in the same
domain.  I am not an AFS expert, but it seems like volserver and
salvager should be able to run in separate domains.  Why can't they?

On Wed, 2005-02-09 at 20:55 -0500, Andrew Reisse wrote:
> Here is a policy for an afs fileserver.
> 
> Only bosserver, fileserver, volserver, salvager, kaserver, vlserver, and
> ptserver processes are supported. Labelling rules are included only for the
> "traditional" (/usr/afs) layout; sites using the "openafs" layout
> will need different labelling rules.
> 
> The types defined for the kaserver ports may conflict with policies for other
> kerberos servers. Also, the policy has never been used during the 
> installation and configuration of a server. 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--=-hjer7l73Vdl6p+BAu1Pj
Content-Disposition: attachment; filename=afs.te
Content-Type: text/plain; name=afs.te; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
# Macros for defining AFS domains
#

define(`afs_domain',`
type afs_$1_t, domain $2;
type afs_$1_exec_t, file_type, sysadmfile;
type afs_$1_port_t;

role system_r types afs_$1_t;

allow afs_$1_t afs_config_t:file create_file_perms;
allow afs_$1_t afs_config_t:dir create_dir_perms;
allow afs_$1_t afs_logfile_t:file create_file_perms;
allow afs_$1_t afs_logfile_t:dir create_dir_perms;
allow afs_$1_t afs_$1_port_t:udp_socket name_bind;
uses_shlib(afs_$1_t)
can_network(afs_$1_t)
allow afs_$1_t locale_t:{file lnk_file} r_file_perms;
allow afs_$1_t locale_t:dir r_dir_perms;
')

define(`afs_under_bos',`
domain_auto_trans(afs_bos_t, afs_$1_exec_t, afs_$1_t)
allow afs_bos_t afs_$1_exec_t:file { rx_file_perms };
allow afs_$1_t self:unix_stream_socket { create connect read write };
allow afs_$1_t { etc_t net_conf_t }:{ file lnk_file } r_file_perms;
')

define(`afs_db_access',`
type afs_$1_db_t, file_type;

allow afs_bos_t afs_$1_t:process { signal_perms };
allow afs_$1_t afs_$1_db_t:file create_file_perms;
file_type_auto_trans(afs_$1_t, afs_dbdir_t, afs_$1_db_t, file);
dontaudit afs_$1_t { var_t var_run_t }:file r_file_perms;
dontaudit afs_$1_t { var_t var_run_t }:dir r_dir_perms;
dontaudit afs_$1_t sysadm_devpts_t:chr_file rw_file_perms;
')


#
# bos server
#

afs_domain(`bos')
base_file_read_access(afs_bos_t)

domain_auto_trans(initrc_t, afs_bos_exec_t, afs_bos_t)
domain_auto_trans(sysadm_t, afs_bos_exec_t, afs_bos_t)
allow initrc_t afs_bos_exec_t:file rx_file_perms;
allow sysadm_t afs_bos_exec_t:file rx_file_perms;

allow afs_bos_t self:process { fork setsched signal_perms };
allow afs_bos_t afs_bos_exec_t:file { execute_no_trans rx_file_perms };
allow afs_bos_t afs_dbdir_t:dir { search read getattr };
allow afs_bos_t afs_fs_t:process signal_perms;

allow afs_bos_t etc_t:{file lnk_file} r_file_perms;
allow afs_bos_t { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
allow afs_bos_t device_t:dir r_dir_perms;

# allow sysadm to use bos
allow afs_bos_t sysadm_t:udp_socket { sendto recvfrom };
allow sysadm_t afs_bos_t:udp_socket { recvfrom sendto };

dontaudit afs_bos_t sysadm_devpts_t:chr_file rw_file_perms;


#
# file server, vol server, and salvager
#

afs_domain(`fs',`,privlog')
afs_under_bos(`fs')

base_file_read_access(afs_fs_t)
file_type_auto_trans(afs_fs_t, afs_config_t, afs_files_t)

allow afs_fs_t self:process { fork sigchld setsched signal_perms };
allow afs_fs_t self:capability { kill dac_override chown fowner sys_nice };
allow afs_fs_t self:fifo_file { rw_file_perms };
allow afs_fs_t afs_fs_exec_t:file { execute_no_trans rx_file_perms };
allow afs_fs_t afs_files_t:file create_file_perms;
allow afs_fs_t afs_files_t:dir create_dir_perms;
allow afs_fs_t afs_fs_port_t:tcp_socket name_bind;
allow afs_fs_t { afs_files_t fs_t }:filesystem getattr;

allow afs_fs_t { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
allow afs_fs_t device_t:dir r_dir_perms;
allow afs_fs_t etc_runtime_t:{file lnk_file} r_file_perms;
allow afs_fs_t { var_run_t var_t } :dir r_dir_perms;

allow afs_fs_t proc_t:dir r_dir_perms;
allow afs_fs_t { self proc_t } : { file lnk_file } r_file_perms;
allow afs_fs_t { self proc_t } : dir r_dir_perms;

# fs communicates with other servers
allow afs_fs_t self:unix_dgram_socket { create connect read write };
allow afs_fs_t self:tcp_socket { connectto acceptfrom recvfrom };
allow afs_fs_t self:udp_socket { sendto recvfrom };
allow afs_fs_t { afs_vl_t afs_pt_t }:udp_socket { recvfrom };
allow afs_fs_t sysadm_t:udp_socket { sendto recvfrom };
allow sysadm_t afs_fs_t:udp_socket { recvfrom sendto };

dontaudit afs_fs_t self:capability fsetid;
dontaudit afs_fs_t console_device_t:chr_file rw_file_perms;
dontaudit afs_fs_t initrc_t:fd use;
dontaudit afs_fs_t mnt_t:dir search;


#
# ka server
#

afs_domain(`ka')
afs_under_bos(`ka')
afs_db_access(`ka')

base_file_read_access(afs_ka_t)

allow afs_ka_t self:capability { net_bind_service };

# allow sysadm to use ka
allow afs_ka_t sysadm_t:udp_socket { sendto recvfrom };
allow sysadm_t afs_ka_t:udp_socket { recvfrom sendto };


#
# pt server
#

afs_domain(`pt')
afs_under_bos(`pt')
afs_db_access(`pt')

# allow users to use pt
allow afs_pt_t userdomain:udp_socket { sendto recvfrom };
allow userdomain afs_pt_t:udp_socket { recvfrom sendto };
allow afs_pt_t afs_fs_t:udp_socket { recvfrom };


#
# vl server
#

afs_domain(`vl')
afs_under_bos(`vl')
afs_db_access(`vl')

allow afs_vl_t sysadm_t:udp_socket { sendto recvfrom };
allow sysadm_t afs_vl_t:udp_socket { recvfrom sendto };
allow afs_vl_t afs_fs_t:udp_socket { recvfrom };



--=-hjer7l73Vdl6p+BAu1Pj
Content-Disposition: attachment; filename=afs.fc
Content-Type: text/plain; name=afs.fc; charset=UTF-8
Content-Transfer-Encoding: 7bit

# afs
/usr/afs/bin/bosserver		system_u:object_r:afs_bos_exec_t
/usr/afs/bin/kaserver		system_u:object_r:afs_ka_exec_t
/usr/afs/bin/vlserver		system_u:object_r:afs_vl_exec_t
/usr/afs/bin/ptserver		system_u:object_r:afs_pt_exec_t
/usr/afs/bin/fileserver		system_u:object_r:afs_fs_exec_t
/usr/afs/bin/volserver		system_u:object_r:afs_fs_exec_t
/usr/afs/bin/salvager		system_u:object_r:afs_fs_exec_t

/usr/afs/logs(/.*)?		system_u:object_r:afs_logfile_t
/usr/afs/etc(/.*)?		system_u:object_r:afs_config_t		
/usr/afs/local(/.*)?		system_u:object_r:afs_config_t
/usr/afs/db			system_u:object_r:afs_dbdir_t
/usr/afs/db/pr.*		system_u:object_r:afs_pt_db_t
/usr/afs/db/ka.*		system_u:object_r:afs_ka_db_t
/usr/afs/db/vl.*		system_u:object_r:afs_vl_db_t

/vicep.*			system_u:object_r:afs_files_t

--=-hjer7l73Vdl6p+BAu1Pj--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
