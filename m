Date: Wed, 25 Jul 2007 23:07:53 +0900
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: himainu-ynakam@miomio.jp, ynakam@hitachisoft.jp, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp, jmorris@namei.org, eparis@parisplace.org,
        kaigai@ak.jp.nec.com, method@manicmethod.com
Subject: Re: [RFC] Dynamically deciding number of hash slots for avtab
 (Was:Re: [patch] customizable AVTAB_HASH_BITS for embedded devices
Message-Id: <20070725230753.48a63602.himainu-ynakam@miomio.jp>
In-Reply-To: <1185368380.2900.40.camel@moss-spartans.epoch.ncsc.mil>
References: <20070724181924.41F6.YNAKAM@hitachisoft.jp>
	<1185281523.16598.42.camel@moss-spartans.epoch.ncsc.mil>
	<20070725113339.610F.YNAKAM@hitachisoft.jp>
	<1185368380.2900.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Jul 2007 08:59:40 -0400
Stephen Smalley  wrote:
> On Wed, 2007-07-25 at 12:01 +0900, Yuichi Nakamura wrote:
> > Hi.
> > 
> > Thanks for reply.
> > 
> > On Tue, 24 Jul 2007 08:52:03 -0400
> > Stephen Smalley  wrote:
> > > On Tue, 2007-07-24 at 18:32 +0900, Yuichi Nakamura wrote:
> > > > On Mon, 23 Jul 2007 15:58:31 -0400
> > > > Stephen Smalley  wrote:
> > > > > I'm open to making this configurable, although I'm not sure whether it
> > > > > should be a Kconfig setting or selinuxfs (or sysctl) setting.  Ideally,
> > > > > of course, it would be runtime computed based on the actual policy size.
> > > > > Rewriting the avtab and other security server data structures to more
> > > > > kernel native would be fine with me too - they don't need to match the
> > > > > userland ones.
> > > > > 
> > > > > (please cc James, Eric, and me on selinux kernel patches)
> > > > OK, I made patch about that. 
> > > > Please look at patch at the end of this e-mail.
> > > > 
> > > > It decides number of hash slots based on number of unconditional TE rules.
> > > > I looked at avtab_read, and found number of unconditional TE rules are 
> > > > described in binary policy, 
> > > > so it can be used.
> > > > Number of hash slot is 2^n. n is decided based on number of unconditional TE rules.
> > > > If number of unconditional TE rules is 4000, n is 12, so 2^12 = 4096 slots 
> > > > are allocated for te_avtab and te_cond_avtab.
> > > 
> > > That seems too high; we don't need one slot per rule, especially given
> > > the AVC, as noted by KaiGai.  I'd tune it down further.  And make the
> > > max lower, such that we can always use kmalloc instead of vmalloc.
> > I see. Please do that.
> 
> What?  Your patch would make this change.
OOps, I was misunderstaning.

> > Are you going to always use kmalloc?
> > Using kmalloc only when size of hash slots is small does not sound good for you?
> 
> No, we don't want the code conditionally using kmalloc or vmalloc.  Just
> pick one and use throughout, setting the max accordingly.
I see.


> > > > +	
> > > > +	if (nrules > MAX_AVTAB_SIZE) {
> > > > +		nslot = MAX_AVTAB_SIZE;
> > > > +		mask =  MAX_AVTAB_HASH_MASK ;
> > > > +	} else {
> > > > +		while(work) {
> > > > +			work  = work>>1;
> > > > +			shift++;
> > > > +		}
> > > > +		mask =(1 << shift) - 1;	
> > > > +		nslot = 1 << shift;
> > > 
> > > I'd tune this down.  And you only need to compute 1 << shift once.
> > Fixed about 1<<shift.
> 
> But you still don't need this many slots, I think, as it is ok for the
> hash chains to be longer in the avtab.
I think so, number of slots may be 1/2 or smaller.

> > > Not sure if this should still be called avtab_init() as it no longer
> > > happens at policydb_init().  Versus keeping a simple avtab_init() that
> > > just clears the avtab fields and introducing a new avtab_alloc()
> > > function or similar.
> > I prepared avtab_alloc, because it looks cleaner.
> 
> Good.
> 
> > Following is updated patch with trivial fixes.
> > Using kmalloc, using another hash func are pending
> 
> And the hash stats for using it with reference policy?
Yes, current test policy that I used was refpolicy with small number of modules.

I am now in place where no development environment, within this week...
I will start to measure hash stats in some situations next week.
I also am going to send update for libselinux in another thread, next week.

Regards,
---
Yuichi Nakamura

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
