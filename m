Subject: Re: [RFC 1/2] labeled ipsec internet drafts
From: Joy Latten <latten@austin.ibm.com>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: Paul Moore <paul.moore@hp.com>, gcwilson@us.ibm.com, selinux@tycho.nsa.gov,
        serue@us.ibm.com, tjaeger@cse.psu.edu
In-Reply-To: <1219872785.2627.106.camel@moss-terrapins.epoch.ncsc.mil>
References: <200808252046.m7PKkdQu019720@faith.austin.ibm.com>
	 <1219855775.2627.82.camel@moss-terrapins.epoch.ncsc.mil>
	 <1219862508.2883.146.camel@faith.austin.ibm.com>
	 <200808271650.25409.paul.moore@hp.com>
	 <1219872785.2627.106.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 27 Aug 2008 17:56:38 -0500
Message-Id: <1219877798.2883.191.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-08-27 at 17:33 -0400, David P. Quigley wrote:
> On Wed, 2008-08-27 at 16:50 -0400, Paul Moore wrote:
> > Hi Joy, et al.
> > 
> > I'll respond to the rest of you email a little bit later when I have 
> > some time but since you and David have been having a good discussion 
> > around DOI issues I wanted to add some quick comments ... (see below)
> > 
> > On Wednesday 27 August 2008 2:41:48 pm Joy Latten wrote:
> > > On Wed, 2008-08-27 at 12:49 -0400, David P. Quigley wrote:
> > > > On Wed, 2008-08-27 at 11:17 -0500, Joy Latten wrote:
> > > > > On Tue, 2008-08-26 at 16:24 -0400, David P. Quigley wrote:
> > > > > > On Tue, 2008-08-26 at 12:17 -0500, Joy Latten wrote:
> > > > > > > On Mon, 2008-08-25 at 17:42 -0400, David P. Quigley wrote:
> > > > > > > > On Mon, 2008-08-25 at 15:46 -0500, Joy Latten wrote:
> > 
> > ...
> > 
> > > > > > Yea, it is unfortunate that CALIPSO is only for MLS labels.
> > > > > > IPv6 is still growing in its deployment so it would be nice to
> > > > > > have a robust and flexible method for conveying security labels
> > > > > > from the start. For now it seems as if CALIPSO will try to go
> > > > > > through just as MLS labels and then DTE or other security
> > > > > > labels will have to create their own IP security option.
> > 
> > I've had many discussions with Randall regarding this topic, I even 
> > offered a series of edits to earlier CALIPSO (back when it was still 
> > SIPSO, yipee for the name change!) drafts which introduced a more 
> > generic DTE labeling mechanism.  After much discussion Randall agreed 
> > that having a more generic, DTE-friendly labeling mechanism would be 
> > nice but he wanted to keep CALIPSO focused on MLS labeling since that 
> > was the feedback he had been receiving.  He was very helpful and the 
> > discussion unveiled many potential issues with a DTE labeling protocol, 
> > primarily around the need to make the protocol more intermediate hop 
> > friendly.
> > 
> > I am currently waiting to see how the CALIPSO specification is received 
> > by the general IETF SAAG community, especially the assertion that 
> > explicit packet labeling is an important user requirement.  If the 
> > CALIPSO specification is well received I plan on submitting a draft 
> > specification which will provide a more general packet labeling 
> > mechanism for IPv6 and possibly IPv4.
> 
> When I was in Dublin it was suggested that I look at the CALIPSO draft
> for DOI related information so they are well aware of it and it doesn't
> seem to have hit much resistance yet.
> 
> > 
> > > > > > > > > >I'm also concerned with the implied convention of
> > > > > > > > > > assigning one value to a particular implementation.  In
> > > > > > > > > > the SELinux case, how do you deal with a non-MLS/MCS
> > > > > > > > > > policy such as Gentoo/Ubuntu talking to a MLS/MCS
> > > > > > > > > > policy such as Fedora/RHEL?  What about policies with
> > > > > > > > > > different types? Differing numbers of MLS sensitivity
> > > > > > > > > > levels or categories?
> > > > > > > > >
> > > > > > > > > Hmm... not sure I understand so I may not answer this
> > > > > > > > > correctly...
> > > > > > > > >
> > > > > > > > > The algorithm indicates the security mechanism.
> > > > > > > > > In a way, it identifies the syntax/semantics of the
> > > > > > > > > security context to security mechanism, since security
> > > > > > > > > mechanisms may use different syntax/semantics for the
> > > > > > > > > security contexts. i.e. SELinux and SMACK.
> > > > > > > > > The algorithm field in SELinux is used to "authorize" the
> > > > > > > > > security context. In other words, SELinux only wants and
> > > > > > > > > understands SELinux's security context syntax/semantics.
> > > > > > > > > The "doi"  would be used for further differentiation
> > > > > > > > > within SELinux domain. Far example, a sysadm wants to
> > > > > > > > > differentiate between SELinux policy versions in his
> > > > > > > > > domain. He could used "doi" field to do this.
> > > > > > > > >
> > > > > > > > > I suppose if you wanted two different security mechanisms
> > > > > > > > > to interoperate, a mapping of some sort would have to be
> > > > > > > > > created between them. The security mechanisms would need
> > > > > > > > > to indicate they accept (via the mapping) the other's
> > > > > > > > > security context syntax/semantics. In other words, they
> > > > > > > > > would "authorize" the two different security contexts. It
> > > > > > > > > would do this via the "algorithm" and/or "doi" fields. I
> > > > > > > > > am thinking in this case, "doi" could even indicate the
> > > > > > > > > mapping such as CIPSO's DOI does.
> > > > > > > > >
> > > > > > > > > I considered the information contained in the "algorithm"
> > > > > > > > > and "doi" fields required for interoperability, and the
> > > > > > > > > use implementation specific.
> > > > > > > > >
> > > > > > > > > If this doesn't answer your question, let me know.
> > > > > > > >
> > > > > > > > I think what Paul might be asking is why is it better to
> > > > > > > > have two fields, one for Security Mechanism and one for the
> > > > > > > > DOI when that can be one field. If we go with a method
> > > > > > > > similar to the second described above for DOIs you could
> > > > > > > > have IANA allocate a range of DOIs for SELinux partitioning
> > > > > > > > it off into a range for publicly assigned DOIs and
> > > > > > > > privately managed DOIs. It is acceptable to have IANA
> > > > > > > > create and populate a registry with values in the document.
> > > > > > >
> > > > > > > Ok, I understand now. Yes, that seems reasonable, fair, and
> > > > > > > flexible. I can still keep semantics (a mechanism and ability
> > > > > > > to group or differentiate).
> > > > > > >
> > > > > > > So, a doi field that is 32 bits, with perhaps so much for
> > > > > > > SELinux, further partitioned for public and private use. The
> > > > > > > same for Smack. Right? And remaining for future use.
> > > > > >
> > > > > > The standards people don't particularly care about specific
> > > > > > security models in this case. I initially mentioned
> > > > > > implementation specific details in my early labeled NFS drafts
> > > > > > and was told that those aren't really a concern of the
> > > > > > protocol. Since the label is a (DOI,<OPAQUE>) tuple it is up to
> > > > > > whomever obtains a number from IANA to define the meaning of
> > > > > > that DOI. However it should be written into the standard what
> > > > > > information is recorded by IANA to bind to these numbers. Also
> > > > > > do we see several registries? I really only see one registry
> > > > > > that can be shared by all three of these drafts. I just hope
> > > > > > they don't want us to write up an RFC for the definition and
> > > > > > management of DOIs (it might happen that way though).
> > > > >
> > > > > Ok, gotta admit, I am a little confused as to how we could share
> > > > > the same DOI registry with CALIPSO since they are using a
> > > > > dotted-quad format right now? And it doesn't seem to accomodate
> > > > > but one DOI from IANA which leaves me confused as to how I would
> > > > > get one and then partition it for private and non-private uses.
> > > >
> > > > Well we might need to talk with the CALIPSO people to figure out a
> > > > way that we can all use their DOI scheme. At its core their method
> > > > just seems to be a dotted-quad format as you have said. IANA's job
> > > > is to keep track of these dotted-quads.
> > 
> > The CALIPSO DOI is defined as a opaque 32 bit unsigned integer, similar 
> > to CIPSO and your description of labeled NFS's DOI.  The dotted 
> > notation used in part of the CALIPSO draft is just a convenient way of 
> > representing the value in the same way we represent IPv4 addresses. 
> > 
> > The CALIPSO specification does set aside DOI ranges for specific uses 
> > (is this the source of confusion?) which I think is a good idea and I 
> > would encourage other protocols to follow suit.
> 
> What do they mean by opaque 32 bit integer here? If they are defining
> ranges and assignments to the integer it can't truly be opaque. I don't
> recommend we transport the DOI as the colon separated octet group but
> for the purpose of assigning DOIs and ranges and even specifying them in
> programs I think the syntax is useful.
> 
> I hesitate to say this but I think it might be a good idea to draw up a
> draft explaining what a DOI is and what is expected from IANA for them.
> I've received emails from people working on security labels in
> application layer protocols so they might be interested in a standard
> method for specifying and interpreting DOIs as well.
> 
> > 
> > > > > Because there is already a working prototype of labeled ipsec in
> > > > > Linux, I would have very much like to get assignments from IANA
> > > > > now for SELinux. I would like to make necessary modifications to
> > > > > Linux kernel and userspace soon as possible because it would seem
> > > > > odd to me to have an internet draft and a prototype that does not
> > > > > comply to it. It would also help to set a precedent of what would
> > > > > be required when asking for DOI assignments ( I hope I said that
> > > > > correctly).
> > 
> > I'm sure you've gotten feedback from others on this but nothing 
> > involving the IETF is "quick".  Be prepared for a potentially lengthy 
> > discussion and understand that just because the Linux Kernel already 
> > has a labeled IPsec implementation does not mean it will be accepted 
> > as-is by the IETF community.
> 
> I second Paul on this. We had an implementation of Labeled NFS at IETF
> 71 and I had some elements of the design in the presentation slides. One
> of the members from Sun stood up and basically said that the way we were
> doing certain things was completely wrong. He then suggested better ways
> of handling what we wanted to do and after we went back and looked at it
> all again we realized he was right. In the time between IETF 71 and 72
> we actually dropped several things that we were doing since we came to
> the conclusion that they weren't correct. This feedback from the Working
> Groups really does help to make a better product in the end.
> 

Ok, that is good to know. 

> BTW, which working group is this a part of? It seems like it belongs to
> several ADships since it could sit in security and in internet.
> 

If you are talking about labeled ipsec, I have mentioned this several
times on the IETF's IPsec WG mailing list. Just recently the IPsec WG
recently re-formed. Dublin was their first official meeting. I did
submit labeled ipsec as a possible work item, but only 3 or 4 were
selected and in all honesty they were very important. But individual
submissions are reviewed and discussed too by WG. While forming, one
of the primary focuses discussed was to filter out unnecessary IPsec
extensions. When I asked how come obsoleted IPsec Architecture RFC had
MLS networking and the updated one left it out, the response was we did
not think anyone was using it and it would be non-trivial to add it
back. Gotta admit, I have no idea what to expect. :-) Although I have
read the IPsec rfcs 3000 times (ok I am exaggerating, it just feels like
it), the feeling that I have forgotten something or misunderstood
something never leaves me. :-) So thanks for all reviews, help and
advice. 
 
regards,
Joy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
