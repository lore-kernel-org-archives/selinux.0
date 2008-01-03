Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m03JfrBn025194
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 14:41:53 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m03JfqjV022225
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 19:41:52 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: run_init patch for Fedora 8
Date: Thu, 3 Jan 2008 14:39:27 -0500
Message-ID: <1199389167.12626.322.camel@gorn.columbia.tresys.com>
In-Reply-To: <Pine.LNX.4.64.0712271432030.13060@euphrosyne.pab>
References: <Pine.LNX.4.64.0712271432030.13060@euphrosyne.pab>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <bigotp@acm.org>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-12-27 at 14:39 -0700, Peter A. Bigot wrote:
> This patch, or something like it, seems to be necessary to allow run_init to
> execute in the sysadm_r role on a Fedora 8 system.  Without it I see:
> 
> type=SYSCALL msg=audit(12/27/2007 13:33:40.332:93) : arch=i386 syscall=execve success=yes exit=0 a0=2e3a18 a1=bfd2c31c a2=2e5408 a3=400 items=0 ppid=2123 pid=2126 auid=pab uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=pts0 comm=unix_update exe=/sbin/unix_update subj=staff_u:sysadm_r:run_init_t:s0-s15:c0.c255 key=(null) 
> type=AVC msg=audit(12/27/2007 13:33:40.332:93) : avc:  denied  { execute_no_trans } for  pid=2126 comm=run_init path=/sbin/unix_update dev=sda2 ino=589945 scontext=staff_u:sysadm_r:run_init_t:s0-s15:c0.c255 tcontext=system_u:object_r:updpwd_exec_t:s0 tclass=file 
> type=AVC msg=audit(12/27/2007 13:33:40.332:93) : avc:  denied  { read } for  pid=2126 comm=run_init name=unix_update dev=sda2 ino=589945 scontext=staff_u:sysadm_r:run_init_t:s0-s15:c0.c255 tcontext=system_u:object_r:updpwd_exec_t:s0 tclass=file 
> type=AVC msg=audit(12/27/2007 13:33:40.332:93) : avc:  denied  { execute } for  pid=2126 comm=run_init name=unix_update dev=sda2 ino=589945 scontext=staff_u:sysadm_r:run_init_t:s0-s15:c0.c255 tcontext=system_u:object_r:updpwd_exec_t:s0 tclass=file

I added only the domtrans as your messages don't indicate the additional
access from run is required.

> Index: policy/modules/system/selinuxutil.te
> ===================================================================
> --- policy/modules/system/selinuxutil.te	(revision 2565)
> +++ policy/modules/system/selinuxutil.te	(working copy)
> @@ -388,6 +388,13 @@
>   seutil_libselinux_linked(run_init_t)
>   seutil_read_default_contexts(run_init_t)
> 
> +ifdef(`distro_redhat',`
> +	gen_require(`
> +		attribute admin_terminal;
> +	')
> +	auth_run_upd_passwd(run_init_t, sysadm_r, admin_terminal);
> +')
> +
>   ifndef(`direct_sysadm_daemon',`
>   	ifdef(`distro_gentoo',`
>   		# Gentoo integrated run_init:

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
