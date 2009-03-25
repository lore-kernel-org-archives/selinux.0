Date: Wed, 25 Mar 2009 11:33:17 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org, selinux@tycho.nsa.gov
Subject: Re: [nfsv4] New MAC label support Internet Draft posted to IETF	website
Message-ID: <20090325163317.GV9992@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <49C9F0E1.1040202@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49C9F0E1.1040202@sun.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 25, 2009 at 01:52:49AM -0700, Jarrett Lu wrote:
> 2. section 3, the semantics of DOI in your draft is different from the 
> one in the CALIPSO draft. Traditionally, DOI in MLS context refers to 
> (at least in part) administrative control and deployment of the MLS 
> systems. For example, DOD may own a block of DOIs. Systems using that 
> block of DOIs are permitted to communicate with on another. Label 
> translations are possible among the DOIs. Systems are not permitted to 
> accept data packets carrying DOI outside a known DOI range. In your 
> draft, DOI is used to imply label format in the opaque field of the 
> security attribute. This makes it impossible to share the CALIPSO DOI.

Before CALIPSO it's always been the case that the form of a label
depends on the DOI it is from, with a DOI being either implied by
context or explicit on the wire.

A CALIPSO DOI is, AFAICT, a DOI that imposes an MLS form on the label
(though with label encoding being protocol specific) and a security
policy registration/definition requirement.  CALIPSO also requires that
a DOI always be explicit.  CALIPSO also imposes a namespace of DOIs, and
I'm not sure that it allows any DOIs that are not CALIPSO DOIs.  CALIPSO 

In other words, any protocol that carries a {DOI ID, opaque label}
should be compatible with CALIPSO.

But an implementation that adheres to CALIPSO will not be able to use
non-CALIPSO DOIs.  Is that correct?  If so we need to ensure that a
mapping between MLS and DTE is possible, since David, IIRC, wants
support for DTE.  But as far as I can tell such a mapping is possible.

One thing I think is wrong with section 3.1 is that it talks about
translation of a label "into a form that is usable by the endpoint."
That's superfluous -- it should suffice to say that the DOI field allows
the server to know how to interpret the label if it understands the
given DOI.

> 3. section 3, on a MAC system, every subject and object has a label as 
> you stated. Different objects are labeled in different layers or 
> subsystems. For example, data packets, network interface, sockets are 
> labeled by IP module. I believe the draft should at least state that 
> NFSv4 MAC labeling should be consistent with MAC policy on the entire 
> system. Take MLS system as an example, it's considered a MAC violation 
> that a file labeled SECRET goes out on a network interface labeled 
> UNCLASSIFIED. It's important that NFS implements this correctly so that 
> MAC is enforced correctly on the system. It's difficult for IP module to 
> inspect whether NFS has put the correct label in IP's payload.

Agreed.

> 4. section 4, the draft should probably state how a MAC client knows 
> whether the server is MAC aware or not, via configuration? Also how a 
> MAC aware server knows whether the client is MAC aware, via 
> configuration or based on the fact that security attributes are present?

A client has to know a priori somehow whether to trust a server for a
specific range of labels in some DOI.  The MAC awareness or non-
awareness of a server relates only to how the label of an object is to
be determined (MAC server: the server tells you the object's label;
non-MAC server: the object's location determines the object's label) and
how authorization is to be done (MAC server: the server does MAC and DAC
authorization; non-MAC server: the server does DAC and the clients to
MAC authorization, with the clients having to all have a consistent
configuration).

> 5. section 4, nit. "MAC aware client/server" are probably better names 
> than "smart client/server".

Agreed.

> 6. section 4.1, in full mode, does reply carry a label? It appears to me 
> that a client never needs to do a DOI translation. The draft should be 
> more explicit on  that, IMO.

A client may have to do a DOI translation for reasons unknown to us, but
we should probably not even mention that.   Is that what you mean?

> 8. section 4.3, what actually prevents a MAC aware server to serve a 
> mixture of MAC aware and MAC unaware clients? This restriction may not 
> be necessary. There are environments where both kinds of clients coexist.

I agree.  A MAC aware server can certainly speak to MAC-unaware clients
by coercing all processes (open owners) on the client to a single label
determined via server-side configuration.

> 10. section 7, as stated above, you seem to use the DOI field 
> differently. It appears that you want the DOI to indicate whether an 
> NSFv4 server understands the label format AND knows how to interpret the 
> opaque field. This implies the server has to know all the label 
> definitions for all valid DOIs.

Well, for all the DOIs it knows about, for what else is a "valid DOI"?

>                                 For example, a server must be able to 
> detect a label is undefined under a DOI although it knows the format of 
> the label.

But if the server understands a given DOI then can do that.

>            This may be better solved via configuration instead of going 
> through IANA. For example, if one wants his server to be able to 
> translate among three labeling schemes, she/he will configure the system 
> with all three label definitions, translation tables, modules containing 
> appropriate label functions and utilities, etc..

It should be possible for a server to support multiple DOIs without
necessarily having to know how to translate between them.  Then you get:
processes with labels in one DOI cannot access objects with labels in
another.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
