Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8N2jNrT006693
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 22:45:24 -0400 (EDT)
Received: from maat.darkhonor.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8N2jMWF004436
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 02:45:22 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: SELinux  Doesn't Complete Initialization
Date: Wed, 22 Sep 2004 22:48:51 -0400
Message-ID: <A52BEA1D8EE8634B9196A136333637B130D4@maat.darkhonor.net>
From: "Alex Ackerman" <alex@darkhonor.com>
To: "Luke Kenneth Casson Leighton" <lkcl@lkcl.net>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

No luck.  I didn't see any additional logs.  Is the Cryptographic API
required for the modules to complete initialization? Here are the
relevant parts of the log files:

Sep 22 21:25:07 seth kernel: Linux version 2.6.8-1.521
(bhcompile@tweety.build.redhat.com) (gcc version 3.3.3 20040412 (Red Hat
Linux 3.3.3-7)) #1 Mon Aug 16 09:01:18 EDT 2004
Sep 22 21:25:07 seth kernel: Kernel command line: ro root=LABEL=/ quiet
vga=792 audit=1 selinux=1 enforcing=0
Sep 22 21:25:07 seth kernel: SELinux:  Initializing.
Sep 22 21:25:07 seth kernel: SELinux:  Starting in permissive mode
Sep 22 21:25:07 seth kernel: There is already a security framework
initialized, register_security failed.
Sep 22 21:25:07 seth kernel: selinux_register_security:  Registering
secondary module capability
Sep 22 21:25:07 seth kernel: Capability LSM initialized as secondary
Sep 22 21:25:10 seth kernel: audit(1095888279.943:0): initialized
Sep 22 21:25:11 seth kernel: SELinux:  Registering netfilter hooks
Sep 22 21:25:11 seth kernel: Initializing Cryptographic API
Sep 22 21:25:11 seth kernel: ksign: Installing public key data
Sep 22 21:25:11 seth kernel: Loading keyring
Sep 22 21:25:11 seth kernel: - Added public key 9488DB81FF525AA3
Sep 22 21:25:11 seth kernel: - User ID: Red Hat, Inc. (Kernel Module GPG
key)
Sep 22 21:25:11 seth kernel: ksign: invalid packet (ctb=00)
Sep 22 21:25:11 seth kernel: Unable to load default keyring: error=74


-----Original Message-----
From: Luke Kenneth Casson Leighton [mailto:lkcl@lkcl.net] 
Sent: Wednesday, September 22, 2004 5:51 PM
To: Alex Ackerman
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux Doesn't Complete Initialization

On Wed, Sep 22, 2004 at 02:27:48PM -0400, Alex Ackerman wrote:

> /boot/grub/grub.conf:
> default=0
> timeout=10
> splashimage=(hd0,0)/grub/splash.xpm.gz
> 
> title SELinux (2.6.8-1.521)
>         root (hd0,0)
>         kernel /vmlinuz-2.6.8-1.521 ro root=LABEL=/ quiet vga=792
selinux=1 enforcing=0

	add "audit=1" to this and you will see some loovely debug
messages.

	[auditing was introduced around 2.6.6 or so]

    can't tell you about the options below but from what i understand
	if you didn't have enforcing=0 above then the option
	SELINUX=permissive would be read and used instead.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />








--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
