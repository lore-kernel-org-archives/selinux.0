Subject: Re: [PATCH] libsepol: fix version comparison when writing policies
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        SELinux List <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1161703230.3987.54.camel@moss-spartans.epoch.ncsc.mil>
References: <453E26D2.6050903@trustedcs.com>
	 <1161703230.3987.54.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 11:25:32 -0400
Message-Id: <1161703532.28993.11.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-24 at 11:20 -0400, Stephen Smalley wrote:
> On Tue, 2006-10-24 at 09:44 -0500, Darrel Goeddel wrote:
> > Fix a version comparison that prohibits the "old style" range transition
> > rules from being written for a version 5 base policy.
> > 
> > ---
> > 
> > diff -ruNp --exclude=.svn selinux-base/libsepol/src/write.c selinux/libsepol/src/write.c
> > --- selinux-base/libsepol/src/write.c	2006-10-24 09:35:46.000000000 -0500
> > +++ selinux/libsepol/src/write.c	2006-10-24 09:35:13.000000000 -0500
> > @@ -1641,7 +1641,7 @@ int policydb_write(policydb_t * p, struc
> >  	if ((p->policyvers >= POLICYDB_VERSION_MLS
> >  	     && p->policy_type == POLICY_KERN)
> >  	    || (p->policyvers >= MOD_POLICYDB_VERSION_MLS
> > -		&& p->policyvers < MOD_POLICYDB_VERSION_MLS
> > +		&& p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS
> >  		&& p->policy_type == POLICY_BASE)) {
> >  		if (range_write(p, fp)) {
> >  			return POLICYDB_ERROR;
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 

Acked-by: Joshua Brindle <jbrindle@tresys.com>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
