From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v2 1/2] [SELINUX] Add a capabilities bitmap to SELinux policy version 22
Date: Thu, 27 Sep 2007 15:07:28 -0400
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov
References: <20070926212810.15998.58788.stgit@flek.americas.hpqcorp.net> <46FADC17.8070606@manicmethod.com> <1190893010.27038.15.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190893010.27038.15.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200709271507.28809.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 27 September 2007 7:36:50 am Stephen Smalley wrote:
> On Wed, 2007-09-26 at 18:24 -0400, Joshua Brindle wrote:
> > Paul Moore wrote:
> > > Add a new policy capabilities bitmap to SELinux policy version 22. 
> > > This bitmap will enable the security server to query the policy to
> > > determine which features it supports.
> > > ---
> > >
> > >  security/selinux/include/security.h |   15 +++++-
> > >  security/selinux/selinuxfs.c        |   90
> > > +++++++++++++++++++++++++++++++++-- security/selinux/ss/policydb.c     
> > > |   18 +++++++
> > >  security/selinux/ss/policydb.h      |    2 +
> > >  security/selinux/ss/services.c      |   39 +++++++++++++++
> > >  5 files changed, 158 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/security/selinux/include/security.h
> > > b/security/selinux/include/security.h index 83bdd4d..d7e6ed2 100644
> > > --- a/security/selinux/include/security.h
> > > +++ b/security/selinux/include/security.h
> > > @@ -25,13 +25,14 @@
> > >  #define POLICYDB_VERSION_MLS		19
> > >  #define POLICYDB_VERSION_AVTAB		20
> > >  #define POLICYDB_VERSION_RANGETRANS	21
> > > +#define POLICYDB_VERSION_CAPBITMAP	22
> >
> > I didn't like this name (I almost used it myself) because it sounds like
> > we are doing something with linux capabilities, I ended up using
> > POLICYDB_VERSION_PCAPS (for policy capabilities)
>
> Doesn't help much; PCAP sounds like process capabilities, and
> CAP_SETPCAP ;)  I don't think the name matters either way.

What's in a name after all, right?

 :)

The voices in my head said they liked POLICYDB_VERSION_POLCAP the best, so I'm 
gonna go with that.  I've found it's best not to ignore the voices ...

> > > +int security_policycap_supported(unsigned int req_cap)
> > > +{
> > > +	int rc;
> > > +
> > > +	POLICY_RDLOCK;
> > > +	rc = ebitmap_get_bit(&policydb.policycaps, req_cap);
> > > +	POLICY_RDUNLOCK;
> > > +
> > > +	return rc;
> > > +}
> > > +
> >
> > Shouldn't this just check if policyvers > POLICYDB_VERSION_CAPBITMAP? it
> > could be inlined too.
>
> It can't be inlined as it is a security server interface.
>
> I suppose you could check the version first to see if it is < 22 and
> always return 0 in that case without having to take the rdlock.
>
> You could also extract the first word of the bitmap to a simple unsigned
> long in the policydb at load time and do a direct bit test on it if
> req_cap < (sizeof(unsigned long) * 8), without taking policy rdlock.

My thinking was that for capability checks that are likely to be in 
performance critical sections we could create a separate flag like I did for 
the the netpeer stuff in the patch.  This removes any issues with a function 
call as well as the policy lock.

I suppose that this approach may not scale very well if the bitmap grows to 
include a number of different capabilities, but I don't foresee that 
happening for a while so I'm happy to leave the issue for later.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
