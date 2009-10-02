Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n92Ltqjb017146
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 17:55:52 -0400
Received: from e36.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n92Lt4bx017380
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 21:55:04 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n92Lrm4Q015746
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 15:53:48 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n92Ltkjm227860
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 15:55:46 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n92LtjAK009526
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 15:55:45 -0600
Date: Fri, 2 Oct 2009 16:55:44 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 3/3] cr: add selinux support (v4)
Message-ID: <20091002215544.GA7446@us.ibm.com>
References: <20091002034916.GA16871@us.ibm.com> <20091002035250.GC16920@us.ibm.com> <1254488381.30591.316.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1254488381.30591.316.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> On Thu, 2009-10-01 at 22:52 -0500, Serge E. Hallyn wrote:
> > Documentation/checkpoint/readme.txt begins:
> > """
> > Application checkpoint/restart is the ability to save the state
> > of a running application so that it can later resume its execution
> > from the time at which it was checkpointed.
> > """
> > 
> > This patch adds the ability to checkpoint and restore selinux
> > contexts for tasks, open files, and sysvipc objects.  Contexts
> > are checkpointed as strings.  For tasks and files, where a security
> > struct actually points to several contexts, all contexts are
> > written out in one string, separated by ':::'.
> 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 8d8b69c..4fb8b5d 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2961,6 +2962,108 @@ static int selinux_file_permission(struct file *file, int mask)
> >  	return selinux_revalidate_file_permission(file, mask);
> >  }
> >  
> > +/*
> > + * for file context, we print both the fsec->sid and fsec->fown_sid
> > + * as string representations, separated by ':::'
> > + * We don't touch isid - if you wanted that set you shoulda set up the
> > + * fs correctly.
> > + */
> > +static inline char *selinux_file_checkpoint(void *security)

Thanks for looking it over again, Stephen.

> Why are these functions declared inline?  In any event, just let the
> compiler figure out when to make them inline if appropriate.

Yikes, I don't know.  Must have cut-n-pasted the prototypes from
include/linux/security.h.  Fixed below.

