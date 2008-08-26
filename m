Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7QKgIk4008588
	for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2008 16:42:18 -0400
Subject: Re: [RFC 1/2] labeled ipsec internet drafts
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Joy Latten <latten@austin.ibm.com>
Cc: paul.moore@hp.com, gcwilson@us.ibm.com, selinux@tycho.nsa.gov,
        serue@us.ibm.com, tjaeger@cse.psu.edu
In-Reply-To: <1219771040.2883.79.camel@faith.austin.ibm.com>
References: <200808252046.m7PKkdQu019720@faith.austin.ibm.com>
	 <1219700549.2627.27.camel@moss-terrapins.epoch.ncsc.mil>
	 <1219771040.2883.79.camel@faith.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 26 Aug 2008 16:24:22 -0400
Message-Id: <1219782262.2627.50.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-08-26 at 12:17 -0500, Joy Latten wrote:
> On Mon, 2008-08-25 at 17:42 -0400, David P. Quigley wrote:
> > On Mon, 2008-08-25 at 15:46 -0500, Joy Latten wrote:
> > [Snip...]
> > > 
> > > >>
> > > >>        - doi (1 octet) - The first octet contains the security
> > > >> label's domain of interpretation.
> > > >>
> > > >>          The domain of interpretation can be viewed as a group of
> > > >>          systems that agree on the meaning of particular values
> > > >> within the security label of a security mechanism.
> > > >>
> > > >>          The value of 1 is reserved as the default.
> > > >>
> > > >>          Reserved       0
> > > >>          Default        1
> > > >>
> > > >>        - algorithm (1 octet) - The second octet contains the security
> > > >>          label's algorithm.
> > > >>
> > > >>
> > > >>
> > > >>
> > > >> Latten, et al.               Expires ?                          [Page
> > > >> 3] 
> > > >> Internet-Draft               IKEv1SecurityLabel                June
> > > >> 2008
> > > >>
> > > >>
> > > >>          The security label's algorithm specifies the security
> > > >>          mechanism or context in which the label is applicable. For
> > > >>          example, the security label is interpreted within the
> > > >> SELinux context.
> > > >>
> > > >>          Requests for assignment of additional algorithms should be
> > > >>          addressed to the Internet Assigned Numbers Authority (IANA).
> > > >>
> > > >>          Reserved       0
> > > >>          SELinux        1
> > > >>          Smack          2
> > > >>          Private Use    120-128
> > > >
> > > >Is one octet enough here?  I honestly don't have a good idea as to how 
> > > >much is enough, so a little justification of your choice (even if it 
> > > >only lives in email, not in the spec) would be welcome.
> > > 
> > > I used one octet here because it is defined as one octet in the kernel's
> > > sec_ctx structure. Originally, I think we used one octect for each
> > > to keep within a 64-bit alignment requirement for pfkey. We thought
> > > one octet would be enough...
> > > 
> > 
> > There are several documents being submitted as drafts to the IETF at the
> > moment and all of them have different definitions of a DOI.
> > 
> > In your method you pair a mechanism with the DOI to form something along
> > the lines of a (mechanism,policyversion) tuple. The question of if one
> > octet is enough to identify all potential policies in a mechanism is
> > unclear but I have a feeling the answer will be no.
> > 
> > The second method is in the SIPSO for IPv6 draft. In this the DOI is a
> > 32 bit value existing as 4 octets. They partition off what are
> > essentially address spaces to be used privately, by certain
> > organizations, and they also keep a block for IETF considerations in
> > later revisions of the specification. There is a lot of information in
> > the document and most of it pertains to MLS labels.
> > 
> > The third method is in the label support for NFSv4 draft. In this we
> > just define the DOI as a 32 big value. It is up to a translation daemon
> > to decide if the endpoint has the knowledge and desire to translate
> > labels from the foreign DOI to its own.
> > 
> > Regardless of which method is used we need to come to a consensus on
> > what a DOI is and how we are going to represent it. We can't go to the
> > IETF with 3 different definitions of a DOI.
> > 
> 
> I just now quickly glanced at the CALIPSO draft as I had not read 
> it before. I did read the labeled nfs draft a while back. 
> 
> I see what you mean. However, I guess I am feeling a bit wary since
> the CALIPSO draft's description of the DOI and it's format seem to be
> tailored specifically for MLS labels. The labeled ipsec's doi field had
> a broader purpose in mind. 

Yea, it is unfortunate that CALIPSO is only for MLS labels. IPv6 is
still growing in its deployment so it would be nice to have a robust and
flexible method for conveying security labels from the start. For now it
seems as if CALIPSO will try to go through just as MLS labels and then
DTE or other security labels will have to create their own IP security
option.

