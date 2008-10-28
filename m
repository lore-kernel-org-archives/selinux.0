From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC] sVirt v0.10 - initial prototype
Date: Tue, 28 Oct 2008 18:17:35 -0400
Cc: Daniel J Walsh <dwalsh@redhat.com>, libvir-list@redhat.com,
        "Daniel P. Berrange" <berrange@redhat.com>,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org> <200810230805.39558.paul.moore@hp.com> <alpine.LRH.1.10.0810290836010.25230@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0810290836010.25230@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810281817.35288.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 28 October 2008 5:42:17 pm James Morris wrote:
> On Thu, 23 Oct 2008, Paul Moore wrote:
> > However, may I suggest that instead of representing the DOI as a
> > string we use a 32bit integer?  I know that may sound a bit odd,
> > but in the networking world most DOI values are represented as
> > integers and when security labels are involved they tend to be
> > 32bits.  I understand that using a plain integer is much more
> > abstract than a human readable string but it should make it easier
> > to leverage existing and future* DOI frameworks.
>
> I'd prefer to use string, which can be managed freely by the user,
> and be human-readable.  Unlike IP layer networking, we're not
> constrained by e.g. having to fit in the IP options, and can simply
> convey the DOI as-is.

True, we've got plenty of space to play with in the sVirt case as 
opposed to things like labeled networking and labeled NFS.  However, 
that wasn't really my concern.  It is likely that at some point in the 
future we will have some sort of standardized approach to dealing with 
DOIs and right now most of the DOIs in the labeled security space are 
32 bit integers; using a 32 bit value in sVirt has the potential to 
make life much easier down the road.  Granted, if strings are voted as 
the way forward and portability of labeled guests really takes off then 
I'm sure we'll find a way to deal with it; it would just be nice not to 
have to adapt things later on.

> This will also not prevent users from utilizing integers as the DOI
> if desired.

Also true.

> In the common non-DoD case, people should be able to configure the
> DOI as simply as editing a configuration file to set the DOI to a
> domain name or arbitrary realm name.

I don't think DoD/non-DoD has anything to do with it, it is more of a 
management issue and both groups have the same problem.  Is the 
convenience of being able to enter "guests-r-us.com" over "5" in the 
DOI field really worth the disconnect from the traditional 32 bit DOI 
integer?

> > *An informal group/list just formed to start discussing DOI
> > management issues such as DOI formats, negotiation and translation.
>
> URL ?

Viola, http://mail.opensolaris.org/mailman/listinfo/doi-discuss, there 
was one thread in the beginning that got some traffic but it has been 
pretty quiet since then.  I'm pretty sure archives are available at the 
link above.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
