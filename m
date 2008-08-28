From: Paul Moore <paul.moore@hp.com>
To: Joy Latten <latten@austin.ibm.com>
Subject: Re: [RFC 1/2] labeled ipsec internet drafts
Date: Thu, 28 Aug 2008 11:44:25 -0400
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, gcwilson@us.ibm.com,
        selinux@tycho.nsa.gov, serue@us.ibm.com, tjaeger@cse.psu.edu
References: <200808252046.m7PKkdQu019720@faith.austin.ibm.com> <200808271650.25409.paul.moore@hp.com> <1219879658.2883.221.camel@faith.austin.ibm.com>
In-Reply-To: <1219879658.2883.221.camel@faith.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808281144.25994.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 27 August 2008 7:27:38 pm Joy Latten wrote:
> On Wed, 2008-08-27 at 16:50 -0400, Paul Moore wrote:

...

> > I am currently waiting to see how the CALIPSO specification is
> > received by the general IETF SAAG community, especially the
> > assertion that explicit packet labeling is an important user
> > requirement.  If the CALIPSO specification is well received I plan
> > on submitting a draft specification which will provide a more
> > general packet labeling mechanism for IPv6 and possibly IPv4.
>
> Do you mean one that would take a more generic label?

Yes.  In addition, I'm starting to wonder about making it sufficiently 
generic that the specification could be used beyond just security 
labels; there may be other potential uses cases such as DPI which could 
be greatly simplified through the use of a labeling specification.

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
> The CALIPSO draft restricted the amount of DOIs given to an
> organization. And I am thinking that if we share a DOI registry,  I
> will need more than one if I want any security mechanism that uses
> labeled ipsec to also have a range for private use. I wasn't sure how
> this would fit into what the draft stated. Thus my confusion. But I
> do think it would be really great if we could share a registry and
> use DOIs in such a similar manner that we could even share the
> values. Am I making sense? What I mean is labeled ipsec could use the
> same DOIs as labeled nfs and CALIPSO. It would not have to allocate a
> separate range of them.

If everyone (labeled NFS, labeled networking, etc.) can agree on a 
common DOI representation and registry I think this would make life 
much easier for cross-domain solutions.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
