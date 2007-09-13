Subject: Re: [PATCH] SELinux: whitespace fun
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1189689295.18713.30.camel@moss-spartans.epoch.ncsc.mil>
References: <1189097504.3418.22.camel@localhost.localdomain>
	 <1189689295.18713.30.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 13 Sep 2007 09:26:32 -0400
Message-Id: <1189689992.3391.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-13 at 09:14 -0400, Stephen Smalley wrote:
> On Thu, 2007-09-06 at 12:51 -0400, Eric Paris wrote:
> > Decided to fix a bunch of whitespace issues which had been nagging me.
> > Then I realized there were a lot more than I originally thought.  Most
> > places where a space could be replaced by a tab, I replaced it.  You
> > won't find any more "        " in the security directory.
> 
> Did you do this by hand or using a script?  If the latter, we can always
> just run that after we've merged any other pending patches to avoid
> disrupting them.

It was supposed to be small and by hand.  Turns out if was large and by
hand.  It's actually on top of most of my 'in flux' patches.  We could
just commit anything that doesn't get rejected and call it a win.

-Eric
> 
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > 
> > ---
> >  fs/super.c                             |    6 +-
> >  security/capability.c                  |    4 +-
> >  security/commoncap.c                   |    2 +-
> >  security/inode.c                       |   18 ++--
> >  security/keys/keyring.c                |    2 +-
> >  security/selinux/avc.c                 |   28 ++--
> >  security/selinux/hooks.c               |  216 ++++++++++++++++----------------
> >  security/selinux/include/avc.h         |   12 +-
> >  security/selinux/include/conditional.h |    2 +-
> >  security/selinux/include/netlabel.h    |    6 +-
> >  security/selinux/include/objsec.h      |   56 ++++----
> >  security/selinux/include/security.h    |    2 +-
> >  security/selinux/netif.c               |   10 +-
> >  security/selinux/netlabel.c            |    2 +-
> >  security/selinux/netlink.c             |    2 +-
> >  security/selinux/nlmsgtab.c            |    2 +-
> >  security/selinux/selinuxfs.c           |   10 +-
> >  security/selinux/ss/avtab.c            |    4 +-
> >  security/selinux/ss/avtab.h            |    4 +-
> >  security/selinux/ss/conditional.c      |    4 +-
> >  security/selinux/ss/conditional.h      |    4 +-
> >  security/selinux/ss/constraint.h       |    2 +-
> >  security/selinux/ss/context.h          |    2 +-
> >  security/selinux/ss/ebitmap.c          |    4 +-
> >  security/selinux/ss/hashtab.c          |    4 +-
> >  security/selinux/ss/hashtab.h          |    4 +-
> >  security/selinux/ss/mls.c              |   20 ++--
> >  security/selinux/ss/mls.h              |    4 +-
> >  security/selinux/ss/mls_types.h        |    4 +-
> >  security/selinux/ss/policydb.c         |   58 +++++-----
> >  security/selinux/ss/policydb.h         |   14 ++-
> >  security/selinux/ss/services.c         |   98 +++++++-------
> >  security/selinux/xfrm.c                |    2 +-
> >  33 files changed, 307 insertions(+), 305 deletions(-)
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index fc8ebed..d8b49ab 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -886,9 +886,9 @@ vfs_kern_mount(struct file_system_type *type, int flags, const char *name, void
> >  		goto out_free_secdata;
> >  	BUG_ON(!mnt->mnt_sb);
> >  
> > - 	error = security_sb_kern_mount(mnt->mnt_sb, secdata);
> > - 	if (error)
> > - 		goto out_sb;
> > +	error = security_sb_kern_mount(mnt->mnt_sb, secdata);
> > +	if (error)
> > +		goto out_sb;
> >  
> >  	mnt->mnt_mountpoint = mnt->mnt_root;
> >  	mnt->mnt_parent = mnt;
> > diff --git a/security/capability.c b/security/capability.c
> > index 38296a0..5f9e4f5 100644
> > --- a/security/capability.c
> > +++ b/security/capability.c
> > @@ -42,9 +42,9 @@ static struct security_operations capability_ops = {
> >  	.task_post_setuid =		cap_task_post_setuid,
> >  	.task_reparent_to_init =	cap_task_reparent_to_init,
> >  
> > -	.syslog =                       cap_syslog,
> > +	.syslog =			cap_syslog,
> >  
> > -	.vm_enough_memory =             cap_vm_enough_memory,
> > +	.vm_enough_memory =		cap_vm_enough_memory,
> >  };
> >  
> >  /* flag to keep track of how we were registered */
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index 7520361..06bb5e1 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -276,7 +276,7 @@ int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid,
> >  
> >  			/*
> >  			 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
> > -			 *          if not, we might be a bit too harsh here.
> > +			 *	   if not, we might be a bit too harsh here.
> >  			 */
> >  
> >  			if (!issecure (SECURE_NO_SETUID_FIXUP)) {
> > diff --git a/security/inode.c b/security/inode.c
> > index 307211a..a259d99 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -190,13 +190,13 @@ static int create_by_name(const char *name, mode_t mode,
> >   * @name: a pointer to a string containing the name of the file to create.
> >   * @mode: the permission that the file should have
> >   * @parent: a pointer to the parent dentry for this file.  This should be a
> > - *          directory dentry if set.  If this paramater is NULL, then the
> > - *          file will be created in the root of the securityfs filesystem.
> > + *	    directory dentry if set.  If this paramater is NULL, then the
> > + *	    file will be created in the root of the securityfs filesystem.
> >   * @data: a pointer to something that the caller will want to get to later
> > - *        on.  The inode.i_private pointer will point to this value on
> > - *        the open() call.
> > + *	  on.  The inode.i_private pointer will point to this value on
> > + *	  the open() call.
> >   * @fops: a pointer to a struct file_operations that should be used for
> > - *        this file.
> > + *	  this file.
> >   *
> >   * This is the basic "create a file" function for securityfs.  It allows for a
> >   * wide range of flexibility in createing a file, or a directory (if you
> > @@ -250,10 +250,10 @@ EXPORT_SYMBOL_GPL(securityfs_create_file);
> >   * securityfs_create_dir - create a directory in the securityfs filesystem
> >   *
> >   * @name: a pointer to a string containing the name of the directory to
> > - *        create.
> > + *	  create.
> >   * @parent: a pointer to the parent dentry for this file.  This should be a
> > - *          directory dentry if set.  If this paramater is NULL, then the
> > - *          directory will be created in the root of the securityfs filesystem.
> > + *	    directory dentry if set.  If this paramater is NULL, then the
> > + *	    directory will be created in the root of the securityfs filesystem.
> >   *
> >   * This function creates a directory in securityfs with the given name.
> >   *
> > @@ -279,7 +279,7 @@ EXPORT_SYMBOL_GPL(securityfs_create_dir);
> >   * securityfs_remove - removes a file or directory from the securityfs filesystem
> >   *
> >   * @dentry: a pointer to a the dentry of the file or directory to be
> > - *          removed.
> > + *	    removed.
> >   *
> >   * This function removes a file or directory in securityfs that was previously
> >   * created with a call to another securityfs function (like
> > diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> > index 88292e3..15837ca 100644
> > --- a/security/keys/keyring.c
> > +++ b/security/keys/keyring.c
> > @@ -303,7 +303,7 @@ key_ref_t keyring_search_aux(key_ref_t keyring_ref,
> >  	key_check(keyring);
> >  
> >  	/* top keyring must have search permission to begin the search */
> > -        err = key_task_permission(keyring_ref, context, KEY_SEARCH);
> > +	err = key_task_permission(keyring_ref, context, KEY_SEARCH);
> >  	if (err < 0) {
> >  		key_ref = ERR_PTR(err);
> >  		goto error;
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index 0e69adf..22d60ae 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -2,7 +2,7 @@
> >   * Implementation of the kernel access vector cache (AVC).
> >   *
> >   * Authors:  Stephen Smalley, <sds@epoch.ncsc.mil>
> > - *           James Morris <jmorris@redhat.com>
> > + *	     James Morris <jmorris@redhat.com>
> >   *
> >   * Update:   KaiGai, Kohei <kaigai@ak.jp.nec.com>
> >   *     Replaced the avc_lock spinlock by RCU.
> > @@ -11,7 +11,7 @@
> >   *
> >   *	This program is free software; you can redistribute it and/or modify
> >   *	it under the terms of the GNU General Public License version 2,
> > - *      as published by the Free Software Foundation.
> > + *	as published by the Free Software Foundation.
> >   */
> >  #include <linux/types.h>
> >  #include <linux/stddef.h>
> > @@ -92,7 +92,7 @@ struct avc_entry {
> >  struct avc_node {
> >  	struct avc_entry	ae;
> >  	struct list_head	list;
> > -	struct rcu_head         rhead;
> > +	struct rcu_head		rhead;
> >  };
> >  
> >  struct avc_cache {
> > @@ -105,8 +105,8 @@ struct avc_cache {
> >  
> >  struct avc_callback_node {
> >  	int (*callback) (u32 event, u32 ssid, u32 tsid,
> > -	                 u16 tclass, u32 perms,
> > -	                 u32 *out_retained);
> > +			 u16 tclass, u32 perms,
> > +			 u32 *out_retained);
> >  	u32 events;
> >  	u32 ssid;
> >  	u32 tsid;
> > @@ -526,8 +526,8 @@ static inline void avc_print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
> >   * before calling the auditing code.
> >   */
> >  void avc_audit(u32 ssid, u32 tsid,
> > -               u16 tclass, u32 requested,
> > -               struct av_decision *avd, int result, struct avc_audit_data *a)
> > +	       u16 tclass, u32 requested,
> > +	       struct av_decision *avd, int result, struct avc_audit_data *a)
> >  {
> >  	struct task_struct *tsk = current;
> >  	struct inode *inode = NULL;
> > @@ -541,7 +541,7 @@ void avc_audit(u32 ssid, u32 tsid,
> >  			return;
> >  	} else if (result) {
> >  		audited = denied = requested;
> > -        } else {
> > +	} else {
> >  		audited = requested;
> >  		if (!(audited & avd->auditallow))
> >  			return;
> > @@ -688,10 +688,10 @@ void avc_audit(u32 ssid, u32 tsid,
> >   * -%ENOMEM if insufficient memory exists to add the callback.
> >   */
> >  int avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
> > -                                     u16 tclass, u32 perms,
> > -                                     u32 *out_retained),
> > -                     u32 events, u32 ssid, u32 tsid,
> > -                     u16 tclass, u32 perms)
> > +				     u16 tclass, u32 perms,
> > +				     u32 *out_retained),
> > +		     u32 events, u32 ssid, u32 tsid,
> > +		     u16 tclass, u32 perms)
> >  {
> >  	struct avc_callback_node *c;
> >  	int rc = 0;
> > @@ -815,7 +815,7 @@ int avc_ss_reset(u32 seqno)
> >  	for (c = avc_callbacks; c; c = c->next) {
> >  		if (c->events & AVC_CALLBACK_RESET) {
> >  			tmprc = c->callback(AVC_CALLBACK_RESET,
> > -			                    0, 0, 0, 0, NULL);
> > +					    0, 0, 0, 0, NULL);
> >  			/* save the first error encountered for the return
> >  			   value and continue processing the callbacks */
> >  			if (!rc)
> > @@ -907,7 +907,7 @@ out:
> >   * another -errno upon other errors.
> >   */
> >  int avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
> > -                 u32 requested, struct avc_audit_data *auditdata)
> > +		 u32 requested, struct avc_audit_data *auditdata)
> >  {
> >  	struct av_decision avd;
> >  	int rc;
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 13cf4f1..d5cc7ad 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4,20 +4,20 @@
> >   *  This file contains the SELinux hook function implementations.
> >   *
> >   *  Authors:  Stephen Smalley, <sds@epoch.ncsc.mil>
> > - *            Chris Vance, <cvance@nai.com>
> > - *            Wayne Salamon, <wsalamon@nai.com>
> > - *            James Morris <jmorris@redhat.com>
> > + *	      Chris Vance, <cvance@nai.com>
> > + *	      Wayne Salamon, <wsalamon@nai.com>
> > + *	      James Morris <jmorris@redhat.com>
> >   *
> >   *  Copyright (C) 2001,2002 Networks Associates Technology, Inc.
> >   *  Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
> >   *  Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
> > - *                          <dgoeddel@trustedcs.com>
> > + *			    <dgoeddel@trustedcs.com>
> >   *  Copyright (C) 2006 Hewlett-Packard Development Company, L.P.
> > - *                     Paul Moore, <paul.moore@hp.com>
> > + *		       Paul Moore, <paul.moore@hp.com>
> >   *
> >   *	This program is free software; you can redistribute it and/or modify
> >   *	it under the terms of the GNU General Public License version 2,
> > - *      as published by the Free Software Foundation.
> > + *	as published by the Free Software Foundation.
> >   */
> >  
> >  #include <linux/module.h>
> > @@ -1106,7 +1106,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
> >  			rc = 0;
> >  		} else {
> >  			rc = security_context_to_sid_default(context, rc, &sid,
> > -			                                     sbsec->def_sid);
> > +							     sbsec->def_sid);
> >  			if (rc) {
> >  				printk(KERN_WARNING "%s:  context_to_sid(%s) "
> >  				       "returned %d for dev=%s ino=%ld\n",
> > @@ -1561,7 +1561,7 @@ static int selinux_ptrace(struct task_struct *parent, struct task_struct *child)
> >  }
> >  
> >  static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
> > -                          kernel_cap_t *inheritable, kernel_cap_t *permitted)
> > +			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
> >  {
> >  	int error;
> >  
> > @@ -1573,7 +1573,7 @@ static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
> >  }
> >  
> >  static int selinux_capset_check(struct task_struct *target, kernel_cap_t *effective,
> > -                                kernel_cap_t *inheritable, kernel_cap_t *permitted)
> > +				kernel_cap_t *inheritable, kernel_cap_t *permitted)
> >  {
> >  	int error;
> >  
> > @@ -1585,7 +1585,7 @@ static int selinux_capset_check(struct task_struct *target, kernel_cap_t *effect
> >  }
> >  
> >  static void selinux_capset_set(struct task_struct *target, kernel_cap_t *effective,
> > -                               kernel_cap_t *inheritable, kernel_cap_t *permitted)
> > +			       kernel_cap_t *inheritable, kernel_cap_t *permitted)
> >  {
> >  	secondary_ops->capset_set(target, effective, inheritable, permitted);
> >  }
> > @@ -1677,7 +1677,7 @@ static int selinux_sysctl(ctl_table *table, int op)
> >  		if (av)
> >  			error = avc_has_perm(tsec->sid, tsid,
> >  					     SECCLASS_FILE, av, NULL);
> > -        }
> > +	}
> >  
> >  	return error;
> >  }
> > @@ -1693,14 +1693,14 @@ static int selinux_quotactl(int cmds, int type, int id, struct super_block *sb)
> >  		case Q_SYNC:
> >  		case Q_QUOTAON:
> >  		case Q_QUOTAOFF:
> > -	        case Q_SETINFO:
> > +		case Q_SETINFO:
> >  		case Q_SETQUOTA:
> >  			rc = superblock_has_perm(current,
> >  						 sb,
> >  						 FILESYSTEM__QUOTAMOD, NULL);
> >  			break;
> > -	        case Q_GETFMT:
> > -	        case Q_GETINFO:
> > +		case Q_GETFMT:
> > +		case Q_GETINFO:
> >  		case Q_GETQUOTA:
> >  			rc = superblock_has_perm(current,
> >  						 sb,
> > @@ -1727,20 +1727,20 @@ static int selinux_syslog(int type)
> >  		return rc;
> >  
> >  	switch (type) {
> > -		case 3:         /* Read last kernel messages */
> > -		case 10:        /* Return size of the log buffer */
> > +		case 3:		/* Read last kernel messages */
> > +		case 10:	/* Return size of the log buffer */
> >  			rc = task_has_system(current, SYSTEM__SYSLOG_READ);
> >  			break;
> > -		case 6:         /* Disable logging to console */
> > -		case 7:         /* Enable logging to console */
> > +		case 6:		/* Disable logging to console */
> > +		case 7:		/* Enable logging to console */
> >  		case 8:		/* Set level of messages printed to console */
> >  			rc = task_has_system(current, SYSTEM__SYSLOG_CONSOLE);
> >  			break;
> > -		case 0:         /* Close log */
> > -		case 1:         /* Open log */
> > -		case 2:         /* Read from log */
> > -		case 4:         /* Read/clear last kernel messages */
> > -		case 5:         /* Clear ring buffer */
> > +		case 0:		/* Close log */
> > +		case 1:		/* Open log */
> > +		case 2:		/* Read from log */
> > +		case 4:		/* Read/clear last kernel messages */
> > +		case 5:		/* Clear ring buffer */
> >  		default:
> >  			rc = task_has_system(current, SYSTEM__SYSLOG_MOD);
> >  			break;
> > @@ -1834,7 +1834,7 @@ static int selinux_bprm_set_security(struct linux_binprm *bprm)
> >  	} else {
> >  		/* Check for a default transition on this program. */
> >  		rc = security_transition_sid(tsec->sid, isec->sid,
> > -		                             SECCLASS_PROCESS, &newsid);
> > +					     SECCLASS_PROCESS, &newsid);
> >  		if (rc)
> >  			return rc;
> >  	}
> > @@ -1846,7 +1846,7 @@ static int selinux_bprm_set_security(struct linux_binprm *bprm)
> >  	if (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)
> >  		newsid = tsec->sid;
> >  
> > -        if (tsec->sid == newsid) {
> > +	if (tsec->sid == newsid) {
> >  		rc = avc_has_perm(tsec->sid, isec->sid,
> >  				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
> >  		if (rc)
> > @@ -2141,8 +2141,8 @@ static inline int match_prefix(char *prefix, int plen, char *option, int olen)
> >  static inline int selinux_option(char *option, int len)
> >  {
> >  	return (match_prefix("context=", sizeof("context=")-1, option, len) ||
> > -	        match_prefix("fscontext=", sizeof("fscontext=")-1, option, len) ||
> > -	        match_prefix("defcontext=", sizeof("defcontext=")-1, option, len) ||
> > +		match_prefix("fscontext=", sizeof("fscontext=")-1, option, len) ||
> > +		match_prefix("defcontext=", sizeof("defcontext=")-1, option, len) ||
> >  		match_prefix("rootcontext=", sizeof("rootcontext=")-1, option, len));
> >  }
> >  
> > @@ -2158,7 +2158,7 @@ static inline void take_option(char **to, char *from, int *first, int len)
> >  }
> >  
> >  static inline void take_selinux_option(char **to, char *from, int *first, 
> > -		                       int len)
> > +				       int len)
> >  {
> >  	int current_size = 0;
> >  
> > @@ -2251,10 +2251,10 @@ static int selinux_sb_statfs(struct dentry *dentry)
> >  }
> >  
> >  static int selinux_mount(char * dev_name,
> > -                         struct nameidata *nd,
> > -                         char * type,
> > -                         unsigned long flags,
> > -                         void * data)
> > +			 struct nameidata *nd,
> > +			 char * type,
> > +			 unsigned long flags,
> > +			 void * data)
> >  {
> >  	int rc;
> >  
> > @@ -2264,10 +2264,10 @@ static int selinux_mount(char * dev_name,
> >  
> >  	if (flags & MS_REMOUNT)
> >  		return superblock_has_perm(current, nd->mnt->mnt_sb,
> > -		                           FILESYSTEM__REMOUNT, NULL);
> > +					   FILESYSTEM__REMOUNT, NULL);
> >  	else
> >  		return dentry_has_perm(current, nd->mnt, nd->dentry,
> > -		                       FILE__MOUNTON);
> > +				       FILE__MOUNTON);
> >  }
> >  
> >  static int selinux_umount(struct vfsmount *mnt, int flags)
> > @@ -2279,7 +2279,7 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
> >  		return rc;
> >  
> >  	return superblock_has_perm(current,mnt->mnt_sb,
> > -	                           FILESYSTEM__UNMOUNT,NULL);
> > +				   FILESYSTEM__UNMOUNT,NULL);
> >  }
> >  
> >  /* inode security operations */
> > @@ -2408,7 +2408,7 @@ static int selinux_inode_mknod(struct inode *dir, struct dentry *dentry, int mod
> >  }
> >  
> >  static int selinux_inode_rename(struct inode *old_inode, struct dentry *old_dentry,
> > -                                struct inode *new_inode, struct dentry *new_dentry)
> > +				struct inode *new_inode, struct dentry *new_dentry)
> >  {
> >  	return may_rename(old_inode, old_dentry, new_inode, new_dentry);
> >  }
> > @@ -2518,7 +2518,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, char *name, void *value
> >  		return rc;
> >  
> >  	rc = security_validate_transition(isec->sid, newsid, tsec->sid,
> > -	                                  isec->sclass);
> > +					  isec->sclass);
> >  	if (rc)
> >  		return rc;
> >  
> > @@ -2530,7 +2530,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, char *name, void *value
> >  }
> >  
> >  static void selinux_inode_post_setxattr(struct dentry *dentry, char *name,
> > -                                        void *value, size_t size, int flags)
> > +					void *value, size_t size, int flags)
> >  {
> >  	struct inode *inode = dentry->d_inode;
> >  	struct inode_security_struct *isec = inode->i_security;
> > @@ -2608,7 +2608,7 @@ static int selinux_inode_getsecurity(const struct inode *inode, const char *name
> >  }
> >  
> >  static int selinux_inode_setsecurity(struct inode *inode, const char *name,
> > -                                     const void *value, size_t size, int flags)
> > +				     const void *value, size_t size, int flags)
> >  {
> >  	struct inode_security_struct *isec = inode->i_security;
> >  	u32 newsid;
> > @@ -2701,8 +2701,8 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
> >  			error = file_has_perm(current, file, 0);
> >  			break;
> >  
> > -	        case KDSKBENT:
> > -	        case KDSKBSENT:
> > +		case KDSKBENT:
> > +		case KDSKBSENT:
> >  			error = task_has_capability(current,CAP_SYS_TTY_CONFIG);
> >  			break;
> >  
> > @@ -2821,7 +2821,7 @@ static int selinux_file_fcntl(struct file *file, unsigned int cmd,
> >  	int err = 0;
> >  
> >  	switch (cmd) {
> > -	        case F_SETFL:
> > +		case F_SETFL:
> >  			if (!file->f_path.dentry || !file->f_path.dentry->d_inode) {
> >  				err = -EINVAL;
> >  				break;
> > @@ -2832,21 +2832,21 @@ static int selinux_file_fcntl(struct file *file, unsigned int cmd,
> >  				break;
> >  			}
> >  			/* fall through */
> > -	        case F_SETOWN:
> > -	        case F_SETSIG:
> > -	        case F_GETFL:
> > -	        case F_GETOWN:
> > -	        case F_GETSIG:
> > +		case F_SETOWN:
> > +		case F_SETSIG:
> > +		case F_GETFL:
> > +		case F_GETOWN:
> > +		case F_GETSIG:
> >  			/* Just check FD__USE permission */
> >  			err = file_has_perm(current, file, 0);
> >  			break;
> >  		case F_GETLK:
> >  		case F_SETLK:
> > -	        case F_SETLKW:
> > +		case F_SETLKW:
> >  #if BITS_PER_LONG == 32
> > -	        case F_GETLK64:
> > +		case F_GETLK64:
> >  		case F_SETLK64:
> > -	        case F_SETLKW64:
> > +		case F_SETLKW64:
> >  #endif
> >  			if (!file->f_path.dentry || !file->f_path.dentry->d_inode) {
> >  				err = -EINVAL;
> > @@ -2874,13 +2874,13 @@ static int selinux_file_set_fowner(struct file *file)
> >  static int selinux_file_send_sigiotask(struct task_struct *tsk,
> >  				       struct fown_struct *fown, int signum)
> >  {
> > -        struct file *file;
> > +	struct file *file;
> >  	u32 perm;
> >  	struct task_security_struct *tsec;
> >  	struct file_security_struct *fsec;
> >  
> >  	/* struct fown_struct is never outside the context of a struct file */
> > -        file = container_of(fown, struct file, f_owner);
> > +	file = container_of(fown, struct file, f_owner);
> >  
> >  	tsec = tsk->security;
> >  	fsec = file->f_security;
> > @@ -3143,11 +3143,11 @@ static int selinux_parse_skb_ipv4(struct sk_buff *skb,
> >  		*proto = ih->protocol;
> >  
> >  	switch (ih->protocol) {
> > -        case IPPROTO_TCP: {
> > -        	struct tcphdr _tcph, *th;
> > +	case IPPROTO_TCP: {
> > +		struct tcphdr _tcph, *th;
> >  
> > -        	if (ntohs(ih->frag_off) & IP_OFFSET)
> > -        		break;
> > +		if (ntohs(ih->frag_off) & IP_OFFSET)
> > +			break;
> >  
> >  		offset += ihlen;
> >  		th = skb_header_pointer(skb, offset, sizeof(_tcph), &_tcph);
> > @@ -3157,23 +3157,23 @@ static int selinux_parse_skb_ipv4(struct sk_buff *skb,
> >  		ad->u.net.sport = th->source;
> >  		ad->u.net.dport = th->dest;
> >  		break;
> > -        }
> > -        
> > -        case IPPROTO_UDP: {
> > -        	struct udphdr _udph, *uh;
> > -        	
> > -        	if (ntohs(ih->frag_off) & IP_OFFSET)
> > -        		break;
> > -        		
> > +	}
> > +	
> > +	case IPPROTO_UDP: {
> > +		struct udphdr _udph, *uh;
> > +		
> > +		if (ntohs(ih->frag_off) & IP_OFFSET)
> > +			break;
> > +			
> >  		offset += ihlen;
> > -        	uh = skb_header_pointer(skb, offset, sizeof(_udph), &_udph);
> > +		uh = skb_header_pointer(skb, offset, sizeof(_udph), &_udph);
> >  		if (uh == NULL)
> >  			break;	
> >  
> > -        	ad->u.net.sport = uh->source;
> > -        	ad->u.net.dport = uh->dest;
> > -        	break;
> > -        }
> > +		ad->u.net.sport = uh->source;
> > +		ad->u.net.dport = uh->dest;
> > +		break;
> > +	}
> >  
> >  	case IPPROTO_DCCP: {
> >  		struct dccp_hdr _dccph, *dh;
> > @@ -3189,11 +3189,11 @@ static int selinux_parse_skb_ipv4(struct sk_buff *skb,
> >  		ad->u.net.sport = dh->dccph_sport;
> >  		ad->u.net.dport = dh->dccph_dport;
> >  		break;
> > -        }
> > +	}
> >  
> > -        default:
> > -        	break;
> > -        }
> > +	default:
> > +		break;
> > +	}
> >  out:
> >  	return ret;
> >  }
> > @@ -3228,7 +3228,7 @@ static int selinux_parse_skb_ipv6(struct sk_buff *skb,
> >  
> >  	switch (nexthdr) {
> >  	case IPPROTO_TCP: {
> > -        	struct tcphdr _tcph, *th;
> > +		struct tcphdr _tcph, *th;
> >  
> >  		th = skb_header_pointer(skb, offset, sizeof(_tcph), &_tcph);
> >  		if (th == NULL)
> > @@ -3261,7 +3261,7 @@ static int selinux_parse_skb_ipv6(struct sk_buff *skb,
> >  		ad->u.net.sport = dh->dccph_sport;
> >  		ad->u.net.dport = dh->dccph_dport;
> >  		break;
> > -        }
> > +	}
> >  
> >  	/* includes fragments */
> >  	default:
> > @@ -3498,7 +3498,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
> >  			ipv6_addr_copy(&ad.u.net.v6info.saddr, &addr6->sin6_addr);
> >  
> >  		err = avc_has_perm(isec->sid, sid,
> > -		                   isec->sclass, node_perm, &ad);
> > +				   isec->sclass, node_perm, &ad);
> >  		if (err)
> >  			goto out;
> >  	}
> > @@ -3768,8 +3768,8 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
> >  		u32 port_sid;
> >  
> >  		err = security_port_sid(sk->sk_family, sk->sk_type,
> > -		                        sk->sk_protocol, ntohs(ad->u.net.sport),
> > -		                        &port_sid);
> > +					sk->sk_protocol, ntohs(ad->u.net.sport),
> > +					&port_sid);
> >  		if (err)
> >  			goto out;
> >  
> > @@ -4086,10 +4086,10 @@ static int selinux_ip_postroute_last_compat(struct sock *sk, struct net_device *
> >  		u32 port_sid;
> >  		
> >  		err = security_port_sid(sk->sk_family,
> > -		                        sk->sk_type,
> > -		                        sk->sk_protocol,
> > -		                        ntohs(ad->u.net.dport),
> > -		                        &port_sid);
> > +					sk->sk_type,
> > +					sk->sk_protocol,
> > +					ntohs(ad->u.net.dport),
> > +					&port_sid);
> >  		if (err)
> >  			goto out;
> >  
> > @@ -4101,11 +4101,11 @@ out:
> >  }
> >  
> >  static unsigned int selinux_ip_postroute_last(unsigned int hooknum,
> > -                                              struct sk_buff **pskb,
> > -                                              const struct net_device *in,
> > -                                              const struct net_device *out,
> > -                                              int (*okfn)(struct sk_buff *),
> > -                                              u16 family)
> > +					      struct sk_buff **pskb,
> > +					      const struct net_device *in,
> > +					      const struct net_device *out,
> > +					      int (*okfn)(struct sk_buff *),
> > +					      u16 family)
> >  {
> >  	char *addrp;
> >  	int len, err = 0;
> > @@ -4196,7 +4196,7 @@ static int selinux_netlink_recv(struct sk_buff *skb, int capability)
> >  	ad.u.cap = capability;
> >  
> >  	return avc_has_perm(NETLINK_CB(skb).sid, NETLINK_CB(skb).sid,
> > -	                    SECCLASS_CAPABILITY, CAP_TO_MASK(capability), &ad);
> > +			    SECCLASS_CAPABILITY, CAP_TO_MASK(capability), &ad);
> >  }
> >  
> >  static int ipc_alloc_security(struct task_struct *task,
> > @@ -4661,7 +4661,7 @@ static int selinux_unregister_security (const char *name, struct security_operat
> >  {
> >  	if (ops != secondary_ops) {
> >  		printk(KERN_ERR "%s:  trying to unregister a security module "
> > -		        "that is not registered.\n", __FUNCTION__);
> > +			"that is not registered.\n", __FUNCTION__);
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -4797,11 +4797,11 @@ static int selinux_setprocattr(struct task_struct *p,
> >  				}
> >  			while_each_thread(g, t);
> >  			read_unlock(&tasklist_lock);
> > -                }
> > +		}
> >  
> >  		/* Check permissions for the transition. */
> >  		error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
> > -		                     PROCESS__DYNTRANSITION, NULL);
> > +				     PROCESS__DYNTRANSITION, NULL);
> >  		if (error)
> >  			return error;
> >  
> > @@ -4908,7 +4908,7 @@ static struct security_operations selinux_ops = {
> >  	.vm_enough_memory =		selinux_vm_enough_memory,
> >  
> >  	.netlink_send =			selinux_netlink_send,
> > -        .netlink_recv =			selinux_netlink_recv,
> > +	.netlink_recv =			selinux_netlink_recv,
> >  
> >  	.bprm_alloc_security =		selinux_bprm_alloc_security,
> >  	.bprm_free_security =		selinux_bprm_free_security,
> > @@ -4921,7 +4921,7 @@ static struct security_operations selinux_ops = {
> >  	.sb_alloc_security =		selinux_sb_alloc_security,
> >  	.sb_free_security =		selinux_sb_free_security,
> >  	.sb_copy_data =			selinux_sb_copy_data,
> > -	.sb_kern_mount =	        selinux_sb_kern_mount,
> > +	.sb_kern_mount =		selinux_sb_kern_mount,
> >  	.sb_statfs =			selinux_sb_statfs,
> >  	.sb_mount =			selinux_mount,
> >  	.sb_umount =			selinux_umount,
> > @@ -4950,10 +4950,10 @@ static struct security_operations selinux_ops = {
> >  	.inode_getxattr =		selinux_inode_getxattr,
> >  	.inode_listxattr =		selinux_inode_listxattr,
> >  	.inode_removexattr =		selinux_inode_removexattr,
> > -	.inode_xattr_getsuffix =        selinux_inode_xattr_getsuffix,
> > -	.inode_getsecurity =            selinux_inode_getsecurity,
> > -	.inode_setsecurity =            selinux_inode_setsecurity,
> > -	.inode_listsecurity =           selinux_inode_listsecurity,
> > +	.inode_xattr_getsuffix =	selinux_inode_xattr_getsuffix,
> > +	.inode_getsecurity =		selinux_inode_getsecurity,
> > +	.inode_setsecurity =		selinux_inode_setsecurity,
> > +	.inode_listsecurity =		selinux_inode_listsecurity,
> >  
> >  	.file_permission =		selinux_file_permission,
> >  	.file_alloc_security =		selinux_file_alloc_security,
> > @@ -4975,7 +4975,7 @@ static struct security_operations selinux_ops = {
> >  	.task_setgid =			selinux_task_setgid,
> >  	.task_setpgid =			selinux_task_setpgid,
> >  	.task_getpgid =			selinux_task_getpgid,
> > -	.task_getsid =		        selinux_task_getsid,
> > +	.task_getsid =			selinux_task_getsid,
> >  	.task_getsecid =		selinux_task_getsecid,
> >  	.task_setgroups =		selinux_task_setgroups,
> >  	.task_setnice =			selinux_task_setnice,
> > @@ -4989,7 +4989,7 @@ static struct security_operations selinux_ops = {
> >  	.task_wait =			selinux_task_wait,
> >  	.task_prctl =			selinux_task_prctl,
> >  	.task_reparent_to_init =	selinux_task_reparent_to_init,
> > -	.task_to_inode =                selinux_task_to_inode,
> > +	.task_to_inode =		selinux_task_to_inode,
> >  
> >  	.ipc_permission =		selinux_ipc_permission,
> >  
> > @@ -5018,15 +5018,15 @@ static struct security_operations selinux_ops = {
> >  	.register_security =		selinux_register_security,
> >  	.unregister_security =		selinux_unregister_security,
> >  
> > -	.d_instantiate =                selinux_d_instantiate,
> > +	.d_instantiate =		selinux_d_instantiate,
> >  
> > -	.getprocattr =                  selinux_getprocattr,
> > -	.setprocattr =                  selinux_setprocattr,
> > +	.getprocattr =			selinux_getprocattr,
> > +	.setprocattr =			selinux_setprocattr,
> >  
> >  	.secid_to_secctx =		selinux_secid_to_secctx,
> >  	.release_secctx =		selinux_release_secctx,
> >  
> > -        .unix_stream_connect =		selinux_socket_unix_stream_connect,
> > +	.unix_stream_connect =		selinux_socket_unix_stream_connect,
> >  	.unix_may_send =		selinux_socket_unix_may_send,
> >  
> >  	.socket_create =		selinux_socket_create,
> > @@ -5069,9 +5069,9 @@ static struct security_operations selinux_ops = {
> >  #endif
> >  
> >  #ifdef CONFIG_KEYS
> > -	.key_alloc =                    selinux_key_alloc,
> > -	.key_free =                     selinux_key_free,
> > -	.key_permission =               selinux_key_permission,
> > +	.key_alloc =			selinux_key_alloc,
> > +	.key_free =			selinux_key_free,
> > +	.key_permission =		selinux_key_permission,
> >  #endif
> >  };
> >  
> > @@ -5132,8 +5132,8 @@ next_sb:
> >  	if (!list_empty(&superblock_security_head)) {
> >  		struct superblock_security_struct *sbsec =
> >  				list_entry(superblock_security_head.next,
> > -				           struct superblock_security_struct,
> > -				           list);
> > +					   struct superblock_security_struct,
> > +					   list);
> >  		struct super_block *sb = sbsec->sb;
> >  		sb->s_count++;
> >  		spin_unlock(&sb_security_lock);
> > diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> > index e145f6e..6b2ec98 100644
> > --- a/security/selinux/include/avc.h
> > +++ b/security/selinux/include/avc.h
> > @@ -77,7 +77,7 @@ struct avc_audit_data {
> >  
> >  /* Initialize an AVC audit data structure. */
> >  #define AVC_AUDIT_DATA_INIT(_d,_t) \
> > -        { memset((_d), 0, sizeof(struct avc_audit_data)); (_d)->type = AVC_AUDIT_DATA_##_t; }
> > +	{ memset((_d), 0, sizeof(struct avc_audit_data)); (_d)->type = AVC_AUDIT_DATA_##_t; }
> >  
> >  /*
> >   * AVC statistics
> > @@ -99,8 +99,8 @@ struct avc_cache_stats
> >  void __init avc_init(void);
> >  
> >  void avc_audit(u32 ssid, u32 tsid,
> > -               u16 tclass, u32 requested,
> > -               struct av_decision *avd, int result, struct avc_audit_data *auditdata);
> > +	       u16 tclass, u32 requested,
> > +	       struct av_decision *avd, int result, struct avc_audit_data *auditdata);
> >  
> >  #define AVC_STRICT 1 /* Ignore permissive mode. */
> >  int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> > @@ -109,8 +109,8 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> >  			 struct av_decision *avd);
> >  
> >  int avc_has_perm(u32 ssid, u32 tsid,
> > -                 u16 tclass, u32 requested,
> > -                 struct avc_audit_data *auditdata);
> > +		 u16 tclass, u32 requested,
> > +		 struct avc_audit_data *auditdata);
> >  
> >  #define AVC_CALLBACK_GRANT		1
> >  #define AVC_CALLBACK_TRY_REVOKE		2
> > @@ -122,7 +122,7 @@ int avc_has_perm(u32 ssid, u32 tsid,
> >  #define AVC_CALLBACK_AUDITDENY_DISABLE	128
> >  
> >  int avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
> > -                                     u16 tclass, u32 perms,
> > +				     u16 tclass, u32 perms,
> >  				     u32 *out_retained),
> >  		     u32 events, u32 ssid, u32 tsid,
> >  		     u16 tclass, u32 perms);
> > diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
> > index 67ce7a8..849ffee 100644
> > --- a/security/selinux/include/conditional.h
> > +++ b/security/selinux/include/conditional.h
> > @@ -6,7 +6,7 @@
> >   *
> >   * Copyright (C) 2003 - 2004 Tresys Technology, LLC
> >   *	This program is free software; you can redistribute it and/or modify
> > - *  	it under the terms of the GNU General Public License as published by
> > + *	it under the terms of the GNU General Public License as published by
> >   *	the Free Software Foundation, version 2.
> >   */
> >  
> > diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
> > index 218e3f7..78ae672 100644
> > --- a/security/selinux/include/netlabel.h
> > +++ b/security/selinux/include/netlabel.h
> > @@ -64,19 +64,19 @@ static inline void selinux_netlbl_cache_invalidate(void)
> >  }
> >  
> >  static inline void selinux_netlbl_sk_security_reset(
> > -	                                       struct sk_security_struct *ssec,
> > +					       struct sk_security_struct *ssec,
> >  					       int family)
> >  {
> >  	return;
> >  }
> >  static inline void selinux_netlbl_sk_security_init(
> > -	                                       struct sk_security_struct *ssec,
> > +					       struct sk_security_struct *ssec,
> >  					       int family)
> >  {
> >  	return;
> >  }
> >  static inline void selinux_netlbl_sk_security_clone(
> > -	                                    struct sk_security_struct *ssec,
> > +					    struct sk_security_struct *ssec,
> >  					    struct sk_security_struct *newssec)
> >  {
> >  	return;
> > diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> > index fc4768e..9975746 100644
> > --- a/security/selinux/include/objsec.h
> > +++ b/security/selinux/include/objsec.h
> > @@ -4,16 +4,16 @@
> >   *  This file contains the SELinux security data structures for kernel objects.
> >   *
> >   *  Author(s):  Stephen Smalley, <sds@epoch.ncsc.mil>
> > - *              Chris Vance, <cvance@nai.com>
> > - *              Wayne Salamon, <wsalamon@nai.com>
> > - *              James Morris <jmorris@redhat.com>
> > + *		Chris Vance, <cvance@nai.com>
> > + *		Wayne Salamon, <wsalamon@nai.com>
> > + *		James Morris <jmorris@redhat.com>
> >   *
> >   *  Copyright (C) 2001,2002 Networks Associates Technology, Inc.
> >   *  Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
> >   *
> >   *	This program is free software; you can redistribute it and/or modify
> >   *	it under the terms of the GNU General Public License version 2,
> > - *      as published by the Free Software Foundation.
> > + *	as published by the Free Software Foundation.
> >   */
> >  #ifndef _SELINUX_OBJSEC_H_
> >  #define _SELINUX_OBJSEC_H_
> > @@ -29,9 +29,9 @@
> >  
> >  struct task_security_struct {
> >  	struct task_struct *task;      /* back pointer to task object */
> > -	u32 osid;            /* SID prior to last execve */
> > -	u32 sid;             /* current SID */
> > -	u32 exec_sid;        /* exec SID */
> > +	u32 osid;	     /* SID prior to last execve */
> > +	u32 sid;	     /* current SID */
> > +	u32 exec_sid;	     /* exec SID */
> >  	u32 create_sid;      /* fscreate SID */
> >  	u32 keycreate_sid;   /* keycreate SID */
> >  	u32 sockcreate_sid;  /* fscreate SID */
> > @@ -39,51 +39,51 @@ struct task_security_struct {
> >  };
> >  
> >  struct inode_security_struct {
> > -        struct inode *inode;           /* back pointer to inode object */
> > -	struct list_head list;         /* list of inode_security_struct */
> > -	u32 task_sid;        /* SID of creating task */
> > -	u32 sid;             /* SID of this object */
> > -	u16 sclass;       /* security class of this object */
> > -	unsigned char initialized;     /* initialization flag */
> > +	struct inode *inode;		/* back pointer to inode object */
> > +	struct list_head list;		/* list of inode_security_struct */
> > +	u32 task_sid;	/* SID of creating task */
> > +	u32 sid;	/* SID of this object */
> > +	u16 sclass;	/* security class of this object */
> > +	unsigned char initialized;	/* initialization flag */
> >  	struct mutex lock;
> > -	unsigned char inherit;         /* inherit SID from parent entry */
> > +	unsigned char inherit;		/* inherit SID from parent entry */
> >  };
> >  
> >  struct file_security_struct {
> > -	struct file *file;              /* back pointer to file object */
> > -	u32 sid;              /* SID of open file description */
> > -	u32 fown_sid;         /* SID of file owner (for SIGIO) */
> > +	struct file *file;	/* back pointer to file object */
> > +	u32 sid;		/* SID of open file description */
> > +	u32 fown_sid;		/* SID of file owner (for SIGIO) */
> >  };
> >  
> >  struct superblock_security_struct {
> > -	struct super_block *sb;         /* back pointer to sb object */
> > -	struct list_head list;          /* list of superblock_security_struct */
> > +	struct super_block *sb;		/* back pointer to sb object */
> > +	struct list_head list;		/* list of superblock_security_struct */
> >  	u32 sid;			/* SID of file system superblock */
> >  	u32 def_sid;			/* default SID for labeling */
> >  	u32 mntpoint_sid;		/* SECURITY_FS_USE_MNTPOINT context for files */
> > -	unsigned int behavior;          /* labeling behavior */
> > -	unsigned char initialized;      /* initialization flag */
> > +	unsigned int behavior;		/* labeling behavior */
> > +	unsigned char initialized;	/* initialization flag */
> >  	unsigned char flags;		/* which mount options were specified */
> > -	unsigned char proc;             /* proc fs */
> > +	unsigned char proc;		/* proc fs */
> >  	struct mutex lock;
> >  	struct list_head isec_head;
> >  	spinlock_t isec_lock;
> >  };
> >  
> >  struct msg_security_struct {
> > -	struct msg_msg *msg;		/* back pointer */
> > -	u32 sid;              /* SID of message */
> > +	struct msg_msg *msg;	/* back pointer */
> > +	u32 sid;		/* SID of message */
> >  };
> >  
> >  struct ipc_security_struct {
> >  	struct kern_ipc_perm *ipc_perm; /* back pointer */
> >  	u16 sclass;	/* security class of this object */
> > -	u32 sid;              /* SID of IPC resource */
> > +	u32 sid;	/* SID of IPC resource */
> >  };
> >  
> >  struct bprm_security_struct {
> > -	struct linux_binprm *bprm;     /* back pointer to bprm object */
> > -	u32 sid;                       /* SID for transformed process */
> > +	struct linux_binprm *bprm;	/* back pointer to bprm object */
> > +	u32 sid;			/* SID for transformed process */
> >  	unsigned char set;
> >  
> >  	/*
> > @@ -116,7 +116,7 @@ struct sk_security_struct {
> >  
> >  struct key_security_struct {
> >  	struct key *obj; /* back pointer */
> > -	u32 sid;         /* SID of key */
> > +	u32 sid;	 /* SID of key */
> >  };
> >  
> >  extern unsigned int selinux_checkreqprot;
> > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > index 83bdd4d..ed0ea51 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -84,7 +84,7 @@ int security_node_sid(u16 domain, void *addr, u32 addrlen,
> >  	u32 *out_sid);
> >  
> >  int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
> > -                                 u16 tclass);
> > +				 u16 tclass);
> >  
> >  int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
> >  
> > diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> > index b10c34e..809c967 100644
> > --- a/security/selinux/netif.c
> > +++ b/security/selinux/netif.c
> > @@ -64,7 +64,7 @@ static inline struct sel_netif *sel_netif_find(struct net_device *dev)
> >  
> >  	__list_for_each_rcu(pos, &sel_netif_hash[idx]) {
> >  		struct sel_netif *netif = list_entry(pos,
> > -		                                     struct sel_netif, list);
> > +						     struct sel_netif, list);
> >  		if (likely(netif->nsec.dev == dev))
> >  			return netif;
> >  	}
> > @@ -152,7 +152,7 @@ static struct sel_netif *sel_netif_lookup(struct net_device *dev)
> >  	netif = new;
> >  	
> >  	DEBUGP("new: ifindex=%u name=%s if_sid=%u msg_sid=%u\n", dev->ifindex, dev->name,
> > -	        nsec->if_sid, nsec->msg_sid);
> > +		nsec->if_sid, nsec->msg_sid);
> >  out:
> >  	return netif;
> >  }
> > @@ -220,7 +220,7 @@ static void sel_netif_flush(void)
> >  }
> >  
> >  static int sel_netif_avc_callback(u32 event, u32 ssid, u32 tsid,
> > -                                  u16 class, u32 perms, u32 *retained)
> > +				  u16 class, u32 perms, u32 *retained)
> >  {
> >  	if (event == AVC_CALLBACK_RESET) {
> >  		sel_netif_flush();
> > @@ -230,7 +230,7 @@ static int sel_netif_avc_callback(u32 event, u32 ssid, u32 tsid,
> >  }
> >  
> >  static int sel_netif_netdev_notifier_handler(struct notifier_block *this,
> > -                                             unsigned long event, void *ptr)
> > +					     unsigned long event, void *ptr)
> >  {
> >  	struct net_device *dev = ptr;
> >  
> > @@ -257,7 +257,7 @@ static __init int sel_netif_init(void)
> >  	register_netdevice_notifier(&sel_netif_netdev_notifier);
> >  	
> >  	err = avc_add_callback(sel_netif_avc_callback, AVC_CALLBACK_RESET,
> > -	                       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
> > +			       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
> >  	if (err)
> >  		panic("avc_add_callback() failed, error %d\n", err);
> >  
> > diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> > index d243ddc..2a5ba7d 100644
> > --- a/security/selinux/netlabel.c
> > +++ b/security/selinux/netlabel.c
> > @@ -92,7 +92,7 @@ void selinux_netlbl_cache_invalidate(void)
> >  void selinux_netlbl_sk_security_reset(struct sk_security_struct *ssec,
> >  				      int family)
> >  {
> > -        if (family == PF_INET)
> > +	if (family == PF_INET)
> >  		ssec->nlbl_state = NLBL_REQUIRE;
> >  	else
> >  		ssec->nlbl_state = NLBL_UNSET;
> > diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
> > index f49046d..ff7baed 100644
> > --- a/security/selinux/netlink.c
> > +++ b/security/selinux/netlink.c
> > @@ -105,7 +105,7 @@ void selnl_notify_policyload(u32 seqno)
> >  static int __init selnl_init(void)
> >  {
> >  	selnl = netlink_kernel_create(NETLINK_SELINUX, SELNLGRP_MAX, NULL, NULL,
> > -	                              THIS_MODULE);
> > +				      THIS_MODULE);
> >  	if (selnl == NULL)
> >  		panic("SELinux:  Cannot create netlink socket.");
> >  	netlink_set_nonroot(NETLINK_SELINUX, NL_NONROOT_RECV);	
> > diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> > index eddc7b4..7a12a28 100644
> > --- a/security/selinux/nlmsgtab.c
> > +++ b/security/selinux/nlmsgtab.c
> > @@ -159,7 +159,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
> >  		if ((nlmsg_type >= AUDIT_FIRST_USER_MSG &&
> >  		     nlmsg_type <= AUDIT_LAST_USER_MSG) ||
> >  		    (nlmsg_type >= AUDIT_FIRST_USER_MSG2 &&
> > -                     nlmsg_type <= AUDIT_LAST_USER_MSG2)) {
> > +		     nlmsg_type <= AUDIT_LAST_USER_MSG2)) {
> >  			*perm = NETLINK_AUDIT_SOCKET__NLMSG_RELAY;
> >  		} else {
> >  			err = nlmsg_perm(nlmsg_type, perm, nlmsg_audit_perms,
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index c9e92da..42a97c2 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -5,7 +5,7 @@
> >   * Copyright (C) 2003 - 2004 Tresys Technology, LLC
> >   * Copyright (C) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
> >   *	This program is free software; you can redistribute it and/or modify
> > - *  	it under the terms of the GNU General Public License as published by
> > + *	it under the terms of the GNU General Public License as published by
> >   *	the Free Software Foundation, version 2.
> >   */
> >  
> > @@ -227,7 +227,7 @@ static const struct file_operations sel_disable_ops = {
> >  };
> >  
> >  static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
> > -                                   size_t count, loff_t *ppos)
> > +				   size_t count, loff_t *ppos)
> >  {
> >  	char tmpbuf[TMPBUFLEN];
> >  	ssize_t length;
> > @@ -898,8 +898,8 @@ out:
> >  }
> >  
> >  static const struct file_operations sel_bool_ops = {
> > -	.read           = sel_read_bool,
> > -	.write          = sel_write_bool,
> > +	.read		= sel_read_bool,
> > +	.write		= sel_write_bool,
> >  };
> >  
> >  static ssize_t sel_commit_bools_write(struct file *filep,
> > @@ -955,7 +955,7 @@ out:
> >  }
> >  
> >  static const struct file_operations sel_commit_bools_ops = {
> > -	.write          = sel_commit_bools_write,
> > +	.write		= sel_commit_bools_write,
> >  };
> >  
> >  /* partial revoke() from fs/proc/generic.c proc_kill_inodes */
> > diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> > index 85705eb..4a3ee37 100644
> > --- a/security/selinux/ss/avtab.c
> > +++ b/security/selinux/ss/avtab.c
> > @@ -10,7 +10,7 @@
> >   *
> >   * Copyright (C) 2003 Tresys Technology, LLC
> >   *	This program is free software; you can redistribute it and/or modify
> > - *  	it under the terms of the GNU General Public License as published by
> > + *	it under the terms of the GNU General Public License as published by
> >   *	the Free Software Foundation, version 2.
> >   */
> >  
> > @@ -292,7 +292,7 @@ static uint16_t spec_order[] = {
> >  };
> >  
> >  int avtab_read_item(void *fp, u32 vers, struct avtab *a,
> > -	            int (*insertf)(struct avtab *a, struct avtab_key *k,
> > +		    int (*insertf)(struct avtab *a, struct avtab_key *k,
> >  				   struct avtab_datum *d, void *p),
> >  		    void *p)
> >  {
> > diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> > index 0a90d93..ea73966 100644
> > --- a/security/selinux/ss/avtab.h
> > +++ b/security/selinux/ss/avtab.h
> > @@ -14,7 +14,7 @@
> >   *
> >   * Copyright (C) 2003 Tresys Technology, LLC
> >   *	This program is free software; you can redistribute it and/or modify
> > - *  	it under the terms of the GNU General Public License as published by
> > + *	it under the terms of the GNU General Public License as published by
> >   *	the Free Software Foundation, version 2.
> >   */
> >  #ifndef _SS_AVTAB_H_
> > @@ -27,7 +27,7 @@ struct avtab_key {
> >  #define AVTAB_ALLOWED     1
> >  #define AVTAB_AUDITALLOW  2
> >  #define AVTAB_AUDITDENY   4
> > -#define AVTAB_AV         (AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
> > +#define AVTAB_AV	 (AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
> >  #define AVTAB_TRANSITION 16
> >  #define AVTAB_MEMBER     32
> >  #define AVTAB_CHANGE     64
> > diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> > index d2737ed..0ed31af 100644
> > --- a/security/selinux/ss/conditional.c
> > +++ b/security/selinux/ss/conditional.c
> > @@ -1,9 +1,9 @@
> >  /* Authors: Karl MacMillan <kmacmillan@tresys.com>
> > - *          Frank Mayer <mayerf@tresys.com>
> > + *	    Frank Mayer <mayerf@tresys.com>
> >   *
> >   * Copyright (C) 2003 - 2004 Tresys Technology, LLC
> >   *	This program is free software; you can redistribute it and/or modify
> > - *  	it under the terms of the GNU General Public License as published by
> > + *	it under the terms of the GNU General Public License as published by
> >   *	the Free Software Foundation, version 2.
> >   */
> >  
> > diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
> > index f3a1fc6..44e97e7 100644
> > --- a/security/selinux/ss/conditional.h
> > +++ b/security/selinux/ss/conditional.h
> > @@ -1,9 +1,9 @@
> >  /* Authors: Karl MacMillan <kmacmillan@tresys.com>
> > - *          Frank Mayer <mayerf@tresys.com>
> > + *	    Frank Mayer <mayerf@tresys.com>
> >   *
> >   * Copyright (C) 2003 - 2004 Tresys Technology, LLC
> >   *	This program is free software; you can redistribute it and/or modify
> > - *  	it under the terms of the GNU General Public License as published by
> > + *	it under the terms of the GNU General Public License as published by
> >   *	the Free Software Foundation, version 2.
> >   */
> >  
> > diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/constraint.h
> > index 149dda7..9ed2c4f 100644
> > --- a/security/selinux/ss/constraint.h
> > +++ b/security/selinux/ss/constraint.h
> > @@ -43,7 +43,7 @@ struct constraint_expr {
> >  #define CEXPR_EQ     1		/* == or eq */
> >  #define CEXPR_NEQ    2		/* != */
> >  #define CEXPR_DOM    3		/* dom */
> > -#define CEXPR_DOMBY  4		/* domby  */
> > +#define CEXPR_DOMBY  4		/* domby */
> >  #define CEXPR_INCOMP 5		/* incomp */
> >  	u32 op;			/* operator */
> >  
> > diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
> > index 2eee0da..3ab1b75 100644
> > --- a/security/selinux/ss/context.h
> > +++ b/security/selinux/ss/context.h
> > @@ -2,7 +2,7 @@
> >   * A security context is a set of security attributes
> >   * associated with each subject and object controlled
> >   * by the security policy.  Security contexts are
> > -  * externally represented as variable-length strings
> > + * externally represented as variable-length strings
> >   * that can be interpreted by a user or application
> >   * with an understanding of the security policy.
> >   * Internally, the security server uses a simple
> > diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> > index ce492a6..1c1981a 100644
> > --- a/security/selinux/ss/ebitmap.c
> > +++ b/security/selinux/ss/ebitmap.c
> > @@ -111,7 +111,7 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
> >  				goto netlbl_export_failure;
> >  			c_iter = c_iter->next;
> >  			c_iter->startbit = e_iter->startbit &
> > -				           ~(NETLBL_CATMAP_SIZE - 1);
> > +					   ~(NETLBL_CATMAP_SIZE - 1);
> >  		}
> >  		cmap_idx = (e_iter->startbit - c_iter->startbit) /
> >  			   NETLBL_CATMAP_MAPSIZE;
> > @@ -165,7 +165,7 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
> >  			emap_prev = e_iter;
> >  
> >  			e_iter->startbit = c_iter->startbit +
> > -				           NETLBL_CATMAP_MAPSIZE * c_idx;
> > +					   NETLBL_CATMAP_MAPSIZE * c_idx;
> >  			e_iter->map = c_iter->bitmap[c_idx];
> >  		}
> >  		c_iter = c_iter->next;
> > diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> > index 77b530c..2e7788e 100644
> > --- a/security/selinux/ss/hashtab.c
> > +++ b/security/selinux/ss/hashtab.c
> > @@ -9,8 +9,8 @@
> >  #include "hashtab.h"
> >  
> >  struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
> > -                               int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
> > -                               u32 size)
> > +			       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
> > +			       u32 size)
> >  {
> >  	struct hashtab *p;
> >  	u32 i;
> > diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
> > index 7e2ff3e..fc73170 100644
> > --- a/security/selinux/ss/hashtab.h
> > +++ b/security/selinux/ss/hashtab.h
> > @@ -40,8 +40,8 @@ struct hashtab_info {
> >   * the new hash table otherwise.
> >   */
> >  struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
> > -                               int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
> > -                               u32 size);
> > +			       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
> > +			       u32 size);
> >  
> >  /*
> >   * Inserts the specified (key, datum) pair into the specified hash table.
> > diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> > index 4a8bab2..be5e114 100644
> > --- a/security/selinux/ss/mls.c
> > +++ b/security/selinux/ss/mls.c
> > @@ -66,7 +66,7 @@ int mls_compute_context_len(struct context * context)
> >  
> >  		if (l == 0) {
> >  			if (mls_level_eq(&context->range.level[0],
> > -			                 &context->range.level[1]))
> > +					 &context->range.level[1]))
> >  				break;
> >  			else
> >  				len++;
> > @@ -82,7 +82,7 @@ int mls_compute_context_len(struct context * context)
> >   * Update `*scontext' to point to the end of the MLS fields.
> >   */
> >  void mls_sid_to_context(struct context *context,
> > -                        char **scontext)
> > +			char **scontext)
> >  {
> >  	char *scontextp;
> >  	int i, l, range, wrote_sep;
> > @@ -146,7 +146,7 @@ void mls_sid_to_context(struct context *context,
> >  
> >  		if (l == 0) {
> >  			if (mls_level_eq(&context->range.level[0],
> > -			                 &context->range.level[1]))
> > +					 &context->range.level[1]))
> >  				break;
> >  			else {
> >  				*scontextp = '-';
> > @@ -309,14 +309,14 @@ int mls_context_to_sid(char oldc,
> >  				}
> >  
> >  				catdatum = hashtab_search(policydb.p_cats.table,
> > -				                          scontextp);
> > +							  scontextp);
> >  				if (!catdatum) {
> >  					rc = -EINVAL;
> >  					goto out;
> >  				}
> >  
> >  				rc = ebitmap_set_bit(&context->range.level[l].cat,
> > -				                     catdatum->value - 1, 1);
> > +						     catdatum->value - 1, 1);
> >  				if (rc)
> >  					goto out;
> >  
> > @@ -393,7 +393,7 @@ int mls_from_string(char *str, struct context *context, gfp_t gfp_mask)
> >  		rc = -ENOMEM;
> >  	} else {
> >  		rc = mls_context_to_sid(':', &tmpstr, context,
> > -		                        NULL, SECSID_NULL);
> > +					NULL, SECSID_NULL);
> >  		kfree(freestr);
> >  	}
> >  
> > @@ -404,7 +404,7 @@ int mls_from_string(char *str, struct context *context, gfp_t gfp_mask)
> >   * Copies the MLS range `range' into `context'.
> >   */
> >  static inline int mls_range_set(struct context *context,
> > -                                struct mls_range *range)
> > +				struct mls_range *range)
> >  {
> >  	int l, rc = 0;
> >  
> > @@ -421,7 +421,7 @@ static inline int mls_range_set(struct context *context,
> >  }
> >  
> >  int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
> > -                         struct context *usercon)
> > +			 struct context *usercon)
> >  {
> >  	if (selinux_mls_enabled) {
> >  		struct mls_level *fromcon_sen = &(fromcon->range.level[0]);
> > @@ -490,7 +490,7 @@ int mls_convert_context(struct policydb *oldp,
> >  				int rc;
> >  
> >  				catdatum = hashtab_search(newp->p_cats.table,
> > -				         	oldp->p_cat_val_to_name[i]);
> > +						oldp->p_cat_val_to_name[i]);
> >  				if (!catdatum)
> >  					return -EINVAL;
> >  				rc = ebitmap_set_bit(&bitmap, catdatum->value - 1, 1);
> > @@ -525,7 +525,7 @@ int mls_compute_sid(struct context *scontext,
> >  			    rtr->target_class == tclass) {
> >  				/* Set the range from the rule */
> >  				return mls_range_set(newcontext,
> > -				                     &rtr->target_range);
> > +						     &rtr->target_range);
> >  			}
> >  		}
> >  		/* Fallthrough */
> > diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> > index 096d1b4..4fd0360 100644
> > --- a/security/selinux/ss/mls.h
> > +++ b/security/selinux/ss/mls.h
> > @@ -29,7 +29,7 @@ void mls_sid_to_context(struct context *context, char **scontext);
> >  int mls_context_isvalid(struct policydb *p, struct context *c);
> >  
> >  int mls_context_to_sid(char oldc,
> > -	               char **scontext,
> > +		       char **scontext,
> >  		       struct context *context,
> >  		       struct sidtab *s,
> >  		       u32 def_sid);
> > @@ -47,7 +47,7 @@ int mls_compute_sid(struct context *scontext,
> >  		    struct context *newcontext);
> >  
> >  int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
> > -                         struct context *usercon);
> > +			 struct context *usercon);
> >  
> >  #ifdef CONFIG_NETLABEL
> >  void mls_export_netlbl_lvl(struct context *context,
> > diff --git a/security/selinux/ss/mls_types.h b/security/selinux/ss/mls_types.h
> > index 0c692d5..b6e943a 100644
> > --- a/security/selinux/ss/mls_types.h
> > +++ b/security/selinux/ss/mls_types.h
> > @@ -31,7 +31,7 @@ static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
> >  		return 1;
> >  
> >  	return ((l1->sens == l2->sens) &&
> > -	        ebitmap_cmp(&l1->cat, &l2->cat));
> > +		ebitmap_cmp(&l1->cat, &l2->cat));
> >  }
> >  
> >  static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
> > @@ -40,7 +40,7 @@ static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
> >  		return 1;
> >  
> >  	return ((l1->sens >= l2->sens) &&
> > -	        ebitmap_contains(&l1->cat, &l2->cat));
> > +		ebitmap_contains(&l1->cat, &l2->cat));
> >  }
> >  
> >  #define mls_level_incomp(l1, l2) \
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index f05f97a..7785b75 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -16,7 +16,7 @@
> >   * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
> >   * Copyright (C) 2003 - 2004 Tresys Technology, LLC
> >   *	This program is free software; you can redistribute it and/or modify
> > - *  	it under the terms of the GNU General Public License as published by
> > + *	it under the terms of the GNU General Public License as published by
> >   *	the Free Software Foundation, version 2.
> >   */
> >  
> > @@ -68,39 +68,39 @@ struct policydb_compat_info {
> >  /* These need to be updated if SYM_NUM or OCON_NUM changes */
> >  static struct policydb_compat_info policydb_compat[] = {
> >  	{
> > -		.version        = POLICYDB_VERSION_BASE,
> > -		.sym_num        = SYM_NUM - 3,
> > -		.ocon_num       = OCON_NUM - 1,
> > +		.version	= POLICYDB_VERSION_BASE,
> > +		.sym_num	= SYM_NUM - 3,
> > +		.ocon_num	= OCON_NUM - 1,
> >  	},
> >  	{
> > -		.version        = POLICYDB_VERSION_BOOL,
> > -		.sym_num        = SYM_NUM - 2,
> > -		.ocon_num       = OCON_NUM - 1,
> > +		.version	= POLICYDB_VERSION_BOOL,
> > +		.sym_num	= SYM_NUM - 2,
> > +		.ocon_num	= OCON_NUM - 1,
> >  	},
> >  	{
> > -		.version        = POLICYDB_VERSION_IPV6,
> > -		.sym_num        = SYM_NUM - 2,
> > -		.ocon_num       = OCON_NUM,
> > +		.version	= POLICYDB_VERSION_IPV6,
> > +		.sym_num	= SYM_NUM - 2,
> > +		.ocon_num	= OCON_NUM,
> >  	},
> >  	{
> > -		.version        = POLICYDB_VERSION_NLCLASS,
> > -		.sym_num        = SYM_NUM - 2,
> > -		.ocon_num       = OCON_NUM,
> > +		.version	= POLICYDB_VERSION_NLCLASS,
> > +		.sym_num	= SYM_NUM - 2,
> > +		.ocon_num	= OCON_NUM,
> >  	},
> >  	{
> > -		.version        = POLICYDB_VERSION_MLS,
> > -		.sym_num        = SYM_NUM,
> > -		.ocon_num       = OCON_NUM,
> > +		.version	= POLICYDB_VERSION_MLS,
> > +		.sym_num	= SYM_NUM,
> > +		.ocon_num	= OCON_NUM,
> >  	},
> >  	{
> > -		.version        = POLICYDB_VERSION_AVTAB,
> > -		.sym_num        = SYM_NUM,
> > -		.ocon_num       = OCON_NUM,
> > +		.version	= POLICYDB_VERSION_AVTAB,
> > +		.sym_num	= SYM_NUM,
> > +		.ocon_num	= OCON_NUM,
> >  	},
> >  	{
> > -		.version        = POLICYDB_VERSION_RANGETRANS,
> > -		.sym_num        = SYM_NUM,
> > -		.ocon_num       = OCON_NUM,
> > +		.version	= POLICYDB_VERSION_RANGETRANS,
> > +		.sym_num	= SYM_NUM,
> > +		.ocon_num	= OCON_NUM,
> >  	},
> >  };
> >  
> > @@ -409,7 +409,7 @@ static int policydb_index_others(struct policydb *p)
> >  
> >  	p->role_val_to_struct =
> >  		kmalloc(p->p_roles.nprim * sizeof(*(p->role_val_to_struct)),
> > -		        GFP_KERNEL);
> > +			GFP_KERNEL);
> >  	if (!p->role_val_to_struct) {
> >  		rc = -ENOMEM;
> >  		goto out;
> > @@ -417,7 +417,7 @@ static int policydb_index_others(struct policydb *p)
> >  
> >  	p->user_val_to_struct =
> >  		kmalloc(p->p_users.nprim * sizeof(*(p->user_val_to_struct)),
> > -		        GFP_KERNEL);
> > +			GFP_KERNEL);
> >  	if (!p->user_val_to_struct) {
> >  		rc = -ENOMEM;
> >  		goto out;
> > @@ -959,7 +959,7 @@ bad:
> >  }
> >  
> >  static int read_cons_helper(struct constraint_node **nodep, int ncons,
> > -                            int allowxtarget, void *fp)
> > +			    int allowxtarget, void *fp)
> >  {
> >  	struct constraint_node *c, *lc;
> >  	struct constraint_expr *e, *le;
> > @@ -1503,10 +1503,10 @@ int policydb_read(struct policydb *p, void *fp)
> >  	p->policyvers = le32_to_cpu(buf[0]);
> >  	if (p->policyvers < POLICYDB_VERSION_MIN ||
> >  	    p->policyvers > POLICYDB_VERSION_MAX) {
> > -	    	printk(KERN_ERR "security:  policydb version %d does not match "
> > -	    	       "my version range %d-%d\n",
> > -	    	       le32_to_cpu(buf[0]), POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
> > -	    	goto bad;
> > +		printk(KERN_ERR "security:  policydb version %d does not match "
> > +		       "my version range %d-%d\n",
> > +		       le32_to_cpu(buf[0]), POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
> > +		goto bad;
> >  	}
> >  
> >  	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
> > diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> > index 8319d5f..be7eacc 100644
> > --- a/security/selinux/ss/policydb.h
> > +++ b/security/selinux/ss/policydb.h
> > @@ -17,7 +17,7 @@
> >   * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
> >   * Copyright (C) 2003 - 2004 Tresys Technology, LLC
> >   *	This program is free software; you can redistribute it and/or modify
> > - *  	it under the terms of the GNU General Public License as published by
> > + *	it under the terms of the GNU General Public License as published by
> >   *	the Free Software Foundation, version 2.
> >   */
> >  
> > @@ -143,7 +143,7 @@ struct ocontext {
> >  		struct {
> >  			u32 addr[4];
> >  			u32 mask[4];
> > -		} node6;        /* IPv6 node information */
> > +		} node6;	/* IPv6 node information */
> >  	} u;
> >  	union {
> >  		u32 sclass;  /* security class for genfs */
> > @@ -230,10 +230,12 @@ struct policydb {
> >  	   TCP or UDP port numbers, network interfaces and nodes */
> >  	struct ocontext *ocontexts[OCON_NUM];
> >  
> > -        /* security contexts for files in filesystems that cannot support
> > -	   a persistent label mapping or use another
> > -	   fixed labeling behavior. */
> > -  	struct genfs *genfs;
> > +	/*
> > +	 * security contexts for files in filesystems that cannot support
> > +	 * a persistent label mapping or use another
> > +	 * fixed labeling behavior.
> > +	 */
> > +	struct genfs *genfs;
> >  
> >  	/* range transitions */
> >  	struct range_trans *range_tr;
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 6100fc0..008a203 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -2,7 +2,7 @@
> >   * Implementation of the security services.
> >   *
> >   * Authors : Stephen Smalley, <sds@epoch.ncsc.mil>
> > - *           James Morris <jmorris@redhat.com>
> > + *	     James Morris <jmorris@redhat.com>
> >   *
> >   * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
> >   *
> > @@ -26,7 +26,7 @@
> >   * Copyright (C) 2003 - 2004, 2006 Tresys Technology, LLC
> >   * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
> >   *	This program is free software; you can redistribute it and/or modify
> > - *  	it under the terms of the GNU General Public License as published by
> > + *	it under the terms of the GNU General Public License as published by
> >   *	the Free Software Foundation, version 2.
> >   */
> >  #include <linux/kernel.h>
> > @@ -383,16 +383,16 @@ static int context_struct_compute_av(struct context *scontext,
> >  		}
> >  		if (!ra)
> >  			avd->allowed = (avd->allowed) & ~(PROCESS__TRANSITION |
> > -			                                PROCESS__DYNTRANSITION);
> > +							PROCESS__DYNTRANSITION);
> >  	}
> >  
> >  	return 0;
> >  }
> >  
> >  static int security_validtrans_handle_fail(struct context *ocontext,
> > -                                           struct context *ncontext,
> > -                                           struct context *tcontext,
> > -                                           u16 tclass)
> > +					   struct context *ncontext,
> > +					   struct context *tcontext,
> > +					   u16 tclass)
> >  {
> >  	char *o = NULL, *n = NULL, *t = NULL;
> >  	u32 olen, nlen, tlen;
> > @@ -404,9 +404,9 @@ static int security_validtrans_handle_fail(struct context *ocontext,
> >  	if (context_struct_to_string(tcontext, &t, &tlen) < 0)
> >  		goto out;
> >  	audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
> > -	          "security_validate_transition:  denied for"
> > -	          " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
> > -	          o, n, t, policydb.p_class_val_to_name[tclass-1]);
> > +		  "security_validate_transition:  denied for"
> > +		  " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
> > +		  o, n, t, policydb.p_class_val_to_name[tclass-1]);
> >  out:
> >  	kfree(o);
> >  	kfree(n);
> > @@ -418,7 +418,7 @@ out:
> >  }
> >  
> >  int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
> > -                                 u16 tclass)
> > +				 u16 tclass)
> >  {
> >  	struct context *ocontext;
> >  	struct context *ncontext;
> > @@ -478,9 +478,9 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
> >  	constraint = tclass_datum->validatetrans;
> >  	while (constraint) {
> >  		if (!constraint_expr_eval(ocontext, ncontext, tcontext,
> > -		                          constraint->expr)) {
> > +					  constraint->expr)) {
> >  			rc = security_validtrans_handle_fail(ocontext, ncontext,
> > -			                                     tcontext, tclass);
> > +							     tcontext, tclass);
> >  			goto out;
> >  		}
> >  		constraint = constraint->next;
> > @@ -581,8 +581,8 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
> >  		policydb.p_role_val_to_name[context->role - 1],
> >  		policydb.p_type_val_to_name[context->type - 1]);
> >  	scontextp += strlen(policydb.p_user_val_to_name[context->user - 1]) +
> > -	             1 + strlen(policydb.p_role_val_to_name[context->role - 1]) +
> > -	             1 + strlen(policydb.p_type_val_to_name[context->type - 1]);
> > +		     1 + strlen(policydb.p_role_val_to_name[context->role - 1]) +
> > +		     1 + strlen(policydb.p_type_val_to_name[context->type - 1]);
> >  
> >  	mls_sid_to_context(context, &scontextp);
> >  
> > @@ -782,7 +782,7 @@ out:
> >  int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
> >  {
> >  	return security_context_to_sid_core(scontext, scontext_len,
> > -	                                    sid, SECSID_NULL);
> > +					    sid, SECSID_NULL);
> >  }
> >  
> >  /**
> > @@ -805,7 +805,7 @@ int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
> >  int security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
> >  {
> >  	return security_context_to_sid_core(scontext, scontext_len,
> > -	                                    sid, def_sid);
> > +					    sid, def_sid);
> >  }
> >  
> >  static int compute_sid_handle_invalid_context(
> > @@ -1212,7 +1212,7 @@ static int convert_context(u32 key,
> >  
> >  	/* Convert the user. */
> >  	usrdatum = hashtab_search(args->newp->p_users.table,
> > -	                          args->oldp->p_user_val_to_name[c->user - 1]);
> > +				  args->oldp->p_user_val_to_name[c->user - 1]);
> >  	if (!usrdatum) {
> >  		goto bad;
> >  	}
> > @@ -1220,7 +1220,7 @@ static int convert_context(u32 key,
> >  
> >  	/* Convert the role. */
> >  	role = hashtab_search(args->newp->p_roles.table,
> > -	                      args->oldp->p_role_val_to_name[c->role - 1]);
> > +			      args->oldp->p_role_val_to_name[c->role - 1]);
> >  	if (!role) {
> >  		goto bad;
> >  	}
> > @@ -1228,7 +1228,7 @@ static int convert_context(u32 key,
> >  
> >  	/* Convert the type. */
> >  	typdatum = hashtab_search(args->newp->p_types.table,
> > -	                          args->oldp->p_type_val_to_name[c->type - 1]);
> > +				  args->oldp->p_type_val_to_name[c->type - 1]);
> >  	if (!typdatum) {
> >  		goto bad;
> >  	}
> > @@ -1582,7 +1582,7 @@ out:
> >   */
> >  
> >  int security_get_user_sids(u32 fromsid,
> > -	                   char *username,
> > +			   char *username,
> >  			   u32 **sids,
> >  			   u32 *nel)
> >  {
> > @@ -1696,7 +1696,7 @@ out:
> >   * transition SIDs or task SIDs.
> >   */
> >  int security_genfs_sid(const char *fstype,
> > -	               char *path,
> > +		       char *path,
> >  		       u16 sclass,
> >  		       u32 *sid)
> >  {
> > @@ -1808,11 +1808,11 @@ int security_get_bools(int *len, char ***names, int **values)
> >  		goto out;
> >  	}
> >  
> > -       *names = kcalloc(*len, sizeof(char*), GFP_ATOMIC);
> > +	*names = kcalloc(*len, sizeof(char*), GFP_ATOMIC);
> >  	if (!*names)
> >  		goto err;
> >  
> > -       *values = kcalloc(*len, sizeof(int), GFP_ATOMIC);
> > +	*values = kcalloc(*len, sizeof(int), GFP_ATOMIC);
> >  	if (!*values)
> >  		goto err;
> >  
> > @@ -1820,7 +1820,7 @@ int security_get_bools(int *len, char ***names, int **values)
> >  		size_t name_len;
> >  		(*values)[i] = policydb.bool_val_to_struct[i]->state;
> >  		name_len = strlen(policydb.p_bool_val_to_name[i]) + 1;
> > -               (*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
> > +		(*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
> >  		if (!(*names)[i])
> >  			goto err;
> >  		strncpy((*names)[i], policydb.p_bool_val_to_name[i], name_len);
> > @@ -2116,7 +2116,7 @@ void selinux_audit_rule_free(struct selinux_audit_rule *rule)
> >  }
> >  
> >  int selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
> > -                            struct selinux_audit_rule **rule)
> > +			    struct selinux_audit_rule **rule)
> >  {
> >  	struct selinux_audit_rule *tmprule;
> >  	struct role_datum *roledatum;
> > @@ -2209,8 +2209,8 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
> >  }
> >  
> >  int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
> > -                             struct selinux_audit_rule *rule,
> > -                             struct audit_context *actx)
> > +			     struct selinux_audit_rule *rule,
> > +			     struct audit_context *actx)
> >  {
> >  	struct context *ctxt;
> >  	struct mls_level *level;
> > @@ -2218,7 +2218,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
> >  
> >  	if (!rule) {
> >  		audit_log(actx, GFP_ATOMIC, AUDIT_SELINUX_ERR,
> > -		          "selinux_audit_rule_match: missing rule\n");
> > +			  "selinux_audit_rule_match: missing rule\n");
> >  		return -ENOENT;
> >  	}
> >  
> > @@ -2226,7 +2226,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
> >  
> >  	if (rule->au_seqno < latest_granting) {
> >  		audit_log(actx, GFP_ATOMIC, AUDIT_SELINUX_ERR,
> > -		          "selinux_audit_rule_match: stale rule\n");
> > +			  "selinux_audit_rule_match: stale rule\n");
> >  		match = -ESTALE;
> >  		goto out;
> >  	}
> > @@ -2234,8 +2234,8 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
> >  	ctxt = sidtab_search(&sidtab, sid);
> >  	if (!ctxt) {
> >  		audit_log(actx, GFP_ATOMIC, AUDIT_SELINUX_ERR,
> > -		          "selinux_audit_rule_match: unrecognized SID %d\n",
> > -		          sid);
> > +			  "selinux_audit_rule_match: unrecognized SID %d\n",
> > +			  sid);
> >  		match = -ENOENT;
> >  		goto out;
> >  	}
> > @@ -2281,36 +2281,36 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
> >  	case AUDIT_OBJ_LEV_LOW:
> >  	case AUDIT_OBJ_LEV_HIGH:
> >  		level = ((field == AUDIT_SUBJ_SEN ||
> > -		          field == AUDIT_OBJ_LEV_LOW) ?
> > -		         &ctxt->range.level[0] : &ctxt->range.level[1]);
> > +			  field == AUDIT_OBJ_LEV_LOW) ?
> > +			 &ctxt->range.level[0] : &ctxt->range.level[1]);
> >  		switch (op) {
> >  		case AUDIT_EQUAL:
> >  			match = mls_level_eq(&rule->au_ctxt.range.level[0],
> > -			                     level);
> > +					     level);
> >  			break;
> >  		case AUDIT_NOT_EQUAL:
> >  			match = !mls_level_eq(&rule->au_ctxt.range.level[0],
> > -			                      level);
> > +					      level);
> >  			break;
> >  		case AUDIT_LESS_THAN:
> >  			match = (mls_level_dom(&rule->au_ctxt.range.level[0],
> > -			                       level) &&
> > -			         !mls_level_eq(&rule->au_ctxt.range.level[0],
> > -			                       level));
> > +					       level) &&
> > +				 !mls_level_eq(&rule->au_ctxt.range.level[0],
> > +					       level));
> >  			break;
> >  		case AUDIT_LESS_THAN_OR_EQUAL:
> >  			match = mls_level_dom(&rule->au_ctxt.range.level[0],
> > -			                      level);
> > +					      level);
> >  			break;
> >  		case AUDIT_GREATER_THAN:
> >  			match = (mls_level_dom(level,
> > -			                      &rule->au_ctxt.range.level[0]) &&
> > -			         !mls_level_eq(level,
> > -			                       &rule->au_ctxt.range.level[0]));
> > +					      &rule->au_ctxt.range.level[0]) &&
> > +				 !mls_level_eq(level,
> > +					       &rule->au_ctxt.range.level[0]));
> >  			break;
> >  		case AUDIT_GREATER_THAN_OR_EQUAL:
> >  			match = mls_level_dom(level,
> > -			                      &rule->au_ctxt.range.level[0]);
> > +					      &rule->au_ctxt.range.level[0]);
> >  			break;
> >  		}
> >  	}
> > @@ -2323,7 +2323,7 @@ out:
> >  static int (*aurule_callback)(void) = NULL;
> >  
> >  static int aurule_avc_callback(u32 event, u32 ssid, u32 tsid,
> > -                               u16 class, u32 perms, u32 *retained)
> > +			       u16 class, u32 perms, u32 *retained)
> >  {
> >  	int err = 0;
> >  
> > @@ -2337,7 +2337,7 @@ static int __init aurule_init(void)
> >  	int err;
> >  
> >  	err = avc_add_callback(aurule_avc_callback, AVC_CALLBACK_RESET,
> > -	                       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
> > +			       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
> >  	if (err)
> >  		panic("avc_add_callback() failed, error %d\n", err);
> >  
> > @@ -2354,10 +2354,10 @@ void selinux_audit_set_callback(int (*callback)(void))
> >  /*
> >   * NetLabel cache structure
> >   */
> > -#define NETLBL_CACHE(x)           ((struct selinux_netlbl_cache *)(x))
> > -#define NETLBL_CACHE_T_NONE       0
> > -#define NETLBL_CACHE_T_SID        1
> > -#define NETLBL_CACHE_T_MLS        2
> > +#define NETLBL_CACHE(x)		((struct selinux_netlbl_cache *)(x))
> > +#define NETLBL_CACHE_T_NONE	0
> > +#define NETLBL_CACHE_T_SID	1
> > +#define NETLBL_CACHE_T_MLS	2
> >  struct selinux_netlbl_cache {
> >  	u32 type;
> >  	union {
> > diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> > index ba715f4..7af1c78 100644
> > --- a/security/selinux/xfrm.c
> > +++ b/security/selinux/xfrm.c
> > @@ -8,7 +8,7 @@
> >   *
> >   *  Updated: Venkat Yekkirala <vyekkirala@TrustedCS.com>
> >   *
> > - *           Granular IPSec Associations for use in MLS environments.
> > + *	     Granular IPSec Associations for use in MLS environments.
> >   *
> >   *  Copyright (C) 2005 International Business Machines Corporation
> >   *  Copyright (C) 2006 Trusted Computer Solutions, Inc.
> > 
> > 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
