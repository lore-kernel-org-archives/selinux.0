Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76F3wrT012693
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 11:03:58 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76F3vO0025001
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 15:03:57 GMT
Subject: Re: Now that SELinux supports booleans should we replace tunables
	with booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   selinux-dev@tresys.com
In-Reply-To: <41139870.9090203@redhat.com>
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
	 <1091802227.8590.58.camel@moss-spartans.epoch.ncsc.mil>
	 <41139870.9090203@redhat.com>
Content-Type: text/plain
Message-Id: <1091804570.8590.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 06 Aug 2004 11:02:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-06 at 10:40, Daniel J Walsh wrote:
> I have not studied the booleans that closely.  But I it seems to me that 
> booleans are something
> that Admins would like to work with, versus tunables being something 
> that distributions are going
> to make decisions on.  Of course it is not that clean.  The  best thing 
> about booleans is that the source
> code is not required.
> 
> I think there are several tunables that can be removed.

Ok, so it would be helpful to review the current set of booleans and
tunables to see how well they match up against this general criteria,
and to also check which ones can be removed entirely.  The present
breakdown is really only based on whether or not the existing tunable
could be easily converted to a boolean (i.e. only covered TE avtab
rules, relatively localized, small number of affected rules).

Current set of booleans (strict policy) are:
allow_xserver_home_fonts
cron_can_relabel
ftpd_is_daemon
ftp_home_dir
httpd_enable_cgi
httpd_enable_homedirs
httpd_ssi_exec
mozilla_readhome
mozilla_writehome
named_write_master_zones
read_default_t
run_ssh_inetd
secure_mode
ssh_sysadm_login
staff_read_sysadm_file
user_direct_mouse
user_dmesg
user_ping
user_rw_noexattrfile
user_rw_usb
user_tcp_server
user_ttyfile_stat
xdm_sysadm_login

Current set of policy tunables are:
nscd_all_connect
user_net_control
user_can_mount
unlimitedRPM
unlimitedUtils
nfs_home_dirs
use_games
allow_ypbind
unlimitedRC
direct_sysadm_daemon
hide_broken_symptoms
unrestricted_admin
nfs_export_all_rw
unlimitedUsers
nfs_export_all_ro
user_canbe_sysadm
unlimitedInetd

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
