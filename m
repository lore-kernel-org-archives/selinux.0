Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0SLAu53027442
	for <selinux@tycho.nsa.gov>; Fri, 28 Jan 2005 16:10:56 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0SLAwng017737
	for <selinux@tycho.nsa.gov>; Fri, 28 Jan 2005 21:10:58 GMT
Message-ID: <41FAAA5A.1020800@redhat.com>
Date: Fri, 28 Jan 2005 16:10:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: selinux@tycho.nsa.gov
Subject: Re: [ RESEND ] Fedora Rawhide mplayer policy
References: <1106944688.2174.13.camel@cobra.ivg2.net>
In-Reply-To: <1106944688.2174.13.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>So, how about this policy again?
>I didn't get too many comments last time.
>Do you find it useful, or have you decided to go with 
>a tunable for reading /dev/rtc.
>
>There's more things involved that reading /dev/rtc, for example, 
>mplayer required execute permissions on /usr/lib/win32,
>which is of type { lib_t } by default. I relabeled it to win32_lib_t.
>The win32 loader needs { execmem }.
>
>Any more comments? 
>Latest version attached.
>It's for selinux-policy-strict-1.21.4-2.
>
>  
>
>------------------------------------------------------------------------
>
>--- base_user_macros.te	2005-01-27 15:02:48.000000000 -0700
>+++ base_user_macros.new	2005-01-27 15:02:20.000000000 -0700
>@@ -188,6 +188,10 @@
> ifdef(`using_spamassassin', `spamassassin_domain($1)')
> ifdef(`uml.te', `uml_domain($1)')
> ifdef(`cdrecord.te', `cdrecord_domain($1)')
>+ifdef(`mplayer.te', `
>+mplayer_domain($1)
>+mencoder_domain($1)
>+')
> 
> # Instantiate a derived domain for user cron jobs.
> ifdef(`crond.te', `crond_domain($1)')
>  
>
>------------------------------------------------------------------------
>
># mplayer
>/usr/bin/mplayer	--	   	system_u:object_r:mplayer_exec_t
>/usr/bin/mencoder	--	   	system_u:object_r:mencoder_exec_t
>
>/etc/mplayer(/.*)?		system_u:object_r:mplayer_etc_t
>HOME_DIR/\.mplayer(/.*)?        system_u:object_r:ROLE_mplayer_rw_t
>  
>
>------------------------------------------------------------------------
>
>#
># Macros for mplayer
>#
># Author: Ivan Gyurdiev <ivg2@cornell.edu>
>#
>#
># mplayer_domain(domain_prefix)
># mencoder_domain(domain_prefix)
>
>################################################
>#    mplayer_common(prefix, mplayer domain)    #
>################################################
>
>define(`mplayer_common',`
>
># Home directory stuff
>if (use_nfs_home_dirs) {
>create_dir_file($1_$2_t, nfs_t)
>}
>if (use_samba_home_dirs) {
>create_dir_file($1_$2_t, cifs_t)
>}
>allow $1_$2_t autofs_t:dir { search getattr };
>
># Read local config
>r_dir_file($1_$2_t, $1_mplayer_rw_t)
>
># Read global config
>r_dir_file($1_$2_t, mplayer_etc_t)
>
># Read data in /usr/share (fonts, icons..)
>r_dir_file($1_$2_t, usr_t)
>
># Read /proc files and directories
># Necessary for /proc/meminfo, /proc/cpuinfo, etc..
>allow $1_$2_t proc_t:dir search;
>allow $1_$2_t proc_t:file { getattr read };
>
># Sysctl on kernel version 
>allow $1_$2_t sysctl_kernel_t:dir search;
>allow $1_$2_t sysctl_kernel_t:file { getattr read };
>
># allow ps
>can_ps($1_t, $1_$2_t)
>
># uses shared libraries
>uses_shlib($1_$2_t)
>
># localization
>read_locale($1_$2_t)
>
># Access the terminal.
>allow $1_$2_t devpts_t:dir { search };
>allow $1_$2_t $1_tty_device_t:chr_file rw_file_perms;
>allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;
>
># Required for win32 binary loader 
>allow $1_$2_t zero_device_t:chr_file { read write execute };
>allow $1_$2_t self:process { execmem };
>allow $1_$2_t win32_lib_t:file rx_file_perms;
>allow $1_$2_t win32_lib_t:dir r_dir_perms;
>
># Access to DVD/CD/V4L
>allow $1_$2_t device_t:dir r_dir_perms;
>allow $1_$2_t device_t:lnk_file { getattr read };
>allow $1_$2_t removable_device_t:blk_file { getattr read };
>allow $1_$2_t v4l_device_t:chr_file { getattr read };
>')
>
>##############################
>#  mplayer_domain(prefix)    #
>##############################
>
>define(`mplayer_domain',`
>
># Derive from X client domain
>x_client_domain($1, `mplayer', `')
>
># Mplayer common stuff
>mplayer_common($1, mplayer)
>
># Additional rules for search /tmp/.X11-unix
>ifdef(`xdm.te', `
>allow $1_mplayer_t xdm_tmp_t:dir search;
>')dnl end if xdm.te
>
># Prevent getattr denials on restricted types when browsing with gmplayer
>dontaudit $1_mplayer_t file_type:dir_file_class_set { getattr };
>
># Audio
>allow $1_mplayer_t sound_device_t:chr_file rw_file_perms;
>
># RTC clock 
>allow $1_mplayer_t clock_device_t:chr_file { ioctl read };
>
># Read home directory content
>r_dir_file($1_mplayer_t, $1_home_t);
>') dnl end mplayer_domain
>
>##############################
>#  mencoder_domain(prefix)   #
>##############################
>
>define(`mencoder_domain',`
>
># Privhome type transitions to $1_home_t in home dir.
>type $1_mencoder_t, domain, privhome;
>
># Transition
>domain_auto_trans($1_t, mencoder_exec_t, $1_mencoder_t)
>can_exec($1_mencoder_t, mencoder_exec_t)
>role $1_r types $1_mencoder_t;
>
># Mplayer common stuff
>mplayer_common($1, mencoder)
>
>') dnl end mencoder_domain
>  
>
>------------------------------------------------------------------------
>
>#DESC mplayer - media player 
>#
># Author: Ivan Gyurdiev <ivg2@cornell.edu>
>#
>
># Type for the mplayer executable.
>type mplayer_exec_t, file_type, exec_type, sysadmfile;
>type mencoder_exec_t, file_type, exec_type, sysadmfile;
>type mplayer_etc_t, file_type, sysadmfile;
>type win32_lib_t, file_type, sysadmfile;
>
># Everything else is in the mplayer_domain macro in
># macros/program/mplayer_macros.te.
>  
>
>------------------------------------------------------------------------
>
>--- types.fc	2005-01-28 13:21:56.000000000 -0700
>+++ types.new	2005-01-28 13:21:45.000000000 -0700
>@@ -332,6 +332,7 @@
> #
> /usr(/.*)?			system_u:object_r:usr_t
> /usr(/.*)?/lib(64)?(/.*)?	system_u:object_r:lib_t
>+/usr/lib/win32(/.*)?                    system_u:object_r:win32_lib_t
> /usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
> /usr(/.*)?/java/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
> /usr(/.*)?/java/.*\.jar	--	system_u:object_r:shlib_t
>  
>
I will add them.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
