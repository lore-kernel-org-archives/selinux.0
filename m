Subject: Re: [RFC PATCH] SELinux: differentiate between open and r/w
	operations
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>, jmorris@namei.org, dwalsh@redhat.com,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1203706979.2914.46.camel@localhost.localdomain>
References: <1203706979.2914.46.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 22 Feb 2008 15:21:40 -0500
Message-Id: <1203711700.2804.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-22 at 14:02 -0500, Eric Paris wrote:
> An often found problem with selinux in the wild is the use of things
> like stdout redirection to a file.  As an example it may be perfectly
> reasonable for a user to run a daemon in the foreground for debugging
> and pipe the output to a file in /tmp.  But it would unreasonable for
> that daemon to directly open a file in /tmp.  Currently SELinux sees
> both of these as the same security operation.
> 
> By separating the open permission from the r/w permission we are able to
> more broadly grant r/w permissions while still being able to see and
> stop a number of attack vectors and misbehaving programs.
> 
> ---
> 
> This patch makes use of Paul Moore's new capability map but that was
> completely untested by me.  I actually just added a new selinuxfs file
> to turn these checks on and off at will during my testing and never even
> defined the permissions in my running policy.  So to say the least
> testing is a bit short.  Does it look right to you on first glance Paul?
> 
> It did however work.  If prog1 opened a bunch of files and then execve'd
> prog2 we would have.  prog1 need open+r/w and prog2 just needs r/w.
> 
>  security/selinux/hooks.c                     |   33 +++++++++++++++++++++++++-
>  security/selinux/include/av_perm_to_string.h |    5 ++++
>  security/selinux/include/av_permissions.h    |    5 ++++
>  security/selinux/include/security.h          |    2 +
>  security/selinux/ss/services.c               |    3 ++
>  5 files changed, 47 insertions(+), 1 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 75c2e99..fd911fe 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1616,6 +1616,37 @@ static inline u32 file_to_av(struct file *file)
>  	return av;
>  }
>  
> +/*
> + * Convert a Linux file to an access vector and include the correct open
> + * open permission.
> + */
> +static inline u32 open_file_to_av(struct file *file)
> +{
> +	struct inode *inode = file->f_path.dentry->d_inode;
> +	u32 av = file_to_av(file);
> +
> +	if (selinux_policycap_openperm) {
> +		/*
> +		 * lnk files and socks do not really have an 'open'
> +		 */
> +		if (S_ISREG(inode->i_mode))
> +			av |= FILE__OPEN;
> +		else if (S_ISCHR(inode->i_mode))
> +			av |= CHR_FILE__OPEN;
> +		else if (S_ISBLK(inode->i_mode))
> +			av |= BLK_FILE__OPEN;
> +		else if (S_ISFIFO(inode->i_mode))
> +			av |= FIFO_FILE__OPEN;
> +		else if (S_ISDIR(inode->i_mode))
> +			av |= DIR__OPEN;
> +		else {
> +			printk(KERN_EMERG "inside open_file_to_av with unknown mode:%x\n", inode->i_mode);
> +			BUG();
> +		}
> +	}
> +	return av;
> +}
> +
>  /* Hook functions begin here. */
>  
>  static int selinux_ptrace(struct task_struct *parent, struct task_struct *child)
> @@ -3031,7 +3062,7 @@ static int selinux_dentry_open(struct file *file)
>  	 * new inode label or new policy.
>  	 * This check is not redundant - do not remove.
>  	 */
> -	return inode_has_perm(current, inode, file_to_av(file), NULL);
> +	return inode_has_perm(current, inode, open_file_to_av(file), NULL);

Do we only want this new open permission checked in
selinux_dentry_open() or should it be checked by
selinux_inode_permission()?

selinux_inode_permission() is the original open-time check.
selinux_dentry_open() was only introduced to save state for Yuichi's
improve read/write performance patch.  It only rechecks access because
there is a small window where the saved state might have changed since
the original selinux_inode_permission() check, and we want to ensure
that we don't then fail to revalidate read/write at all.

I'd tend to think that the open check should occur in
selinux_inode_permission() and only there.


