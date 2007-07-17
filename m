Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HEQK4l024037
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 10:26:30 -0400
Received: from e34.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HEQIbS001727
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 14:26:18 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6HEQIdi013753
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 10:26:18 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6HEQHLJ090470
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 08:26:17 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6HEQGCg010529
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 08:26:17 -0600
Subject: Re: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com
In-Reply-To: <200707161523.39706.paul.moore@hp.com>
References: <1184594240.5860.5.camel@localhost.localdomain>
	 <200707161523.39706.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 10:30:13 -0400
Message-Id: <1184682614.5929.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-07-16 at 15:23 -0400, Paul Moore wrote:
> On Monday, July 16 2007 9:57:20 am Mimi Zohar wrote:
> > Index: linux-2.6.22-rc6-mm1/security/selinux/hooks.c
> > ===================================================================
> > --- linux-2.6.22-rc6-mm1.orig/security/selinux/hooks.c
> > +++ linux-2.6.22-rc6-mm1/security/selinux/hooks.c
> > @@ -932,6 +917,19 @@ static int inode_doinit_with_dentry(stru
> >  			sid = sbsec->def_sid;
> >  			rc = 0;
> >  		} else {
> > +			/* Log integrity failures, if integrity enforced
> > +			 * behave like for any other failure.
> > +			 */
> > +			if (status == INTEGRITY_FAIL) {
> > +				printk(KERN_WARNING "%s: verify_metadata "
> > +				       "failed for dev=%s ino=%ld\n",
> > +					__FUNCTION__,
> > +					inode->i_sb->s_id, inode->i_ino);
> 
> Should this event be audited via the audit subsystem?  Or is it audited 
> elsewhere and I'm just missing it (I only saw a disabled block w/audit code).

No, it isn't being audited, but should be.  The question is what type of audit 
message would be appropriate here.  It could be the normal denied/granted 
message, but that would be confusing as this isn't based on a permission or 
capability check, but an integrity error.  Any suggestions how to handle this 
here and in the other places? 

Thanks! 

Mimi Zohar


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
