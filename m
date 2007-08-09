Subject: Re: xattr and LSM interaction
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Vance <Christopher.Vance@sparta.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <36BDDAA7-7173-42C5-A779-0BD6F1143625@sparta.com>
References: <36BDDAA7-7173-42C5-A779-0BD6F1143625@sparta.com>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 17:06:05 -0400
Message-Id: <1186693565.6916.753.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-09 at 15:43 -0400, Chris Vance wrote:
> Having spent a bit of time looking at the vfs_getxattr and  
> vfs_setxattr (as well as the rest of the xattr management calls), I  
> would appreciate a second opinion or an explanation of the  
> interaction between the xattr code and the LSM code.
> 
> It's been a few years since I've lingered in the Linux kernel, so I  
> might have missed another bit of code interaction.  Please let me  
> know if my interpretation is wrong.
> 
>   107 ssize_t
>   108 vfs_getxattr(struct dentry *dentry, char *name, void *value,  
> size_t size)
>   109 {
>   110         struct inode *inode = dentry->d_inode;
>   111         int error;
>   112
>   113         error = xattr_permission(inode, name, MAY_READ);
>   114         if (error)
>   115                 return error;
>   116
>   117         error = security_inode_getxattr(dentry, name);
>   118         if (error)
>   119                 return error;
>   120
>   121         if (inode->i_op->getxattr)
>   122                 error = inode->i_op->getxattr(dentry, name,  
> value, size);
>   123         else
>   124                 error = -EOPNOTSUPP;
>   125
>   126         if (!strncmp(name, XATTR_SECURITY_PREFIX,
>   127                                 XATTR_SECURITY_PREFIX_LEN)) {
>   128                 const char *suffix = name +  
> XATTR_SECURITY_PREFIX_LEN;
>   129                 int ret = security_inode_getsecurity(inode,  
> suffix, value,
>   130                                                      size, error);
>   131                 /*
>   132                  * Only overwrite the return value if a  
> security module
>   133                  * is actually active.
>   134                  */
>   135                 if (ret != -EOPNOTSUPP)
>   136                         error = ret;
>   137         }
>   138
>   139         return error;
>   140 }
> 
> It looks like if the file system supports xattrs, I/O is performed to  
> go off and retrieve the persistent xattr.  A few lines later, if  
> SELinux is loaded (or any LSM), the persistent xattr value and error  
> code are discarded and replaced by the in-memory inode label  
> retrieved by security_inode_getsecurity().

Yep.  There is a fair amount of history there; in the beginning, the vfs
always called the fs ->getxattr method and we had to add pseudo xattr
handlers to each fs that didn't have native support (e.g. tmpfs, devpts)
that redirected into the security module and had zero support for seeing
the in-core label of many filesystem types; then later we introduced
support in the vfs to fallback to calling the security module if the fs
didn't implement ->getxattr; still later that fallback was turned into
an unconditional override to allow canonicalization of the context by
the security module if desired.  The last piece was driven by the
transition to MLS-enabled (for compat on legacy filesystems) but was
also useful for letting us display the actual in-core label for e.g.
filesystems that use mountpoint labeling (filesystems mounted with
context= options).  

> I have a couple questions:
> 1) Why is the I/O essentially unconditional if the results are  
> intended to be replaced by the value retrieved via the LSM hook.

It allows the hook to look at the on-disk value and make a decision
about what it wants to do, e.g. replace it, use it, whatever.  At one
time SELinux looked at it and only replaced it if it didn't already
match the canonical value, but that turned out to be no more expensive
than just always replacing.

> 2) Is it always correct to prefer the in-memory-LSM-retrieved  
> representation over the persistent label?  I believe there are cases  
> where the persistent label can be different from the in-memory inode  
> label (if the persistent label is no longer valid in the context of  
> the currently loaded policy, it will default to unlabeled_t, right?).

They can differ, but if you want the kernel to present its internal view
of the MAC label to userspace, then this is the right answer.
Otherwise, userspace can e.g. see etc_t but the kernel is handling as
unlabeled_t (due to type removal in policy) or even as foo_t (due to
context mount overriding the on-disk value), which is no less confusing
and can cause its own kind of breakage (e.g. some applications only
relabel if the file doesn't already have the right label).

> 3) Is there a way to retrieve the actual persistent label, or is this  
> never needed?

I can see where it can be useful, but there isn't currently any user
demanding it.

> An unrelated side note is that hooks.c computes (sizeof  
> XATTR_SECURITY_PREFIX - 1) vs. using XATTR_SECURITY_PREFIX_LEN.   

Likely wasn't defined when that code was first written.  Got a patch?

> Sometimes the LSM hooks pass the entire xattr name, sometimes a  
> portion of it.  The modules must have code to check for ownership a  
> couple ways.

Yep, I think that's a legacy of how the inode_setsecurity/getsecurity
hooks were originally called from the fs handlers for ->setxattr and
->getxttr after the namespace was already parsed and stripped.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
