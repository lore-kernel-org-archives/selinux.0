Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7MJu7gj019327
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 15:56:07 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7MJu6H3002124
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 19:56:06 GMT
Subject: Re: [Fwd: [PATCH] refpolicy: system_fstools changes]
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46B22336.2060105@redhat.com>
References: <46B22336.2060105@redhat.com>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 15:55:11 -0400
Message-Id: <1187812511.13874.103.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 14:32 -0400, Daniel J Walsh wrote:
> 
> Do not want to confine mkswap

This part cannot be applied.  You won't be able to format swap
partitions.  For any other use, thats why its attributed as an app, and
exec() interfaces exist.

> postfix wants to read fsdaemon pipes

Merged.

> fsadm tools can be executed by users

Redundant due to init_system_domain()

> fsadm needs to interact with xen

I can't find the implementation for this interface.

> --- nsaserefpolicy/policy/modules/system/fstools.fc     2007-06-11 16:05:30.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/system/fstools.fc  2007-08-02 11:02:02.000000000 -0400
> @@ -20,7 +20,6 @@
>  /sbin/mkfs.*           --      gen_context(system_u:object_r:fsadm_exec_t,s0)
>  /sbin/mkraid           --      gen_context(system_u:object_r:fsadm_exec_t,s0)
>  /sbin/mkreiserfs       --      gen_context(system_u:object_r:fsadm_exec_t,s0)
> -/sbin/mkswap           --      gen_context(system_u:object_r:fsadm_exec_t,s0)
>  /sbin/parted           --      gen_context(system_u:object_r:fsadm_exec_t,s0)
>  /sbin/partprobe                --      gen_context(system_u:object_r:fsadm_exec_t,s0)
>  /sbin/partx            --      gen_context(system_u:object_r:fsadm_exec_t,s0)
> --- nsaserefpolicy/policy/modules/system/fstools.if     2007-05-29 14:10:58.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/system/fstools.if  2007-08-02 11:02:02.000000000 -0400
> @@ -124,3 +124,22 @@
> 
>         allow $1 swapfile_t:file getattr;
>  ')
> +
> +########################################
> +## <summary>
> +##     Read fstools unnamed pipes.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`fstools_read_pipes',`
> +       gen_require(`
> +               type fsdaemon_t;
> +       ')
> +
> +       allow $1 fsdaemon_t:fifo_file read_fifo_file_perms;
> +')
> +
> --- nsaserefpolicy/policy/modules/system/fstools.te     2007-07-25 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/system/fstools.te  2007-08-02 11:02:02.000000000 -0400
> @@ -9,6 +9,7 @@
>  type fsadm_t;
>  type fsadm_exec_t;
>  init_system_domain(fsadm_t,fsadm_exec_t)
> +application_executable_file(fsadm_exec_t)
>  role system_r types fsadm_t;
> 
>  type fsadm_log_t;
> @@ -69,6 +70,7 @@
> 
>  dev_getattr_all_chr_files(fsadm_t)
>  dev_dontaudit_getattr_all_blk_files(fsadm_t)
> +dev_dontaudit_getattr_generic_files(fsadm_t)
>  # mkreiserfs and other programs need this for UUID
>  dev_read_rand(fsadm_t)
>  dev_read_urand(fsadm_t)
> @@ -179,3 +181,8 @@
>         fs_dontaudit_write_ramfs_pipes(fsadm_t)
>         rhgb_stub(fsadm_t)
>  ')
> +
> +optional_policy(`
> +       xen_append_log(fsadm_t)
> +       xen_rw_image_files(fsadm_t)
> +')
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
