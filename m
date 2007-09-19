Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8JJaXdY030849
	for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2007 15:36:33 -0400
Received: from e36.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8JJaWYs002286
	for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2007 19:36:32 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8JJa5pp022558
	for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2007 15:36:05 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8JJa5uN464198
	for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2007 13:36:05 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8JJZslm026423
	for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2007 13:36:04 -0600
Subject: Re: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com,
        sailer@us.ibm.com
In-Reply-To: <1188382494.6129.35.camel@localhost.localdomain>
References: <1188340501.11528.14.camel@localhost.localdomain>
	 <46D4F337.1030704@manicmethod.com>
	 <1188382494.6129.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 15:41:23 -0400
Message-Id: <1190230883.7323.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-29 at 06:14 -0400, Mimi Zohar wrote:
> On Wed, 2007-08-29 at 00:16 -0400, Joshua Brindle wrote:
> > Mimi Zohar wrote:
> > 
> > > Index: linux-2.6.23-rc3-mm1/security/selinux/ss/services.c
> > > ===================================================================
> > > --- linux-2.6.23-rc3-mm1.orig/security/selinux/ss/services.c
> > > +++ linux-2.6.23-rc3-mm1/security/selinux/ss/services.c
> > > @@ -305,12 +305,12 @@ static int context_struct_compute_av(str
> > >  		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
> > >  			tclass = SECCLASS_NETLINK_SOCKET;
> > >  
> > > -	if (!tclass || tclass > policydb.p_classes.nprim) {
> > > -		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> > > -		       tclass);
> > > -		return -EINVAL;
> > > -	}
> > > -	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> > > +//	if (!tclass || tclass > policydb.p_classes.nprim) {
> > > +//		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> > > +//		       tclass);
> > > +//		return -EINVAL;
> > > +//	}
> > > +//	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> > >  
> > >   
> > 
> > Err? Did you mean to submit it like this? This should be fixed by Eric's 
> > patch to handle unknown classes anyway.
> 
> I'm working off the latest -mm tree and that patch hasn't made it in yet,
> as well as some other patches.  For example, additional security class 
> numbers have been defined.  So I will need to update SECCLASS_INTEGRITY
> as well. The above code was added in order to test the patch. Once the 
> basic integrity concept has been reviewed and accepted, I will repost 
> based on the latest selinux development source tree.

Ok, so how do I get the latest selinux development source tree?

Thanks!

Mimi Zohar


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
