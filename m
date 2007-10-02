Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l92LFSNV020098
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 17:15:28 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l92LFRdd003174
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 21:15:28 GMT
Received: by an-out-0708.google.com with SMTP id c38so690306ana
        for <selinux@tycho.nsa.gov>; Tue, 02 Oct 2007 14:14:53 -0700 (PDT)
Message-ID: <7e0fb38c0710021414u766766a7u9d619340d7ffc7b@mail.gmail.com>
Date: Tue, 2 Oct 2007 17:14:52 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Paul Moore" <paul.moore@hp.com>
Subject: Re: [RFC PATCH v3 1/2] [SELINUX] Add a capabilities bitmap to SELinux policy version 22
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20071002183730.24760.37484.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071002183121.24760.92916.stgit@flek.americas.hpqcorp.net>
	 <20071002183730.24760.37484.stgit@flek.americas.hpqcorp.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>  diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
>  index 83bdd4d..cc53ce4 100644
>  --- a/security/selinux/include/security.h
>  +++ b/security/selinux/include/security.h
>  @@ -25,13 +25,14 @@
>   #define POLICYDB_VERSION_MLS		19
>   #define POLICYDB_VERSION_AVTAB		20
>   #define POLICYDB_VERSION_RANGETRANS	21
>  +#define POLICYDB_VERSION_POLCAP		22
>
>   /* Range of policy versions we understand*/
>   #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
>   #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
>   #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
>   #else
>  -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
>  +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_POLCAP
>   #endif
>
>   struct netlbl_lsm_secattr;

This needs to be fixed and supported in security/selinux/Kconfig as well.


>  -#define SEL_INITCON_INO_OFFSET 	0x01000000
>  -#define SEL_BOOL_INO_OFFSET	0x02000000
>  -#define SEL_CLASS_INO_OFFSET	0x04000000
>  -#define SEL_INO_MASK		0x00ffffff
>  +#define SEL_INITCON_INO_OFFSET		0x01000000
>  +#define SEL_BOOL_INO_OFFSET		0x02000000
>  +#define SEL_CLASS_INO_OFFSET		0x04000000
>  +#define SEL_POLICYCAP_INO_OFFSET	0x08000000
>  +#define SEL_INO_MASK			0x00ffffff

I like it no matter what they say   :)

>  +static ssize_t sel_read_policycap(struct file *file, char __user *buf,
>  +				  size_t count, loff_t *ppos)
>  +{
>  +	int value;
>  +	char tmpbuf[TMPBUFLEN];
>  +	ssize_t length;
>  +	unsigned long inode = file->f_path.dentry->d_inode->i_ino;

can we call this i_ino please?  i know its a nit, but i was confused when i read
the next line and initialy thought inode was a struct inode * like everywhere
else

>  +
>  +	value = security_policycap_supported(inode & SEL_INO_MASK);
>  +	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", value);
>  +
>  +	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
>  +}
>  +
>  +static const struct file_operations sel_policycap_ops = {
>  +	.read		= sel_read_policycap,
>  +};
>  +
>   static int sel_make_perm_files(char *objclass, int classvalue,
>   				struct dentry *dir)
>   {
>  @@ -1530,6 +1569,36 @@ out:
>   	return rc;
>   }
>
>  +static int sel_make_policycap(void)
>  +{
>  +	unsigned int iter;
>  +	struct dentry *dentry = NULL;
>  +	struct inode *inode = NULL;
>  +
>  +	sel_remove_entries(policycap_dir);
>  +
>  +	for (iter = 0; iter <= POLICYDB_CAPABILITY_MAX; iter++) {
>  +		if (iter <= ARRAY_SIZE(policycap_names))

aren't these going to grow together and always
array_size(policycap_names) == POLICYDB_CAP_MAX + 1 ??

assuming they were different, aren't you running one off the end of the
policycap_names array?  Don't you need to be strictly < ARRAY_SIZE ?

[snip]

>  @@ -102,6 +107,11 @@ static struct policydb_compat_info policydb_compat[] = {
>   		.sym_num        = SYM_NUM,
>   		.ocon_num       = OCON_NUM,
>   	},
>  +	{
>  +		.version        = POLICYDB_VERSION_POLCAP,
>  +		.sym_num        = SYM_NUM,
>  +		.ocon_num       = OCON_NUM,
>  +	}
>   };

I don't care if policydb_compat[] does it wrong.  Tabs, not spaces.

[snip]

>  +int security_get_policycaps(int *len, int **values)

Who is using this function?  ints just seem huge to hold one bit each  :(

>  +{
>  +	int rc = -ENOMEM;
>  +	unsigned int iter;
>  +
>  +	POLICY_RDLOCK;
>  +
>  +	*values = kcalloc(POLICYDB_CAPABILITY_MAX, sizeof(int), GFP_ATOMIC);

Depedning on who you think is going to use this, we might not need GFP_ATOMIC...

>  +	if (*values == NULL)
>  +		goto out;
>  +	for (iter = 0; iter < POLICYDB_CAPABILITY_MAX; iter++)
>  +		(*values)[iter] = ebitmap_get_bit(&policydb.policycaps, iter);
>  +	*len = POLICYDB_CAPABILITY_MAX;
>  +
>  +out:
>  +	POLICY_RDUNLOCK;
>  +	return rc;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
