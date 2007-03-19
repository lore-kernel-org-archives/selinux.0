Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JFSXOK030028
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 11:28:33 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JFSXP3015293
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 15:28:33 GMT
Subject: Re: sudo change in policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45E59FF1.9070306@redhat.com>
References: <45E59FF1.9070306@redhat.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 11:29:04 -0400
Message-Id: <1174318144.29664.56.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-28 at 10:29 -0500, Daniel J Walsh wrote:
> sudo should be able to getattr on all executables not just 
> bin_t/sbin_t.  Confined executeables run from sudo need this.
> 
> sudo_exec_t needs to be marked as exec_type so prelink will work correctly.
> 
> sudo semanage should work

Merged, except for the comment change.

> --- nsaserefpolicy/policy/modules/admin/sudo.if 2007-02-19
> 11:32:54.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/admin/sudo.if      2007-02-28
> 10:25:17.000000000 -0500
> @@ -37,7 +37,6 @@
>  
>         gen_require(`
>                 type sudo_exec_t;
> -               bool secure_mode;
>         ')
>  
>         ##############################
> @@ -92,12 +91,10 @@
>         fs_getattr_xattr_fs($1_sudo_t)
>  
>         auth_domtrans_chk_passwd($1_sudo_t)
> -       # sudo stores a token in the pam_pid directory
>         auth_manage_pam_pid($1_sudo_t)
>  
> -       corecmd_getattr_bin_files($1_sudo_t)
>         corecmd_read_sbin_symlinks($1_sudo_t)
> -       corecmd_getattr_sbin_files($1_sudo_t)
> +       corecmd_getattr_all_executables($1_sudo_t)
>  
>         domain_use_interactive_fds($1_sudo_t)
>         domain_sigchld_interactive_fds($1_sudo_t)
> --- nsaserefpolicy/policy/modules/admin/sudo.te 2007-02-19
> 11:32:54.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/admin/sudo.te      2007-02-28
> 10:25:17.000000000 -0500
> @@ -7,5 +7,6 @@
>  
>  type sudo_exec_t;
>  files_type(sudo_exec_t)
> +corecmd_executable_file(sudo_exec_t)
>  
>  # Remaining policy in per user domain template.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
