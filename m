From: Paul Moore <paul.moore@hp.com>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: Re: [RFC 1/2] labeled ipsec internet drafts
Date: Thu, 28 Aug 2008 12:08:04 -0400
Cc: Joy Latten <latten@austin.ibm.com>, gcwilson@us.ibm.com,
        selinux@tycho.nsa.gov, serue@us.ibm.com, tjaeger@cse.psu.edu
References: <200808252046.m7PKkdQu019720@faith.austin.ibm.com> <200808271650.25409.paul.moore@hp.com> <1219872785.2627.106.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1219872785.2627.106.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808281208.04770.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 27 August 2008 5:33:05 pm David P. Quigley wrote:
> On Wed, 2008-08-27 at 16:50 -0400, Paul Moore wrote:
> > I am currently waiting to see how the CALIPSO specification is
> > received by the general IETF SAAG community, especially the
> > assertion that explicit packet labeling is an important user
> > requirement.  If the CALIPSO specification is well received I plan
> > on submitting a draft specification which will provide a more
> > general packet labeling mechanism for IPv6 and possibly IPv4.
>
> When I was in Dublin it was suggested that I look at the CALIPSO
> draft for DOI related information so they are well aware of it and it
> doesn't seem to have hit much resistance yet.

Yep, although it still hasn't really hit a really wide distribution, 
the -05 draft was just recently submitted and it should see a wider 
audience than previous drafts.  As one would expect there is a fair 
amount of political wrangling going on but so far things look good.

