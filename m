Subject: RE: [RFC 0/5] Static/fallback external labels for NetLabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF8521580@HAVOC.tcs-sec.com>
References: <D709A20F2164C84E8B7014B0301F5EF8521580@HAVOC.tcs-sec.com>
Content-Type: text/plain
Date: Wed, 29 Aug 2007 11:45:07 -0400
Message-Id: <1188402307.26572.193.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-29 at 11:29 -0400, Venkat Yekkirala wrote:
> > Please keep sending RFCs/patches to the SELinux list while we 
> > sort out all of 
> > the implementation details and I'll see about setting up a 
> > git tree where we 
> > can do all of the bigger/intrusive changes.  This should make 
> > it easier for 
> > us to work together and people who are interesting in testing the new 
> > features will have a working tree to pull from.  Once things 
> > are looking good 
> > I'll work to get all of the contributed patches upstream.
> 
> Good. Are you using the upstream or the LSPP kernel? I vaguely
> remember James asking for stuff to be tested on the LSPP kernel
> before being ported and presented upstream, but I am now not sure
> if that applied only to development under the LSPP umbrella.
> I will be OK either way. I presume Eric would love to see it be the
> LSPP kernel.

I'm pretty sure it is the other way around - patches get submitted to
mainline, vetted there, and then if accepted, back ported to distro
kernels.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
