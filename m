Subject: Re: [RFC][PATCH] selinux:  support 64-bit capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <20080207140331.GB4058@sergelap.austin.ibm.com>
References: <1202314924.27371.163.camel@moss-spartans.epoch.ncsc.mil>
	 <1202322530.27371.171.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0802071102420.5800@us.intercode.com.au>
	 <1202392386.27371.199.camel@moss-spartans.epoch.ncsc.mil>
	 <20080207140331.GB4058@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 10:15:57 -0500
Message-Id: <1202397357.27371.246.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-07 at 08:03 -0600, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > 
> > On Thu, 2008-02-07 at 11:04 +1100, James Morris wrote:
> > > On Wed, 6 Feb 2008, Stephen Smalley wrote:
> > > 
> > > > 
> > > > > +	switch (CAP_TO_INDEX(cap)) {
> > > > > +	case 0:
> > > > > +		sclass = SECCLASS_CAPABILITY;
> > > > > +		break;
> > > > > +	case 1:
> > > > > +		sclass = SECCLASS_CAPABILITY2;
> > > > > +		break;
> > > > > +	default:
> > > > > +		return -EPERM;
> > > > 
> > > > Should likely make this something like:
> > > > 	printk(KERN_WARNING "SELinux:  unknown capability %d\n", cap);
> > > > 	if (selinux_enforcing)
> > > > 		return -EPERM;
> > > > 	else
> > > > 		return 0;
> > > > 
> > > > Then, if/when people introduce capabilities without updating SELinux,
> > > > we'll get a warning but permissive mode will allow the operation to
> > > > proceed.
> > > 
> > > Agreed, perhaps also suggest upgrading policy in the message.
> > 
> > Policy upgrade won't help in that case - it requires code changes to
> > allow SELinux to deal with higher capabilities beyond its supported
> > range (the printk here is in the default: case, where we've gone beyond
> > CAP_INDEX() of 0 or 1, i.e. capability value >= 64).
> > 
> > Alternatively, possibly we could cause a build failure in some way if
> > CAP_INDEX(CAP_LAST_CAP) > 1, and make the default case a BUG().
> 
> That sounds good.  And maybe add a comment near CAP_LAST_CAP pointing
> out that it's only responsible for any new caps to be added to
> security/selinux/include/av_perm_to_string.h

Well, I think we'd just insert a polite request there to send an email
to the SELinux maintainers and/or the entire LSM list to notify all LSM
maintainers that they need to deal with a new capability.  We don't
really want people directly patching the generated headers though - we
need to keep them in sync with policy (and avoid the Fedora fiasco with
taking permissions that never got reserved upstream in policy).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