>  }
>  
>  /* task security operations */
> diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
> index d569669..1223b4f 100644
> --- a/security/selinux/include/av_perm_to_string.h
> +++ b/security/selinux/include/av_perm_to_string.h
> @@ -14,12 +14,17 @@
>     S_(SECCLASS_DIR, DIR__REPARENT, "reparent")
>     S_(SECCLASS_DIR, DIR__SEARCH, "search")
>     S_(SECCLASS_DIR, DIR__RMDIR, "rmdir")
> +   S_(SECCLASS_DIR, DIR__OPEN, "open")
>     S_(SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, "execute_no_trans")
>     S_(SECCLASS_FILE, FILE__ENTRYPOINT, "entrypoint")
>     S_(SECCLASS_FILE, FILE__EXECMOD, "execmod")
> +   S_(SECCLASS_FILE, FILE__OPEN, "open")
>     S_(SECCLASS_CHR_FILE, CHR_FILE__EXECUTE_NO_TRANS, "execute_no_trans")
>     S_(SECCLASS_CHR_FILE, CHR_FILE__ENTRYPOINT, "entrypoint")
>     S_(SECCLASS_CHR_FILE, CHR_FILE__EXECMOD, "execmod")
> +   S_(SECCLASS_CHR_FILE, CHR_FILE__OPEN, "open")
> +   S_(SECCLASS_BLK_FILE, BLK_FILE__OPEN, "open")
> +   S_(SECCLASS_FIFO_FILE, FIFO_FILE__OPEN, "open")
>     S_(SECCLASS_FD, FD__USE, "use")
>     S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto")
>     S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NEWCONN, "newconn")
> diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
> index 75b4131..c4c5116 100644
> --- a/security/selinux/include/av_permissions.h
> +++ b/security/selinux/include/av_permissions.h
> @@ -79,6 +79,7 @@
>  #define DIR__REPARENT                             0x00080000UL
>  #define DIR__SEARCH                               0x00100000UL
>  #define DIR__RMDIR                                0x00200000UL
> +#define DIR__OPEN                                 0x00400000UL
>  #define FILE__IOCTL                               0x00000001UL
>  #define FILE__READ                                0x00000002UL
>  #define FILE__WRITE                               0x00000004UL
> @@ -99,6 +100,7 @@
>  #define FILE__EXECUTE_NO_TRANS                    0x00020000UL
>  #define FILE__ENTRYPOINT                          0x00040000UL
>  #define FILE__EXECMOD                             0x00080000UL
> +#define FILE__OPEN                                0x00100000UL
>  #define LNK_FILE__IOCTL                           0x00000001UL
>  #define LNK_FILE__READ                            0x00000002UL
>  #define LNK_FILE__WRITE                           0x00000004UL
> @@ -136,6 +138,7 @@
>  #define CHR_FILE__EXECUTE_NO_TRANS                0x00020000UL
>  #define CHR_FILE__ENTRYPOINT                      0x00040000UL
>  #define CHR_FILE__EXECMOD                         0x00080000UL
> +#define CHR_FILE__OPEN                            0x00100000UL
>  #define BLK_FILE__IOCTL                           0x00000001UL
>  #define BLK_FILE__READ                            0x00000002UL
>  #define BLK_FILE__WRITE                           0x00000004UL
> @@ -153,6 +156,7 @@
>  #define BLK_FILE__SWAPON                          0x00004000UL
>  #define BLK_FILE__QUOTAON                         0x00008000UL
>  #define BLK_FILE__MOUNTON                         0x00010000UL
> +#define BLK_FILE__OPEN                            0x00020000UL
>  #define SOCK_FILE__IOCTL                          0x00000001UL
>  #define SOCK_FILE__READ                           0x00000002UL
>  #define SOCK_FILE__WRITE                          0x00000004UL
> @@ -187,6 +191,7 @@
>  #define FIFO_FILE__SWAPON                         0x00004000UL
>  #define FIFO_FILE__QUOTAON                        0x00008000UL
>  #define FIFO_FILE__MOUNTON                        0x00010000UL
> +#define FIFO_FILE__OPEN                           0x00020000UL
>  #define FD__USE                                   0x00000001UL
>  #define SOCKET__IOCTL                             0x00000001UL
>  #define SOCKET__READ                              0x00000002UL
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 837ce42..fa30f53 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -43,11 +43,13 @@ extern int selinux_mls_enabled;
>  /* Policy capabilities */
>  enum {
>  	POLICYDB_CAPABILITY_NETPEER,
> +	POLICYDB_CAPABILITY_OPENPERM,
>  	__POLICYDB_CAPABILITY_MAX
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>  
>  extern int selinux_policycap_netpeer;
> +extern int selinux_policycap_openperm;
>  
>  int security_load_policy(void * data, size_t len);
>  
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index f374186..23a61f1 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -61,6 +61,7 @@ extern void selnl_notify_policyload(u32 seqno);
>  unsigned int policydb_loaded_version;
>  
>  int selinux_policycap_netpeer;
> +int selinux_policycap_openperm;
>  
>  /*
>   * This is declared in avc.c
> @@ -1306,6 +1307,8 @@ static void security_load_policycaps(void)
>  {
>  	selinux_policycap_netpeer = ebitmap_get_bit(&policydb.policycaps,
>  						  POLICYDB_CAPABILITY_NETPEER);
> +	selinux_policycap_openperm = ebitmap_get_bit(&policydb.policycaps,
> +						  POLICYDB_CAPABILITY_OPENPERM);
>  }
>  
>  extern void selinux_complete_init(void);
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
