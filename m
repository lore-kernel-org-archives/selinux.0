Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77Gxqmo008340
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 12:59:52 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l77GxoI6022381
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 16:59:52 GMT
Subject: Re: [PATCH] refpolicy: kernel_storage changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022013.l72KDahn029980@redsox.boston.devel.redhat.com>
References: <200708022013.l72KDahn029980@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 12:59:21 -0400
Message-Id: <1186505961.18881.32.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:13 -0400, dwalsh@redhat.com wrote:
> New storage devices.
> Fedora has fixed_disk_device_t chr files

Merged.

> --- nsaserefpolicy/policy/modules/kernel/storage.fc     2007-06-15
> 14:54:30.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/kernel/storage.fc  2007-08-02
> 11:02:02.000000000 -0400
> @@ -23,6 +23,7 @@
>  /dev/loop.*            -b
> gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
>  /dev/lvm               -c
> gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
>  /dev/mcdx?             -b
> gen_context(system_u:object_r:removable_device_t,s0)
> +/dev/megadev.*         -c
> gen_context(system_u:object_r:removable_device_t,s0)
>  /dev/mmcblk.*          -b
> gen_context(system_u:object_r:removable_device_t,s0)
>  /dev/nb[^/]+           -b
> gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
>  /dev/optcd             -b
> gen_context(system_u:object_r:removable_device_t,s0)
> --- nsaserefpolicy/policy/modules/kernel/storage.if     2007-06-15
> 14:54:30.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/kernel/storage.if  2007-08-02
> 11:02:02.000000000 -0400
> @@ -100,6 +100,7 @@
> 
>         dev_list_all_dev_nodes($1)
>         allow $1 fixed_disk_device_t:blk_file read_blk_file_perms;
> +       allow $1 fixed_disk_device_t:chr_file read_chr_file_perms;
>         typeattribute $1 fixed_disk_raw_read;
>  ')
> 
> @@ -144,6 +145,7 @@
> 
>         dev_list_all_dev_nodes($1)
>         allow $1 fixed_disk_device_t:blk_file write_blk_file_perms;
> +       allow $1 fixed_disk_device_t:chr_file write_chr_file_perms;
>         typeattribute $1 fixed_disk_raw_write;
>  ')
> 
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
