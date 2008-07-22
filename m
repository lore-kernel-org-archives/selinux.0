Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6M22npB003184
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 22:02:49 -0400
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6M22nmn007879
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 02:02:49 GMT
Received: by yw-out-1718.google.com with SMTP id 6so619116ywa.84
        for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 19:02:49 -0700 (PDT)
Subject: Re: questions about persistent storage of security contexts
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Eric Paris <eparis@parisplace.org>
Cc: Andrew Warner <warner@rubix.com>, selinux@tycho.nsa.gov
In-Reply-To: <7e0fb38c0807211735w40e6fe4bjb31171b9d13cea45@mail.gmail.com>
References: <48851770.5020002@rubix.com>
	 <7e0fb38c0807211735w40e6fe4bjb31171b9d13cea45@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 21 Jul 2008 22:01:03 -0400
Message-Id: <1216692067.17786.21.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-07-21 at 20:35 -0400, Eric Paris wrote:
> On Mon, Jul 21, 2008 at 7:10 PM, Andrew Warner <warner@rubix.com> wrote:
> > Hello,
> >
> > I am currently developing an "SELinux aware" DBMS (primarily TE and MLS)
> > that is characterized by:
> >
> > 1. The need to store a security context (in some recoverable form) in our
> > persistent database (storage size of the context is an important factor)
> > 2. The need to frequently perform a high number of security access checks in
> > a performance sensitive way
> >
> > My question relates to the first characteristic from above. I am having
> > trouble deciding on the best way to store the security context in the
> > database. From my research I  see (I think!) three different representations
> > for a security context: 1) string; 2) raw; 3) SID.
> >
> > The string representation, generally, seems clear as this is what is shown
> > in all documentation as the context representation that exists in user
> > space. My only question regarding the string representation is: is there is
> > any hard limit to the length of the security context string? Do I need to
> > allow for no theoretical size limit on a context string if I choose to store
> > it?
> 
> No hard limit that I can think of. There might be one somewhere but I
> wouldn't count on it.

Correct - the core logic imposes no fixed limits on the context strings,
although the kernel interfaces do impose certain practical limits (e.g.
page size).  The NFSv4 support will likewise impose certain limits in
accordance with existing limits on the size of containing structures.

> > I am inferring the the raw representation exists from seeing *_raw functions
> > (e.g., security_compute_create_raw) referenced in selinux header files.
> > Other than seeing these functions declared I am having trouble finding out
> > much about a raw representation. Is there any advantage to
> > storing/manipulating a context in its raw representation? That is, are they
> > more suited for a fast security access check, are they smaller in size, or
> > do they have a fixed or maximum length?
> 
> The _raw is actually what you want.  _raw basically just means strings
> without any translations from things like mcstransd.  Given a context
> like user_u:role_r:type_t the "raw" on an MLS system maybe
> "user_u:object_r:type_t::s0."  Throwing a context with the MLS portion
> attched at the !raw functions will work just fine.
> 
> > The SID I have also seen mentioned in various documentations but can
> > determine little about them. My guess is that they are an integer value that
> > is used for fast internal access, particularly for the AVC. Are SIDs indeed
> > integer values? Are they persistent or are they meaningful only for a
> > particular OS session?
> 
> That's exactly what they are.  They are kernel internal integer
> representations that are (for the most part) only meaningful for that
> session.  There are some 'initial sids' that are always the same, but
> no userspace app should care about 'sids' in the general sense.
> 
> > I have also considered maintaining my own internal, persistent mapping
> > between string based contexts and an integer representation, the mapping
> > being stored/indexed inside the DBMS. This gives me a small storage overhead
> > with a fixed size.
> 
> I don't have a problem with internal mapping like that.

The original SELinux filesystem labeling implementation used something
like that - they were called "persistent security identifiers" (PSIDs),
and were maintained as private indices per-filesystem that mapped to
security context strings.

> But, don't we already have sepostgresql?  Maybe you should be looking
> to see if that fits your needs or you might get ideas from the work
> that they performed?

Yes, I'd recommend looking at SE-PostgreSQL as a worked example of
applying the Flask architecture to a DBMS, including not only its
approach to storing security contexts but also its approach to the
userspace AVC.  You can find a link to that work from the Related Work
page off of the SELinux web site.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
