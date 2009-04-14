Date: Tue, 14 Apr 2009 12:10:19 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: Jarrett Lu <Jarrett.Lu@sun.com>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org, nfsv4@ietf.org
Subject: Re: [nfsv4] my thoughts on how Labeled NFSv4 draft should move forward
Message-ID: <20090414171019.GB1500@Sun.COM>
References: <49DA6EF8.1080704@sun.com> <20090410201718.GB1500@Sun.COM> <20090410203839.GC1500@Sun.COM> <1239724769.9761.126.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1239724769.9761.126.camel@moss-terrapins.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Apr 14, 2009 at 11:59:29AM -0400, David P. Quigley wrote:
> On Fri, 2009-04-10 at 15:38 -0500, Nicolas Williams wrote:
> > Of course, it's not clear yet that it will be of much practical value to
> > have such smart servers (e.g., if all the clients would be fully trusted
> > anyways).  It may be possible that "dumb" servers are good enough, in
> > which case we don't need to complicate RPCSEC_GSSv3 with process label
> > assertions (though it's not much of a complication, but the client does
> > need to know, via an NFS operation, whether the server is smart or
> > dumb).
> 
> It is unclear to me why an NFS operation is needed for this. Why can't

It could be an attribute.  That's how a variety of things are negotiated
already.

> this be something that is negotiated in the GSS context? When the GSS
> context is created they can decide if the server is smart or not and if
> it is then the process label is something that is part of the context.
> Then when the server is making a decision if it is Smart it will use the
> credential from the GSS context if not it will ignore it.

I'm thinking that the server could even be selectively smart or dumb.
For example, for objects labeled with MLS the server could be smart.
For objects labeled with Smack the server could be smart if it can
retrieve the rules matched by the client process' label's DOI.  For
objects with DTE labels in a DOI where the number of domains is too
large for it to be meaningful for the server to be smart then the server
could be dumb.

A filesystem attribute seems potentially too coarse for this, but it
could be a per-object attribute.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
