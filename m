Subject: Re: [RFC PATCH v2 1/2] [SELINUX] Add a capabilities bitmap to
	SELinux policy version 22
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
In-Reply-To: <46FADC17.8070606@manicmethod.com>
References: <20070926212810.15998.58788.stgit@flek.americas.hpqcorp.net>
	 <20070926213218.15998.48463.stgit@flek.americas.hpqcorp.net>
	 <46FADC17.8070606@manicmethod.com>
Content-Type: text/plain
Date: Thu, 27 Sep 2007 07:36:50 -0400
Message-Id: <1190893010.27038.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-26 at 18:24 -0400, Joshua Brindle wrote:
> Paul Moore wrote:
> > Add a new policy capabilities bitmap to SELinux policy version 22.  This bitmap
> > will enable the security server to query the policy to determine which features
> > it supports.
> > ---
> >
> >  security/selinux/include/security.h |   15 +++++-
> >  security/selinux/selinuxfs.c        |   90 +++++++++++++++++++++++++++++++++--
> >  security/selinux/ss/policydb.c      |   18 +++++++
> >  security/selinux/ss/policydb.h      |    2 +
> >  security/selinux/ss/services.c      |   39 +++++++++++++++
> >  5 files changed, 158 insertions(+), 6 deletions(-)
> >
> > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > index 83bdd4d..d7e6ed2 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -25,13 +25,14 @@
> >  #define POLICYDB_VERSION_MLS		19
> >  #define POLICYDB_VERSION_AVTAB		20
> >  #define POLICYDB_VERSION_RANGETRANS	21
> > +#define POLICYDB_VERSION_CAPBITMAP	22
> >  
> >   
> 
> I didn't like this name (I almost used it myself) because it sounds like 
> we are doing something with linux capabilities, I ended up using 
> POLICYDB_VERSION_PCAPS (for policy capabilities)

Doesn't help much; PCAP sounds like process capabilities, and
CAP_SETPCAP ;)  I don't think the name matters either way.

> >  /* Range of policy versions we understand*/
> >  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> >  #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
> >  #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
> >  #else
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
> >   
> 
> Hrm, I just used an ebitmap and didn't set a max at all.

ebitmaps are a security server internal construct; you have to export
them in a different form to users of the security server, like
selinuxfs, the hook functions, etc.  Or you'd have to move them out a
layer.

