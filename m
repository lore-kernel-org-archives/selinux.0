Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4OHhVgA019290
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 13:43:31 -0400 (EDT)
Received: from web60413.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j4OHckMp026094
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 17:38:46 GMT
Message-ID: <20050524173846.41350.qmail@web60413.mail.yahoo.com>
Date: Tue, 24 May 2005 10:38:46 -0700 (PDT)
From: Roger Brunell <rog_brunell@yahoo.com>
Subject: Re: Moving target -- kernel version.
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2005-05-24 at 05:35 -0700, Roger Brunell wrote:
> > I am starting to feel a rising wave of frustration with producing a
> > reproducible script for installing selinux.
> > 
> > To do the install the kernel must be patched and rebuild.
> > To patch and build the source must be present
> > But which source???
> >   ? apt-get kernel-source-2.6.11     (version = 2.6.11-3)
> >   ? Distro version is not documented
> >      ? Kernel.org patches applied not documented
> >      ? Distro patches applied -- not documented
> 
> First, you can use a vanilla kernel.org kernel or your favorite distro
> kernel unchanged, as long it is a 2.6 kernel and SELinux support was
> enabled in the kernel configuration, since SELinux is in the mainline
> kernel.  For some distro kernels like Debian or SuSE, this means you
> need to boot with selinux=1 on the kernel commandline because they
> compiled in SELinux support but set the default to disable at boot time.
> You only need to patch and build your own kernel if you want the latest
> SELinux changes and they aren't already included in your kernel.  Note
> that a superset of the SELinux changes from the patch on nsa.gov are
> included in 2.6.12-rc4, so that is actually more up-to-date with the
> latest SELinux changes than the 2.6.11-based patch on nsa.gov.
> 
> Second, http://www.nsa.gov/selinux/code/download5.cfm clearly states
> that the SELinux kernel patch available there is relative to the 2.6.11
> sources from The Linux Kernel Archives aka kernel.org.  It applies
> cleanly to that kernel.
> 
> >   ? /nsa/linux-2.6/    is what? Virgin kernel.org sourec ??
> >          nope, it changed since last CVS download a week ago (changes =
> 2168)
> 
> Did you read the nsa/README file?  The vendor branch of that tree tracks
> the official nsa.gov SELinux releases, and interim updates between
                                              ?? to selinux ??
> releases are committed on the head.  Hence, it is presently 2.6.11 with
                                                              ^^^^^^??
                                                    with what patches?

> the 2.6.11-selinux1.patch applied plus some subsequent updates to
                                         ------------------????
> reflect changes made since the release.  I don't believe that it has
                                 ^^ of 2.6.11 or NewSelinux
> changed recently; looks like the last update was April 28th.


  OK; after posting, I continued to dig. I really want to be sure that any
distro changes aren't removed that the distro depends upon. Along the way, I
downloaded the pkg labeled:
       kernel-patch-dedebian.6.11
I open this up and found all the kernel.org patches up through #10 as well as
the Debian unique ones. So it looks like the kernel-source-2.6.11 pkg should be
good. I confirm that by verifying the first code modification in p10 is in the
source:
---------
diff -Naur linux-2.6.11/arch/ia64/kernel/fsys.S
linux-2.6.11.10/arch/ia64/kernel/fsys.S
--- linux-2.6.11/arch/ia64/kernel/fsys.S        2005-03-01 23:38:34.000000000
-0800
+++ linux-2.6.11.10/arch/ia64/kernel/fsys.S     2005-05-16 10:50:30.000000000
-0700
@@ -611,8 +611,10 @@
        movl r2=ia64_ret_from_syscall
        ;;
        mov rp=r2                               // set the real return addr
-       tbit.z p8,p0=r3,TIF_SYSCALL_TRACE
+       and r3=_TIF_SYSCALL_TRACEAUDIT,r3
        ;;
-------

And sure enough, my /usr/src/kernel-source-2.6.11/arch/ia64/kernel/fsfsys says

------
    611         movl r2=ia64_ret_from_syscall
    612         ;;
    613         mov rp=r2                               // set the real return
    613 addr
    614         and r3=_TIF_SYSCALL_TRACEAUDIT,r3
    615         ;;
------

But the CVCVS downloaded this morning says:

------
    611         movl r2=ia64_ret_from_syscall
    612         ;;
    613         mov rp=r2                               // set the real return
    613 addr
    614         tbit.z p8,p0=r3,TIF_SYSCALL_TRACE
    615         ;;
-------
  I think this means that the sourceforge CVS is less than p10? I haven't
tracked back to what level it is. I now have a better understanding of some of
the patching, and how to track them down. It appears the Debian source is
keeping up with the Kernel.org plus any distro uniqueisms.

> 
> > Right now I am diffing the /nsa/linux-2.6 and the apt-get kernel source.
> 
> Bad idea.  That will end up reverting all the patches applied to the

    I didn't say unpatching, just looking at the diffs.

> Debian kernel, since nsa/linux-2.6 is just vanilla 2.6.11 plus SELinux
> changes.  Either just use the Debian kernel as is (boot with selinux=1)
> or try applying the 2.6.11-selinux1.patch to it if you truly need those
> changes.
  ^^^^^^^                                                           ^^^^^
     I have no idea what "those changes" are, you are speaking of. Do you mean
those found in the SElinux patch on the NSA site may already be in 2.6.11.10
kernel as delivered?
    Nope, I just looked at the security.h file included with the distro
(/usr/src/kernel-headers-2.6.11) and the selinux-patch changes are not yet
present. 
    So I still have to apply that patch a do a kernel build.

> 
> -- 
> Stephen Smalley
> National Security Agency
> 


Roger Brunell

Infosec Engineer (retired)
"Born 20 years too early"

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
