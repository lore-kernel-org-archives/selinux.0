Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7PMSAOb020568
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2005 18:28:11 -0400 (EDT)
Received: from smtp.osdl.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7PMGS2h010699
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2005 22:16:30 GMT
Date: Thu, 25 Aug 2005 15:17:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@namei.org>, Stephen Smalley <sds@epoch.ncsc.mil>
Cc: linux-security-module@wirex.com, selinux@tycho.nsa.gov
Subject: selinux stacked ops
Message-ID: <20050825221732.GR7991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm unclear on the internal stacking for SELinux.  Some of them make sense
from the perpsective of working with capablities, specifically these:

rc = secondary_ops->ptrace(parent,child);
return secondary_ops->capget(target, effective, inheritable, permitted);        error = secondary_ops->capset_check(target, effective, inheritable, permitted);
secondary_ops->capset_set(target, effective, inheritable, permitted);
rc = secondary_ops->capable(tsk, cap);
rc = secondary_ops->syslog(type);
rc = secondary_ops->capable(current, CAP_SYS_ADMIN); /* for vm_enough_memory */
rc = secondary_ops->bprm_set_security(bprm);
return (atsecure || secondary_ops->bprm_secureexec(bprm));
secondary_ops->bprm_apply_creds(bprm, unsafe);
err = secondary_ops->netlink_send(sk, skb);
      (not exactly using netlink_recv)
return secondary_ops->task_post_setuid(id0,id1,id2,flags);
secondary_ops->task_reparent_to_init(p);

not using cap:
cap_settime (obviously)
cap_inode_setxattr (makes sense)
cap_inode_removexattr (makes sense)
cap_vm_enough_memory (makes sense)

These are no-ops in dummy or capabilities, but don't represent the rest
of the hooks, or the rest in a single object area (i.e. task or inode).
Looks like (from discussion in early May) they were added to help stack
with grsec and something else?

rc = secondary_ops->sysctl(table, op);
return secondary_ops->bprm_check_security(bprm);
rc = secondary_ops->sb_mount(dev_name, nd, type, flags, data);
rc = secondary_ops->sb_umount(mnt, flags);
rc = secondary_ops->inode_link(old_dentry,dir,new_dentry);  /* maybe owlsm? */
rc = secondary_ops->inode_unlink(dir, dentry);
rc = secondary_ops->inode_mknod(dir, dentry, mode, dev);
rc = secondary_ops->inode_follow_link(dentry,nameidata);    /* maybe owlsm? */
rc = secondary_ops->inode_permission(inode, mask, nd);
rc = secondary_ops->inode_setattr(dentry, iattr);
rc = secondary_ops->file_mmap(file, reqprot, prot, flags);  /* maybe digsig? */
rc = secondary_ops->file_mprotect(vma, reqprot, prot);      /* maybe digsig? */
rc = secondary_ops->task_create(clone_flags);
rc = secondary_ops->task_setnice(p, nice);
rc = secondary_ops->task_setrlimit(resource, new_rlim);
rc = secondary_ops->task_kill(p, info, sig);
err = secondary_ops->unix_stream_connect(sock, other, newsk);
rc = secondary_ops->shm_shmat(shp, shmaddr, shmflg);

Would it make more sense to directly use cap_* as library functions,
and drop the whole ad-hoc internal stacking?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
