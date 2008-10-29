Subject: Re: [RFC] sVirt v0.10 - initial prototype
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: James Morris <jmorris@namei.org>, Daniel J Walsh <dwalsh@redhat.com>,
        libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <200810281817.35288.paul.moore@hp.com>
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org>
	 <200810230805.39558.paul.moore@hp.com>
	 <alpine.LRH.1.10.0810290836010.25230@tundra.namei.org>
	 <200810281817.35288.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 29 Oct 2008 10:40:00 -0400
Message-Id: <1225291200.31157.260.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-10-28 at 18:17 -0400, Paul Moore wrote:
> On Tuesday 28 October 2008 5:42:17 pm James Morris wrote:
> > On Thu, 23 Oct 2008, Paul Moore wrote:
> > > However, may I suggest that instead of representing the DOI as a
> > > string we use a 32bit integer?  I know that may sound a bit odd,
> > > but in the networking world most DOI values are represented as
> > > integers and when security labels are involved they tend to be
> > > 32bits.  I understand that using a plain integer is much more
> > > abstract than a human readable string but it should make it easier
> > > to leverage existing and future* DOI frameworks.
> >
> > I'd prefer to use string, which can be managed freely by the user,
> > and be human-readable.  Unlike IP layer networking, we're not
> > constrained by e.g. having to fit in the IP options, and can simply
> > convey the DOI as-is.
> 
> True, we've got plenty of space to play with in the sVirt case as 
> opposed to things like labeled networking and labeled NFS.  However, 
> that wasn't really my concern.  It is likely that at some point in the 
> future we will have some sort of standardized approach to dealing with 
> DOIs and right now most of the DOIs in the labeled security space are 
> 32 bit integers; using a 32 bit value in sVirt has the potential to 
> make life much easier down the road.  Granted, if strings are voted as 
> the way forward and portability of labeled guests really takes off then 
> I'm sure we'll find a way to deal with it; it would just be nice not to 
> have to adapt things later on.

I really don't like the idea of using strings for this. With our u32
scheme we have a way of provisioning off private DOI spaces which is
fairly simple since we can allocate ranges within the int. With strings
if you want to indicate something is private you are going to have to
come up with come convention of adding a prefix or suffix to indicate
that. If you want to do DOI->Name translations we can make sure to
require a valid name for the DOI in the IANA registration for the public
ones and you will have to have something similar to setransd to handle
them for private ones. Either that or build it into your scheme that
when I specify a DOI I specify a name for it as well. You can have DOI
be a complex element containing an int and a string.

> 
> > This will also not prevent users from utilizing integers as the DOI
> > if desired.
> 
> Also true.

However if you go with strings they are completely unusable for labeled
networking and labeled NFS unless they are already a number or we come
up with some sort of translation facility for it. I'd rather see the
translation from int->string than string->int.

> 
> > In the common non-DoD case, people should be able to configure the
> > DOI as simply as editing a configuration file to set the DOI to a
> > domain name or arbitrary realm name.
> 
> I don't think DoD/non-DoD has anything to do with it, it is more of a 
> management issue and both groups have the same problem.  Is the 
> convenience of being able to enter "guests-r-us.com" over "5" in the 
> DOI field really worth the disconnect from the traditional 32 bit DOI 
> integer?

If in the config file the DOI is a complex element with both DOI and
name you can have your cake and eat it to. I see the name element as an
explicit mapping rule of DOI to a string. Also if you intend to have
names like the one above it seems even less correct to use them. When
guests-r-us.com and myguests.com can be running policies with the same
exact semantics then it is even more important to say they both have a
DOI of 5. That way you really know the policy semantics are the same
instead of it being shrouded by the names. It would confuse the hell out
of me as an administrator if they were identical but have two different
names or if I looked at my myguests.com VMs and saw that they were
running the guests-r-us.com DOI.

> 
> > > *An informal group/list just formed to start discussing DOI
> > > management issues such as DOI formats, negotiation and translation.
> >
> > URL ?
> 
> Viola, http://mail.opensolaris.org/mailman/listinfo/doi-discuss, there 
> was one thread in the beginning that got some traffic but it has been 
> pretty quiet since then.  I'm pretty sure archives are available at the 
> link above.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
