Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HEXpSk024713
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 10:33:51 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HEXnbS003313
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 14:33:49 GMT
From: Paul Moore <paul.moore@hp.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [RFC]integrity: SELinux patch
Date: Tue, 17 Jul 2007 10:32:32 -0400
Cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com
References: <1184594240.5860.5.camel@localhost.localdomain> <200707161523.39706.paul.moore@hp.com> <1184682614.5929.10.camel@localhost.localdomain>
In-Reply-To: <1184682614.5929.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707171032.32191.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, July 17 2007 10:30:13 am Mimi Zohar wrote:
> On Mon, 2007-07-16 at 15:23 -0400, Paul Moore wrote:
> > On Monday, July 16 2007 9:57:20 am Mimi Zohar wrote:
> > > Index: linux-2.6.22-rc6-mm1/security/selinux/hooks.c
> > > ===================================================================
> > > --- linux-2.6.22-rc6-mm1.orig/security/selinux/hooks.c
> > > +++ linux-2.6.22-rc6-mm1/security/selinux/hooks.c
> > > @@ -932,6 +917,19 @@ static int inode_doinit_with_dentry(stru
> > >  			sid = sbsec->def_sid;
> > >  			rc = 0;
> > >  		} else {
> > > +			/* Log integrity failures, if integrity enforced
> > > +			 * behave like for any other failure.
> > > +			 */
> > > +			if (status == INTEGRITY_FAIL) {
> > > +				printk(KERN_WARNING "%s: verify_metadata "
> > > +				       "failed for dev=%s ino=%ld\n",
> > > +					__FUNCTION__,
> > > +					inode->i_sb->s_id, inode->i_ino);
> >
> > Should this event be audited via the audit subsystem?  Or is it audited
> > elsewhere and I'm just missing it (I only saw a disabled block w/audit
> > code).
>
> No, it isn't being audited, but should be.  The question is what type of
> audit message would be appropriate here.  It could be the normal
> denied/granted message, but that would be confusing as this isn't based on
> a permission or capability check, but an integrity error.  Any suggestions
> how to handle this here and in the other places?

I would suggest asking some of the folks on the audit mailing list, 
linux-audit@redhat.com.  It doesn't have to be a deny/grant message like 
SELinux AVC messages to be "auditable".  Look at some of the other audit 
messages to get an idea.  The NetLabel code, for example, emits several audit 
messages which I would consider configuration notifications and not access 
control results.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
