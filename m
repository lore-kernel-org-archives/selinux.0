Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MNoFdW026810
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 18:50:15 -0500 (EST)
Received: from smtp.osdl.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1MNljZG025091
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 23:47:53 GMT
Date: Tue, 22 Feb 2005 15:47:37 -0800
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: lsm <linux-security-module@wirex.com>, Chris Wright <chrisw@osdl.org>,
   James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Ivan Gyurdiev <ivg2@cornell.edu>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][PATCH] Pass requested protection to security_file_mmap/mprotect hooks
Message-ID: <20050222234737.GK15867@shell0.pdx.osdl.net>
References: <1109095368.15893.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1109095368.15893.17.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> This patch adds a reqprot parameter to the security_file_mmap and
> security_file_mprotect hooks that is the original requested protection
> value prior to any modification for read-implies-exec, and changes the
> SELinux module to allow a mode of operation (controllable via
> a /selinux/checkreqprot setting) where it applies checks based on that
> protection value rather than the protection that will be applied by the
> kernel, effectively restoring SELinux's original behavior prior to the
> introduction of the read-implies-exec logic in the mainline kernel.  At
> present, the read-implies-exec logic causes SELinux to see every
> mmap/mprotect read request by legacy binaries or binaries marked with
> PT_GNU_STACK RWE as a read|execute request, which tends to distort
> policy even if it reflects what is ultimately possible.

Only other way I can see is to effectively tweak policy based on
tsk->personality.  While it seems ugly, it's an accurate reflection
of both policy and reality (with some confusion of audit messages when
building policy).  But your patch is probably the most straight-forward
way to do it.

> Index: linux-2.6/mm/mprotect.c
> ===================================================================
> RCS file: /nfshome/pal/CVS/linux-2.6/mm/mprotect.c,v
> retrieving revision 1.10
> diff -u -p -r1.10 mprotect.c
> --- linux-2.6/mm/mprotect.c	27 Dec 2004 15:09:53 -0000	1.10
> +++ linux-2.6/mm/mprotect.c	22 Feb 2005 14:36:21 -0000
> @@ -193,7 +193,7 @@ fail:
>  asmlinkage long
>  sys_mprotect(unsigned long start, size_t len, unsigned long prot)
>  {
> -	unsigned long vm_flags, nstart, end, tmp;
> +	unsigned long vm_flags, nstart, end, tmp, reqprot = prot;

Do you want to sample prot after it's been cleared of GROWSUP/DOWN bits
just to keep reqport as clean as possible?

> +		prot = reqprot;
> +
>  	if (vma->vm_file != NULL && vma->anon_vma != NULL && (prot & PROT_EXEC)) {
>  		/*
>  		 * We are making executable a file mapping that has
> Index: linux-2.6/security/selinux/selinuxfs.c
> ===================================================================
> RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/selinuxfs.c,v
> retrieving revision 1.51
> diff -u -p -r1.51 selinuxfs.c
> --- linux-2.6/security/selinux/selinuxfs.c	2 Dec 2004 15:21:42 -0000	1.51
> +++ linux-2.6/security/selinux/selinuxfs.c	22 Feb 2005 15:33:39 -0000
> @@ -34,6 +34,8 @@
>  #include "objsec.h"
>  #include "conditional.h"
>  
> +unsigned int selinux_checkreqprot = 0;

unnecessary initialization

> +
>  static DECLARE_MUTEX(sel_sem);
>  
>  /* global data for booleans */
> @@ -72,6 +74,7 @@ enum sel_inos {
>  	SEL_DISABLE,	/* disable SELinux until next reboot */
>  	SEL_AVC,	/* AVC management directory */
>  	SEL_MEMBER,	/* compute polyinstantiation membership decision */
> +	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
>  };
>  
>  #define TMPBUFLEN	12
> @@ -300,6 +303,55 @@ static struct file_operations sel_contex
>  	.write		= sel_write_context,
>  };
>  
> +#define TMPBUFLEN	12

Looks an unnecessary duplicate 

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
