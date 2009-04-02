Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n32MaT1k009152
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 18:36:29 -0400
Received: from g4t0015.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n32MaSvu004271
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 22:36:29 GMT
From: Paul Moore <paul.moore@hp.com>
To: Nicolas Williams <Nicolas.Williams@sun.com>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet
 =?iso-8859-1?q?Draft=09posted_to_IETF?= website
Date: Thu, 2 Apr 2009 18:35:50 -0400
Cc: Jarrett Lu <Jarrett.Lu@sun.com>, labeled-nfs@linux-nfs.org,
        selinux@tycho.nsa.gov, nfs-discuss@opensolaris.org, nfsv4@ietf.org
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <200904011246.33436.paul.moore@hp.com> <20090402152423.GL1500@Sun.COM>
In-Reply-To: <20090402152423.GL1500@Sun.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904021835.51068.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 02 April 2009 11:24:24 am Nicolas Williams wrote:
> On Wed, Apr 01, 2009 at 12:46:33PM -0400, Paul Moore wrote:
> > My only comment was that figuring out how to transfer information over
> > the network isn't really that important yet.  Reading through the thread
> > I don't think there is general agreement on what we even need to send to
> > enable proper label translation/encoding/etc.
>
> I think we all agree that a client and server have to agree on the
> meaning of any given DOI number so that they can properly encode labels.
>
> In order to interop this means we need a common label encoding for any
> given DOI.
>
> I think we agree on that, no?

Yep.  Although I don't think we should try to force a single label encoding 
for all DOIs (couldn't tell from your reply how far you wanted to take this); 
using some combination of DOI+<opaque label> seems reasonable.

> That leaves this problem: how to ensure that the client and server do
> actually agree as to a given DOI's label encodings?
>
> That's a big problem that to date has been solved by out-of-band
> mechanisms.  That solution leaves interoperability in a lurch: it's up
> to vendors to cooperate to obtain a common security policy for use on
> the wire.

Well, I think the trick is you define a security policy and label format in 
the DOI and then leave it up to the various implementations to handle the 
necessary internalization and import/export of the DOI.  Perhaps we are in a 
six-of-one/half-dozen-of-the-other discussion right now.

> I think Jarret's quite right to ask that we do better than that.

I'm not arguing that we try to do better than has been done before, I'm a big 
fan of "better".  My only concern is that if we do "better" we do "better" for 
more than just NFS.

> Doing better means: a) coming up with a common labeled security policy
> language for MLS and DTE

At this point I'm glad there is an option "B" :)

> b) ensuring that clients and servers agree on a DOI's policy.

As you point out, this seems much more reasonable of a goal.

> > > ... and probably outside the scope of labeled NFSv4 enhancement.
> >
> > Perhaps.  Keep in mind I'm trying to think a bit more generically; if
> > that isn't the goal I'll be happy to go back to my corner and sit quietly
> > :)
>
> Parts of the solution will be outside the scope of the NFSv4 WG.  That
> doesn't mean we can't undertake a solution.  Assuming (a) (see above) we
> need only specify (b) (see above) for NFSv4 -- we can leave (a) to
> another WG.

I guess I personally don't really care about WG boundaries right now, I'm 
mostly interested in arriving at a decent, complete solution.  My belief is 
that once we arrive at a good idea we can divide it up amongst whatever WGs 
are appropriate.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
