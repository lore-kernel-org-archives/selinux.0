Message-ID: <D709A20F2164C84E8B7014B0301F5EF85215A0@HAVOC.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        James Morris
	 <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: RE: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Wed, 29 Aug 2007 12:15:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Good. Are you using the upstream or the LSPP kernel? I vaguely
> > remember James asking for stuff to be tested on the LSPP kernel
> > before being ported and presented upstream, but I am now not sure
> > if that applied only to development under the LSPP umbrella.
> > I will be OK either way. I presume Eric would love to see it be the
> > LSPP kernel.
> 
> I'm pretty sure it is the other way around - patches get submitted to
> mainline, vetted there, and then if accepted, back ported to distro
> kernels.

OK, thanks. This would be proper and distro-neutral.

Paul, is davem's net-2.6.24 git cool with you or would you
prefer the stable 2.6.22.5? Or would James' selinu-2.6 git
be proper?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
