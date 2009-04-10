Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3AJlIDi003590
	for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 15:47:18 -0400
Subject: Re: [nfsv4] my thoughts on how Labeled NFSv4 draft should move
 forward
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Nicolas Williams <Nicolas.Williams@sun.com>
Cc: Jarrett Lu <Jarrett.Lu@sun.com>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, selinux@tycho.nsa.gov, nfsv4@ietf.org
In-Reply-To: <20090406220838.GL1500@Sun.COM>
References: <49DA6EF8.1080704@sun.com>  <20090406220838.GL1500@Sun.COM>
Content-Type: text/plain
Date: Fri, 10 Apr 2009 15:43:45 -0400
Message-Id: <1239392625.9761.107.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So we agree that in abstract there is no difference between 1 and 2
however fundamentally we believe that the label format belongs in a
registry that people can consult, for the reasons that I specified in my
reply to Jarrett, while the label semantics really belong to the
specific authorities that determine them. By separating the two we
separate the hard problem (policy reconciliation) from the label
transport problem within the respective applications.

We see something similar to your option three as being the correct
solution. Instead of DOI+label_format+opaque_label we see the DOI as
being the label format specifier and then within the opaque label we
have an authority field which will allow you to determine the label
semantics. An example of its use would be for CALIPSO to request a DOI
for their label format and then within the opaque section use their DOI
to identify the label semantics.

With respect to the URIs we have a few issues with using them as a way
of specifying policy. First off they are spoofable as we can't
definitively guarantee the integrity of the URI and its source. A
related question is can we actually define the policy documents it would
point to in the face of the variability required by today's systems? The
specifications in the past worked to some extent due to the static
nature of the policy which isn't something we can assume with today's
systems. Also taking this into account how do we then proceed to
automate this process?

Dave

On Mon, 2009-04-06 at 17:08 -0500, Nicolas Williams wrote:
> On Mon, Apr 06, 2009 at 02:07:04PM -0700, Jarrett Lu wrote:
> > There were a lot of discussion on labeled NFSv4 recently. I like to make 
> > a suggestion in how your draft should go forward.  I believe you should 
> > continue proposing adding a DOI + an opaque label field. There are two 
> > slightly different usage models of DOI:
> > (1) the current proposal -- DOI is used to indicate the format of label 
> > in the opaque field. A new predefined DOI / label format pairing needs 
> > to exist in a registry. Being able to parse a label doesn't necessarily 
> > imply one can correctly interpret or translate a label. Label policy 
> > consistency is administered outside of the Labeled NFSv4 protocol 
> > extension. (2) Using same DOI implies that communicating peers can 
> > correctly parse the opaque label field AND label policy between 
> > communicating parties are consistent, i.e. they can correctly interpret 
> > labels using same DOI.  This DOI usage is consistent with CALIPSO DOI; 
> > hence the same DOI registry can be used by NFSv4. I like (2) better for 
> > following reasons:
> 
> The difference between (1) and (2) is artificial since in both cases the
> client and the server have to agree on what each DOI they use means.
> The difference is only whether we ought to have a registry.  Clearly we
> should not, for all the reasons that you list in part because we may well want to go with DOI+opaque now
> and later add support for agreeing on security policy subsets (by, e.g.,
> exchanging URIs of policies specified in SPIF or whatever), so defining
> a registry would be a waste of effort later.
> 
> Option 3: send DOI+label_format+opaque_label.  But still, this strikes
> me as unnecessary -- the client and server have to agree on what the DOI
> means, so they might as well agree on what the label format is (MLS,
> DTE, ...).
> 
> > In any case, the "DOI  + opaque label" proposal relies on an OOB method 
> > to be useful. This is weak in terms of interoperability. But I believe 
> > that allowing systems to share file label attribute still adds value, 
> > even when an OOB method is required. I can help writing some usage 
> > scenarios about how such extensions may be used on MLS systems.
> 
> Yes, but you've convinced me that we need to solve that interoperability
> problem.  I don't think we should block labeled NFSv4 on solving that
> problem, but we should have an idea of how we'll shoehorn a solution
> into labeled NFSv4 later.  Fortunately labeled NFSv4 will rely on
> RPCSEC_GSSv3, which I've designed to be extensible from the get-go.
> 
> > Now there is a separate discussion on saag list in how to do policy 
> > exchange among MAC systems. If this can be done, labeled NFS can 
> > definitely benefit from that effort and improve its interoperability 
> > story. It's probably wise to separate the two efforts so that each can 
> > proceed independently. I haven't studied the "labeled policy exchange 
> > framework" enough to know if it changes the current NFSv4 proposal.
> 
> I agree.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
