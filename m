Subject: Re: [RFC][PATCH] selinux:  support 64-bit capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <47AA5664.8020903@manicmethod.com>
References: <1202314924.27371.163.camel@moss-spartans.epoch.ncsc.mil>
	 <1202322530.27371.171.camel@moss-spartans.epoch.ncsc.mil>
	 <47AA5664.8020903@manicmethod.com>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 08:55:34 -0500
Message-Id: <1202392534.27371.203.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-06 at 19:52 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Wed, 2008-02-06 at 11:22 -0500, Stephen Smalley wrote:
> >   
> >> 64-bit capability support has gone into mainline.
> >> Update SELinux to correctly handle 64-bit capabilities.
> >>
> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index e5ed075..fa4b021 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -1278,6 +1278,8 @@ static int task_has_capability(struct task_struct *tsk,
> >>  {
> >>  	struct task_security_struct *tsec;
> >>  	struct avc_audit_data ad;
> >> +	u16 sclass;
> >> +	u32 av = CAP_TO_MASK(cap);	
> >>  
> >>  	tsec = tsk->security;
> >>  
> >> @@ -1285,8 +1287,17 @@ static int task_has_capability(struct task_struct *tsk,
> >>  	ad.tsk = tsk;
> >>  	ad.u.cap = cap;
> >>  
> >> -	return avc_has_perm(tsec->sid, tsec->sid,
> >> -			    SECCLASS_CAPABILITY, CAP_TO_MASK(cap), &ad);
> >> +	switch (CAP_TO_INDEX(cap)) {
> >> +	case 0:
> >> +		sclass = SECCLASS_CAPABILITY;
> >> +		break;
> >> +	case 1:
> >> +		sclass = SECCLASS_CAPABILITY2;
> >> +		break;
> >> +	default:
> >> +		return -EPERM;
> >>     
> >
> > Should likely make this something like:
> > 	printk(KERN_WARNING "SELinux:  unknown capability %d\n", cap);
> > 	if (selinux_enforcing)
> > 		return -EPERM;
> > 	else
> > 		return 0;
> >
> > Then, if/when people introduce capabilities without updating SELinux,
> > we'll get a warning but permissive mode will allow the operation to
> > proceed.
> >
> >   
> 
> Are we going to do some magic in the toolchain to treat caps as 1 class 
> in source policy but split it up in binary? I remember that being a 
> possibility at some point.

We could, but at present, there are no capabilities > 31 that we care
about (mac_admin and mac_override are only used by other LSMs).

And the avc messages will still report them as capability or
capability2, with audit2allow turning that into distinct allow rules
unless we modify it to collapse them.

I'm not sure it really buys us much - it isn't that hard to just write
two allow rules for the distinct capability classes for the cases where
we actually want them both.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
