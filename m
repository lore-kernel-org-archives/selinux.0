Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2MDB1gY006669
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 09:11:01 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2MDAxcm026049
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 13:10:59 GMT
Subject: Re: Minor changes to lvm
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200703081440.l28EemSK008903@localhost.localdomain>
References: <200703081440.l28EemSK008903@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 09:11:32 -0400
Message-Id: <1174569092.19924.25.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 09:40 -0500, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/system/lvm.te	2007-03-06 09:53:20.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/system/lvm.te	2007-03-08 08:42:37.000000000 -0500
> @@ -47,6 +48,7 @@
>  allow clvmd_t self:capability { sys_admin mknod };
>  dontaudit clvmd_t self:capability sys_tty_config;
>  allow clvmd_t self:process signal_perms;
> +dontaudit clvmd_t self:process ptrace;
>  allow clvmd_t self:socket create_socket_perms;
>  allow clvmd_t self:fifo_file rw_fifo_file_perms;
>  allow clvmd_t self:unix_stream_socket { connectto create_stream_socket_perms };

Merged this part

> @@ -146,6 +148,10 @@
>  ')
>  
>  optional_policy(`
> +	udev_read_db(clvmd_t)
> +')
> +
> +optional_policy(`
>  	ricci_dontaudit_rw_modcluster_pipes(clvmd_t)
>  	ricci_dontaudit_use_modcluster_fds(clvmd_t)
>  ')

clvmd already has this perm a few lines down.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
