Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3ALI4pj015069
	for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 17:18:04 -0400
Received: from sca-ea-mail-2.sun.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3ALI33X029364
	for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 21:18:03 GMT
Received: from dm-central-02.central.sun.com ([129.147.62.5])
	by sca-ea-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n3ALI21V023172
	for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 21:18:03 GMT
Received: from binky.Central.Sun.COM (binky.Central.Sun.COM [129.153.128.104])
	by dm-central-02.central.sun.com (8.13.8+Sun/8.13.8/ENSMAIL,v2.2) with ESMTP id n3ALI2th012769
	for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 15:18:02 -0600 (MDT)
Date: Fri, 10 Apr 2009 15:38:39 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Cc: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org
Subject: Re: [nfsv4] my thoughts on how Labeled NFSv4 draft should move	forward
Message-ID: <20090410203839.GC1500@Sun.COM>
References: <49DA6EF8.1080704@sun.com> <20090410201718.GB1500@Sun.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090410201718.GB1500@Sun.COM>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 10, 2009 at 03:17:18PM -0500, Nicolas Williams wrote:
> After that long thread on SAAG and a subsequent off-list discussion with
> Casey (plus my reading Smack documentation) I'm almost ready to reach
> the following conclusions:

I should expand on this.  See below.

>  - We don't need policy agreement for MLS.  Servers have all the
>    necessary information when comparing labels without reference to a
>    policy.  However, clients have to be sharing a common MLS policy.

Which means DOI + label in CALIPSO-like label representation is
sufficient.  DOI + opaque label is also good enough for MLS if the DOI
can be used to find the label representation.

>  - For "smart" MLS and Smack servers we need a method by which servers
>    can determine the label range/set of client and user principals, but
>    this need not be specified in a standard way except where label
>    range/set is borne by authentication credentials (Kerberos V ticket
>    authorization-data, PKIX cert extensions).
> 
>    This is already described in my RPCSEC_GSSv3 document.

Which means we can proceed with this RPCSEC_GSSv3 aspect of labeled NFS.

Of course, it's not clear yet that it will be of much practical value to
have such smart servers (e.g., if all the clients would be fully trusted
anyways).  It may be possible that "dumb" servers are good enough, in
which case we don't need to complicate RPCSEC_GSSv3 with process label
assertions (though it's not much of a complication, but the client does
need to know, via an NFS operation, whether the server is smart or
dumb).

>  - For Smack we don't need policy agreement either, but it will be
>    useful to distribute common subsets of Smack policy to clients, and
>    to prefix labels from local-only sub-policies with a client ID (or
>    client DOI, if you wish).

Which means we may want to have DOI + opaque label, and, perhaps, DOI +
client ID + opaque label (but a client ID can be in the opaque label).

It should be noted that Smack does have a way to encode Smack labels as
CIPSO MLS labels, though it is a hack.  We could similarly represent
Smack labels via whatever MLS label representation we use -- but it'd be
better (i.e., not hacky) to just have opaque labels for Smack.

>  - For DTE I've no idea what to do.  Policy agreement seems like a
>    flight of fancy for DTE.  But *much* more importantly, because the
>    process label transitions can span so many labels we simply cannot
>    have too smart a server: the server can't meaningfully constrain the
>    labels that a user@client can assert, therefore the server must trust
>    all client assertions of process DTE labels or none at all.
> 
>    I.e., for DTE we can only have "dumb" servers.

Which means that for DTE we should have DOI + opaque label and all the
server does is store them.  The server would not enfore DTE policies:
only clients would.  Of course, the server can have share-level ACLs to
decide which clients are trusted, but the server remains dumb.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
