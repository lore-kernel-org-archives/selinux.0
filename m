Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n335LXwB012155
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 01:21:33 -0400
Received: from brmea-mail-4.sun.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n335LWFl000112
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 05:21:32 GMT
Received: from dm-central-02.central.sun.com ([129.147.62.5])
	by brmea-mail-4.sun.com (8.13.6+Sun/8.12.9) with ESMTP id n335LWX9016837
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 05:21:32 GMT
Received: from binky.Central.Sun.COM (binky.Central.Sun.COM [129.153.128.104])
	by dm-central-02.central.sun.com (8.13.8+Sun/8.13.8/ENSMAIL,v2.2) with ESMTP id n335LVXm043955
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 23:21:32 -0600 (MDT)
Date: Thu, 2 Apr 2009 23:42:10 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Jarrett Lu <Jarrett.Lu@sun.com>, labeled-nfs@linux-nfs.org,
        selinux@tycho.nsa.gov, nfs-discuss@opensolaris.org, nfsv4@ietf.org
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft	posted to IETF website
Message-ID: <20090403044210.GK1500@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <200904011246.33436.paul.moore@hp.com> <20090402152423.GL1500@Sun.COM> <200904021835.51068.paul.moore@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200904021835.51068.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 02, 2009 at 06:35:50PM -0400, Paul Moore wrote:
> On Thursday 02 April 2009 11:24:24 am Nicolas Williams wrote:
> > On Wed, Apr 01, 2009 at 12:46:33PM -0400, Paul Moore wrote:
> > > My only comment was that figuring out how to transfer information over
> > > the network isn't really that important yet.  Reading through the thread
> > > I don't think there is general agreement on what we even need to send to
> > > enable proper label translation/encoding/etc.
> >
> > I think we all agree that a client and server have to agree on the
> > meaning of any given DOI number so that they can properly encode labels.
> >
> > In order to interop this means we need a common label encoding for any
> > given DOI.
> >
> > I think we agree on that, no?
> 
> Yep.  Although I don't think we should try to force a single label encoding 
> for all DOIs (couldn't tell from your reply how far you wanted to take this); 
> using some combination of DOI+<opaque label> seems reasonable.

Right.  Once again we have a disconnect on what is meant by "label
encoding" -- only this time I'd adopted Jarret's use of the term for
what Solaris TX calls label encodings and confused you (Jarret had
confused me earlier).

> > That leaves this problem: how to ensure that the client and server do
> > actually agree as to a given DOI's label encodings?
> >
> > That's a big problem that to date has been solved by out-of-band
> > mechanisms.  That solution leaves interoperability in a lurch: it's up
> > to vendors to cooperate to obtain a common security policy for use on
> > the wire.
> 
> Well, I think the trick is you define a security policy and label format in 
> the DOI and then leave it up to the various implementations to handle the 
> necessary internalization and import/export of the DOI.  Perhaps we are in a 
> six-of-one/half-dozen-of-the-other discussion right now.

What Jarret means by label encoding is "the mappings of human readable
labels to bits on the wire" not just "the generic mapping of internal
MLS labels to bits on the wire" (which CALIPSO does provide, for
example).

> > Doing better means: a) coming up with a common labeled security policy
> > language for MLS and DTE
> 
> At this point I'm glad there is an option "B" :)

These aren't options -- these two go together.

> > b) ensuring that clients and servers agree on a DOI's policy.
> 
> As you point out, this seems much more reasonable of a goal.

For how else do you get a heterogeneous network to agree on a DOI's
policy if not by having a generic way to represent that policy?  The
alternative is to show that two descriptions of the same policy but in
different languages are equivalent, and that strikes me as mostly
equivalent to having a common language -- but a common language would
surely be easier to work with.

> > Parts of the solution will be outside the scope of the NFSv4 WG.  That
> > doesn't mean we can't undertake a solution.  Assuming (a) (see above) we
> > need only specify (b) (see above) for NFSv4 -- we can leave (a) to
> > another WG.
> 
> I guess I personally don't really care about WG boundaries right now, I'm 
> mostly interested in arriving at a decent, complete solution.  My belief is 
> that once we arrive at a good idea we can divide it up amongst whatever WGs 
> are appropriate.

Sure.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
