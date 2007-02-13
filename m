Subject: Re: [RFC] Ability to allow undefined permissions and classes -v2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1171309430.10871.2.camel@localhost.localdomain>
References: <1171309430.10871.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 07:27:53 -0500
Message-Id: <1171369673.3242.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-12 at 14:43 -0500, Eric Paris wrote:
> I started off doing as Stephen suggested and padding the avtab entries
> with permissions which were unknown to the kernel.  But upon (completing
> this implementation and then) re-reading the whole thread Stephen also
> mentioned the case where NO TE rules existed but we still would want to
> give a 'default' avd.allow which included undefined perms.  And when I
> went back to look at this I threw out all of my previous padding at load
> time.  Adding checks into context_struct_compute_av to see 'did we find
> any avtab entry' appeared to me that it would take more work than simply
> making the 'default' .allow created by context_struct_compute_av include
> all the undefined perms.  In doing this I was able to stop padding avtab
> entries on load.  Permission check time now has a single new if
> statement and simple |=.  Neither of which do I guess will have
> meaningful performance impact.

Fair enough.

> I do still have a problem.  I don't really understand the 'inherits'
> ideas and so I'm not sure how to pad my p->undefined_perms[tclass] with
> permissions which are missing in policy due to an incorrect or missing
> inherits statement.  If this approach seems good and reasonable I will
> try to better understand how I can glean those bits from
> validate_classes() and I will also move this to use config flags and
> have multiple options on how to handle policies.

Missing or incorrect inherits clause should remain fatal, I'd say - it
is too substantive a change to the class definition to expect a running
kernel to adapt.  Classes that inherit a common definition pick up their
initial set of permission bits from that common definition, such that
those bits are uniform across those classes and can be checked by a
single permission check (e.g. for common file or socket checks).  But as
soon as you remove or change them, in addition to removing all of those
inherited permissions, you will have disturbed the values of any
subsequent class-specific permissions.

> 
> Right now to make changes you need to:
> 
> echo 1 > /selinux/allow_unknown
> semodule -R
> 
> -Eric
> 

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ca9154d..e6a60a5 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -306,22 +306,30 @@ static int context_struct_compute_av(struct context *scontext,
>  		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
>  			tclass = SECCLASS_NETLINK_SOCKET;
>  
> -	if (!tclass || tclass > policydb.p_classes.nprim) {
> -		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> -		       tclass);
> -		return -EINVAL;
> -	}
> -	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> -
>  	/*
>  	 * Initialize the access vectors to the default values.
> +	 * This will pad the allow for undefined perms if appropriete.
>  	 */
> -	avd->allowed = 0;
> +	if(selinux_allow_unknown)
> +		avd->allowed = policydb.undefined_perms[tclass];

You moved the bounds checks on tclass down further, but here you use
tclass as an index.  Also, why [tclass] vs. [tclass-1] as in other code?
Aren't you wasting undefined_perms[0]?

> +	else
> +		avd->allowed = 0;
>  	avd->decided = 0xffffffff;
>  	avd->auditallow = 0;
>  	avd->auditdeny = 0xffffffff;
>  	avd->seqno = latest_granting;
>  
> +	if (!tclass || tclass > policydb.p_classes.nprim) {
> +		if(selinux_allow_unknown && tclass) {

Awkward - split up the original test.

> +			avd->allowed = 0xffffffff;
> +			return 0;
> +		}
> +		else {
> +			return -EINVAL;
> +		}
> +	}
> +	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> +
>  	/*
>  	 * If a specific type enforcement rule was defined for
>  	 * this permission check, then use it.
> @@ -1037,6 +1045,7 @@ int security_change_sid(u32 ssid,
>  static int validate_classes(struct policydb *p)
>  {
>  	int i, j;
> +	int rc = 0;
>  	struct class_datum *cladatum;
>  	struct perm_datum *perdatum;
>  	u32 nprim, tmp, common_pts_len, perm_val, pol_val;
> @@ -1045,6 +1054,19 @@ static int validate_classes(struct policydb *p)
>  	const char *def_class, *def_perm, *pol_class;
>  	struct symtab *perms;
>  
> +	if (selinux_allow_unknown) {
> +		int num_classes;

u32

> +		if (kdefs->cts_len > p->p_classes.nprim)
> +			num_classes = kdefs->cts_len;
> +		else
> +			num_classes = p->p_classes.nprim;
> +		p->undefined_perms = kzalloc(sizeof(u32)*num_classes, GFP_KERNEL);
> +		if (!p->undefined_perms) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +	}
> +
>  	for (i = 1; i < kdefs->cts_len; i++) {
>  		def_class = kdefs->class_to_string[i];
>  		if (i > p->p_classes.nprim) {
> @@ -1058,7 +1080,8 @@ static int validate_classes(struct policydb *p)
>  			printk(KERN_ERR
>  			       "security:  class %d is incorrect, found %s but should be %s\n",
>  			       i, pol_class, def_class);
> -			return -EINVAL;
> +			rc = -EINVAL;
> +			goto out;
>  		}
>  	}
>  	for (i = 0; i < kdefs->av_pts_len; i++) {
> @@ -1076,6 +1099,8 @@ static int validate_classes(struct policydb *p)
>  			printk(KERN_INFO
>  			       "security:  permission %s in class %s not defined in policy\n",
>  			       def_perm, pol_class);
> +			if (selinux_allow_unknown)
> +				p->undefined_perms[class_val] |= perm_val;
>  			continue;
>  		}
>  		perdatum = hashtab_search(perms->table, def_perm);
> @@ -1083,14 +1108,16 @@ static int validate_classes(struct policydb *p)
>  			printk(KERN_ERR
>  			       "security:  permission %s in class %s not found in policy\n",
>  			       def_perm, pol_class);
> -			return -EINVAL;
> +			rc = -EINVAL;
> +			goto out;

I would have thought that this also would have turned into a non-fatal
error if (selinux_allow_unknown).  No?


> @@ -1126,17 +1154,24 @@ static int validate_classes(struct policydb *p)
>  				printk(KERN_ERR
>  				       "security:  permission %s in class %s not found in policy\n",
>  				       def_perm, pol_class);
> -				return -EINVAL;
> +				rc = -EINVAL;
> +				goto out;

Ditto.

> +out:
> +	if (rc && selinux_allow_unknown) {
> +		kfree(p->undefined_perms);
> +		p->undefined_perms = NULL;

Is this necessary - it would be caught when the policydb is destroyed on
the final exit path of the caller, right?  Once we link something into a
policydb, we generally don't free it except upon policydb_destroy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
