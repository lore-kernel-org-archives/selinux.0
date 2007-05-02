Subject: Re: [RFC] Ability to allow unknown class and permissions -v4
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>
In-Reply-To: <1178134459.3443.105.camel@moss-spartans.epoch.ncsc.mil>
References: <1178130337.3897.14.camel@dhcp59-235.rdu.redhat.com>
	 <1178134459.3443.105.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 02 May 2007 17:11:33 -0400
Message-Id: <1178140294.3897.22.camel@dhcp59-235.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-02 at 15:34 -0400, Stephen Smalley wrote:
> On Wed, 2007-05-02 at 14:25 -0400, Eric Paris wrote:

> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 40660ff..17c293c 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -322,6 +316,40 @@ static int context_struct_compute_av(struct context *scontext,
> >  	avd->seqno = latest_granting;
> >  
> >  	/*
> > +	 * Check if the class in question is a kernel class and if it
> > +	 * is defined in policy.  If yes to both it will pad the allow
> > +	 * for undefined perms if appropriate.
> > +	 */
> > +	if (unlikely(!tclass))
> > +		goto inval_class;
> > +	if (unlikely(tclass > policydb.p_classes.nprim)) {
> > +		if (tclass > kdefs->cts_len || (policydb.handle_unknown == DENY_UNKNOWN))
> > +			goto inval_class;
> > +		/* 
> > +		 * kernel class not in policy, but we
> > +		 * allow unknown, so let everything through
> > +		 */
> > +		if (kdefs->class_to_string[tclass - 1]) {
> > +			avd->allowed = 0xffffffff;
> > +			return 0;
> > +		}
> 
> Do you need to special case this vs. just filling in
> policydb.undefined_perms[] with ~0UL when the kernel class is not in
> policy and using it always?  With some rearrangement of the code to
> avoid duplication?
> Especially since you allocate the array to the number of kernel classes.
> 
> > +		/* 
> > +		 * this is a 'hole' in policy where a userspace
> > +		 * class exists
> > +		 */
> > +		goto inval_class;
> > +	}
> > +	if (tclass < kdefs->cts_len && (policydb.handle_unknown == ALLOW_UNKNOWN))
> > +		/* 
> > +		 * kernel class, defined in policy, allow unknown.
> > +		 * might have undefined permissions, so default 
> > +		 * those perms to allow
> > +		 */
> > +		avd->allowed = policydb.undefined_perms[tclass - 1];
> > +
> > +	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> > +
> > +	/*
> >  	 * If a specific type enforcement rule was defined for
> >  	 * this permission check, then use it.
> >  	 */


It does get rid of the special casing but it isn't much less complex.
Anyone see a way to make this bit better?

-Eric


@@ -322,6 +316,38 @@ static int context_struct_compute_av(struct context *scontext,
 	avd->seqno = latest_granting;
 
 	/*
+	 * Check for all the invalid cases.
+	 * - tclass 0
+	 * - tclass > policy and > kernel
+	 * - tclass > policy but is a userspace class
+	 * - tclass > policy but we do not allow unknowns
+	 */
+	if (unlikely(!tclass))
+		goto inval_class;
+	if (unlikely(tclass > policydb.p_class.nprim))
+		if (tclass > kdefs->cts_len || 
+		    !kdefs->class_to_string[tclass - 1] ||
+		    policydb.handle_unknown != ALLOW_UNKOWN)
+			goto inval_class;
+
+	/* 
+	 * Kernel class and we ALLOW_UNKNOWN so pad the allow decision 
+	 * the pad will be all 1 for unknown classes.
+	 */
+	if (tclass <= kdefs->cts_len && (policydb.handle_unknown == ALLOW_UNKNOWN))
+		avd->allowed = policydb.undefined_perms[tclass - 1];
+
+	/*
+	 * Kernel class not in policy and we ALLOW_UNKNOWN.  Since decision is 
+	 * completed return.
+	 */
+	if (unlikely(tclass > policydb.p_class.nprim &&
+		     tclass <= kdefs->cts_len))
+		return 0;
+
+	tclass_datum = policydb.class_val_to_struct[tclass - 1];
+
+	/*
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
 	 */



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
