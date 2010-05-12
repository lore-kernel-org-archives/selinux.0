Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4CMIPHl007450
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 18:18:25 -0400
Received: from mxout-08.mxes.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4CMJZlx008346
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 22:19:35 GMT
Message-ID: <20100512231821.vljm4wn1cgcwow44@legacy.mxes.net>
Date: Wed, 12 May 2010 23:18:21 +0100
From: Martin Orr <martin@martinorr.name>
To: Petter Reinholdtsen <pere@hungry.com>
Cc: selinux@tycho.nsa.gov, sysvinit-devel@nongnu.org, 580272@bugs.debian.org
Subject: Re: [Pkg-sysvinit-devel] Bug#580272: sysvinit 2.88 and SELinux
	policy
References: <20100507192427.9mwu09kubk0w44o0@legacy.mxes.net>
	<20100508071114.GH27129@myhost.felk.cvut.cz>
	<20100512121746.GA6219@login2.uio.no>
In-Reply-To: <20100512121746.GA6219@login2.uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed 12 May 13:17:46 2010, Petter Reinholdtsen wrote:

> [Michal Svoboda]
>> And why we want that? Because the function checks if we already have
>> a policy loaded in the kernel. 1 means yes, 0 means no and -1 means
>> no as well. No need to mess with mounting /proc ;-)
>
> Can you test this patch and let me know if it work?

This patch works for me, and so far as I understand things it should 
cover all the cases (no initrd, non-SELinux aware initrd, initrd that 
loads SELinux policy) though I only tested the non-SELinux aware initrd 
case.

Thanks,
Martin Orr

> Index: src/init.c
> ===================================================================
> --- src/init.c  (revision 1888)
> +++ src/init.c  (working copy)
> @@ -54,10 +54,6 @@
>
>  #ifdef WITH_SELINUX
>  #  include <selinux/selinux.h>
> -#  include <sys/mount.h>
> -#  ifndef MNT_DETACH /* present in glibc 2.10, missing in 2.7 */
> -#    define MNT_DETACH 2
> -#  endif
>  #endif
>
>  #ifdef __i386__
> @@ -2869,11 +2865,9 @@
>
>  #ifdef WITH_SELINUX
>         if (getenv("SELINUX_INIT") == NULL) {
> -         const int rc = mount("proc", "/proc", "proc", 0, 0);
> -         if (is_selinux_enabled() > 0) {
> -           putenv("SELINUX_INIT=YES");
> -           if (rc == 0) umount2("/proc", MNT_DETACH);
> +         if (is_selinux_enabled() != 1) {
>             if (selinux_init_load_policy(&enforce) == 0) {
> +             putenv("SELINUX_INIT=YES");
>               execv(myname, argv);
>             } else {
>               if (enforce > 0) {
> @@ -2884,7 +2878,6 @@
>               }
>             }
>           }
> -         if (rc == 0) umount2("/proc", MNT_DETACH);
>         }
>  #endif
>         /* Start booting. */






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
