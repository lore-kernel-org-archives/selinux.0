Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BE6T7k015796
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 10:06:29 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BE6PDE009133
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 14:06:28 GMT
Subject: Re: Proper transition rules for pppd to create /etc/resolv.confe
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301430.l4UEUn0v007884@localhost.localdomain>
References: <200705301430.l4UEUn0v007884@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 10:05:00 -0400
Message-Id: <1181570700.16029.16.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:30 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/ppp.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/ppp.te	2007-05-30 07:35:54.000000000 -0400
> @@ -153,7 +153,7 @@
>  
>  files_exec_etc_files(pppd_t)
>  files_manage_etc_runtime_files(pppd_t)
> -files_etc_filetrans_etc_runtime(pppd_t, { dir file })
> +sysnet_etc_filetrans_config(pppd_t)
>  files_dontaudit_write_etc_files(pppd_t)
>  
>  # for scripts

Merged with reordering.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
