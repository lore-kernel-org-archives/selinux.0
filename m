Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82JOHrT002326
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:24:17 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82JNM3w006872
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 19:23:27 GMT
Date: Thu, 2 Sep 2004 18:19:35 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: fedora-selinux-list@redhat.com, Linas Vepstas <linas@austin.ibm.com>,
   Nigel Kukard <nkukard@lbsd.net>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [OT] SELinux vs. other systems [was Re: [idea] udev + selinux]
Message-ID: <20040902171935.GH5745@lkcl.net>
References: <20040830173744.GD10151@lbsd.net> <20040831191809.GC4375@lkcl.net> <20040831224447.GA4964@austin.ibm.com> <200409022215.20830.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409022215.20830.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 02, 2004 at 10:15:20PM +1000, Russell Coker wrote:

> > Compare that to this thread, where we are talking about atomic vs.
> > non-atomic restoration of context for udev-mounted temp file systems.
> > Shudder. This seems to be begging for an exploit to be discovered.
> > Are we sure that SELinux is really on the right track here?
> 
> The original udev implementation had the device nodes relabelled after 
> creation.  As of recent times (since 2002) the default SE Linux policy has 
> denied almost all domains (only two system domains) access to device nodes 
> labelled as device_t.  This means that there is no window of opportunity for 
> an attacker to access a device before it is correctly labelled.
> 
> The worst race condition attack would be a DOS attack, cause an access at the 
> wrong time and have it be denied when otherwise it would be permitted.  This 
> is the least serious of all possible problems related to device labelling.

 ... and with the use of matchpathcon() followed by setfscreatecon(),
 it isn't even that: inode, symlink and directory
 creation-plus-filecontext-setting are done as an atomic operation.

 problem goes away.

 the _old_ selinux udev support (0.024), on the other hand, suffered
 from the big-deal-DOS-attack that russell describes above.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
