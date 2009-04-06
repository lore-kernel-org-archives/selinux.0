Date: Mon, 6 Apr 2009 17:08:39 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Cc: dpquigl@tycho.nsa.gov, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, selinux@tycho.nsa.gov, nfsv4@ietf.org
Subject: Re: [nfsv4] my thoughts on how Labeled NFSv4 draft should move forward
Message-ID: <20090406220838.GL1500@Sun.COM>
References: <49DA6EF8.1080704@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49DA6EF8.1080704@sun.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 06, 2009 at 02:07:04PM -0700, Jarrett Lu wrote:
> There were a lot of discussion on labeled NFSv4 recently. I like to make 
> a suggestion in how your draft should go forward.  I believe you should 
> continue proposing adding a DOI + an opaque label field. There are two 
> slightly different usage models of DOI:
> (1) the current proposal -- DOI is used to indicate the format of label 
> in the opaque field. A new predefined DOI / label format pairing needs 
> to exist in a registry. Being able to parse a label doesn't necessarily 
> imply one can correctly interpret or translate a label. Label policy 
> consistency is administered outside of the Labeled NFSv4 protocol 
> extension. (2) Using same DOI implies that communicating peers can 
> correctly parse the opaque label field AND label policy between 
> communicating parties are consistent, i.e. they can correctly interpret 
> labels using same DOI.  This DOI usage is consistent with CALIPSO DOI; 
> hence the same DOI registry can be used by NFSv4. I like (2) better for 
> following reasons:

The difference between (1) and (2) is artificial since in both cases the
client and the server have to agree on what each DOI they use means.
The difference is only whether we ought to have a registry.  Clearly we
should not, for all the reasons that you list in part because we may well want to go with DOI+opaque now
and later add support for agreeing on security policy subsets (by, e.g.,
exchanging URIs of policies specified in SPIF or whatever), so defining
a registry would be a waste of effort later.

Option 3: send DOI+label_format+opaque_label.  But still, this strikes
me as unnecessary -- the client and server have to agree on what the DOI
means, so they might as well agree on what the label format is (MLS,
DTE, ...).

> In any case, the "DOI  + opaque label" proposal relies on an OOB method 
> to be useful. This is weak in terms of interoperability. But I believe 
> that allowing systems to share file label attribute still adds value, 
> even when an OOB method is required. I can help writing some usage 
> scenarios about how such extensions may be used on MLS systems.

Yes, but you've convinced me that we need to solve that interoperability
problem.  I don't think we should block labeled NFSv4 on solving that
problem, but we should have an idea of how we'll shoehorn a solution
into labeled NFSv4 later.  Fortunately labeled NFSv4 will rely on
RPCSEC_GSSv3, which I've designed to be extensible from the get-go.

> Now there is a separate discussion on saag list in how to do policy 
> exchange among MAC systems. If this can be done, labeled NFS can 
> definitely benefit from that effort and improve its interoperability 
> story. It's probably wise to separate the two efforts so that each can 
> proceed independently. I haven't studied the "labeled policy exchange 
> framework" enough to know if it changes the current NFSv4 proposal.

I agree.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
