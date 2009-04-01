Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n31GkfXZ013112
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 12:46:41 -0400
Received: from g5t0006.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n31GkejJ013332
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 16:46:40 GMT
From: Paul Moore <paul.moore@hp.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted to IETF website
Date: Wed, 1 Apr 2009 12:46:33 -0400
Cc: labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <200903311047.21216.paul.moore@hp.com> <49D31BF2.2040100@sun.com>
In-Reply-To: <49D31BF2.2040100@sun.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200904011246.33436.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 01 April 2009 03:46:58 am Jarrett Lu wrote:
> On 3/31/2009 7:47 AM, Paul Moore wrote:
> > On Monday 30 March 2009 11:07:02 pm Casey Schaufler wrote:
> >> Jarrett Lu wrote:
> >>> Maybe we can do something better 15 years later. The first step is to
> >>> figure out how much information is needed and then look into how to
> >>> get this info across securely. GSS_SEC may be able to help us. To make
> >>> NFSv4 work, only TCP is needed. So peer information is needed per
> >>> session vs. per packet, I believe. Evidently, there is more work to do
> >>> in figuring this all out.
> >>
> >> Not to throw a puppy in the gears, but sophisticated handshaking and
> >> negotiation protocols are not the answer. We had TSIG session management
> >> for doing that and it is just not enough. How would you negotiate the
> >> differences between two SELinux policies?
> >
> > I'm with Casey, I don't think it is worth spending a whole lot of time
> > right now finding out how to pass information across the network in a
> > secure manner. There are plenty of ways of to do that which are well
> > established, interoperable and generally regarded as "secure".
>
> I'm not reinventing another secure way to pass information. I thought
> kerberos gss api may be a good candidate. I also agree that
> sophisticated handshaking negotiation protocol or complicated security
> attribute mapping between various systems is not the way to go.

My only comment was that figuring out how to transfer information over the 
network isn't really that important yet.  Reading through the thread I don't 
think there is general agreement on what we even need to send to enable proper 
label translation/encoding/etc.

> >  From my point of view the real issue is how do we translate/resolve
> > security labels defined by DOI X to an internal, security model/policy
> > specific label? Some have mentioned a mechanism which would serve up
> > label encoding data whenever a new system joined the network;
> > unfortunately, I believe this only works when you know the security
> > policy of the system before hand (or can restrict the security policy,
> > after all a TSOL label encodings file will do nothing for SELinux and/or
> > Smack).  While I think it is reasonable to assume a limited number of
> > on-the-wire label encodings and DOIs I think it would be a mistake to
> > assume a limited number of security models and or policies.
>
> True. The first question is whether we should try to solve, or at least
> ease, the label interpretation / translation problem in the context of
> NFSv4 protocol. I don't know if we can solve it, but it seems worthwhile
> to explore further, to gain more understanding if nothing else.

I've been trying to look at this problem in a more generic sense and not just 
from a labeled NFS point of view.  While the current pain point is labeled NFS 
the idea of label translation/encoding/etc is not exclusive to NFS or network 
filesystems in general; I'm sure we can all agree on this.  While we may need 
to solve (as best we can) the label translation issues on a per-application 
basis I really hope that we might be able to develop a solution which can be 
used across multiple applications and not just NFS.

> The challenge of interpreting and translating labels is that one system
> needs to know a lot of info about its peer. And there is no good way to
> describe the (sometimes subtle) difference. I think this problem may be
> harder on DTE systems than on MLS systems, I believe.

I'm not sure we will ever be able to arrive at a solution that requires a 
system to be able to understand the security policy/labels of another; things 
change to much and I don't think anyone's crystal ball is that good.  
Personally I think the best we can do is hope for a solution that allows a 
system to understand a security policy/label system defined by a pre-existing 
DOI definition.  If we can do that then we can at least allow two different 
systems to communicate via an agreed upon DOI regardless of their internal 
security policies/labels.  I'll admit it isn't perfect, but I think the 
problem space is much smaller and likely to have less churn over time.

> > Ultimately I believe that the required label translation information
> > (wire/DOI label to internal and the other way around) is going to need to
> > be bundled with the system's security policy and distributed as a single
> > "package". Granted this does require prior knowledge of the DOIs in use
> > but I believe this is a much easier requirement than the opposite.  From
> > a practical point of view this isn't too far removed from the notion of
> > sending sending label encoding data upon joining the network, the big
> > difference is that we are sending both security policy and label
> > encoding/DOI-translation data at the same time (in the TSOL case I
> > suspect this would just be the label encoding data, which may mean the
> > original poster had this in mind).
>
> Depending how different the systems are, the "package" content will be
> different.

Yep, that is the point; squares hole need square pegs, round holes need round 
pegs.

> Assuming we can assemble all the information required to do
> label translation correctly into a package, passing that around the
> systems seem inefficient, non-scalable ...

Honestly I don't see it as being that far removed from many of the current 
solutions that ship "security policy" to individual systems through the 
network/enterprise.  Also look at some of the NAC stuff that is being used 
these days, how is a security policy/translation "package" all that different 
from an anti-virus update or a set of os/application patches?

It is a solvable problem, or at least one that users have shown a willingness 
to tolerate.

> ... and probably outside the scope of labeled NFSv4 enhancement.

Perhaps.  Keep in mind I'm trying to think a bit more generically; if that 
isn't the goal I'll be happy to go back to my corner and sit quietly :)

> So realistically, I think the DOI + opaque label is useful between very
> compatible systems.

Of course.  I agree there are a lot of things you can do with a DOI + opaque 
label, especially if you are only concerned about end-to-end security issues 
which I believe is the case for labeled NFS.

> Given that limitation, may be the "package" is small enough and can be
> passed in RPC layer during authentication so that MLS can share files with
> like MLS systems, and same is true for DTE, fmac, smack, ....

Well, I think all that the opaque label buys you is the ability to limit who 
you share the security policy/translation "package" with, as those systems 
that participate in the labeled communication (be it NFS, generic IP or some 
other random service) still need to worry about label translation and security 
policy differences if they want to enforce policy locally.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
