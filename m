Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m17GF0pc030560
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 11:15:00 -0500
Received: from web36615.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m17GExuS001764
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 16:14:59 GMT
Date: Thu, 7 Feb 2008 08:14:41 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC][PATCH] selinux:  support 64-bit capabilities
To: Stephen Smalley <sds@tycho.nsa.gov>, "Serge E. Hallyn" <serue@us.ibm.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <1202397357.27371.246.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <863373.64505.qm@web36615.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> 
> On Thu, 2008-02-07 at 08:03 -0600, Serge E. Hallyn wrote:
> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > 
> > > On Thu, 2008-02-07 at 11:04 +1100, James Morris wrote:
> > > > On Wed, 6 Feb 2008, Stephen Smalley wrote:
> > > > 
> > > > > 
> > > > > > +	switch (CAP_TO_INDEX(cap)) {
> > > > > > +	case 0:
> > > > > > +		sclass = SECCLASS_CAPABILITY;
> > > > > > +		break;
> > > > > > +	case 1:
> > > > > > +		sclass = SECCLASS_CAPABILITY2;
> > > > > > +		break;
> > > > > > +	default:
> > > > > > +		return -EPERM;
> > > > > 
> > > > > Should likely make this something like:
> > > > > 	printk(KERN_WARNING "SELinux:  unknown capability %d\n", cap);
> > > > > 	if (selinux_enforcing)
> > > > > 		return -EPERM;
> > > > > 	else
> > > > > 		return 0;
> > > > > 
> > > > > Then, if/when people introduce capabilities without updating SELinux,
> > > > > we'll get a warning but permissive mode will allow the operation to
> > > > > proceed.
> > > > 
> > > > Agreed, perhaps also suggest upgrading policy in the message.
> > > 
> > > Policy upgrade won't help in that case - it requires code changes to
> > > allow SELinux to deal with higher capabilities beyond its supported
> > > range (the printk here is in the default: case, where we've gone beyond
> > > CAP_INDEX() of 0 or 1, i.e. capability value >= 64).
> > > 
> > > Alternatively, possibly we could cause a build failure in some way if
> > > CAP_INDEX(CAP_LAST_CAP) > 1, and make the default case a BUG().
> > 
> > That sounds good.  And maybe add a comment near CAP_LAST_CAP pointing
> > out that it's only responsible for any new caps to be added to
> > security/selinux/include/av_perm_to_string.h
> 
> Well, I think we'd just insert a polite request there to send an email
> to the SELinux maintainers and/or the entire LSM list to notify all LSM
> maintainers that they need to deal with a new capability.

That wouldn't be a bad idea, maybe put something in Documentation, too.

> We don't
> really want people directly patching the generated headers though - we
> need to keep them in sync with policy (and avoid the Fedora fiasco with
> taking permissions that never got reserved upstream in policy).

Yes, patching generated headers is a bad idea.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
