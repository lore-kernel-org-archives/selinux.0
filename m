From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Wed, 29 Aug 2007 12:41:40 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <D709A20F2164C84E8B7014B0301F5EF85215A0@HAVOC.tcs-sec.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF85215A0@HAVOC.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708291241.40943.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, August 29 2007 12:15:31 pm Venkat Yekkirala wrote:
> > > Good. Are you using the upstream or the LSPP kernel? I vaguely
> > > remember James asking for stuff to be tested on the LSPP kernel
> > > before being ported and presented upstream, but I am now not sure
> > > if that applied only to development under the LSPP umbrella.
> > > I will be OK either way. I presume Eric would love to see it be the
> > > LSPP kernel.
> >
> > I'm pretty sure it is the other way around - patches get submitted to
> > mainline, vetted there, and then if accepted, back ported to distro
> > kernels.
>
> OK, thanks. This would be proper and distro-neutral.
>
> Paul, is davem's net-2.6.24 git cool with you or would you
> prefer the stable 2.6.22.5? Or would James' selinu-2.6 git
> be proper?

For right now go ahead and back against Linus' linux-2.6 tree and I'll deal 
with any merge issues once I get a git tree going.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
