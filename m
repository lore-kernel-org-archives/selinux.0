Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3EG38CH002329
	for <selinux@tycho.nsa.gov>; Tue, 14 Apr 2009 12:03:08 -0400
Subject: Re: [nfsv4] my thoughts on how Labeled NFSv4 draft should move
 forward
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Nicolas Williams <Nicolas.Williams@sun.com>
Cc: Jarrett Lu <Jarrett.Lu@sun.com>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, selinux@tycho.nsa.gov, nfsv4@ietf.org
In-Reply-To: <20090410203839.GC1500@Sun.COM>
References: <49DA6EF8.1080704@sun.com> <20090410201718.GB1500@Sun.COM>
	 <20090410203839.GC1500@Sun.COM>
Content-Type: text/plain
Date: Tue, 14 Apr 2009 11:59:29 -0400
Message-Id: <1239724769.9761.126.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-04-10 at 15:38 -0500, Nicolas Williams wrote:
> On Fri, Apr 10, 2009 at 03:17:18PM -0500, Nicolas Williams wrote:
> > After that long thread on SAAG and a subsequent off-list discussion with
> > Casey (plus my reading Smack documentation) I'm almost ready to reach
> > the following conclusions:
> 
> I should expand on this.  See below.
> 
> >  - We don't need policy agreement for MLS.  Servers have all the
> >    necessary information when comparing labels without reference to a
> >    policy.  However, clients have to be sharing a common MLS policy.
> 
> Which means DOI + label in CALIPSO-like label representation is
> sufficient.  DOI + opaque label is also good enough for MLS if the DOI
> can be used to find the label representation.
> 
> >  - For "smart" MLS and Smack servers we need a method by which servers
> >    can determine the label range/set of client and user principals, but
> >    this need not be specified in a standard way except where label
> >    range/set is borne by authentication credentials (Kerberos V ticket
> >    authorization-data, PKIX cert extensions).
> > 
> >    This is already described in my RPCSEC_GSSv3 document.
> 
> Which means we can proceed with this RPCSEC_GSSv3 aspect of labeled NFS.
> 
> Of course, it's not clear yet that it will be of much practical value to
> have such smart servers (e.g., if all the clients would be fully trusted
> anyways).  It may be possible that "dumb" servers are good enough, in
> which case we don't need to complicate RPCSEC_GSSv3 with process label
> assertions (though it's not much of a complication, but the client does
> need to know, via an NFS operation, whether the server is smart or
> dumb).

It is unclear to me why an NFS operation is needed for this. Why can't
this be something that is negotiated in the GSS context? When the GSS
context is created they can decide if the server is smart or not and if
it is then the process label is something that is part of the context.
Then when the server is making a decision if it is Smart it will use the
credential from the GSS context if not it will ignore it.

> 
> >  - For Smack we don't need policy agreement either, but it will be
> >    useful to distribute common subsets of Smack policy to clients, and
> >    to prefix labels from local-only sub-policies with a client ID (or
> >    client DOI, if you wish).
> 
> Which means we may want to have DOI + opaque label, and, perhaps, DOI +
> client ID + opaque label (but a client ID can be in the opaque label).
> 
> It should be noted that Smack does have a way to encode Smack labels as
> CIPSO MLS labels, though it is a hack.  We could similarly represent
> Smack labels via whatever MLS label representation we use -- but it'd be
> better (i.e., not hacky) to just have opaque labels for Smack.
> 
> >  - For DTE I've no idea what to do.  Policy agreement seems like a
> >    flight of fancy for DTE.  But *much* more importantly, because the
> >    process label transitions can span so many labels we simply cannot
> >    have too smart a server: the server can't meaningfully constrain the
> >    labels that a user@client can assert, therefore the server must trust
> >    all client assertions of process DTE labels or none at all.
> > 
> >    I.e., for DTE we can only have "dumb" servers.
> 
> Which means that for DTE we should have DOI + opaque label and all the
> server does is store them.  The server would not enfore DTE policies:
> only clients would.  Of course, the server can have share-level ACLs to
> decide which clients are trusted, but the server remains dumb.
> 
> Nico


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
