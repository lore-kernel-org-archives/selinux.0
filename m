Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l42HU0U6007801
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 13:30:00 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l42HTxuY002143
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 17:29:59 GMT
Subject: Re: modutils policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46278057.6000608@redhat.com>
References: <46278057.6000608@redhat.com>
Content-Type: text/plain
Date: Wed, 02 May 2007 13:29:37 -0400
Message-Id: <1178126977.445.6.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 10:44 -0400, Daniel J Walsh wrote:
> insmod needs to be able to mount kvmfs for kvm.
> 
> insmod executes init scripts when inserting and removing certain
> modules.
> 
> Any gui tool that is launched via userhelper can trigger a 
> unconfined_rw_pipe including ones that insert modules.

Merged except for the init script part; thats a spec transition instead
of a auto (insmod is selinux-aware)?

> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (modutils.patch)
> 
> --- nsaserefpolicy/policy/modules/system/modutils.te    2007-04-11 15:52:54.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/system/modutils.te        2007-04-17 15:50:53.000000000 -0400
> @@ -58,6 +58,7 @@
>  kernel_read_system_state(insmod_t)
>  kernel_write_proc_files(insmod_t)
>  kernel_mount_debugfs(insmod_t)
> +kernel_mount_kvmfs(insmod_t)
>  kernel_read_debugfs(insmod_t)
>  # Rules for /proc/sys/kernel/tainted
>  kernel_read_kernel_sysctls(insmod_t)
> @@ -101,6 +102,7 @@
>  init_use_fds(insmod_t)
>  init_use_script_fds(insmod_t)
>  init_use_script_ptys(insmod_t)
> +init_spec_domtrans_script(insmod_t)
>  
>  libs_use_ld_so(insmod_t)
>  libs_use_shared_libs(insmod_t)
> @@ -163,6 +165,10 @@
>         xserver_getattr_log(insmod_t)
>  ')
>  
> +optional_policy(`
> +       unconfined_dontaudit_rw_pipes(insmod_t)
> +')
> +
>  ########################################
>  #
>  # depmod local policy
> --- nsaserefpolicy/policy/modules/kernel/kernel.if      2007-02-19 11:32:51.000000000 -0500
> +++ serefpolicy-2.5.12/policy/modules/kernel/kernel.if  2007-04-17 15:50:55.000000000 -0400
> @@ -2408,3 +2425,22 @@
>  
>         typeattribute $1 kern_unconfined;
>  ')
> +
> +########################################
> +## <summary>
> +##     Mount a kernel vm filesystem.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     The type of the domain mounting the filesystem.
> +##     </summary>
> +## </param>
> +#
> +interface(`kernel_mount_kvmfs',`
> +       gen_require(`
> +               type kvmfs_t;
> +       ')
> +
> +       allow $1 kvmfs_t:filesystem mount;
> +')
> +
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
