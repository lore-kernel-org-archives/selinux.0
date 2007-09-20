Subject: Re: [RFC]integrity: SELinux patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        zohar@us.ibm.com, safford@watson.ibm.com, sailer@us.ibm.com
In-Reply-To: <1190252058.7323.33.camel@localhost.localdomain>
References: <1188340501.11528.14.camel@localhost.localdomain>
	 <46D4F337.1030704@manicmethod.com>
	 <1188382494.6129.35.camel@localhost.localdomain>
	 <1190230883.7323.3.camel@localhost.localdomain>
	 <1190235840.25863.98.camel@moss-spartans.epoch.ncsc.mil>
	 <1190252058.7323.33.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 20 Sep 2007 09:12:29 -0400
Message-Id: <1190293949.12553.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-19 at 21:34 -0400, Mimi Zohar wrote:
> On Wed, 2007-09-19 at 17:04 -0400, Stephen Smalley wrote:
> > On Wed, 2007-09-19 at 15:41 -0400, Mimi Zohar wrote:
> > > On Wed, 2007-08-29 at 06:14 -0400, Mimi Zohar wrote:
> > > > On Wed, 2007-08-29 at 00:16 -0400, Joshua Brindle wrote:
> > > > > Mimi Zohar wrote:
> > > > > 
> > > > > > Index: linux-2.6.23-rc3-mm1/security/selinux/ss/services.c
> > > > > > ===================================================================
> > > > > > --- linux-2.6.23-rc3-mm1.orig/security/selinux/ss/services.c
> > > > > > +++ linux-2.6.23-rc3-mm1/security/selinux/ss/services.c
> > > > > > @@ -305,12 +305,12 @@ static int context_struct_compute_av(str
> > > > > >  		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
> > > > > >  			tclass = SECCLASS_NETLINK_SOCKET;
> > > > > >  
> > > > > > -	if (!tclass || tclass > policydb.p_classes.nprim) {
> > > > > > -		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> > > > > > -		       tclass);
> > > > > > -		return -EINVAL;
> > > > > > -	}
> > > > > > -	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> > > > > > +//	if (!tclass || tclass > policydb.p_classes.nprim) {
> > > > > > +//		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> > > > > > +//		       tclass);
> > > > > > +//		return -EINVAL;
> > > > > > +//	}
> > > > > > +//	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> > > > > >  
> > > > > >   
> > > > > 
> > > > > Err? Did you mean to submit it like this? This should be fixed by Eric's 
> > > > > patch to handle unknown classes anyway.
> > > > 
> > > > I'm working off the latest -mm tree and that patch hasn't made it in yet,
> > > > as well as some other patches.  For example, additional security class 
> > > > numbers have been defined.  So I will need to update SECCLASS_INTEGRITY
> > > > as well. The above code was added in order to test the patch. Once the 
> > > > basic integrity concept has been reviewed and accepted, I will repost 
> > > > based on the latest selinux development source tree.
> > > 
> > > Ok, so how do I get the latest selinux development source tree?
> > 
> > James Morris maintains a selinux git tree on kernel.org, but even that
> > wouldn't yet have Eric's patch (that patch has been posted a few times
> > on list, but there are still a couple of changes to be made).
> 
> I could post a patch without commenting out the above lines, so that when
> Eric's patch does become available, there won't be any conflicts.  That 
> still leaves the issue of which number to use when extending the object 
> class in security/selinux/include/flask.h for integrity.  62 is not 
> assigned in either the latest -mm or -git, but didn't someone already
> post a patch on the SELinux mailing list using it?

Don't worry about conflicts with pending patches; just make a clean
patch (where a clean patch follows the usual guidelines and doesn't
include commented-out code) against some well-defined baseline (linus,
mm, or selinux.git).  Using the for-akpm branch of selinux.git makes it
easier for James to merge of course, but as -mm includes that branch, it
should be the same except as other patches in mm might happen to overlap
and except as one happens to lag behind the other.

The capability override patch was using class 62, but that has not been
merged and I wasn't planning on pushing it - there was a fair amount of
concern about whether capability overrides are safe and usable as long
as the distros have to allow selinux to be disabled as an option.  So 62
is still available.  More generally, class/perm values are not truly
reserved until their definitions are committed, much like syscall
values.

In any event, I don't think we are really at the point of just cleaning
up implementation nits in these integrity patches - I think there needs
to be more discussion and work on the overall design, hook placement and
coverage, how it will be used in practice, who would use it, etc.  Which
goes beyond just how it would be integrated with selinux.  I haven't
really seen a compelling argument and concept of operations so far.  As
a general concept, I can see potential value in integrity measurement
(although lots of pitfalls too), but I'm not sure that this approach is
going to yield that value.

I had hoped that others more involved or interested in integrity
measurement might have weighed in on the discussion (hint, hint).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
