Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QGIdnh009241
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 11:18:39 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1QGK0W2005387
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 16:20:00 GMT
Subject: Re: Latest bluetooth requires net_bind_service
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB3124.6050905@redhat.com>
References: <45DB3124.6050905@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 16:20:18 +0000
Message-Id: <1172506818.19655.22.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 12:34 -0500, Daniel J Walsh wrote:
> Also search inotify

Merged

> --- nsaserefpolicy/policy/modules/services/bluetooth.te 2007-01-02 12:57:43.000000000 -0500
> +++ serefpolicy-2.5.4/policy/modules/services/bluetooth.te      2007-02-19 16:01:52.000000000 -0500
> @@ -41,7 +41,7 @@
>  # Bluetooth services local policy
>  #
>  
> -allow bluetooth_t self:capability { net_admin net_raw sys_tty_config ipc_lock };
> +allow bluetooth_t self:capability { net_bind_service net_admin net_raw sys_tty_config ipc_lock };
>  dontaudit bluetooth_t self:capability sys_tty_config;
>  allow bluetooth_t self:process { getsched signal_perms };
>  allow bluetooth_t self:fifo_file rw_fifo_file_perms;
> @@ -98,6 +98,7 @@
>  
>  fs_getattr_all_fs(bluetooth_t)
>  fs_search_auto_mountpoints(bluetooth_t)
> +fs_search_inotifyfs(bluetooth_t)
>  
>  term_dontaudit_use_console(bluetooth_t)
>  #Handle bluetooth serial devices
> 

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
