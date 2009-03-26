Date: Thu, 26 Mar 2009 10:09:34 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org, selinux@tycho.nsa.gov
Subject: Re: [nfsv4] New MAC label support Internet Draft posted to IETF	website
Message-ID: <20090326150934.GR9992@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM> <49CB4A18.3090709@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49CB4A18.3090709@sun.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jarret,

I agree with your point about interoperability: we must impose a label
encoding.  We can leave parts of the DOI number space reserved for
as-yet-unspecified label forms and encodings -- that would satisfy my
desire for extensibility.  That's a comment I should make on CALIPSO,
that it should not impose its label structure and encoding on all DOIs,
just all DOIs in parts of the DOI number space open for registration.

Also, this does not mean that the label shouldn't be opaque in the XDR
sense.  Using opaque in the XDR sense but actually imposing a label
encoding might still be desirable (mostly for compression, but also if
we should reserve some of the DOI number space for as-yet-unspecified
label structures and encodings).

On Thu, Mar 26, 2009 at 02:25:44AM -0700, Jarrett Lu wrote:
> Nicolas Williams wrote:
> >On Wed, Mar 25, 2009 at 01:52:49AM -0700, Jarrett Lu wrote:
> >>2. section 3, the semantics of DOI in your draft is different from the 
> >>one in the CALIPSO draft. Traditionally, DOI in MLS context refers to 
> >>[...]
> >
> >Before CALIPSO it's always been the case that the form of a label
> >depends on the DOI it is from, with a DOI being either implied by
> >context or explicit on the wire.
> >  
> 
> CALIPSO DOI is intended for IP packets. Nodes using same DOI value 

Yes, and there's a relationship to the application data.  Thus, for
example, the label used for packets carrying NFS traffic has to dominate
the labels of the files being accessed via NFS.

That means that CALIPSO has an impact beyond IP.  Specifically,
CALIPSO's imposition of structure on labels of any DOIs with DOI ID <
2^32 applies to applications as well.

> implies that they all agree on how to interpret a MAC label. In that 
> sense, it's more about label definition and encodings, less about its 
> format. For example, host A and host B use a label encoding where label 
> CONFIDENTIAL dominates label INTERNAL. A and B communicate using DOI 1. 

CALIPSO imposes structure on labels, not encoding (it does define an
encoding for use in IPsec though).  The structure is: DOI, sensitivity
level, compartments, releasability.  We'll need to pick an encoding.

> CALIPSO spec is very clear that the first thing IP checks is DOI number. 
> IP drops packets if the DOI is unexpected. CALIPSO hasn't changed how 
> DOI is used in that regard. Sun's trusted OS has similar behavior for a 
> long time. That's DOI for IP module. It appear that labeled NFSv4 wants 
> a different DOI, or different semantics of DOI. Using the example above, 
> it seems to desire the following semantics:

David seems to want explicit support for DTE.  If we can get away with a
combination of MLS (and, maybe, privileges) to represent DTE then we can
stick exclusively to MLS and remain compliant with CALIPSO.  Given the
impact that CALIPSO has on application protocols I think we have no
choice (see above).

> DOI value      Opaque Security Attribute Field
> ---------      -------------------------------
>    1          CALIPSO MLS label using label encodings shared by A, B
>    2          CALIPSO MLS label using label encodings shared by C, D
>    3          Redhat DTE label using security policy shared by A, B
>    4          OpenSolaris FMAC DTE label using sec policy shared by C, D
>    5          BSD's Biba label using security policy shared by C, D
>   ....
> 
> In an MLS example, server host C gets a request from client host A with 
> DOI = 1, requester label = CONFIDENTIAL. The client wants to write to 
> file foo, which is protected by label INTERNAL under DOI 2. Server C 
> validates that CONFIDENTIAL is a defined label in label encodings under 
> DOI 1. It then translates the label and concludes that CONFIDENTIAL in 
> DOI 1 is equivalent to INTERNAL in DOI 2, it then grants the write 
> access to object foo (note in MLS, write access requires labels being 
> equal).

