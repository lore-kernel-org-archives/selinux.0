Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8UKSqsJ021242
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2003 16:28:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8UKR5Zt006536
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2003 20:27:05 GMT
Received: from out006.verizon.net (out006pub.verizon.net [206.46.170.106])
	by jazzswing.ncsc.mil  with ESMTP id h8UKR4M3006530
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2003 20:27:04 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: Eamon Walsh <ewalsh@epoch.ncsc.mil>
Subject: Re: X Windows discussion
Date: Tue, 30 Sep 2003 16:31:12 -0400
Cc: selinux@tycho.nsa.gov
References: <1064880029.5342.349.camel@moss-tarheels.epoch.ncsc.mil>
In-Reply-To: <1064880029.5342.349.camel@moss-tarheels.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200309301631.12831.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 29 September 2003 08:00 pm, Eamon Walsh wrote:
> [This continues the X discussion that was under the "Emacs major mode"
> thread]
>
> On Fri, 2003-09-26 at 22:09, Bill Laut wrote:
> > An estimate of six months strikes me as "contingency planning" and which
> > is certainly acceptable.  My personal implementation schedule, however,
> > will be considerably more aggressive.
>
> Some of the points I make below are taken from the document "Securing the X
> Window System with SELinux" ( http://www.nsa.gov/selinux/x11-abs.html ). 
> I'm largely working from this document in terms of looking at the problem.
>

Understood.  I've read that document as well.

>
> > I think you're going too far up the tree.  You want to be closer to the
> > root.
> >
> > [...]
>
> Why do you think the XSecurity extension isn't close enough "to the root?"
> It installs its own dispatch table and is thus positioned to see every
> request that comes in, including SendEvent requests.
>

I'm going through my notes to answer your question, but I seem unable to find 
it.  There was something about the XSecurity extension that stood out to me.

I'll get back to this point by Wednesday evening.  If I don't find it by then, 
I'll concede the point and we'll go your way.

>
> I think that building on XSecurity is the way to go.  My impression so far
> is that it has hooks in good places and that using it will reduce the
> changes we have to make to the core server.  It will also look better if
> one can say to the XFree86 maintainers "Here's a new security extension"
> than "Here's a bunch of new code for the dix and os layers."
>

>From a political consideration I agree that XSecurity will be easier to sell, 
no doubt about it, unless a valid technical explanation is made.  It 
certainly meets the objective of being less intrusive.

>
> There are some XSecurity fields in the Client structure that may be very
> useful if we can store the security context in them and then get from an
> arbitrary resource (GC, colormap, drawable, whatever) back to the client
> that created it.  We could then do labeling with a minimum of new fields in
> the internal X structures.
>
> Some links to XSecurity documentation:
> http://ftp.x.org/pub/R6.4/xc/doc/hardcopy/Xserver/secint.PS.gz
> http://davinci01.man.ac.uk/aix433/x11/specs/pdf/security.htm
>

One of the things I'm currently sketching out is a means to implement this, 
using advice that Stephen posted 8/29/03.  Email me off-list if you want me 
to forward you a copy.  In a nutshell, he suggested (1) implementing a 
userspace AVC, (2) extentions to the socket API so the Xserver can obtain the 
security contexts of the local clients, and (3) a notification interface for 
when the policy is changed.  His recommendations paralleled the conclusions I 
was reaching, and should be straightforward to implement.