> > > > > > > > > >I'm also concerned with the implied convention of
> > > > > > > > > > assigning one value to a particular implementation.
> > > > > > > > > >  In the SELinux case, how do you deal with a
> > > > > > > > > > non-MLS/MCS policy such as Gentoo/Ubuntu talking to
> > > > > > > > > > a MLS/MCS policy such as Fedora/RHEL?  What about
> > > > > > > > > > policies with different types? Differing numbers of
> > > > > > > > > > MLS sensitivity levels or categories?
> > > > > > > > >
> > > > > > > > > Hmm... not sure I understand so I may not answer this
> > > > > > > > > correctly...
> > > > > > > > >
> > > > > > > > > The algorithm indicates the security mechanism.
> > > > > > > > > In a way, it identifies the syntax/semantics of the
> > > > > > > > > security context to security mechanism, since
> > > > > > > > > security mechanisms may use different
> > > > > > > > > syntax/semantics for the security contexts. i.e.
> > > > > > > > > SELinux and SMACK.
> > > > > > > > > The algorithm field in SELinux is used to "authorize"
> > > > > > > > > the security context. In other words, SELinux only
> > > > > > > > > wants and understands SELinux's security context
> > > > > > > > > syntax/semantics. The "doi"  would be used for
> > > > > > > > > further differentiation within SELinux domain. Far
> > > > > > > > > example, a sysadm wants to differentiate between
> > > > > > > > > SELinux policy versions in his domain. He could used
> > > > > > > > > "doi" field to do this.
> > > > > > > > >
> > > > > > > > > I suppose if you wanted two different security
> > > > > > > > > mechanisms to interoperate, a mapping of some sort
> > > > > > > > > would have to be created between them. The security
> > > > > > > > > mechanisms would need to indicate they accept (via
> > > > > > > > > the mapping) the other's security context
> > > > > > > > > syntax/semantics. In other words, they would
> > > > > > > > > "authorize" the two different security contexts. It
> > > > > > > > > would do this via the "algorithm" and/or "doi"
> > > > > > > > > fields. I am thinking in this case, "doi" could even
> > > > > > > > > indicate the mapping such as CIPSO's DOI does.
> > > > > > > > >
> > > > > > > > > I considered the information contained in the
> > > > > > > > > "algorithm" and "doi" fields required for
> > > > > > > > > interoperability, and the use implementation
> > > > > > > > > specific.
> > > > > > > > >
> > > > > > > > > If this doesn't answer your question, let me know.
> > > > > > > >
> > > > > > > > I think what Paul might be asking is why is it better
> > > > > > > > to have two fields, one for Security Mechanism and one
> > > > > > > > for the DOI when that can be one field. If we go with a
> > > > > > > > method similar to the second described above for DOIs
> > > > > > > > you could have IANA allocate a range of DOIs for
> > > > > > > > SELinux partitioning it off into a range for publicly
> > > > > > > > assigned DOIs and privately managed DOIs. It is
> > > > > > > > acceptable to have IANA create and populate a registry
> > > > > > > > with values in the document.
> > > > > > >
> > > > > > > Ok, I understand now. Yes, that seems reasonable, fair,
> > > > > > > and flexible. I can still keep semantics (a mechanism and
> > > > > > > ability to group or differentiate).
> > > > > > >
> > > > > > > So, a doi field that is 32 bits, with perhaps so much for
> > > > > > > SELinux, further partitioned for public and private use.
> > > > > > > The same for Smack. Right? And remaining for future use.
> > > > > >
> > > > > > The standards people don't particularly care about specific
> > > > > > security models in this case. I initially mentioned
> > > > > > implementation specific details in my early labeled NFS
> > > > > > drafts and was told that those aren't really a concern of
> > > > > > the protocol. Since the label is a (DOI,<OPAQUE>) tuple it
> > > > > > is up to whomever obtains a number from IANA to define the
> > > > > > meaning of that DOI. However it should be written into the
> > > > > > standard what information is recorded by IANA to bind to
> > > > > > these numbers. Also do we see several registries? I really
> > > > > > only see one registry that can be shared by all three of
> > > > > > these drafts. I just hope they don't want us to write up an
> > > > > > RFC for the definition and management of DOIs (it might
> > > > > > happen that way though).
> > > > >
> > > > > Ok, gotta admit, I am a little confused as to how we could
> > > > > share the same DOI registry with CALIPSO since they are using
> > > > > a dotted-quad format right now? And it doesn't seem to
> > > > > accomodate but one DOI from IANA which leaves me confused as
> > > > > to how I would get one and then partition it for private and
> > > > > non-private uses.
> > > >
> > > > Well we might need to talk with the CALIPSO people to figure
> > > > out a way that we can all use their DOI scheme. At its core
> > > > their method just seems to be a dotted-quad format as you have
> > > > said. IANA's job is to keep track of these dotted-quads.
> >
> > The CALIPSO DOI is defined as a opaque 32 bit unsigned integer,
> > similar to CIPSO and your description of labeled NFS's DOI.  The
> > dotted notation used in part of the CALIPSO draft is just a
> > convenient way of representing the value in the same way we
> > represent IPv4 addresses.
> >
> > The CALIPSO specification does set aside DOI ranges for specific
> > uses (is this the source of confusion?) which I think is a good
> > idea and I would encourage other protocols to follow suit.
>
> What do they mean by opaque 32 bit integer here? If they are defining
> ranges and assignments to the integer it can't truly be opaque. I
> don't recommend we transport the DOI as the colon separated octet
> group but for the purpose of assigning DOIs and ranges and even
> specifying them in programs I think the syntax is useful.

By opaque value I think they mean a single 32 unsigned integer that 
isn't to be subdivided.  While I agree that blocking off certain ranges 
of DOIs for specific uses does seem to raise eyebrows in regards to 
the "opaque" claim, the ranges don't violate the fact that it is still 
a 32 bit unsigned integer.

How the value is represented is another matter entirely, the CALIPSO 
authors chose the IPv4'esque dotted notation which seems as good as any 
to me.

> I hesitate to say this but I think it might be a good idea to draw up
> a draft explaining what a DOI is and what is expected from IANA for
> them. I've received emails from people working on security labels in
> application layer protocols so they might be interested in a standard
> method for specifying and interpreting DOIs as well.

That sounds like it might be reasonable as an informational RFC.  If you 
are looking help I'd be more than happy to contribute or review.  It is 
probably a good idea to contact Randall as I think he has the most 
current user/IETF feedback on DOI issues.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
