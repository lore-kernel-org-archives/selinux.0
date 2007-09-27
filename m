Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8RJCuGe018471
	for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2007 15:12:56 -0400
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8RJCow1029031
	for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2007 19:12:51 GMT
From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: [RFC PATCH v2 1/2] [SELINUX] Add a capabilities bitmap to SELinux policy version 22
Date: Thu, 27 Sep 2007 07:46:22 -0400
Cc: selinux@tycho.nsa.gov
References: <20070926212810.15998.58788.stgit@flek.americas.hpqcorp.net> <20070926213218.15998.48463.stgit@flek.americas.hpqcorp.net> <46FADC17.8070606@manicmethod.com>
In-Reply-To: <46FADC17.8070606@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200709270746.22920.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 September 2007 6:24:23 pm Joshua Brindle wrote:
> Paul Moore wrote:
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -25,13 +25,14 @@
> >  #define POLICYDB_VERSION_MLS		19
> >  #define POLICYDB_VERSION_AVTAB		20
> >  #define POLICYDB_VERSION_RANGETRANS	21
> > +#define POLICYDB_VERSION_CAPBITMAP	22
>
> I didn't like this name (I almost used it myself) because it sounds like
> we are doing something with linux capabilities, I ended up using
> POLICYDB_VERSION_PCAPS (for policy capabilities)

Makes sense, I'll change it to your suggestion.

> >  /* Range of policy versions we understand*/
> >  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> >  #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
> >  #define
> > POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
> > #else
> > -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
> > +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_CAPBITMAP
> >  #endif
> >
> >  struct netlbl_lsm_secattr;
> > @@ -39,8 +40,19 @@ struct netlbl_lsm_secattr;
> >  extern int selinux_enabled;
> >  extern int selinux_mls_enabled;
> >
> > +/* Policy capabilities */
> > +enum {
> > +	POLICYDB_CAPABILITY_NETPEER,
> > +	__POLICYDB_CAPABILITY_MAX
> > +};
> > +#define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> > +
>
> Hrm, I just used an ebitmap and didn't set a max at all.

The "max" value is really just a sentinel value to make life easier in the 
code, it's not a limit of any sort.  Although it does have a side benefit of 
preventing kernels from having to worry about bitmap fields they don't 
understand which could provide some benefits for backwards compatibility.

> >  int security_get_classes(char ***classes, int *nclasses);
> >  int security_get_permissions(char *class, char ***perms, int *nperms);
> > +int security_get_policycaps(int *len, int **values);
>
> We can fill in an array but I thought it'd be better just to use an
> ebitmap and ebitmap_get_bit()

