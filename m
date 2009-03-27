Date: Thu, 26 Mar 2009 19:11:03 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org, selinux@tycho.nsa.gov
Subject: Re: [nfsv4] New MAC label support Internet Draft posted to IETF	website
Message-ID: <20090327001102.GU9992@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM> <49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM> <49CBFB94.6030408@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49CBFB94.6030408@sun.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Mar 26, 2009 at 03:03:00PM -0700, Jarrett Lu wrote:
> CALIPSO spec doesn't tie a DOI with a particular label encoding. For 

CALIPSO is very specific about label domination -- that means that
having any application protocol w/ labeling above IP requires that we be
able to determine whether an application-level label is dominated by a
CALIPSO label, and the rules given are MLS with Bell-LaPadula.

Perhaps that does not mean that we must adopt MLS and Bell-LaPadula at
the application layer, but it certainly seems like the easiest path,
particularly if we can also represent DTE that way.

Now, CALIPSO does not impose a label _encoding_ (layout of bits on the
_wire_) outside IP, but it does seem to impose label _structure_ outside
of IP (see above).

> example, it DOI 1000 doesn't have to mean it's CALIPSO label with this 
> label encoding file. DOI 1000 could very well be used by SELinux systems 
> using a particular MAC policy. CALIPSO DOI does imply that when a node 
> can communicate with a DOI, it knows how to interpret the labels 
> associated with the DOI. All nodes using the same DOI have agreed on 
> what format and encodings to use. The agreement takes place else where, 
> most likely an administrative decision. Does labeled NFSv4 aim to 
> establish this agreement within the protocol itself?

As I read it CALIPSO allows each DOI to determine the names and meanings
of sensitivity levels, compartments, and releasability.  It does not
allow DOIs to impose a different label structure involving things other
than those (and the DOI number itself).

What exactly is your comment re: David's I-D?  I thought it was "opaque
is bad" but now I think you're saying the opposite.  I'm confused :)

I think partly the confusion relates to the word "encoding" (see below).

> >Also, this does not mean that the label shouldn't be opaque in the XDR
> >sense.  Using opaque in the XDR sense but actually imposing a label
> >encoding might still be desirable (mostly for compression, but also if
> >we should reserve some of the DOI number space for as-yet-unspecified
> >label structures and encodings).
> 
> CALIPSO spec reserves DOI value 1 - 255 for private use. If an 
> organization doesn't want to do labeled communication outside its 
> control, it can use a number in that range, without need to register 
> with IANA.

Indeed, but it still imposes label structure on private use DOIs, at
least as far as I can tell.  Did I misread CALIPSO?

> >Yes, and there's a relationship to the application data.  Thus, for
> >example, the label used for packets carrying NFS traffic has to
> >dominate the labels of the files being accessed via NFS.
> 
> Typically, SECRET data/file traffic doesn't leave SECRET network. So 
> labels in different layers/subsystems should match. What must not happen 
> is SECRET data flowing through UNCLASSIFIED network. In other words, we 
> don't want to see a request coming in from UNCLASIFFIED  interface 
> asking for SECRET files.

I think you've restated what I wrote.  I was arguing that this
requirement imposes CALIPSO's label structure (DOI, sensitivity level,
compartments and releasability) on the applications layered above IP.
Perhaps that's wrong.  This matter is one we're going to have to decide
before long.

> >CALIPSO imposes structure on labels, not encoding (it does define an
> >encoding for use in IPsec though).  The structure is: DOI, sensitivity
> >level, compartments, releasability.  We'll need to pick an encoding.
> 
> By label encoding, I mean how a CALIPSO label represented in a more 

Fine, but when talking about protocols with bits on the wire "encoding"
generally means "the format of the bits on the wire," so that's how I've
been using the term.

> basic form (e.g. hex or binary). It's usually done in a file, e.g. 
> 0x000300a0000 translates to SECRET and it dominates 0x0001007000. 
> Security administrators control the encoding. They get to say what 
> labels are valid and how valid label relate to each other on their 
> systems. Given this kind of local control, I don't know how we, who 
> defined protocol attributes, could pick one. The way it works is that 
> they (administrators) picked one, and agreed among themselves what label 
> encoding and DOI to use.

CALIPSO certainly specifies an encoding for use on the wire (see setion
5.1 of draft-stjohns-sipso-11).  If CALIPSO can, so can we.  The encoding
on the file system, the translation to human readable strings, the
semantics of each sensitivity level and compartment -- these are all
things that are specific to each DOI's rules.

> >David seems to want explicit support for DTE.  If we can get away with a
> >combination of MLS (and, maybe, privileges) to represent DTE then we can
> >stick exclusively to MLS and remain compliant with CALIPSO.  Given the
> >impact that CALIPSO has on application protocols I think we have no
> >choice (see above).
> 
> I used MLS as examples, but I'd expect all MAC systems will have similar 
> issues, i.e. MAC aware applications should not do things which are in 
> conflicts with MAC policies in other parts of the system. I think the 
> "interference" of CALIPSO DOI on application protocols comes from the 
> fact that labeled NFSv4 wants to reuse CALIPSO DOI for something different.

David's I-D doesn't even mention CALIPSO, so I don't see how you could
think that :)

> >I agree that it's best to have an encoding for the label than to leave
> >it opaque.  I want a range of unknown DOIs with opque labels for
> >extensibility though (see above).
> 
> The difficulty is that label interpretation is directly tied to a label 
> encoding file. Different organizations have control over content of this 
> file. I don't know how you structure this with a protocol attribute.

Then it seems to me that you have a comment to make on CALIPSO since it
imposes label structure and an encoding on the wire.

> >In David's I-D the encoding of the label is left to each DOI.  That's
> >not unreasonable.  But in the face of CALIPSO we might as well specify
> >an actual label encoding given that CALIPSO imposes label structure.
> 
> This implies there is only one way to interpret a CALIPSO label. In fact 
> every organization gets to say how a CALIPSO label should be 
> interpreted. I don't see how a single DOI will make it work without some 
> OOB agreement among communicating entities.

No, I don't think so.  I think we're each using "encoding" to mean
something different than the other is.  I'm talking strictly about bits
on the wire, not about interpretation (beyond the basic rules imposed by
CALIPSO), and not what Solaris TX means by label encoding.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
