Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATIWbQX026961
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 13:32:38 -0500
Received: from smtp.nextra.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kATIUr46003516
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 18:30:53 GMT
Received: from linpro2.corki.info (195.47.80.232.adsl.nextra.cz [195.47.80.232])
	by smtp.nextra.cz (Postfix) with ESMTP id 3DC105DF0
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 19:32:53 +0100 (CET)
Subject: Re: CentOS and SELinux refpolicy trouble
From: Filip Bartmann <filbar@centrum.cz>
To: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1164820193.23019.181.camel@moss-spartans.epoch.ncsc.mil>
References: <1164819458.4109.14.camel@localhost>
	 <1164820193.23019.181.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=iso-8859-2
Date: Wed, 29 Nov 2006 19:32:38 +0100
Message-Id: <1164825158.4109.31.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley pí¹e v St 29. 11. 2006 v 12:09 -0500:
> Please identify the precise version numbers of any SELinux-related
> components that you updated (refpolicy, checkpolicy, anything else like
> policycoreutils).
I have installed 

refpolicy-20061018, 
checkpolicy.i386-			 1.32-1(from tresys), 
policycoreutils.i386			 1.18.1-4.9, 
libselinux				 1.19.1-7.2, 
libsepol.i386                            1.1.1-2
setools.i386                             1.5.1-5 

> Aside from setting the TYPE and NAME in build.conf, you also need to set
> (or override on the make commandline) several other definitions for a
> CentOS 4 system, e.g.:
> OUTPUT_POLICY = 18
> DISTRO = rhel4
> DIRECT_INITRC=y
Yes, I have this setting in this file:
OUTPUT_POLICY = 18
TYPE = targeted
NAME = reftargeted
DISTRO = rhel4
DIRECT_INITRC=y
MONOLITHIC=y
POLY=n
MLS_SENS=16
MLS_CATS=256
MCS_CATS=256
QUIET=n

> Not sure about the booleans errors - what did that booleans file
> contain?
The booleans file contain default this values(it's almost defaults from
tresys refpolicy):
allow_cvs_read_shadow = 0
allow_daemons_use_tty = 0
allow_execheap = 0
allow_execmem = 0
allow_execmod = 0
allow_execstack = 0
allow_ftpd_anon_write = 0
allow_ftpd_use_cifs = 0
allow_ftpd_use_nfs = 0
allow_gpg_execstack = 0
allow_gssd_read_tmp = 1
allow_httpd_mod_auth_pam = 0
allow_java_execstack = 0
allow_kerberos = 0
allow_mount_anyfile = 0
allow_mplayer_execstack = 0
allow_nfsd_anon_write = 0
allow_ptrace = 0
allow_rsync_anon_write = 0
allow_saslauthd_read_shadow = 0
allow_smbd_anon_write = 0
allow_ssh_keysign = 0
allow_user_mysql_connect = 0
allow_write_xshm = 0
allow_ypbind = 0
allow_zebra_write_config = 0
cdrecord_read_content = 0
cron_can_relabel = 0
disable_evolution_trans = 0
disable_games_trans = 0
disable_mozilla_trans = 0
disable_thunderbird_trans = 0
fcron_crond = 0
ftp_home_dir = 0
ftpd_is_daemon = 0
global_ssp = 0
httpd_builtin_scripting = 0
httpd_can_network_connect = 0
httpd_can_network_connect_db = 0
httpd_can_network_relay = 0
httpd_enable_cgi = 0
httpd_enable_ftp_server = 0
httpd_enable_homedirs = 0
httpd_ssi_exec = 0
httpd_tty_comm = 0
httpd_unified = 0
mail_read_content = 0
mozilla_read_content = 0
named_write_master_zones = 0
nfs_export_all_ro = 0
nfs_export_all_rw = 0
pppd_can_insmod = 0
pppd_for_user = 0
read_default_t = 0
read_untrusted_content = 0
run_ssh_inetd = 0
samba_enable_home_dirs = 0
samba_share_nfs = 0
secure_mode = 0
secure_mode_insmod = 0
secure_mode_policyload = 0
spamassassin_can_network = 0
spamd_enable_home_dirs = 1
squid_connect_any = 0
ssh_sysadm_login = 0
staff_read_sysadm_file = 0
stunnel_is_daemon = 0
use_nfs_home_dirs = 0
use_samba_home_dirs = 0
user_direct_mouse = 0
user_dmesg = 0
user_net_control = 0
user_ping = 0
user_rw_noexattrfile = 0
user_tcp_server = 0
user_ttyfile_stat = 0
write_untrusted_content = 0
xdm_sysadm_login = 0

Filip Bartmann


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