I use the ebitmap data type as much as possible, but keep in mind that the 
ebitmap type exists only inside the security server, i.e. 
security/selinux/ss/*, so any use/queries outside of the security server 
needs to deal with a more general type.  Look at the class and permission 
functions declared just about the policycaps function, they have the 
same/similar problem.

> > -#define SEL_INITCON_INO_OFFSET 	0x01000000
> > -#define SEL_BOOL_INO_OFFSET	0x02000000
> > -#define SEL_CLASS_INO_OFFSET	0x04000000
> > -#define SEL_INO_MASK		0x00ffffff
> > +#define SEL_INITCON_INO_OFFSET		0x01000000
> > +#define SEL_BOOL_INO_OFFSET		0x02000000
> > +#define SEL_CLASS_INO_OFFSET		0x04000000
> > +#define SEL_POLICYCAP_INO_OFFSET	0x08000000
> > +#define SEL_INO_MASK			0x00ffffff
>
> whitespace changes?

Yep, the columns didn't all line up when I added SEL_POLICYCAP_INO_OFFSET so I 
adjusted the rest.  I know you're not *supposed* to do such things, but it 
was bugging me ...

> > +static ssize_t sel_read_policycap(struct file *file, char __user *buf,
> > +				  size_t count, loff_t *ppos)
> > +{
> > +	int value;
> > +	char tmpbuf[TMPBUFLEN];
> > +	ssize_t length;
> > +	unsigned long inode = file->f_path.dentry->d_inode->i_ino;
> > +
> > +	value = security_policycap_supported(inode &
> > +					     (SEL_POLICYCAP_INO_OFFSET - 1));
> > +	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", value);
> > +
> > +	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
> > +}
> > +
> > +static const struct file_operations sel_policycap_ops = {
> > +	.read		= sel_read_policycap,
> > +};
> > +
>
> Yea, I wondered how we were going to do this, we could have symbolic
> names for each of them or we could just output offsets and let userspace
> decipher it. I guess having symbolic names in a directory is better
> (eg., /selinux/policy_caps/peersid_reconciliation)

Based on the discussion between Eric and Eamon I figured symbolic names would 
be better, even though it requires a little bit more work in the kernel.

> > +static int sel_make_policycap(void)
> > +{
> > +	unsigned int iter;
> > +	struct dentry *dentry = NULL;
> > +	struct inode *inode = NULL;
> > +
> > +	sel_remove_entries(policycap_dir);
> > +
> > +	for (iter = 0; iter <= POLICYDB_CAPABILITY_MAX; iter++) {
> > +		if (iter <= ARRAY_SIZE(policycap_names))
> > +			dentry = d_alloc_name(policycap_dir,
> > +					      policycap_names[iter]);
> > +		else
> > +			dentry = d_alloc_name(policycap_dir, "unknown");
> > +
> > +		if (dentry == NULL)
> > +			return -ENOMEM;
> > +
> > +		inode = sel_make_inode(policycap_dir->d_sb, S_IFREG | S_IRUGO);
> > +		if (inode == NULL)
> > +			return -ENOMEM;
> > +
> > +		inode->i_fop = &sel_policycap_ops;
> > +		inode->i_ino = iter | SEL_POLICYCAP_INO_OFFSET;
> > +		d_add(dentry, inode);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
>
> err, yea, agreed :)

Hopefully the cut 'n paste job wasn't too obvious :)

> > +int security_get_policycaps(int *len, int **values)
> > +{
> > +	int rc = -ENOMEM;
> > +	unsigned int iter;
> > +
> > +	POLICY_RDLOCK;
> > +
> > +	*values = kcalloc(POLICYDB_CAPABILITY_MAX, sizeof(int), GFP_ATOMIC);
> > +	if (*values == NULL)
> > +		goto out;
> > +	for (iter = 0; iter < POLICYDB_CAPABILITY_MAX; iter++)
> > +		(*values)[iter] = ebitmap_get_bit(&policydb.policycaps, iter);
> > +
> > +	*len = POLICYDB_CAPABILITY_MAX;
> > +
> > +out:
> > +	POLICY_RDUNLOCK;
> > +	return rc;
> > +}
> > +
>
> Why do we want to write out to an array instead of just passing the
> ebitmap around?

See my earlier comments about the scope of the ebitmap data type.

> > +int security_policycap_supported(unsigned int req_cap)
> > +{
> > +	int rc;
> > +
> > +	POLICY_RDLOCK;
> > +	rc = ebitmap_get_bit(&policydb.policycaps, req_cap);
> > +	POLICY_RDUNLOCK;
> > +
> > +	return rc;
> > +}
> > +
>
> Shouldn't this just check if policyvers > POLICYDB_VERSION_CAPBITMAP? it
> could be inlined too.

I'm not sure the check is needed, if the policy does not support the 
capability bitmap then the function will always return zero regardless of 
what capability is requested because the ebitmap will be empty.  A value of 
zero means the capability is not supported.

We shouldn't inline this function because it's intent is to provide an 
interface into the security server to query capabilities.  For example, code 
in the security/selinux/hooks.c file may need to check a specific capability 
but can't access the ebitmap directly so it would need to use this function.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
