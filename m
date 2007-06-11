Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BEqr75018539
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 10:52:53 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BEqqQ2018793
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 14:52:52 GMT
Subject: Re: Mdadm makes its own devices, reads generic iscsi
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301250.l4UCoZCF003454@localhost.localdomain>
References: <200705301250.l4UCoZCF003454@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 14:51:27 +0000
Message-Id: <1181573487.16029.23.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 08:50 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/system/raid.te	2007-05-29 14:10:58.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/system/raid.te	2007-05-30 07:35:54.000000000 -0400
> @@ -19,7 +19,7 @@
>  # Local policy
>  #
>  
> -allow mdadm_t self:capability { dac_override sys_admin ipc_lock };
> +allow mdadm_t self:capability { dac_override mknod sys_admin ipc_lock };
>  dontaudit mdadm_t self:capability sys_tty_config;
>  allow mdadm_t self:process { sigchld sigkill sigstop signull signal };
>  allow mdadm_t self:fifo_file rw_fifo_file_perms;

Added mknod to storage_manage_fixed_disk() instead.

> @@ -46,6 +46,7 @@
>  # RAID block device access
>  storage_manage_fixed_disk(mdadm_t)
>  storage_dev_filetrans_fixed_disk(mdadm_t)
> +storage_read_scsi_generic(mdadm_t)
>  
>  term_dontaudit_list_ptys(mdadm_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
