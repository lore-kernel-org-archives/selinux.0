Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NJXhrT020722
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 15:33:44 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NJWpAU025557
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 19:32:58 GMT
Message-ID: <412A4685.5000307@redhat.com>
Date: Mon, 23 Aug 2004 15:33:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   selinux-dev@tresys.com
Subject: Re: Now that SELinux supports booleans should we replace tunables
 with booleans?
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>	 <1091802227.8590.58.camel@moss-spartans.epoch.ncsc.mil>	 <41139870.9090203@redhat.com> <1091804570.8590.80.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1091804570.8590.80.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2004-08-06 at 10:40, Daniel J Walsh wrote:
>  
>
>>I have not studied the booleans that closely.  But I it seems to me that 
>>booleans are something
>>that Admins would like to work with, versus tunables being something 
>>that distributions are going
>>to make decisions on.  Of course it is not that clean.  The  best thing 
>>about booleans is that the source
>>code is not required.
>>
>>I think there are several tunables that can be removed.
>>    
>>
>
>Ok, so it would be helpful to review the current set of booleans and
>tunables to see how well they match up against this general criteria,
>and to also check which ones can be removed entirely.  The present
>breakdown is really only based on whether or not the existing tunable
>could be easily converted to a boolean (i.e. only covered TE avtab
>rules, relatively localized, small number of affected rules).
>
>Current set of booleans (strict policy) are:
>allow_xserver_home_fonts
>cron_can_relabel
>ftpd_is_daemon
>ftp_home_dir
>httpd_enable_cgi
>httpd_enable_homedirs
>httpd_ssi_exec
>mozilla_readhome
>mozilla_writehome
>named_write_master_zones
>read_default_t
>run_ssh_inetd
>secure_mode
>ssh_sysadm_login
>staff_read_sysadm_file
>user_direct_mouse
>user_dmesg
>user_ping
>user_rw_noexattrfile
>user_rw_usb
>user_tcp_server
>user_ttyfile_stat
>xdm_sysadm_login
>
>Current set of policy tunables are:
>nscd_all_connect
>user_net_control
>user_can_mount
>unlimitedRPM
>unlimitedUtils
>nfs_home_dirs
>use_games
>allow_ypbind
>unlimitedRC
>direct_sysadm_daemon
>hide_broken_symptoms
>unrestricted_admin
>nfs_export_all_rw
>unlimitedUsers
>nfs_export_all_ro
>user_canbe_sysadm
>unlimitedInetd
>
>  
>
I think we can get rid of unlimitedUsers, you really should run targeted 
policy for this.
single_userdomain should also be removed since I don't think anyone has 
run it and they should use targeted policy.
I am not sure unrestricted_admin is needed although this has been turned 
on in Fedora Policy.
nfs_export_all should be made one tunable and then have a boolean to 
allow RW or not.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