> 
> > > >I'm also concerned with the implied convention of assigning one value to 
> > > >a particular implementation.  In the SELinux case, how do you deal with 
> > > >a non-MLS/MCS policy such as Gentoo/Ubuntu talking to a MLS/MCS policy 
> > > >such as Fedora/RHEL?  What about policies with different types?  
> > > >Differing numbers of MLS sensitivity levels or categories?
> > > >
> > > 
> > > Hmm... not sure I understand so I may not answer this correctly...
> > > 
> > > The algorithm indicates the security mechanism.
> > > In a way, it identifies the syntax/semantics of the 
> > > security context to security mechanism, since security mechanisms 
> > > may use different syntax/semantics for the security contexts. 
> > > i.e. SELinux and SMACK.
> > > The algorithm field in SELinux is used to "authorize" the security
> > > context. In other words, SELinux only wants and understands
> > > SELinux's security context syntax/semantics.
> > > The "doi"  would be used for further differentiation within SELinux
> > > domain. Far example, a sysadm wants to differentiate between SELinux
> > > policy versions in his domain. He could used "doi" field to do this.
> > > 
> > > I suppose if you wanted two different security mechanisms to 
> > > interoperate, a mapping of some sort would have to be created
> > > between them. The security mechanisms would need
> > > to indicate they accept (via the mapping) the other's
> > > security context syntax/semantics. In other words, they would "authorize" 
> > > the two different security contexts. It would do this via the 
> > > "algorithm" and/or "doi" fields. I am thinking in this case, "doi" could
> > > even indicate the mapping such as CIPSO's DOI does. 
> > > 
> > > I considered the information contained in the "algorithm" and 
> > > "doi" fields required for interoperability, and the use
> > > implementation specific.
> > > 
> > > If this doesn't answer your question, let me know. 
> > 
> > I think what Paul might be asking is why is it better to have two
> > fields, one for Security Mechanism and one for the DOI when that can be
> > one field. If we go with a method similar to the second described above
> > for DOIs you could have IANA allocate a range of DOIs for SELinux
> > partitioning it off into a range for publicly assigned DOIs and
> > privately managed DOIs. It is acceptable to have IANA create and
> > populate a registry with values in the document.
> > 
> 
> Ok, I understand now. Yes, that seems reasonable, fair, and flexible.
> I can still keep semantics (a mechanism and ability to group or
> differentiate).
> 
> So, a doi field that is 32 bits, with perhaps so much for SELinux,
> further partitioned for public and private use. The same for Smack.
> Right? And remaining for future use.

The standards people don't particularly care about specific security
models in this case. I initially mentioned implementation specific
details in my early labeled NFS drafts and was told that those aren't
really a concern of the protocol. Since the label is a (DOI,<OPAQUE>)
tuple it is up to whomever obtains a number from IANA to define the
meaning of that DOI. However it should be written into the standard what
information is recorded by IANA to bind to these numbers. Also do we see
several registries? I really only see one registry that can be shared by
all three of these drafts. I just hope they don't want us to write up an
RFC for the definition and management of DOIs (it might happen that way
though).

> 
> Would this be a consensus in regards to DOI for labeled nfs, labeled
> ipsec, and CALIPSO drafts?
> 

I would like to think that we could establish one definition of a DOI
for IETF documents. I spoke with several people at the last IETF meeting
and they said that we need to stay consistent here. I will be trying to
organize a security label BOF at the next IETF meeting so we can sit
down and discuss the way things should work. I doubt this will spawn a
working group for security labels but we could come to a consensus on
certain things.


> > > 
> > > >>Also, can you explain the reason for having both a DOI and a algorithm 
> > > >>field?  From an interoperability point of view, the node's security 
> > > >>implementation is irrelevant as long as it agrees to abide by the rules 
> > > >>and labels specified in the DOI.  I understand that currently a SELinux 
> > > >>security label looks different from a traditional MLS/CMW security 
> > > >>label, but there is no reason that a translation mechanism could not be 
> > > >>implemented to provide a common network security label that could be 
> > > >>understood and internalized by both types of systems.  While I'm not 
> > > >>holding this up as a particularly good example in all cases, we do have 
> > > >>something similar to this today in SELinux with how we handle the CIPSO 
> > > >>protocol.
> > > 
> > > I hope the above explained it. In a way my above explanation
> > > agrees with what you are saying here.
> > > 
> > > >>        - length (2 octets) - The third and fourth octets contain the
> > > >>          string length of the security context.
> > > >>
> > > >>        - security label (1 or more octets) - The security label. The
> > > >>          actual content will be dependent on the security algorithm
> > > >>          that is specified. Within IKE context, this is regarded as
> > > >>          an opaque bit string.
> > > >
> > > >I'm being picky here, but it might be better to say "opaque bit field" 
> > > >just so we don't get into string encoding issues (is it UTF-8 or 
> > > >something else?).
> > > 
> > > Ok, will do
> > 
> > I think the proper terminology is an "opaque byte" something where
> > something is an array, or a stream</pedantic>. At least that is what we
> > use in the NFSv4 documents, however they use XDR encoding and that term
> > is actually defined. I'm not sure if the IPSec document already has
> > definitions for these data types. The problem here is opaque usually
> > means with respect to the protocol not the encoding. So I think you
> > should make a decision on the string encoding or it might turn into an
> > interop nightmare. It's fine to say the semantic meaning of the string
> > is opaque to the protocol but you should agree on if your sending UTF-8
> > or whatever.
> > 
> 
> Ahh, yes! Thanks for pointing that out!  Let me go investigate and
> determine which encoding.
> 
> Thanks!
> 
> Hopefully, will send out a revised draft with both Paul and David's 
> improvements soon. 
> 
> regards,
> Joy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
