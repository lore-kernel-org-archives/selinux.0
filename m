Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IDsrDb023422
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 09:54:53 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m6IDsqAI013311
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 13:54:53 GMT
Subject: Re: [refpolicy] Let dpkg scripts ptrace
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Martin Orr <martin@martinorr.name>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <486272E3.109@martinorr.name>
References: <486272E3.109@martinorr.name>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 09:54:25 -0400
Message-Id: <1216389265.21191.141.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-06-25 at 17:31 +0100, Martin Orr wrote:
> Some dpkg maintainer scripts run pidof, which needs the sys_ptrace capability.
> 
> Mar 17 15:14:31 caligula kernel: audit(1205766871.788:13): avc:  denied  {
> sys_ptrace } for  pid=4214 comm="pidof" capability=19
> scontext=system_u:system_r:dpkg_script_t:s0
> tcontext=system_u:system_r:dpkg_script_t:s0 tclass=capability

Seems odd, since the ptrace process permission is not allowed.  Does it
work without this in enforcing?

> plain text document attachment (118_dpkg_script_pidof)
> Written by: Martin Orr
> 
> Allow dpkg scripts to run pidof
> 
> Mar 17 15:14:31 caligula kernel: audit(1205766871.788:13): avc:  denied  { sys_ptrace } for  pid=4214 comm="pidof" capability=19 scontext=system_u:system_r:dpkg_script_t:s0 tcontext=system_u:system_r:dpkg_script_t:s0 tclass=capability
> 
> Index: policy/modules/admin/dpkg.te
> ===================================================================
> --- policy/modules/admin/dpkg.te.orig
> +++ policy/modules/admin/dpkg.te
> @@ -216,7 +216,7 @@
>  #
>  # TODO: actually use dpkg_script_t
>  
> -allow dpkg_script_t self:capability { chown dac_override dac_read_search fowner fsetid setgid setuid ipc_lock sys_chroot sys_nice mknod kill };
> +allow dpkg_script_t self:capability { chown dac_override dac_read_search fowner fsetid setgid setuid ipc_lock sys_chroot sys_nice mknod kill sys_ptrace };
>  allow dpkg_script_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
>  allow dpkg_script_t self:fd use;
>  allow dpkg_script_t self:fifo_file rw_fifo_file_perms;
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