I think that's the sort of thing that David was aiming for, yes.

> I am having difficulty with how to manage DOIs with different 
> combinations in the opaque field.

I agree that it's best to have an encoding for the label than to leave
it opaque.  I want a range of unknown DOIs with opque labels for
extensibility though (see above).

> >A CALIPSO DOI is, AFAICT, a DOI that imposes an MLS form on the label
> >(though with label encoding being protocol specific) and a security
> >policy registration/definition requirement.  CALIPSO also requires that
> >a DOI always be explicit.  CALIPSO also imposes a namespace of DOIs, and
> >I'm not sure that it allows any DOIs that are not CALIPSO DOIs.  CALIPSO 
> >
> >In other words, any protocol that carries a {DOI ID, opaque label}
> >should be compatible with CALIPSO.

I should have qualified that last statement: "any protocol that carries
a {DOI ID, opaque label} _and can use MLS exclusively_ should be
compatible with CALIPSO."

> Whenever a packet carries a CALIPSO label, explicit DOI is mandatory.

David's I-D has that.

> >But an implementation that adheres to CALIPSO will not be able to use
> >non-CALIPSO DOIs.  Is that correct?  If so we need to ensure that a
> >mapping between MLS and DTE is possible, since David, IIRC, wants
> >support for DTE.  But as far as I can tell such a mapping is possible.
> 
> If labeled NFSv4 DOI is used to indicate how the opaque field should be 

In David's I-D the encoding of the label is left to each DOI.  That's
not unreasonable.  But in the face of CALIPSO we might as well specify
an actual label encoding given that CALIPSO imposes label structure.

> >>[...]
> >
> >A client has to know a priori somehow whether to trust a server for a
> >specific range of labels in some DOI.  The MAC awareness or non-
> >awareness of a server relates only to how the label of an object is to
> >be determined (MAC server: the server tells you the object's label;
> >non-MAC server: the object's location determines the object's label) and
> >how authorization is to be done (MAC server: the server does MAC and DAC
> >authorization; non-MAC server: the server does DAC and the clients to
> >MAC authorization, with the clients having to all have a consistent
> >configuration).
> >  
> 
> I spoke to David about this. He is of the opinion that a MAC aware 
> client should not care whether the server is MAC aware. I guess that 
> means client always provides label attributes to server, and MAC unaware 
> server just ignores it. But I agree with you that MAC aware clients 
> should somehow know whether the server is MAC aware so that the client 
> is clear on whose responsibility it is to set label of an object. It's 
> also more robust to be able to detect the error case where a MAC aware 
> server should set label attributes but fails to do so.

I agree with you and disagree with David then on this:

 - MAC-unaware clients must be treated as being at a single label.

 - MAC-unaware servers must either be treated as being at a single label
   or filesystem object labels must be derived from the fsid of each
   object.

   The latter is more or less the Solaris TX approach to file labeling
   in general right now, and it requires that all MAC-aware clients be
   configured the same way.  It also effectively requires that all
   clients of MAC-unaware servers be MAC-aware, which is why MAC-unaware
   servers will be difficult to use in practice.

> If a client also needs to do DOI translation, the document should 
> explicit about  that and say that replies from server should also carry 
> DOI. That way, implementors know what kind of client they need to build 
> to be compliant. Requiring client to do translation adds quite a bit of 
> complexity. It's probably better not requiring that, until we know for 
> sure that is needed.

The DOI should always be explicit in NFSv4.x, yes.  I think that DOI
translation will never really happen, thus we should probably chuck it.

> >It should be possible for a server to support multiple DOIs without
> >necessarily having to know how to translate between them.  Then you get:
> >processes with labels in one DOI cannot access objects with labels in
> >another.
> 
> Yes, that's possible, and this is simpler than having to translate. I 
> don't know enough use cases to know whether users keep multiple file 
> systems on same server but protect them with two sets of labels.

I'm thinking of a single storage infrastructure serving clients from
multiple DOIs, with each DOI kept strictly separated by server policy,
thus no two DOIs "meet."  Granted, such a thing can be implemented via
virtualization.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
