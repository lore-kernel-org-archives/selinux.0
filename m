Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26EKxw8030840
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 09:20:59 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l26EMQF8019040
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 14:22:26 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: lvm changes to policy
Date: Tue, 6 Mar 2007 09:22:45 -0500
Message-ID: <1173190965.15853.10.camel@sgc>
In-Reply-To: <200702261803.l1QI3Zbe030851@localhost.localdomain>
References: <200702261803.l1QI3Zbe030851@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 13:03 -0500, dwalsh@localhost.localdomain wrote:
> Fix bugs in interface, add lvm_manage_config for ricci_modstorage
> lvm needs to be able to create and delete device files

Merged except for one question:

> --- nsaserefpolicy/policy/modules/system/lvm.te	2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/system/lvm.te	2007-02-26 11:02:34.000000000 -0500

> @@ -46,7 +46,7 @@
>  
>  allow clvmd_t self:capability { sys_admin mknod };
>  dontaudit clvmd_t self:capability sys_tty_config;
> -allow clvmd_t self:process signal_perms;
> +allow clvmd_t self:process { ptrace signal_perms };
>  allow clvmd_t self:socket create_socket_perms;
>  allow clvmd_t self:fifo_file rw_fifo_file_perms;
>  allow clvmd_t self:unix_stream_socket { connectto create_stream_socket_perms };

Are you sure this isn't one that should be dontaudited?


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
