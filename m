Subject: Re: [PATCH 1/3] libsepol: Add support for multiple target OSes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov
In-Reply-To: <1253123098.4348.221.camel@moss-stripedbass.epoch.ncsc.mil>
References: <1253031316.3209.116.camel@moss-stripedbass.epoch.ncsc.mil>
	 <4AB0EF22.8070003@manicmethod.com>
	 <1253123098.4348.221.camel@moss-stripedbass.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 16 Sep 2009 15:01:20 -0400
Message-Id: <1253127680.18198.120.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-16 at 13:44 -0400, Paul Nuzzi wrote:
> On Wed, 2009-09-16 at 09:58 -0400, Joshua Brindle wrote:
> > 
> > pjnuzzi wrote:
> > 
> > <snip>
> > > Signed-off-by: Paul Nuzzi<pjnuzzi@tycho.ncsc.mil>
> > >
> > > ---
> > >   libsepol/include/sepol/policydb/policydb.h |   28 +++-
> > >   libsepol/src/expand.c                      |   85 +++++++++++-
> > >   libsepol/src/policydb.c                    |  197
> > > ++++++++++++++++++++++++-----
> > >   libsepol/src/policydb_internal.h           |    1
> > >   libsepol/src/write.c                       |   90 ++++++++++++-
> > >   5 files changed, 359 insertions(+), 42 deletions(-)
> > >
> > > diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
> > > index 0105cf4..2013238 100644
> > > --- a/libsepol/include/sepol/policydb/policydb.h
> > > +++ b/libsepol/include/sepol/policydb/policydb.h
> > > @@ -276,6 +276,16 @@ typedef struct ocontext {
> > >   			uint32_t addr[4]; /* network order */
> > >   			uint32_t mask[4]; /* network order */
> > >   		} node6;	/* IPv6 node information */
> > > +		uint32_t device;
> > > +		uint16_t pirq;
> > > +		struct {
> > > +			uint32_t low_iomem;
> > > +			uint32_t high_iomem;
> > > +		} iomem;
> > > +		struct {
> > > +			uint32_t low_ioport;
> > > +			uint32_t high_ioport;
> > > +		} ioport;
> > >    
> > 
> > I'd rather have separate ocontext structs for each system. That way it 
> > is very easy to understand which ones apply to which system and you 
> > don't get a crazy out of context ocontext struct.
> > 
> 
> In the beginning I tried implementing a separate ocontext struct for
> each system but I was having issues.  If we have a separate struct for
> each platform a lot more code is going to have to be patched to decouple
> SELinux from being the default ocontext target.  Just a quick search
> with cscope shows there is 96 references to ocontext_t.  It might be
> easier to have one big (and confusing) ocontext structure at the expense
> of refactoring a lot of code.  
> 
> A good compromise might be to have an ocontext structure that nests Xen,
> SELinux, Solaris, etc. structures to make it easier to see which ones
> apply to the platform.  For example..
> 
> struct ocontext {
> 	struct xen_ocontexts {
> 		uint32_t device;
> 			struct {
> 				uint32_t low_iomem;
> 				uint32_t high_iomem;
> 			} iomem;
> 	} xen;
> 	struct selinux_ocontexts {
> 		uint32_t addr[4]; /* network order */
> 	} selinux;	
> }
> 
> Let me know what would be better.

My $0.02 - this particular change isn't worth the trouble.  struct
ocontext already contains a union where the particular field is selected
based on the OCON_ index, and adding new fields within that union causes
no confusion.  Target platforms will always share the fields outside of
the union (the context, sid, and next fields), and will share the union
fields as appropriate (e.g. Linux, FreeBSD, and Solaris will share the
name, port, and node fields).

Most of the other suggested changes sounded reasonable to me.  In
particular, letting OCON_NUM vary based on target platform would be
nice.  Note that this means replacing all uses of OCON_NUM with a value
taken from the policydb compat info structure, and dynamically
allocating the ocontext array to that size.  Also passing in the target
platform as a key into policydb_lookup_compat().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