I do have a concern about the effects on system performance.  Unlike general 
policy enforcement decisions, the X system presents a scenario where multiple 
tests may have to be made before a decision can be rendered and/or where 
multiple tests may have to be interleaved to reach a "composite" decision (a 
screen snapshot, for example, comes immediately to mind in both cases).  
Additionally, X will probably induce greater enforcement overhead because all 
events--mouse movements, keystrokes, cursor blinking, etc.--get shoveled back 
and forth between the Xserver and whatever client currently has focus, as 
well as whichever clients have requested event notification (ie, the mouse 
moving through a client's window).

Per Stephen's advice, we could start off with a trivial port of the kernel 
AVC, but before we make a final committment I think it may behoove us to 
spend some time optimizing the AVC for the concerns I've listed above.

Does this seem reasonable to you?

Also, I should note that I am currently learning the internals of the kernel 
AVC implementation and in the process I wouldn't doubt that I'll "discover" 
its efficiency is already maximally optimized, thereby rendering my concerns 
moot.   I mean no disrespect to the SELinux Team by implying the AVC *could* 
be improved upon.  My concerns are merely speculative at this point.

>
> > As an "extra homework assignment," this could also be a good excuse to go
> > through the code to hunt down potential buffer overruns and nail them in
> > the Gatehouse, but that could be for another topic.
>
> As a policy enforcer, the X server will have to be vetted for security
> holes. I don't think we have to worry about that for now, however.  See
> Section 3.0 of the SElinux/X paper.
>

Agreed.

>
> I'm afraid of Cut & Paste because I don't know much about it, yet.  There's
> the old method of setting properties on windows to pass clipboard data and
> do drag & drop, then there's Clip Extension, and I have a vague notion that
> the desktops are doing their own thing.  It's very much a moving target.
>

I agree that the desktop managers do cloud it, since their clipboards are not 
within X.  The others could be handled via the Request Queue, but as I think 
about it I'm now not certain about the Clip Extention.

Yeah, this is going to require more digging.

I anticipate that SE-KDE and SE-Gnome will likely follow after the successful 
conclusion to SE-X.

>
> > <discussion of local clients snipped>
> >
> > On the other hand, what do we do with remote clients connecting via the
> > network?  Anything more than a summary policy decision will require
> > authentication data not stored on the XServer's box.  How do we protect
> > ourselves from being spoofed?
>
> The existing SELinux policy in the kernel controls who can connect to the X
> server.
>

I was under the impression that the existing SELinux policy only had 
granularity to the IP/port address, not to the client's source context 
(unless labeled networking is in effect).  Has this changed?

>
>  All we have to worry about is what goes on over the connection
> once it's established.
>

Unless we mandate something like labeled networking, how do we determine the 
remote client's source context so that we can match its incoming Requests 
against the Xserver's policy?

*blink*  Labeled Networking?  Hmmm.....

I haven't yet closely scrutinized Labeled Networking, so what I'm about to 
suggest could be in error.  That said, labeled networking appears to be an 
ideal foundation although it would require some modifications.  Notably, (1) 
a finer granularity is needed so that labeled and unlabeled traffic can be 
simultaneously accepted and distinguished where applicable within the policy.  
eg, the current behavior of dropping unlabelled packets would have to be 
discontinued, so that "ordinary" traffic (such as an outgoing connection to 
an POP3 or web server) can occur while receiving labeled traffic intended for 
(among others) the Xserver.  (2) The labels themselves would have to be 
encrypted end-to-end by the kernels (or a trusted userspace extention), so 
that they are both kept out of reach of the client, and using a session key 
negotiated with an acceptable asymmetric ("public key") cipher so that a 
malicious user could not spoof the labeling via a raw ip socket.  (3)  We 
cannot include the labeling within any Xprotocol data structures nor the TCP 
stream itself, because that exposes it to possible userspace spoofing.  
Ideally, the encrypted label is applied in IP after the sender's TCP layer 
and processed/removed before the receiver's TCP layer.

I suppose what I'm proposing is something like Labeled Networking with 
IPSec-like key negotiation, etc., but without it actually becoming a formal 
VPN.  Assuming both the client and server boxes are running LN, this will 
allow us to identify the source context of who is attempting to connect to 
the Xserver before the connection is accepted, and afterwards to let the 
policy determine what access to permit on a per-Request basis.

>
> You're right about the authentication problem though.  We need a way of
> associating the security context of a client application with its objects
> in the X server.  Unfortunately, there doesn't seem to be an easy, secure
> way of doing this.  The client can't be trusted to send it over.  If there
> were a way of getting the remote security context from a (unix domain)
> socket, we could use that, but the kernel has to be involved somehow, and
> with functionality that it doesn't currently have.  Unless I'm missing
> something.
>

I think that (for lack of a better term) "Enhanced Labeled Networking" as 
described above deserves to be considered.  LN already stores the label in 
the IP Options field; we merely need to harden it for transit over untrusted 
networks.

X may well be the "killer application" for labeled networking.

If this seems like a plausible solution, then we may also want to consider 
extending Labeled Networking to include some sort of mapping abstraction 
between heterogenous but cooperating systems, because I'm skeptical that all 
cooperating X systems can be counted on to have homogenous policies.

Of course, this doesn't deal with the (imo) "bugaboo" of networked X sessions, 
namely unencrypted TCP streams.  Since the kernel now comes with a 
crytographic API, perhaps ELN can be extended to encrypt everything.

Does this seem like a reasonable approach to dealing with remote Xclients?

>
> The cop-out solution, and probably the only solution for remote clients, is
> to treat all clients the same way.  This may be too inflexible: screen-shot
> applications, for example, would no longer be possible.
>

If we employ ELN, the policy can then distinguish between labelled and 
unlabelled clients, and so the "cop-out solution" instead becomes the default 
solution.

Bill


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
