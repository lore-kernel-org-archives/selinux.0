Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PEZIVH016860
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 09:35:18 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1PEZHa4008115
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 14:35:17 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: refpolicy: patch rpc
Date: Mon, 25 Feb 2008 09:31:07 -0500
Message-ID: <1203949867.32061.52.camel@gorn>
In-Reply-To: <20080225123830.GA31035@bobek.pm.i.cz>
References: <20080225123830.GA31035@bobek.pm.i.cz>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?iso-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: <selinux@tycho.nsa.gov>, <selinux-devel@lists.alioth.debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-02-25 at 13:38 +0100, Václav Ovsík wrote:
> Hi,
> following denials appears during startup of rpc.statd (nfs-common
> service) on Debian Sid:
> 
> Feb 22 23:27:45 sid kernel: audit(1203719264.336:3): avc:  denied  { search } for  pid=1482 comm="rpc.statd" name="sbin" dev=sda1 ino=245761 scontext=system_u:system_r:rpcd_t:s0 tcontext=system_u:object_r:bin_t:s0 tclass=dir
> Feb 22 23:27:45 sid kernel: audit(1203719264.336:4): avc:  denied  { execute } for  pid=1482 comm="rpc.statd" name="sm-notify" dev=sda1 ino=376910 scontext=system_u:system_r:rpcd_t:s0 tcontext=system_u:object_r:bin_t:s0 tclass=file
> Feb 22 23:27:45 sid kernel: audit(1203719264.336:5): avc:  denied  { execute_no_trans } for  pid=1482 comm="rpc.statd" name="sm-notify" dev=sda1 ino=376910 scontext=system_u:system_r:rpcd_t:s0 tcontext=system_u:object_r:bin_t:s0 tclass=file
> Feb 22 23:27:45 sid kernel: audit(1203719264.336:6): avc:  denied  { read } for  pid=1482 comm="rpc.statd" name="sm-notify" dev=sda1 ino=376910 scontext=system_u:system_r:rpcd_t:s0 tcontext=system_u:object_r:bin_t:s0 tclass=file
> Feb 22 23:27:45 sid kernel: audit(1203719264.724:7): avc:  denied  { search } for  pid=1482 comm="sm-notify" name="fs" dev=proc ino=-268435429 scontext=system_u:system_r:rpcd_t:s0 tcontext=system_u:object_r:sysctl_fs_t:s0 tclass=dir

> @@ -60,10 +60,13 @@
>  manage_files_pattern(rpcd_t,rpcd_var_run_t,rpcd_var_run_t)
>  files_pid_filetrans(rpcd_t,rpcd_var_run_t,file)
>  
> +corecmd_exec_bin(rpcd_t)
> +
>  kernel_read_system_state(rpcd_t) 
>  kernel_search_network_state(rpcd_t) 
>  # for rpc.rquotad
>  kernel_read_sysctl(rpcd_t)  
> +kernel_rw_fs_sysctls(rpcd_t)
>  
>  fs_list_rpc(rpcd_t)
>  fs_read_rpc_files(rpcd_t)

Perhaps we should make sm-notify rpcd_exec_t and allow exec on that?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
