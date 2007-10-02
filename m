Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l92Mae09023647
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 18:36:40 -0400
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l92Macx6007956
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 22:36:38 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Eric Paris" <eparis@parisplace.org>
Subject: Re: [RFC PATCH v3 1/2] [SELINUX] Add a capabilities bitmap to SELinux policy version 22
Date: Tue, 2 Oct 2007 18:35:54 -0400
Cc: selinux@tycho.nsa.gov
References: <20071002183121.24760.92916.stgit@flek.americas.hpqcorp.net> <20071002183730.24760.37484.stgit@flek.americas.hpqcorp.net> <7e0fb38c0710021414u766766a7u9d619340d7ffc7b@mail.gmail.com>
In-Reply-To: <7e0fb38c0710021414u766766a7u9d619340d7ffc7b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710021835.54390.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 02 October 2007 5:14:52 pm Eric Paris wrote:
> >   /* Range of policy versions we understand*/
> >   #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> >   #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
> >   #define
> > POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
> > #else
> >  -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
> >  +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_POLCAP
> >   #endif
> >
> >   struct netlbl_lsm_secattr;
>
> This needs to be fixed and supported in security/selinux/Kconfig as well.

Didn't know that was there - thank you.

> >  +static ssize_t sel_read_policycap(struct file *file, char __user *buf,
> >  +				  size_t count, loff_t *ppos)
> >  +{
> >  +	int value;
> >  +	char tmpbuf[TMPBUFLEN];
> >  +	ssize_t length;
> >  +	unsigned long inode = file->f_path.dentry->d_inode->i_ino;
>
> can we call this i_ino please?  i know its a nit, but i was confused when i
> read the next line and initialy thought inode was a struct inode * like
> everywhere else

I'll make the change, but just because it's you :)

> >  +static int sel_make_policycap(void)
> >  +{
> >  +	unsigned int iter;
> >  +	struct dentry *dentry = NULL;
> >  +	struct inode *inode = NULL;
> >  +
> >  +	sel_remove_entries(policycap_dir);
> >  +
> >  +	for (iter = 0; iter <= POLICYDB_CAPABILITY_MAX; iter++) {
> >  +		if (iter <= ARRAY_SIZE(policycap_names))
>
> aren't these going to grow together and always
> array_size(policycap_names) == POLICYDB_CAP_MAX + 1 ??

Yes, technically this may be unnecessary, but I thought it might be a nice bit 
of added safety.

> assuming they were different, aren't you running one off the end of the
> policycap_names array?  Don't you need to be strictly < ARRAY_SIZE ?

Sure looks like it doesn't it - fixed.

> >  @@ -102,6 +107,11 @@ static struct policydb_compat_info
> > policydb_compat[] = { .sym_num        = SYM_NUM,
> >   		.ocon_num       = OCON_NUM,
> >   	},
> >  +	{
> >  +		.version        = POLICYDB_VERSION_POLCAP,
> >  +		.sym_num        = SYM_NUM,
> >  +		.ocon_num       = OCON_NUM,
> >  +	}
> >   };
>
> I don't care if policydb_compat[] does it wrong.  Tabs, not spaces.

I place the blame squarely on the "paste" functionality of my editor.  Bad 
editor! ... Bad! ... Bad! ... Bad!

> >  +int security_get_policycaps(int *len, int **values)
>
> Who is using this function?  ints just seem huge to hold one bit each  :(

Right now nobody, but I threw it in for future use since it seems reasonable 
to export a function so that the SELinux portions outside the security server 
could query the policy capability bitmap.  If you feel strongly about it I 
can rip it out and then we'll just add it back in later ... technically it is 
dead code I suppose.

> >  +{
> >  +	int rc = -ENOMEM;
> >  +	unsigned int iter;
> >  +
> >  +	POLICY_RDLOCK;
> >  +
> >  +	*values = kcalloc(POLICYDB_CAPABILITY_MAX, sizeof(int), GFP_ATOMIC);
>
> Depedning on who you think is going to use this, we might not need
> GFP_ATOMIC...

It seems safer and in keeping with the other related functions.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
