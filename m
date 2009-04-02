Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n32G3j3m008943
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 12:03:45 -0400
Received: from sca-ea-mail-2.sun.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n32G3iSg008762
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 16:03:45 GMT
Received: from dm-central-01.central.sun.com ([129.147.62.4])
	by sca-ea-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n32G3iAa020372
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 16:03:44 GMT
Received: from binky.Central.Sun.COM (binky.Central.Sun.COM [129.153.128.104])
	by dm-central-01.central.sun.com (8.13.8+Sun/8.13.8/ENSMAIL,v2.2) with ESMTP id n32G3hDS020492
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 10:03:43 -0600 (MDT)
Date: Thu, 2 Apr 2009 10:24:24 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Jarrett Lu <Jarrett.Lu@sun.com>, labeled-nfs@linux-nfs.org,
        selinux@tycho.nsa.gov, nfs-discuss@opensolaris.org, nfsv4@ietf.org
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft	posted to IETF website
Message-ID: <20090402152423.GL1500@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <200903311047.21216.paul.moore@hp.com> <49D31BF2.2040100@sun.com> <200904011246.33436.paul.moore@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200904011246.33436.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 01, 2009 at 12:46:33PM -0400, Paul Moore wrote:
> My only comment was that figuring out how to transfer information over the 
> network isn't really that important yet.  Reading through the thread I don't 
> think there is general agreement on what we even need to send to enable proper 
> label translation/encoding/etc.

I think we all agree that a client and server have to agree on the
meaning of any given DOI number so that they can properly encode labels.

In order to interop this means we need a common label encoding for any
given DOI.

I think we agree on that, no?

That leaves this problem: how to ensure that the client and server do
actually agree as to a given DOI's label encodings?

That's a big problem that to date has been solved by out-of-band
mechanisms.  That solution leaves interoperability in a lurch: it's up
to vendors to cooperate to obtain a common security policy for use on
the wire.

I think Jarret's quite right to ask that we do better than that.

Doing better means: a) coming up with a common labeled security policy
language for MLS and DTE, b) ensuring that clients and servers agree on
a DOI's policy.

(a) is hard because we'd have to harmonize the differences between
exiting operating systems' labeled security policies, but I doubt it's
infeasible.  (b) is easy: exchange name+version of a DOI's security
policy and you're done (this can be a URL, a hash of the policy
document, whatever).

> > True. The first question is whether we should try to solve, or at least
> > ease, the label interpretation / translation problem in the context of
> > NFSv4 protocol. I don't know if we can solve it, but it seems worthwhile
> > to explore further, to gain more understanding if nothing else.
> 
> I've been trying to look at this problem in a more generic sense and not just 
> from a labeled NFS point of view.  While the current pain point is labeled NFS 
> the idea of label translation/encoding/etc is not exclusive to NFS or network 
> filesystems in general; I'm sure we can all agree on this.  While we may need 
> to solve (as best we can) the label translation issues on a per-application 
> basis I really hope that we might be able to develop a solution which can be 
> used across multiple applications and not just NFS.

+1

> > The challenge of interpreting and translating labels is that one system
> > needs to know a lot of info about its peer. And there is no good way to
> > describe the (sometimes subtle) difference. I think this problem may be
> > harder on DTE systems than on MLS systems, I believe.
> 
> I'm not sure we will ever be able to arrive at a solution that requires a 
> system to be able to understand the security policy/labels of another; things 
> change to much and I don't think anyone's crystal ball is that good.  
> Personally I think the best we can do is hope for a solution that allows a 
> system to understand a security policy/label system defined by a pre-existing 
> DOI definition.  If we can do that then we can at least allow two different 
> systems to communicate via an agreed upon DOI regardless of their internal 
> security policies/labels.  I'll admit it isn't perfect, but I think the 
> problem space is much smaller and likely to have less churn over time.

+1

> > Assuming we can assemble all the information required to do
> > label translation correctly into a package, passing that around the
> > systems seem inefficient, non-scalable ...

There's no need to refer to labeled security policies by value at the
application protocol layer -- just by name/reference.  The common policy
can be referenced by URL so that it can be downloaded only when it's
changed.

> > ... and probably outside the scope of labeled NFSv4 enhancement.
> 
> Perhaps.  Keep in mind I'm trying to think a bit more generically; if that 
> isn't the goal I'll be happy to go back to my corner and sit quietly :)

Parts of the solution will be outside the scope of the NFSv4 WG.  That
doesn't mean we can't undertake a solution.  Assuming (a) (see above) we
need only specify (b) (see above) for NFSv4 -- we can leave (a) to
another WG.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
