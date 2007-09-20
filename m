Subject: Re: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        zohar@us.ibm.com, safford@watson.ibm.com, sailer@us.ibm.com
In-Reply-To: <1190235840.25863.98.camel@moss-spartans.epoch.ncsc.mil>
References: <1188340501.11528.14.camel@localhost.localdomain>
	 <46D4F337.1030704@manicmethod.com>
	 <1188382494.6129.35.camel@localhost.localdomain>
	 <1190230883.7323.3.camel@localhost.localdomain>
	 <1190235840.25863.98.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 21:34:18 -0400
Message-Id: <1190252058.7323.33.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-19 at 17:04 -0400, Stephen Smalley wrote:
> On Wed, 2007-09-19 at 15:41 -0400, Mimi Zohar wrote:
> > On Wed, 2007-08-29 at 06:14 -0400, Mimi Zohar wrote:
> > > On Wed, 2007-08-29 at 00:16 -0400, Joshua Brindle wrote:
> > > > Mimi Zohar wrote:
> > > > 
> > > > > Index: linux-2.6.23-rc3-mm1/security/selinux/ss/services.c
> > > > > ===================================================================
> > > > > --- linux-2.6.23-rc3-mm1.orig/security/selinux/ss/services.c
> > > > > +++ linux-2.6.23-rc3-mm1/security/selinux/ss/services.c
> > > > > @@ -305,12 +305,12 @@ static int context_struct_compute_av(str
> > > > >  		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
> > > > >  			tclass = SECCLASS_NETLINK_SOCKET;
> > > > >  
> > > > > -	if (!tclass || tclass > policydb.p_classes.nprim) {
> > > > > -		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> > > > > -		       tclass);
> > > > > -		return -EINVAL;
> > > > > -	}
> > > > > -	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> > > > > +//	if (!tclass || tclass > policydb.p_classes.nprim) {
> > > > > +//		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> > > > > +//		       tclass);
> > > > > +//		return -EINVAL;
> > > > > +//	}
> > > > > +//	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> > > > >  
> > > > >   
> > > > 
> > > > Err? Did you mean to submit it like this? This should be fixed by Eric's 
> > > > patch to handle unknown classes anyway.
> > > 
> > > I'm working off the latest -mm tree and that patch hasn't made it in yet,
> > > as well as some other patches.  For example, additional security class 
> > > numbers have been defined.  So I will need to update SECCLASS_INTEGRITY
> > > as well. The above code was added in order to test the patch. Once the 
> > > basic integrity concept has been reviewed and accepted, I will repost 
> > > based on the latest selinux development source tree.
> > 
> > Ok, so how do I get the latest selinux development source tree?
> 
> James Morris maintains a selinux git tree on kernel.org, but even that
> wouldn't yet have Eric's patch (that patch has been posted a few times
> on list, but there are still a couple of changes to be made).

I could post a patch without commenting out the above lines, so that when
Eric's patch does become available, there won't be any conflicts.  That 
still leaves the issue of which number to use when extending the object 
class in security/selinux/include/flask.h for integrity.  62 is not 
assigned in either the latest -mm or -git, but didn't someone already
post a patch on the SELinux mailing list using it?

Thanks!

Mimi Zohar


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
