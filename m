Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78I15sK025858
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 14:01:05 -0400
Received: from g4t0014.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m78I15d0023929
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 18:01:05 GMT
From: Paul Moore <paul.moore@hp.com>
To: Mike Edenfield <kutulu@kutulu.org>
Subject: Re: Help: SELinux causing(?) boot failures...
Date: Fri, 8 Aug 2008 14:01:00 -0400
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
References: <489C6A4F.3020704@kutulu.org> <200808081251.45453.paul.moore@hp.com> <489C801E.9040306@kutulu.org>
In-Reply-To: <489C801E.9040306@kutulu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808081401.00581.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 August 2008 1:19:26 pm Mike Edenfield wrote:
> Paul Moore wrote:
> > On Friday 08 August 2008 11:46:23 am Mike Edenfield wrote:
> >> The reason I strongly suspect SELinux is the problem (or at least
> >> a major factor), is that adding "selinux=0" to my boot command
> >> line corrects the problem, and the system boots fine.  Everything
> >> appears to be installed and configured correctly, except obviously
> >> SELinux is now disabled.  The filesystems are all labeled
> >> correctly, and even on the failing boot the AVC messages display
> >> the correct labels, like tty_device_t and urandom_device_t.
> >
> > Hi Mike,
> >
> > In general, you are better off using "enforcing=0", which keeps
> > SELinux enabled but puts it into permissive mode, on the kernel
> > command line instead of "selinux=0", which disables SELinux
> > entirely.  Have you tried rebooting with "enforcing=0" and
> > capturing the AVC messages from the console/audit/syslog output and
> > seeing if anything looks awry?  If not go ahead and do so and send
> > them to the list, this will tell us what actions are being denied
> > and why.
>
> I have SELinux configured for permissive mode to begin with, but I
> tried adding "enforcing=0" to the boot command line to no effect.

Sorry, based on the problems you were seeing I assumed you were running 
in enforcing mode, I guess the old adage about "assuming" applies 
here :(

> Here are the denials I am getting:
>
> (transcribed by hand since neither syslog nor auditd are starting)

Since you went to the trouble to transcribe all the messages by hand I 
really need to apologize!  Since you are running in permissive mode I 
doubt SELinux is the source of all the strange behavior you are seeing; 
in permissive mode SELinux will alert you of access denials (AVC 
messages) but it won't actually deny the access.

What I don't understand is why you are seeing such a substantial 
difference between disabling SELinux entirely and running it in 
permissive mode.  Have you contacted the Gentoo folks about the 
problem?  I'm beginning to think your problems may be distro related.

> avc: denied { execute_no_trans } for pid=1 comm="init"
> path="/sbin/init" dev=sda3 ino=920038
> scontext=system_u:system_r:kernel_t
> tcontext=system_u:object_r:file_t tclass=file
> avc: denied { read } for pid=1 comm="init" name="ld-linux.so.2"
> dev=sda3 ino=1785880 scontext=system_u:system_r:kernel_t
> tcontext=system_u:object_r:file_t tclass=lnk_file
> avc: denied { getattr } for pid=1 comm="init" path="/etc/ld.so.cache"
> dev=sda3 ino=1090186 scontext=system_u:system_r:kernel_t
> tcontext=system_t:object_r:file_t tclass=file
> avc: denied { read } for pid=1 comm="init" name="udanrom" dev=sda3
> ino=126002 scontext=system_u:system_r:kernel_t
> tcontext=system_u:object_r:urandom_device_t tclass=chr_file
> avc: denied { getattr } for pid=1 comm="init" name="/" dev=selinuxfs
> ino=1 scontext=system_u:system_r:kernel_t
> tcontext=system_t:object_r:security_t tclass=filesystem
> avc: denied { read write } for pid=1 comm="init" name="tty0" dev=sda3
> ino=126327 scontext=system_u:system_r:kernel_t
> tcontext=system_u:object_r:tty_device_t tclass=chr_file

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