> 
> > +extern int selinux_policycap_netpeer;
> > +
> >  int security_load_policy(void * data, size_t len);
> >  
> > +int security_policycap_supported(unsigned int req_cap);
> > +
> >  #define SEL_VEC_MAX 32
> >  struct av_decision {
> >  	u32 allowed;
> > @@ -90,6 +102,7 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
> >  
> >  int security_get_classes(char ***classes, int *nclasses);
> >  int security_get_permissions(char *class, char ***perms, int *nperms);
> > +int security_get_policycaps(int *len, int **values);
> >  
> >   
> 
> We can fill in an array but I thought it'd be better just to use an 
> ebitmap and ebitmap_get_bit()

See above.

> 
> >  #define SECURITY_FS_USE_XATTR		1 /* use xattr */
> >  #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index c9e92da..c3e6f06 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -2,6 +2,11 @@
> >   *
> >   * 	Added conditional policy language extensions
> >   *
> > + *  Updated: Hewlett-Packard <paul.moore@hp.com>
> > + *
> > + *      Added support for the policy capability bitmap
> > + *
> > + * Copyright (C) 2007 Hewlett-Packard Development Company, L.P.
> >   * Copyright (C) 2003 - 2004 Tresys Technology, LLC
> >   * Copyright (C) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
> >   *	This program is free software; you can redistribute it and/or modify
> > @@ -35,6 +40,11 @@
> >  #include "objsec.h"
> >  #include "conditional.h"
> >  
> > +/* Policy capability filenames */
> > +static char *policycap_names[] = {
> > +	"network_peer_controls"
> > +};
> > +
> >  unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
> >  
> >  #ifdef CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT
> > @@ -71,6 +81,9 @@ static int *bool_pending_values = NULL;
> >  static struct dentry *class_dir = NULL;
> >  static unsigned long last_class_ino;
> >  
> > +/* global data for policy capabilities */
> > +static struct dentry *policycap_dir = NULL;
> > +
> >  extern void selnl_notify_setenforce(int val);
> >  
> >  /* Check whether a task is allowed to use a security operation. */
> > @@ -108,10 +121,11 @@ enum sel_inos {
> >  
> >  static unsigned long sel_last_ino = SEL_INO_NEXT - 1;
> >  
> > -#define SEL_INITCON_INO_OFFSET 	0x01000000
> > -#define SEL_BOOL_INO_OFFSET	0x02000000
> > -#define SEL_CLASS_INO_OFFSET	0x04000000
> > -#define SEL_INO_MASK		0x00ffffff
> > +#define SEL_INITCON_INO_OFFSET		0x01000000
> > +#define SEL_BOOL_INO_OFFSET		0x02000000
> > +#define SEL_CLASS_INO_OFFSET		0x04000000
> > +#define SEL_POLICYCAP_INO_OFFSET	0x08000000
> > +#define SEL_INO_MASK			0x00ffffff
> >   
> 
> whitespace changes?

Are ok to make them consistent when modifying the code (addition of
POLICYCAP_INO_OFFSET).

> 
> >  
> >  #define TMPBUFLEN	12
> >  static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
> > @@ -243,6 +257,7 @@ static const struct file_operations sel_policyvers_ops = {
> >  /* declaration for sel_write_load */
> >  static int sel_make_bools(void);
> >  static int sel_make_classes(void);
> > +static int sel_make_policycap(void);
> >  
> >  /* declaration for sel_make_class_dirs */
> >  static int sel_make_dir(struct inode *dir, struct dentry *dentry,
> > @@ -303,6 +318,12 @@ static ssize_t sel_write_load(struct file * file, const char __user * buf,
> >  	}
> >  
> >  	ret = sel_make_classes();
> > +	if (ret) {
> > +		length = ret;
> > +		goto out1;
> > +	}
> > +
> > +	ret = sel_make_policycap();
> >  	if (ret)
> >  		length = ret;
> >  	else
> > @@ -1384,6 +1405,25 @@ static const struct file_operations sel_perm_ops = {
> >  	.read		= sel_read_perm,
> >  };
> >  
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
> >   
> 
> Yea, I wondered how we were going to do this, we could have symbolic 
> names for each of them or we could just output offsets and let userspace 
> decipher it. I guess having symbolic names in a directory is better 
> (eg., /selinux/policy_caps/peersid_reconciliation)
> 
> >  static int sel_make_perm_files(char *objclass, int classvalue,
> >  				struct dentry *dir)
> >  {
> > @@ -1530,6 +1570,36 @@ out:
> >  	return rc;
> >  }
> >  
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
> >   
> 
> err, yea, agreed :)
> 
> >  static int sel_make_dir(struct inode *dir, struct dentry *dentry,
> >  			unsigned long *ino)
> >  {
> > @@ -1656,6 +1726,18 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
> >  
> >  	class_dir = dentry;
> >  
> > +	dentry = d_alloc_name(sb->s_root, "policy_capabilities");
> > +	if (!dentry) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	ret = sel_make_dir(root_inode, dentry, &sel_last_ino);
> > +	if (ret)
> > +		goto err;
> > +
> > +	policycap_dir = dentry;
> > +
> >  out:
> >  	return ret;
> >  err:
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index f05f97a..e85a479 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -13,6 +13,11 @@
> >   *
> >   * 	Added conditional policy language extensions
> >   *
> > + * Updated: Hewlett-Packard <paul.moore@hp.com>
> > + *
> > + *      Added support for the policy capability bitmap
> > + *
> > + * Copyright (C) 2007 Hewlett-Packard Development Company, L.P.
> >   * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
> >   * Copyright (C) 2003 - 2004 Tresys Technology, LLC
> >   *	This program is free software; you can redistribute it and/or modify
> > @@ -102,6 +107,11 @@ static struct policydb_compat_info policydb_compat[] = {
> >  		.sym_num        = SYM_NUM,
> >  		.ocon_num       = OCON_NUM,
> >  	},
> > +	{
> > +		.version        = POLICYDB_VERSION_CAPBITMAP,
> > +		.sym_num        = SYM_NUM,
> > +		.ocon_num       = OCON_NUM,
> > +	}
> >  };
> >  
> >  static struct policydb_compat_info *policydb_lookup_compat(int version)
> > @@ -183,6 +193,8 @@ static int policydb_init(struct policydb *p)
> >  	if (rc)
> >  		goto out_free_avtab;
> >  
> > +	ebitmap_init(&p->policycaps);
> > +
> >  out:
> >  	return rc;
> >  
> > @@ -677,6 +689,8 @@ void policydb_destroy(struct policydb *p)
> >  	}
> >  	kfree(p->type_attr_map);
> >  
> > +	ebitmap_destroy(&p->policycaps);
> > +
> >  	return;
> >  }
> >  
> > @@ -1531,6 +1545,10 @@ int policydb_read(struct policydb *p, void *fp)
> >  		}
> >  	}
> >  
> > +	if (p->policyvers >= POLICYDB_VERSION_CAPBITMAP &&
> > +	    ebitmap_read(&p->policycaps, fp) != 0)
> > +		goto bad;
> > +
> >  	info = policydb_lookup_compat(p->policyvers);
> >  	if (!info) {
> >  		printk(KERN_ERR "security:  unable to find policy compat info "
> > diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> > index 8319d5f..e621048 100644
> > --- a/security/selinux/ss/policydb.h
> > +++ b/security/selinux/ss/policydb.h
> > @@ -241,6 +241,8 @@ struct policydb {
> >  	/* type -> attribute reverse mapping */
> >  	struct ebitmap *type_attr_map;
> >  
> > +	struct ebitmap policycaps;
> > +
> >  	unsigned int policyvers;
> >  };
> >  
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 6100fc0..7d8c656 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -16,12 +16,13 @@
> >   * Updated: Hewlett-Packard <paul.moore@hp.com>
> >   *
> >   *      Added support for NetLabel
> > + *      Added support for the policy capability bitmap
> >   *
> >   * Updated: Chad Sellers <csellers@tresys.com>
> >   *
> >   *  Added validation of kernel classes and permissions
> >   *
> > - * Copyright (C) 2006 Hewlett-Packard Development Company, L.P.
> > + * Copyright (C) 2006 - 2007 Hewlett-Packard Development Company, L.P.
> >   * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
> >   * Copyright (C) 2003 - 2004, 2006 Tresys Technology, LLC
> >   * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
> > @@ -59,6 +60,8 @@
> >  extern void selnl_notify_policyload(u32 seqno);
> >  unsigned int policydb_loaded_version;
> >  
> > +int selinux_policycap_netpeer;
> > +
> >  /*
> >   * This is declared in avc.c
> >   */
> > @@ -1304,6 +1307,9 @@ int security_load_policy(void *data, size_t len)
> >  			return -EINVAL;
> >  		}
> >  		policydb_loaded_version = policydb.policyvers;
> > +		selinux_policycap_netpeer = 
> > +		  ebitmap_get_bit(&policydb.policycaps,
> > +				  POLICYDB_CAPABILITY_NETPEER);
> >  		ss_initialized = 1;
> >  		seqno = ++latest_granting;
> >  		LOAD_UNLOCK;
> > @@ -2102,6 +2108,37 @@ err:
> >  	return rc;
> >  }
> >  
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
> >   
> 
> Why do we want to write out to an array instead of just passing the 
> ebitmap around?

Because the callers don't know about ebitmaps and the ebitmap life cycle
is bound to the policy.

> 
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
> >   
> 
> Shouldn't this just check if policyvers > POLICYDB_VERSION_CAPBITMAP? it 
> could be inlined too.

It can't be inlined as it is a security server interface.

I suppose you could check the version first to see if it is < 22 and
always return 0 in that case without having to take the rdlock.

You could also extract the first word of the bitmap to a simple unsigned
long in the policydb at load time and do a direct bit test on it if
req_cap < (sizeof(unsigned long) * 8), without taking policy rdlock.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
