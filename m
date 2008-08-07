Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77ENXnl015793
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:23:33 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m77ENWl6009716
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:23:33 GMT
Subject: Re: [patch 32/35] rsync policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123739.808714725@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123739.808714725@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 10:22:54 -0400
Message-Id: <1218118975.5345.30.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_services_rsync.patch)
> rsync module policy changes, mostly related to a new type for rsync log
> files.

Merged.

> Index: refpolicy/policy/modules/services/rsync.fc
> ===================================================================
> --- refpolicy.orig/policy/modules/services/rsync.fc	2008-07-19 19:15:41.000000000 +0200
> +++ refpolicy/policy/modules/services/rsync.fc	2008-08-03 21:58:33.000000000 +0200
> @@ -1,2 +1,6 @@
>  
>  /usr/bin/rsync		--	gen_context(system_u:object_r:rsync_exec_t,s0)
> +
> +/var/log/rsync\.log      --	gen_context(system_u:object_r:rsync_log_t,s0)
> +
> +/var/run/rsyncd\.lock      --	gen_context(system_u:object_r:rsync_log_t,s0)
> Index: refpolicy/policy/modules/services/rsync.te
> ===================================================================
> --- refpolicy.orig/policy/modules/services/rsync.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/services/rsync.te	2008-08-03 21:58:33.000000000 +0200
> @@ -31,6 +31,9 @@
>  type rsync_data_t;
>  files_type(rsync_data_t)
>  
> +type rsync_log_t;
> +logging_log_file(rsync_log_t)
> +
>  type rsync_tmp_t;
>  files_tmp_file(rsync_tmp_t)
>  
> @@ -42,7 +45,7 @@
>  # Local policy
>  #
>  
> -allow rsync_t self:capability sys_chroot;
> +allow rsync_t self:capability { dac_read_search dac_override setuid setgid sys_chroot };
>  allow rsync_t self:process signal_perms;
>  allow rsync_t self:fifo_file rw_fifo_file_perms;
>  allow rsync_t self:tcp_socket create_stream_socket_perms;
> @@ -52,7 +55,6 @@
>  # cjp: this should probably only be inetd_child_t rules?
>  # search home and kerberos also.
>  allow rsync_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
> -allow rsync_t self:capability { setuid setgid };
>  #end for identd
>  
>  allow rsync_t rsync_data_t:dir list_dir_perms;
> @@ -95,7 +97,8 @@
>  libs_use_shared_libs(rsync_t)
>  
>  logging_send_syslog_msg(rsync_t)
> -logging_dontaudit_search_logs(rsync_t)
> +manage_files_pattern(rsync_t,rsync_log_t,rsync_log_t)
> +logging_log_filetrans(rsync_t,rsync_log_t,file)
>  
>  miscfiles_read_localization(rsync_t)
>  miscfiles_read_public_files(rsync_t)
> @@ -117,7 +120,6 @@
>  ')
>  
>  tunable_policy(`rsync_export_all_ro',`
> -	allow rsync_t self:capability dac_override;
>  	fs_read_noxattr_fs_files(rsync_t) 
>  	auth_read_all_files_except_shadow(rsync_t)
>  ')
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