> > +static inline int selinux_file_restore(struct file *file, char *ctx)
> > +{
> > +	char *s1, *s2;
> > +	__u32 sid1 = 0, sid2 = 0;
> > +	int ret = -EINVAL;
> > +	struct file_security_struct *fsec = file->f_security;
> > +
> > +	/*
> > +	 * Objhash made sure the string is null-terminated.
> > +	 * We make a copy so we can mangle it.
> > +	 */
> > +	s1 = kstrdup(ctx, GFP_KERNEL);
> > +	if (!s1)
> > +		return -ENOMEM;
> > +	s2 = strstr(s1, ":::");
> > +	if (!s2)
> > +		goto out;
> > +
> > +	*s2 = '\0';
> > +	s2 += 3;
> > +	if (*s2 == '\0')
> > +		goto out;
> > +
> > +	/* SECSID_NULL is not valid for file sids */
> > +	if (strlen(s1) == 0 || strlen(s2) == 0)
> > +		goto out;
> > +
> > +	ret = security_context_to_sid(s1, strlen(s1), &sid1);
> > +	if (ret)
> > +		goto out;
> > +	ret = security_context_to_sid(s2, strlen(s2), &sid2);
> > +	if (ret)
> > +		goto out;
> > +
> > +	if (sid1 && fsec->sid != sid1) {
> > +		ret = avc_has_perm(current_sid(), sid1, SECCLASS_FILE,
> > +					FILE__RESTORE, NULL);
> > +		if (ret)
> > +			goto out;
> > +		fsec->sid = sid1;
> > +	}
> > +
> > +#if 0
> > +	/* The following must wait - bc we don't yet support
> > +	 * c/r of fowners. */
> > +	if (sid2 && fsec->fown_sid != sid2) {
> > +		ret = avc_has_perm(current_sid(), sid2, SECCLASS_FILE,
> > +				FILE__FOWN_RESTORE, NULL);
> > +		if (ret)
> > +			goto out;
> > +	       fsec->fown_sid = sid2;
> > +	}
> > +#endif
> 
> I'm not sure why you can't enable this code yet.  From your comment, it
> sounds like c/r doesn't yet handle the uid/euid in the fown_struct, but
> that doesn't mean you can't manage the fown_sid that we store in the
> file.  We just leveraged the fact that a fown_struct is never outside
> the context of a containing struct file (at least from a send_sigio
> context) to avoid introducing a separate security field with its own
> lifecycle there.

Ok, I enabled it (with no resulting problems).

> > @@ -3219,6 +3322,187 @@ static int selinux_task_create(unsigned long clone_flags)
> >  	return current_has_perm(current, PROCESS__FORK);
> >  }
> >  
> > +#define NUMTASKSIDS 6
> > +/*
> > + * for cred context, we print:
> > + *   osid, sid, exec_sid, create_sid, keycreate_sid, sockcreate_sid;
> > + * as string representations, separated by ':::'
> > + */
> > +static inline char *selinux_cred_checkpoint(void *security)
> > +{
> > +	struct task_security_struct *tsec = security;
> > +	char *stmp, *sfull = NULL;
> > +	__u32 slen, runlen;
> > +	int i, ret;
> > +	__u32 sids[NUMTASKSIDS] = { tsec->osid, tsec->sid, tsec->exec_sid,
> > +		tsec->create_sid, tsec->keycreate_sid, tsec->sockcreate_sid };
> 
> Why are you using __u32 rather than just u32?  I think the former is
> only necessary in certain headers that might be shared with userspace?

Changed below

> > +static inline int selinux_cred_restore(struct file *file, struct cred *cred,
> > +					char *ctx)
> > +{
> > +	char *s, *s1, *s2 = NULL;
> > +	int ret = -EINVAL;
> > +	struct task_security_struct *tsec = cred->security;
> > +	int i;
> > +	__u32 sids[NUMTASKSIDS];
> > +	struct inode *ctx_inode = file->f_dentry->d_inode;
> > +	struct avc_audit_data ad;
> 
> audit code was refactored in mainline to share common data structures
> and code among security modules, so e.g. this became common_audit_data.
> Not sure what your baseline is, but this happened in July.

It was merged by Linus on Sep 11, though, which is 2 days after our
latest c/r port to his tree :)

> 
> > +	/*
> > +	 * Check that these transitions are allowed, and effect them.
> > +	 * XXX: Do these checks suffice?
> > +	 */
> > +	if (tsec->osid != sids[0]) {
> > +		/*
> > +		 * Are any security decisions made based on osid?
> > +		 * Is it worth adding a PROCESS_RESTORE_OSID permission
> > +		 * for this?
> > +		 */
> > +		 tsec->osid = sids[0];
> 
> osid is only used in kernel permission checks upon a SID transition, and
> then it has been updated to ->sid prior to the transition.  Userspace
> however may use it in a permission check (obtained via getprevcon) on
> the caller when the program runs in its own domain, e.g. passwd(1).  I
> suppose there should be a check for it, although possibly it could be
> the same as for the ->sid (i.e. PROCESS__RESTORE).

Ok, done.

> > diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
> > index 31df1d7..78945e7 100644
> > --- a/security/selinux/include/av_perm_to_string.h
> > +++ b/security/selinux/include/av_perm_to_string.h
> <snip>
> 
> Just FYI, this file goes away with the dynamic class/perm discovery
> patch that I've been posting to selinux list.
> 
> > diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
> > index d645192..8e066ac 100644
> > --- a/security/selinux/include/av_permissions.h
> > +++ b/security/selinux/include/av_permissions.h
> <snip>
> 
> Likewise, this file goes away and is replaced by an automatically
> generated one from the new classmap.h file, which is the only kernel
> file you'll need to modify to add new permissions.

Ok, that's nice actually.

So I have some work to do when we re-base to Linus' tree, but in the
meantime, here is a version addressing the rest of the comments.  Or
would you prefer I wait and resend after a re-base?

thanks,
-serge
