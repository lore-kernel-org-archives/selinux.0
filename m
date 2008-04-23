Date: Wed, 23 Apr 2008 15:52:22 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: include/security.h whitespace, syntax, and
 other cleanups
In-Reply-To: <12089007782240-git-send-email-eparis@redhat.com>
Message-ID: <Xine.LNX.4.64.0804231552010.1831@us.intercode.com.au>
References: <12089007782175-git-send-email-eparis@redhat.com>
 <1208900778580-git-send-email-eparis@redhat.com> <12089007782327-git-send-email-eparis@redhat.com>
 <120890077840-git-send-email-eparis@redhat.com> <12089007784055-git-send-email-eparis@redhat.com>
 <12089007783451-git-send-email-eparis@redhat.com>
 <12089007782803-git-send-email-eparis@redhat.com>
 <12089007782044-git-send-email-eparis@redhat.com>
 <12089007783524-git-send-email-eparis@redhat.com> <1208900778330-git-send-email-eparis@redhat.com>
 <12089007782240-git-send-email-eparis@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

All applied except for this one, which clashes with a VFS change.



On Tue, 22 Apr 2008, eparis@redhat.com wrote:

> From: Eric Paris <eparis@redhat.com>
> 
> This patch changes include/security.h to fix whitespace and syntax issues.  Things that
> are fixed may include (does not not have to include)
> 
> whitespace at end of lines
> spaces followed by tabs
> spaces used instead of tabs
> spacing around parenthesis
> location of { around structs and else clauses
> location of * in pointer declarations
> removal of initialization of static data to keep it in the right section
> useless {} in if statemetns
> useless checking for NULL before kfree
> fixing of the indentation depth of switch statements
> no assignments in if statements
> include spaces around , in function calls
> and any number of other things I forgot to mention
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>  include/linux/security.h |  859 +++++++++++++++++++++++-----------------------
>  1 files changed, 429 insertions(+), 430 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index fea1f4a..b3acb54 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -46,25 +46,25 @@ struct audit_krule;
>   * These functions are in security/capability.c and are used
>   * as the default capabilities functions
>   */
> -extern int cap_capable (struct task_struct *tsk, int cap);
> -extern int cap_settime (struct timespec *ts, struct timezone *tz);
> -extern int cap_ptrace (struct task_struct *parent, struct task_struct *child);
> -extern int cap_capget (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
> -extern int cap_capset_check (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
> -extern void cap_capset_set (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
> -extern int cap_bprm_set_security (struct linux_binprm *bprm);
> -extern void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe);
> +extern int cap_capable(struct task_struct *tsk, int cap);
> +extern int cap_settime(struct timespec *ts, struct timezone *tz);
> +extern int cap_ptrace(struct task_struct *parent, struct task_struct *child);
> +extern int cap_capget(struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
> +extern int cap_capset_check(struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
> +extern void cap_capset_set(struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
> +extern int cap_bprm_set_security(struct linux_binprm *bprm);
> +extern void cap_bprm_apply_creds(struct linux_binprm *bprm, int unsafe);
>  extern int cap_bprm_secureexec(struct linux_binprm *bprm);
>  extern int cap_inode_setxattr(struct dentry *dentry, char *name, void *value, size_t size, int flags);
>  extern int cap_inode_removexattr(struct dentry *dentry, char *name);
>  extern int cap_inode_need_killpriv(struct dentry *dentry);
>  extern int cap_inode_killpriv(struct dentry *dentry);
> -extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
> -extern void cap_task_reparent_to_init (struct task_struct *p);
> -extern int cap_task_setscheduler (struct task_struct *p, int policy, struct sched_param *lp);
> -extern int cap_task_setioprio (struct task_struct *p, int ioprio);
> -extern int cap_task_setnice (struct task_struct *p, int nice);
> -extern int cap_syslog (int type);
> +extern int cap_task_post_setuid(uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
> +extern void cap_task_reparent_to_init(struct task_struct *p);
> +extern int cap_task_setscheduler(struct task_struct *p, int policy, struct sched_param *lp);
> +extern int cap_task_setioprio(struct task_struct *p, int ioprio);
> +extern int cap_task_setnice(struct task_struct *p, int nice);
> +extern int cap_syslog(int type);
>  extern int cap_vm_enough_memory(struct mm_struct *mm, long pages);
>  
>  struct msghdr;
> @@ -128,7 +128,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>  {
>  	int i;
>  	if (opts->mnt_opts)
> -		for(i = 0; i < opts->num_mnt_opts; i++)
> +		for (i = 0; i < opts->num_mnt_opts; i++)
>  			kfree(opts->mnt_opts[i]);
>  	kfree(opts->mnt_opts);
>  	opts->mnt_opts = NULL;
> @@ -190,21 +190,21 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	@bprm contains the linux_binprm structure.
>   *	Return 0 if the hook is successful and permission is granted.
>   * @bprm_check_security:
> - * 	This hook mediates the point when a search for a binary handler	will
> - * 	begin.  It allows a check the @bprm->security value which is set in
> - * 	the preceding set_security call.  The primary difference from
> - * 	set_security is that the argv list and envp list are reliably
> - * 	available in @bprm.  This hook may be called multiple times
> - * 	during a single execve; and in each pass set_security is called
> - * 	first.
> - * 	@bprm contains the linux_binprm structure.
> + *	This hook mediates the point when a search for a binary handler	will
> + *	begin.  It allows a check the @bprm->security value which is set in
> + *	the preceding set_security call.  The primary difference from
> + *	set_security is that the argv list and envp list are reliably
> + *	available in @bprm.  This hook may be called multiple times
> + *	during a single execve; and in each pass set_security is called
> + *	first.
> + *	@bprm contains the linux_binprm structure.
>   *	Return 0 if the hook is successful and permission is granted.
>   * @bprm_secureexec:
> - *      Return a boolean value (0 or 1) indicating whether a "secure exec" 
> - *      is required.  The flag is passed in the auxiliary table
> - *      on the initial stack to the ELF interpreter to indicate whether libc 
> - *      should enable secure mode.
> - *      @bprm contains the linux_binprm structure.
> + *	Return a boolean value (0 or 1) indicating whether a "secure exec"
> + *	is required.  The flag is passed in the auxiliary table
> + *	on the initial stack to the ELF interpreter to indicate whether libc
> + *	should enable secure mode.
> + *	@bprm contains the linux_binprm structure.
>   *
>   * Security hooks for filesystem operations.
>   *
> @@ -221,7 +221,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	Check permission before obtaining filesystem statistics for the @mnt
>   *	mountpoint.
>   *	@dentry is a handle on the superblock for the filesystem.
> - *	Return 0 if permission is granted.  
> + *	Return 0 if permission is granted.
>   * @sb_mount:
>   *	Check permission before an object specified by @dev_name is mounted on
>   *	the mount point named by @nd.  For an ordinary mount, @dev_name
> @@ -282,12 +282,12 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   * @sb_pivotroot:
>   *	Check permission before pivoting the root filesystem.
>   *	@old_nd contains the nameidata structure for the new location of the current root (put_old).
> - *      @new_nd contains the nameidata structure for the new root (new_root).
> + *	@new_nd contains the nameidata structure for the new root (new_root).
>   *	Return 0 if permission is granted.
>   * @sb_post_pivotroot:
>   *	Update module state after a successful pivot.
>   *	@old_nd contains the nameidata structure for the old root.
> - *      @new_nd contains the nameidata structure for the new root.
> + *	@new_nd contains the nameidata structure for the new root.
>   * @sb_get_mnt_opts:
>   *	Get the security relevant mount options used for a superblock
>   *	@sb the superblock to get security mount options from
> @@ -316,9 +316,9 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   * @inode_free_security:
>   *	@inode contains the inode structure.
>   *	Deallocate the inode security structure and set @inode->i_security to
> - *	NULL. 
> + *	NULL.
>   * @inode_init_security:
> - * 	Obtain the security attribute name suffix and value to set on a newly
> + *	Obtain the security attribute name suffix and value to set on a newly
>   *	created inode and set up the incore security field for the new inode.
>   *	This hook is called by the fs code as part of the inode creation
>   *	transaction and provides for atomic labeling of the inode, unlike
> @@ -349,7 +349,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	@new_dentry contains the dentry structure for the new link.
>   *	Return 0 if permission is granted.
>   * @inode_unlink:
> - *	Check the permission to remove a hard link to a file. 
> + *	Check the permission to remove a hard link to a file.
>   *	@dir contains the inode structure of parent directory of the file.
>   *	@dentry contains the dentry structure for file to be unlinked.
>   *	Return 0 if permission is granted.
> @@ -361,7 +361,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	Return 0 if permission is granted.
>   * @inode_mkdir:
>   *	Check permissions to create a new directory in the existing directory
> - *	associated with inode strcture @dir. 
> + *	associated with inode strcture @dir.
>   *	@dir containst the inode structure of parent of the directory to be created.
>   *	@dentry contains the dentry structure of new directory.
>   *	@mode contains the mode of new directory.
> @@ -406,7 +406,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	called when the actual read/write operations are performed.
>   *	@inode contains the inode structure to check.
>   *	@mask contains the permission mask.
> - *     @nd contains the nameidata (may be NULL).
> + *	@nd contains the nameidata (may be NULL).
>   *	Return 0 if permission is granted.
>   * @inode_setattr:
>   *	Check permission before setting file attributes.  Note that the kernel
> @@ -428,24 +428,24 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	can use this hook to release any persistent label associated with the
>   *	inode.
>   * @inode_setxattr:
> - * 	Check permission before setting the extended attributes
> - * 	@value identified by @name for @dentry.
> - * 	Return 0 if permission is granted.
> + *	Check permission before setting the extended attributes
> + *	@value identified by @name for @dentry.
> + *	Return 0 if permission is granted.
>   * @inode_post_setxattr:
> - * 	Update inode security field after successful setxattr operation.
> - * 	@value identified by @name for @dentry.
> + *	Update inode security field after successful setxattr operation.
> + *	@value identified by @name for @dentry.
>   * @inode_getxattr:
> - * 	Check permission before obtaining the extended attributes
> - * 	identified by @name for @dentry.
> - * 	Return 0 if permission is granted.
> + *	Check permission before obtaining the extended attributes
> + *	identified by @name for @dentry.
> + *	Return 0 if permission is granted.
>   * @inode_listxattr:
> - * 	Check permission before obtaining the list of extended attribute 
> - * 	names for @dentry.
> - * 	Return 0 if permission is granted.
> + *	Check permission before obtaining the list of extended attribute
> + *	names for @dentry.
> + *	Return 0 if permission is granted.
>   * @inode_removexattr:
> - * 	Check permission before removing the extended attribute
> - * 	identified by @name for @dentry.
> - * 	Return 0 if permission is granted.
> + *	Check permission before removing the extended attribute
> + *	identified by @name for @dentry.
> + *	Return 0 if permission is granted.
>   * @inode_getsecurity:
>   *	Retrieve a copy of the extended attribute representation of the
>   *	security label associated with @name for @inode via @buffer.  Note that
> @@ -457,7 +457,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	Set the security label associated with @name for @inode from the
>   *	extended attribute value @value.  @size indicates the size of the
>   *	@value in bytes.  @flags may be XATTR_CREATE, XATTR_REPLACE, or 0.
> - *	Note that @name is the remainder of the attribute name after the 
> + *	Note that @name is the remainder of the attribute name after the
>   *	security. prefix has been removed.
>   *	Return 0 on success.
>   * @inode_listsecurity:
> @@ -564,7 +564,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	struct file, so the file structure (and associated security information)
>   *	can always be obtained:
>   *		container_of(fown, struct file, f_owner)
> - * 	@tsk contains the structure of task receiving signal.
> + *	@tsk contains the structure of task receiving signal.
>   *	@fown contains the file owner information.
>   *	@sig is the signal that will be sent.  When 0, kernel sends SIGIO.
>   *	Return 0 if permission is granted.
> @@ -722,12 +722,12 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	@arg5 contains a argument.
>   *	Return 0 if permission is granted.
>   * @task_reparent_to_init:
> - * 	Set the security attributes in @p->security for a kernel thread that
> - * 	is being reparented to the init task.
> + *	Set the security attributes in @p->security for a kernel thread that
> + *	is being reparented to the init task.
>   *	@p contains the task_struct for the kernel thread.
>   * @task_to_inode:
> - * 	Set the security attributes for an inode based on an associated task's
> - * 	security attributes, e.g. for /proc/pid inodes.
> + *	Set the security attributes for an inode based on an associated task's
> + *	security attributes, e.g. for /proc/pid inodes.
>   *	@p contains the task_struct for the task.
>   *	@inode contains the inode structure for the inode.
>   *
> @@ -737,7 +737,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	Save security information for a netlink message so that permission
>   *	checking can be performed when the message is processed.  The security
>   *	information can be saved using the eff_cap field of the
> - *      netlink_skb_parms structure.  Also may be used to provide fine
> + *	netlink_skb_parms structure.  Also may be used to provide fine
>   *	grained control over message transmission.
>   *	@sk associated sock of task sending the message.,
>   *	@skb contains the sk_buff structure for the netlink message.
> @@ -805,14 +805,14 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	@sock contains the socket structure.
>   *	@address contains the address to bind to.
>   *	@addrlen contains the length of address.
> - *	Return 0 if permission is granted.  
> + *	Return 0 if permission is granted.
>   * @socket_connect:
>   *	Check permission before socket protocol layer connect operation
>   *	attempts to connect socket @sock to a remote address, @address.
>   *	@sock contains the socket structure.
>   *	@address contains the address of remote endpoint.
>   *	@addrlen contains the length of address.
> - *	Return 0 if permission is granted.  
> + *	Return 0 if permission is granted.
>   * @socket_listen:
>   *	Check permission before socket protocol layer listen operation.
>   *	@sock contains the socket structure.
> @@ -842,7 +842,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	@msg contains the message structure.
>   *	@size contains the size of message structure.
>   *	@flags contains the operational flags.
> - *	Return 0 if permission is granted.  
> + *	Return 0 if permission is granted.
>   * @socket_getsockname:
>   *	Check permission before the local address (name) of the socket object
>   *	@sock is retrieved.
> @@ -866,7 +866,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	@sock contains the socket structure.
>   *	@level contains the protocol level to set options for.
>   *	@optname contains the name of the option to set.
> - *	Return 0 if permission is granted.  
> + *	Return 0 if permission is granted.
>   * @socket_shutdown:
>   *	Checks permission before all or part of a connection on the socket
>   *	@sock is shut down.
> @@ -893,19 +893,19 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	Return 0 if all is well, otherwise, typical getsockopt return
>   *	values.
>   * @socket_getpeersec_dgram:
> - * 	This hook allows the security module to provide peer socket security
> - * 	state for udp sockets on a per-packet basis to userspace via
> - * 	getsockopt SO_GETPEERSEC.  The application must first have indicated
> - * 	the IP_PASSSEC option via getsockopt.  It can then retrieve the
> - * 	security state returned by this hook for a packet via the SCM_SECURITY
> - * 	ancillary message type.
> - * 	@skb is the skbuff for the packet being queried
> - * 	@secdata is a pointer to a buffer in which to copy the security data
> - * 	@seclen is the maximum length for @secdata
> - * 	Return 0 on success, error on failure.
> + *	This hook allows the security module to provide peer socket security
> + *	state for udp sockets on a per-packet basis to userspace via
> + *	getsockopt SO_GETPEERSEC.  The application must first have indicated
> + *	the IP_PASSSEC option via getsockopt.  It can then retrieve the
> + *	security state returned by this hook for a packet via the SCM_SECURITY
> + *	ancillary message type.
> + *	@skb is the skbuff for the packet being queried
> + *	@secdata is a pointer to a buffer in which to copy the security data
> + *	@seclen is the maximum length for @secdata
> + *	Return 0 on success, error on failure.
>   * @sk_alloc_security:
> - *      Allocate and attach a security structure to the sk->sk_security field,
> - *      which is used to copy security attributes between local stream sockets.
> + *	Allocate and attach a security structure to the sk->sk_security field,
> + *	which is used to copy security attributes between local stream sockets.
>   * @sk_free_security:
>   *	Deallocate security structure.
>   * @sk_clone_security:
> @@ -920,7 +920,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   * @inet_csk_clone:
>   *	Sets the new child socket's sid to the openreq sid.
>   * @inet_conn_established:
> - *     Sets the connection's peersid to the secmark on skb.
> + *	Sets the connection's peersid to the secmark on skb.
>   * @req_classify_flow:
>   *	Sets the flow's sid to the openreq sid.
>   *
> @@ -999,13 +999,13 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	No return value.
>   * @key_permission:
>   *	See whether a specific operational right is granted to a process on a
> - *      key.
> + *	key.
>   *	@key_ref refers to the key (key pointer + possession attribute bit).
>   *	@context points to the process to provide the context against which to
> - *       evaluate the security data on the key.
> + *	evaluate the security data on the key.
>   *	@perm describes the combination of permissions required of this key.
>   *	Return 1 if permission granted, 0 if permission denied and -ve it the
> - *      normal permissions model should be effected.
> + *	normal permissions model should be effected.
>   *
>   * Security hooks affecting all System V IPC operations.
>   *
> @@ -1056,7 +1056,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	The @msq may be NULL, e.g. for IPC_INFO or MSG_INFO.
>   *	@msq contains the message queue to act upon.  May be NULL.
>   *	@cmd contains the operation to be performed.
> - *	Return 0 if permission is granted.  
> + *	Return 0 if permission is granted.
>   * @msg_queue_msgsnd:
>   *	Check permission before a message, @msg, is enqueued on the message
>   *	queue, @msq.
> @@ -1066,8 +1066,8 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	Return 0 if permission is granted.
>   * @msg_queue_msgrcv:
>   *	Check permission before a message, @msg, is removed from the message
> - *	queue, @msq.  The @target task structure contains a pointer to the 
> - *	process that will be receiving the message (not equal to the current 
> + *	queue, @msq.  The @target task structure contains a pointer to the
> + *	process that will be receiving the message (not equal to the current
>   *	process when inline receives are being performed).
>   *	@msq contains the message queue to retrieve message from.
>   *	@msg contains the message destination.
> @@ -1132,15 +1132,15 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	Return 0 if permission is granted.
>   * @sem_semctl:
>   *	Check permission when a semaphore operation specified by @cmd is to be
> - *	performed on the semaphore @sma.  The @sma may be NULL, e.g. for 
> + *	performed on the semaphore @sma.  The @sma may be NULL, e.g. for
>   *	IPC_INFO or SEM_INFO.
>   *	@sma contains the semaphore structure.  May be NULL.
>   *	@cmd contains the operation to be performed.
>   *	Return 0 if permission is granted.
>   * @sem_semop
>   *	Check permissions before performing operations on members of the
> - *	semaphore set @sma.  If the @alter flag is nonzero, the semaphore set 
> - *      may be modified.
> + *	semaphore set @sma.  If the @alter flag is nonzero, the semaphore set
> + *	may be modified.
>   *	@sma contains the semaphore structure.
>   *	@sops contains the operations to perform.
>   *	@nsops contains the number of operations to perform.
> @@ -1211,7 +1211,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   * @syslog:
>   *	Check permission before accessing the kernel message ring or changing
>   *	logging to the console.
> - *	See the syslog(2) manual page for an explanation of the @type values.  
> + *	See the syslog(2) manual page for an explanation of the @type values.
>   *	@type contains the type of action.
>   *	Return 0 if permission is granted.
>   * @settime:
> @@ -1223,22 +1223,22 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   * @vm_enough_memory:
>   *	Check permissions for allocating a new virtual mapping.
>   *	@mm contains the mm struct it is being added to.
> - *      @pages contains the number of pages.
> + *	@pages contains the number of pages.
>   *	Return 0 if permission is granted.
>   *
>   * @register_security:
> - * 	allow module stacking.
> - * 	@name contains the name of the security module being stacked.
> - * 	@ops contains a pointer to the struct security_operations of the module to stack.
> - * 
> + *	allow module stacking.
> + *	@name contains the name of the security module being stacked.
> + *	@ops contains a pointer to the struct security_operations of the module to stack.
> + *
>   * @secid_to_secctx:
>   *	Convert secid to security context.
>   *	@secid contains the security ID.
>   *	@secdata contains the pointer that stores the converted security context.
>   * @secctx_to_secid:
> - *      Convert security context to secid.
> - *      @secid contains the pointer to the generated security ID.
> - *      @secdata contains the security context.
> + *	Convert security context to secid.
> + *	@secid contains the pointer to the generated security ID.
> + *	@secdata contains the security context.
>   *
>   * @release_secctx:
>   *	Release the security context.
> @@ -1281,54 +1281,54 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>  struct security_operations {
>  	char name[SECURITY_NAME_MAX + 1];
>  
> -	int (*ptrace) (struct task_struct * parent, struct task_struct * child);
> -	int (*capget) (struct task_struct * target,
> -		       kernel_cap_t * effective,
> -		       kernel_cap_t * inheritable, kernel_cap_t * permitted);
> -	int (*capset_check) (struct task_struct * target,
> -			     kernel_cap_t * effective,
> -			     kernel_cap_t * inheritable,
> -			     kernel_cap_t * permitted);
> -	void (*capset_set) (struct task_struct * target,
> -			    kernel_cap_t * effective,
> -			    kernel_cap_t * inheritable,
> -			    kernel_cap_t * permitted);
> -	int (*capable) (struct task_struct * tsk, int cap);
> -	int (*acct) (struct file * file);
> -	int (*sysctl) (struct ctl_table * table, int op);
> -	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
> -	int (*quota_on) (struct dentry * dentry);
> +	int (*ptrace) (struct task_struct *parent, struct task_struct *child);
> +	int (*capget) (struct task_struct *target,
> +		       kernel_cap_t *effective,
> +		       kernel_cap_t *inheritable, kernel_cap_t *permitted);
> +	int (*capset_check) (struct task_struct *target,
> +			     kernel_cap_t *effective,
> +			     kernel_cap_t *inheritable,
> +			     kernel_cap_t *permitted);
> +	void (*capset_set) (struct task_struct *target,
> +			    kernel_cap_t *effective,
> +			    kernel_cap_t *inheritable,
> +			    kernel_cap_t *permitted);
> +	int (*capable) (struct task_struct *tsk, int cap);
> +	int (*acct) (struct file *file);
> +	int (*sysctl) (struct ctl_table *table, int op);
> +	int (*quotactl) (int cmds, int type, int id, struct super_block *sb);
> +	int (*quota_on) (struct dentry *dentry);
>  	int (*syslog) (int type);
>  	int (*settime) (struct timespec *ts, struct timezone *tz);
>  	int (*vm_enough_memory) (struct mm_struct *mm, long pages);
>  
> -	int (*bprm_alloc_security) (struct linux_binprm * bprm);
> -	void (*bprm_free_security) (struct linux_binprm * bprm);
> -	void (*bprm_apply_creds) (struct linux_binprm * bprm, int unsafe);
> -	void (*bprm_post_apply_creds) (struct linux_binprm * bprm);
> -	int (*bprm_set_security) (struct linux_binprm * bprm);
> -	int (*bprm_check_security) (struct linux_binprm * bprm);
> -	int (*bprm_secureexec) (struct linux_binprm * bprm);
> -
> -	int (*sb_alloc_security) (struct super_block * sb);
> -	void (*sb_free_security) (struct super_block * sb);
> -	int (*sb_copy_data)(char *orig, char *copy);
> +	int (*bprm_alloc_security) (struct linux_binprm *bprm);
> +	void (*bprm_free_security) (struct linux_binprm *bprm);
> +	void (*bprm_apply_creds) (struct linux_binprm *bprm, int unsafe);
> +	void (*bprm_post_apply_creds) (struct linux_binprm *bprm);
> +	int (*bprm_set_security) (struct linux_binprm *bprm);
> +	int (*bprm_check_security) (struct linux_binprm *bprm);
> +	int (*bprm_secureexec) (struct linux_binprm *bprm);
> +
> +	int (*sb_alloc_security) (struct super_block *sb);
> +	void (*sb_free_security) (struct super_block *sb);
> +	int (*sb_copy_data) (char *orig, char *copy);
>  	int (*sb_kern_mount) (struct super_block *sb, void *data);
>  	int (*sb_statfs) (struct dentry *dentry);
> -	int (*sb_mount) (char *dev_name, struct nameidata * nd,
> +	int (*sb_mount) (char *dev_name, struct nameidata *nd,
>  			 char *type, unsigned long flags, void *data);
> -	int (*sb_check_sb) (struct vfsmount * mnt, struct nameidata * nd);
> -	int (*sb_umount) (struct vfsmount * mnt, int flags);
> -	void (*sb_umount_close) (struct vfsmount * mnt);
> -	void (*sb_umount_busy) (struct vfsmount * mnt);
> -	void (*sb_post_remount) (struct vfsmount * mnt,
> +	int (*sb_check_sb) (struct vfsmount *mnt, struct nameidata *nd);
> +	int (*sb_umount) (struct vfsmount *mnt, int flags);
> +	void (*sb_umount_close) (struct vfsmount *mnt);
> +	void (*sb_umount_busy) (struct vfsmount *mnt);
> +	void (*sb_post_remount) (struct vfsmount *mnt,
>  				 unsigned long flags, void *data);
> -	void (*sb_post_addmount) (struct vfsmount * mnt,
> -				  struct nameidata * mountpoint_nd);
> -	int (*sb_pivotroot) (struct nameidata * old_nd,
> -			     struct nameidata * new_nd);
> -	void (*sb_post_pivotroot) (struct nameidata * old_nd,
> -				   struct nameidata * new_nd);
> +	void (*sb_post_addmount) (struct vfsmount *mnt,
> +				  struct nameidata *mountpoint_nd);
> +	int (*sb_pivotroot) (struct nameidata *old_nd,
> +			     struct nameidata *new_nd);
> +	void (*sb_post_pivotroot) (struct nameidata *old_nd,
> +				   struct nameidata *new_nd);
>  	int (*sb_get_mnt_opts) (const struct super_block *sb,
>  				struct security_mnt_opts *opts);
>  	int (*sb_set_mnt_opts) (struct super_block *sb,
> @@ -1337,29 +1337,29 @@ struct security_operations {
>  				   struct super_block *newsb);
>  	int (*sb_parse_opts_str) (char *options, struct security_mnt_opts *opts);
>  
> -	int (*inode_alloc_security) (struct inode *inode);	
> +	int (*inode_alloc_security) (struct inode *inode);
>  	void (*inode_free_security) (struct inode *inode);
>  	int (*inode_init_security) (struct inode *inode, struct inode *dir,
>  				    char **name, void **value, size_t *len);
>  	int (*inode_create) (struct inode *dir,
> -	                     struct dentry *dentry, int mode);
> +			     struct dentry *dentry, int mode);
>  	int (*inode_link) (struct dentry *old_dentry,
> -	                   struct inode *dir, struct dentry *new_dentry);
> +			   struct inode *dir, struct dentry *new_dentry);
>  	int (*inode_unlink) (struct inode *dir, struct dentry *dentry);
>  	int (*inode_symlink) (struct inode *dir,
> -	                      struct dentry *dentry, const char *old_name);
> +			      struct dentry *dentry, const char *old_name);
>  	int (*inode_mkdir) (struct inode *dir, struct dentry *dentry, int mode);
>  	int (*inode_rmdir) (struct inode *dir, struct dentry *dentry);
>  	int (*inode_mknod) (struct inode *dir, struct dentry *dentry,
> -	                    int mode, dev_t dev);
> +			    int mode, dev_t dev);
>  	int (*inode_rename) (struct inode *old_dir, struct dentry *old_dentry,
> -	                     struct inode *new_dir, struct dentry *new_dentry);
> +			     struct inode *new_dir, struct dentry *new_dentry);
>  	int (*inode_readlink) (struct dentry *dentry);
>  	int (*inode_follow_link) (struct dentry *dentry, struct nameidata *nd);
>  	int (*inode_permission) (struct inode *inode, int mask, struct nameidata *nd);
>  	int (*inode_setattr)	(struct dentry *dentry, struct iattr *attr);
>  	int (*inode_getattr) (struct vfsmount *mnt, struct dentry *dentry);
> -        void (*inode_delete) (struct inode *inode);
> +	void (*inode_delete) (struct inode *inode);
>  	int (*inode_setxattr) (struct dentry *dentry, char *name, void *value,
>  			       size_t size, int flags);
>  	void (*inode_post_setxattr) (struct dentry *dentry, char *name, void *value,
> @@ -1369,140 +1369,140 @@ struct security_operations {
>  	int (*inode_removexattr) (struct dentry *dentry, char *name);
>  	int (*inode_need_killpriv) (struct dentry *dentry);
>  	int (*inode_killpriv) (struct dentry *dentry);
> -	int (*inode_getsecurity)(const struct inode *inode, const char *name, void **buffer, bool alloc);
> -  	int (*inode_setsecurity)(struct inode *inode, const char *name, const void *value, size_t size, int flags);
> -  	int (*inode_listsecurity)(struct inode *inode, char *buffer, size_t buffer_size);
> -	void (*inode_getsecid)(const struct inode *inode, u32 *secid);
> -
> -	int (*file_permission) (struct file * file, int mask);
> -	int (*file_alloc_security) (struct file * file);
> -	void (*file_free_security) (struct file * file);
> -	int (*file_ioctl) (struct file * file, unsigned int cmd,
> +	int (*inode_getsecurity) (const struct inode *inode, const char *name, void **buffer, bool alloc);
> +	int (*inode_setsecurity) (struct inode *inode, const char *name, const void *value, size_t size, int flags);
> +	int (*inode_listsecurity) (struct inode *inode, char *buffer, size_t buffer_size);
> +	void (*inode_getsecid) (const struct inode *inode, u32 *secid);
> +
> +	int (*file_permission) (struct file *file, int mask);
> +	int (*file_alloc_security) (struct file *file);
> +	void (*file_free_security) (struct file *file);
> +	int (*file_ioctl) (struct file *file, unsigned int cmd,
>  			   unsigned long arg);
> -	int (*file_mmap) (struct file * file,
> +	int (*file_mmap) (struct file *file,
>  			  unsigned long reqprot, unsigned long prot,
>  			  unsigned long flags, unsigned long addr,
>  			  unsigned long addr_only);
> -	int (*file_mprotect) (struct vm_area_struct * vma,
> +	int (*file_mprotect) (struct vm_area_struct *vma,
>  			      unsigned long reqprot,
>  			      unsigned long prot);
> -	int (*file_lock) (struct file * file, unsigned int cmd);
> -	int (*file_fcntl) (struct file * file, unsigned int cmd,
> +	int (*file_lock) (struct file *file, unsigned int cmd);
> +	int (*file_fcntl) (struct file *file, unsigned int cmd,
>  			   unsigned long arg);
> -	int (*file_set_fowner) (struct file * file);
> -	int (*file_send_sigiotask) (struct task_struct * tsk,
> -				    struct fown_struct * fown, int sig);
> -	int (*file_receive) (struct file * file);
> -	int (*dentry_open)  (struct file *file);
> +	int (*file_set_fowner) (struct file *file);
> +	int (*file_send_sigiotask) (struct task_struct *tsk,
> +				    struct fown_struct *fown, int sig);
> +	int (*file_receive) (struct file *file);
> +	int (*dentry_open) (struct file *file);
>  
>  	int (*task_create) (unsigned long clone_flags);
> -	int (*task_alloc_security) (struct task_struct * p);
> -	void (*task_free_security) (struct task_struct * p);
> +	int (*task_alloc_security) (struct task_struct *p);
> +	void (*task_free_security) (struct task_struct *p);
>  	int (*task_setuid) (uid_t id0, uid_t id1, uid_t id2, int flags);
>  	int (*task_post_setuid) (uid_t old_ruid /* or fsuid */ ,
>  				 uid_t old_euid, uid_t old_suid, int flags);
>  	int (*task_setgid) (gid_t id0, gid_t id1, gid_t id2, int flags);
> -	int (*task_setpgid) (struct task_struct * p, pid_t pgid);
> -	int (*task_getpgid) (struct task_struct * p);
> -	int (*task_getsid) (struct task_struct * p);
> -	void (*task_getsecid) (struct task_struct * p, u32 * secid);
> +	int (*task_setpgid) (struct task_struct *p, pid_t pgid);
> +	int (*task_getpgid) (struct task_struct *p);
> +	int (*task_getsid) (struct task_struct *p);
> +	void (*task_getsecid) (struct task_struct *p, u32 *secid);
>  	int (*task_setgroups) (struct group_info *group_info);
> -	int (*task_setnice) (struct task_struct * p, int nice);
> -	int (*task_setioprio) (struct task_struct * p, int ioprio);
> -	int (*task_getioprio) (struct task_struct * p);
> -	int (*task_setrlimit) (unsigned int resource, struct rlimit * new_rlim);
> -	int (*task_setscheduler) (struct task_struct * p, int policy,
> -				  struct sched_param * lp);
> -	int (*task_getscheduler) (struct task_struct * p);
> -	int (*task_movememory) (struct task_struct * p);
> -	int (*task_kill) (struct task_struct * p,
> -			  struct siginfo * info, int sig, u32 secid);
> -	int (*task_wait) (struct task_struct * p);
> +	int (*task_setnice) (struct task_struct *p, int nice);
> +	int (*task_setioprio) (struct task_struct *p, int ioprio);
> +	int (*task_getioprio) (struct task_struct *p);
> +	int (*task_setrlimit) (unsigned int resource, struct rlimit *new_rlim);
> +	int (*task_setscheduler) (struct task_struct *p, int policy,
> +				  struct sched_param *lp);
> +	int (*task_getscheduler) (struct task_struct *p);
> +	int (*task_movememory) (struct task_struct *p);
> +	int (*task_kill) (struct task_struct *p,
> +			  struct siginfo *info, int sig, u32 secid);
> +	int (*task_wait) (struct task_struct *p);
>  	int (*task_prctl) (int option, unsigned long arg2,
>  			   unsigned long arg3, unsigned long arg4,
>  			   unsigned long arg5);
> -	void (*task_reparent_to_init) (struct task_struct * p);
> +	void (*task_reparent_to_init) (struct task_struct *p);
>  	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
>  
> -	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
> +	int (*ipc_permission) (struct kern_ipc_perm *ipcp, short flag);
>  	void (*ipc_getsecid) (struct kern_ipc_perm *ipcp, u32 *secid);
>  
> -	int (*msg_msg_alloc_security) (struct msg_msg * msg);
> -	void (*msg_msg_free_security) (struct msg_msg * msg);
> -
> -	int (*msg_queue_alloc_security) (struct msg_queue * msq);
> -	void (*msg_queue_free_security) (struct msg_queue * msq);
> -	int (*msg_queue_associate) (struct msg_queue * msq, int msqflg);
> -	int (*msg_queue_msgctl) (struct msg_queue * msq, int cmd);
> -	int (*msg_queue_msgsnd) (struct msg_queue * msq,
> -				 struct msg_msg * msg, int msqflg);
> -	int (*msg_queue_msgrcv) (struct msg_queue * msq,
> -				 struct msg_msg * msg,
> -				 struct task_struct * target,
> +	int (*msg_msg_alloc_security) (struct msg_msg *msg);
> +	void (*msg_msg_free_security) (struct msg_msg *msg);
> +
> +	int (*msg_queue_alloc_security) (struct msg_queue *msq);
> +	void (*msg_queue_free_security) (struct msg_queue *msq);
> +	int (*msg_queue_associate) (struct msg_queue *msq, int msqflg);
> +	int (*msg_queue_msgctl) (struct msg_queue *msq, int cmd);
> +	int (*msg_queue_msgsnd) (struct msg_queue *msq,
> +				 struct msg_msg *msg, int msqflg);
> +	int (*msg_queue_msgrcv) (struct msg_queue *msq,
> +				 struct msg_msg *msg,
> +				 struct task_struct *target,
>  				 long type, int mode);
>  
> -	int (*shm_alloc_security) (struct shmid_kernel * shp);
> -	void (*shm_free_security) (struct shmid_kernel * shp);
> -	int (*shm_associate) (struct shmid_kernel * shp, int shmflg);
> -	int (*shm_shmctl) (struct shmid_kernel * shp, int cmd);
> -	int (*shm_shmat) (struct shmid_kernel * shp, 
> +	int (*shm_alloc_security) (struct shmid_kernel *shp);
> +	void (*shm_free_security) (struct shmid_kernel *shp);
> +	int (*shm_associate) (struct shmid_kernel *shp, int shmflg);
> +	int (*shm_shmctl) (struct shmid_kernel *shp, int cmd);
> +	int (*shm_shmat) (struct shmid_kernel *shp,
>  			  char __user *shmaddr, int shmflg);
>  
> -	int (*sem_alloc_security) (struct sem_array * sma);
> -	void (*sem_free_security) (struct sem_array * sma);
> -	int (*sem_associate) (struct sem_array * sma, int semflg);
> -	int (*sem_semctl) (struct sem_array * sma, int cmd);
> -	int (*sem_semop) (struct sem_array * sma, 
> -			  struct sembuf * sops, unsigned nsops, int alter);
> +	int (*sem_alloc_security) (struct sem_array *sma);
> +	void (*sem_free_security) (struct sem_array *sma);
> +	int (*sem_associate) (struct sem_array *sma, int semflg);
> +	int (*sem_semctl) (struct sem_array *sma, int cmd);
> +	int (*sem_semop) (struct sem_array *sma,
> +			  struct sembuf *sops, unsigned nsops, int alter);
>  
> -	int (*netlink_send) (struct sock * sk, struct sk_buff * skb);
> -	int (*netlink_recv) (struct sk_buff * skb, int cap);
> +	int (*netlink_send) (struct sock *sk, struct sk_buff *skb);
> +	int (*netlink_recv) (struct sk_buff *skb, int cap);
>  
>  	/* allow module stacking */
>  	int (*register_security) (const char *name,
> -	                          struct security_operations *ops);
> +				  struct security_operations *ops);
>  
>  	void (*d_instantiate) (struct dentry *dentry, struct inode *inode);
>  
> - 	int (*getprocattr)(struct task_struct *p, char *name, char **value);
> - 	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_t size);
> +	int (*getprocattr)(struct task_struct *p, char *name, char **value);
> +	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_t size);
>  	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
>  	int (*secctx_to_secid)(char *secdata, u32 seclen, u32 *secid);
>  	void (*release_secctx)(char *secdata, u32 seclen);
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> -	int (*unix_stream_connect) (struct socket * sock,
> -				    struct socket * other, struct sock * newsk);
> -	int (*unix_may_send) (struct socket * sock, struct socket * other);
> +	int (*unix_stream_connect) (struct socket *sock,
> +				    struct socket *other, struct sock *newsk);
> +	int (*unix_may_send) (struct socket *sock, struct socket *other);
>  
>  	int (*socket_create) (int family, int type, int protocol, int kern);
> -	int (*socket_post_create) (struct socket * sock, int family,
> +	int (*socket_post_create) (struct socket *sock, int family,
>  				   int type, int protocol, int kern);
> -	int (*socket_bind) (struct socket * sock,
> -			    struct sockaddr * address, int addrlen);
> -	int (*socket_connect) (struct socket * sock,
> -			       struct sockaddr * address, int addrlen);
> -	int (*socket_listen) (struct socket * sock, int backlog);
> -	int (*socket_accept) (struct socket * sock, struct socket * newsock);
> -	void (*socket_post_accept) (struct socket * sock,
> -				    struct socket * newsock);
> -	int (*socket_sendmsg) (struct socket * sock,
> -			       struct msghdr * msg, int size);
> -	int (*socket_recvmsg) (struct socket * sock,
> -			       struct msghdr * msg, int size, int flags);
> -	int (*socket_getsockname) (struct socket * sock);
> -	int (*socket_getpeername) (struct socket * sock);
> -	int (*socket_getsockopt) (struct socket * sock, int level, int optname);
> -	int (*socket_setsockopt) (struct socket * sock, int level, int optname);
> -	int (*socket_shutdown) (struct socket * sock, int how);
> -	int (*socket_sock_rcv_skb) (struct sock * sk, struct sk_buff * skb);
> +	int (*socket_bind) (struct socket *sock,
> +			    struct sockaddr *address, int addrlen);
> +	int (*socket_connect) (struct socket *sock,
> +			       struct sockaddr *address, int addrlen);
> +	int (*socket_listen) (struct socket *sock, int backlog);
> +	int (*socket_accept) (struct socket *sock, struct socket *newsock);
> +	void (*socket_post_accept) (struct socket *sock,
> +				    struct socket *newsock);
> +	int (*socket_sendmsg) (struct socket *sock,
> +			       struct msghdr *msg, int size);
> +	int (*socket_recvmsg) (struct socket *sock,
> +			       struct msghdr *msg, int size, int flags);
> +	int (*socket_getsockname) (struct socket *sock);
> +	int (*socket_getpeername) (struct socket *sock);
> +	int (*socket_getsockopt) (struct socket *sock, int level, int optname);
> +	int (*socket_setsockopt) (struct socket *sock, int level, int optname);
> +	int (*socket_shutdown) (struct socket *sock, int how);
> +	int (*socket_sock_rcv_skb) (struct sock *sk, struct sk_buff *skb);
>  	int (*socket_getpeersec_stream) (struct socket *sock, char __user *optval, int __user *optlen, unsigned len);
>  	int (*socket_getpeersec_dgram) (struct socket *sock, struct sk_buff *skb, u32 *secid);
>  	int (*sk_alloc_security) (struct sock *sk, int family, gfp_t priority);
>  	void (*sk_free_security) (struct sock *sk);
>  	void (*sk_clone_security) (const struct sock *sk, struct sock *newsk);
>  	void (*sk_getsecid) (struct sock *sk, u32 *secid);
> -	void (*sock_graft)(struct sock* sk, struct socket *parent);
> +	void (*sock_graft)(struct sock *sk, struct socket *parent);
>  	int (*inet_conn_request)(struct sock *sk, struct sk_buff *skb,
>  					struct request_sock *req);
>  	void (*inet_csk_clone)(struct sock *newsk, const struct request_sock *req);
> @@ -1547,31 +1547,30 @@ struct security_operations {
>  };
>  
>  /* prototypes */
> -extern int security_init	(void);
> +extern int security_init(void);
>  extern int security_module_enable(struct security_operations *ops);
> -extern int register_security	(struct security_operations *ops);
> -extern int mod_reg_security	(const char *name, struct security_operations *ops);
> +extern int register_security(struct security_operations *ops);
> +extern int mod_reg_security(const char *name, struct security_operations *ops);
>  extern struct dentry *securityfs_create_file(const char *name, mode_t mode,
>  					     struct dentry *parent, void *data,
>  					     const struct file_operations *fops);
>  extern struct dentry *securityfs_create_dir(const char *name, struct dentry *parent);
>  extern void securityfs_remove(struct dentry *dentry);
>  
> -
>  /* Security operations */
>  int security_ptrace(struct task_struct *parent, struct task_struct *child);
>  int security_capget(struct task_struct *target,
> -		     kernel_cap_t *effective,
> -		     kernel_cap_t *inheritable,
> -		     kernel_cap_t *permitted);
> +		    kernel_cap_t *effective,
> +		    kernel_cap_t *inheritable,
> +		    kernel_cap_t *permitted);
>  int security_capset_check(struct task_struct *target,
> -			   kernel_cap_t *effective,
> -			   kernel_cap_t *inheritable,
> -			   kernel_cap_t *permitted);
> -void security_capset_set(struct task_struct *target,
>  			  kernel_cap_t *effective,
>  			  kernel_cap_t *inheritable,
>  			  kernel_cap_t *permitted);
> +void security_capset_set(struct task_struct *target,
> +			 kernel_cap_t *effective,
> +			 kernel_cap_t *inheritable,
> +			 kernel_cap_t *permitted);
>  int security_capable(struct task_struct *tsk, int cap);
>  int security_acct(struct file *file);
>  int security_sysctl(struct ctl_table *table, int op);
> @@ -1594,7 +1593,7 @@ int security_sb_copy_data(char *orig, char *copy);
>  int security_sb_kern_mount(struct super_block *sb, void *data);
>  int security_sb_statfs(struct dentry *dentry);
>  int security_sb_mount(char *dev_name, struct nameidata *nd,
> -                       char *type, unsigned long flags, void *data);
> +		      char *type, unsigned long flags, void *data);
>  int security_sb_check_sb(struct vfsmount *mnt, struct nameidata *nd);
>  int security_sb_umount(struct vfsmount *mnt, int flags);
>  void security_sb_umount_close(struct vfsmount *mnt);
> @@ -1619,12 +1618,12 @@ int security_inode_link(struct dentry *old_dentry, struct inode *dir,
>  			 struct dentry *new_dentry);
>  int security_inode_unlink(struct inode *dir, struct dentry *dentry);
>  int security_inode_symlink(struct inode *dir, struct dentry *dentry,
> -			    const char *old_name);
> +			   const char *old_name);
>  int security_inode_mkdir(struct inode *dir, struct dentry *dentry, int mode);
>  int security_inode_rmdir(struct inode *dir, struct dentry *dentry);
>  int security_inode_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev);
>  int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
> -			   struct inode *new_dir, struct dentry *new_dentry);
> +			  struct inode *new_dir, struct dentry *new_dentry);
>  int security_inode_readlink(struct dentry *dentry);
>  int security_inode_follow_link(struct dentry *dentry, struct nameidata *nd);
>  int security_inode_permission(struct inode *inode, int mask, struct nameidata *nd);
> @@ -1632,9 +1631,9 @@ int security_inode_setattr(struct dentry *dentry, struct iattr *attr);
>  int security_inode_getattr(struct vfsmount *mnt, struct dentry *dentry);
>  void security_inode_delete(struct inode *inode);
>  int security_inode_setxattr(struct dentry *dentry, char *name,
> -			     void *value, size_t size, int flags);
> +			    void *value, size_t size, int flags);
>  void security_inode_post_setxattr(struct dentry *dentry, char *name,
> -				   void *value, size_t size, int flags);
> +				  void *value, size_t size, int flags);
>  int security_inode_getxattr(struct dentry *dentry, char *name);
>  int security_inode_listxattr(struct dentry *dentry);
>  int security_inode_removexattr(struct dentry *dentry, char *name);
> @@ -1652,12 +1651,12 @@ int security_file_mmap(struct file *file, unsigned long reqprot,
>  			unsigned long prot, unsigned long flags,
>  			unsigned long addr, unsigned long addr_only);
>  int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> -			    unsigned long prot);
> +			   unsigned long prot);
>  int security_file_lock(struct file *file, unsigned int cmd);
>  int security_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg);
>  int security_file_set_fowner(struct file *file);
>  int security_file_send_sigiotask(struct task_struct *tsk,
> -				  struct fown_struct *fown, int sig);
> +				 struct fown_struct *fown, int sig);
>  int security_file_receive(struct file *file);
>  int security_dentry_open(struct file *file);
>  int security_task_create(unsigned long clone_flags);
> @@ -1665,7 +1664,7 @@ int security_task_alloc(struct task_struct *p);
>  void security_task_free(struct task_struct *p);
>  int security_task_setuid(uid_t id0, uid_t id1, uid_t id2, int flags);
>  int security_task_post_setuid(uid_t old_ruid, uid_t old_euid,
> -			       uid_t old_suid, int flags);
> +			      uid_t old_suid, int flags);
>  int security_task_setgid(gid_t id0, gid_t id1, gid_t id2, int flags);
>  int security_task_setpgid(struct task_struct *p, pid_t pgid);
>  int security_task_getpgid(struct task_struct *p);
> @@ -1696,9 +1695,9 @@ void security_msg_queue_free(struct msg_queue *msq);
>  int security_msg_queue_associate(struct msg_queue *msq, int msqflg);
>  int security_msg_queue_msgctl(struct msg_queue *msq, int cmd);
>  int security_msg_queue_msgsnd(struct msg_queue *msq,
> -			       struct msg_msg *msg, int msqflg);
> +			      struct msg_msg *msg, int msqflg);
>  int security_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
> -			       struct task_struct *target, long type, int mode);
> +			      struct task_struct *target, long type, int mode);
>  int security_shm_alloc(struct shmid_kernel *shp);
>  void security_shm_free(struct shmid_kernel *shp);
>  int security_shm_associate(struct shmid_kernel *shp, int shmflg);
> @@ -1710,7 +1709,7 @@ int security_sem_associate(struct sem_array *sma, int semflg);
>  int security_sem_semctl(struct sem_array *sma, int cmd);
>  int security_sem_semop(struct sem_array *sma, struct sembuf *sops,
>  			unsigned nsops, int alter);
> -void security_d_instantiate (struct dentry *dentry, struct inode *inode);
> +void security_d_instantiate(struct dentry *dentry, struct inode *inode);
>  int security_getprocattr(struct task_struct *p, char *name, char **value);
>  int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
> @@ -1741,33 +1740,33 @@ static inline int security_init(void)
>  	return 0;
>  }
>  
> -static inline int security_ptrace (struct task_struct *parent, struct task_struct * child)
> +static inline int security_ptrace(struct task_struct *parent, struct task_struct *child)
>  {
> -	return cap_ptrace (parent, child);
> +	return cap_ptrace(parent, child);
>  }
>  
> -static inline int security_capget (struct task_struct *target,
> +static inline int security_capget(struct task_struct *target,
>  				   kernel_cap_t *effective,
>  				   kernel_cap_t *inheritable,
>  				   kernel_cap_t *permitted)
>  {
> -	return cap_capget (target, effective, inheritable, permitted);
> +	return cap_capget(target, effective, inheritable, permitted);
>  }
>  
> -static inline int security_capset_check (struct task_struct *target,
> +static inline int security_capset_check(struct task_struct *target,
>  					 kernel_cap_t *effective,
>  					 kernel_cap_t *inheritable,
>  					 kernel_cap_t *permitted)
>  {
> -	return cap_capset_check (target, effective, inheritable, permitted);
> +	return cap_capset_check(target, effective, inheritable, permitted);
>  }
>  
> -static inline void security_capset_set (struct task_struct *target,
> +static inline void security_capset_set(struct task_struct *target,
>  					kernel_cap_t *effective,
>  					kernel_cap_t *inheritable,
>  					kernel_cap_t *permitted)
>  {
> -	cap_capset_set (target, effective, inheritable, permitted);
> +	cap_capset_set(target, effective, inheritable, permitted);
>  }
>  
>  static inline int security_capable(struct task_struct *tsk, int cap)
> @@ -1775,7 +1774,7 @@ static inline int security_capable(struct task_struct *tsk, int cap)
>  	return cap_capable(tsk, cap);
>  }
>  
> -static inline int security_acct (struct file *file)
> +static inline int security_acct(struct file *file)
>  {
>  	return 0;
>  }
> @@ -1785,13 +1784,13 @@ static inline int security_sysctl(struct ctl_table *table, int op)
>  	return 0;
>  }
>  
> -static inline int security_quotactl (int cmds, int type, int id,
> -				     struct super_block * sb)
> +static inline int security_quotactl(int cmds, int type, int id,
> +				     struct super_block *sb)
>  {
>  	return 0;
>  }
>  
> -static inline int security_quota_on (struct dentry * dentry)
> +static inline int security_quota_on(struct dentry *dentry)
>  {
>  	return 0;
>  }
> @@ -1816,101 +1815,101 @@ static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  	return cap_vm_enough_memory(mm, pages);
>  }
>  
> -static inline int security_bprm_alloc (struct linux_binprm *bprm)
> +static inline int security_bprm_alloc(struct linux_binprm *bprm)
>  {
>  	return 0;
>  }
>  
> -static inline void security_bprm_free (struct linux_binprm *bprm)
> +static inline void security_bprm_free(struct linux_binprm *bprm)
>  { }
>  
> -static inline void security_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
> -{ 
> -	cap_bprm_apply_creds (bprm, unsafe);
> +static inline void security_bprm_apply_creds(struct linux_binprm *bprm, int unsafe)
> +{
> +	cap_bprm_apply_creds(bprm, unsafe);
>  }
>  
> -static inline void security_bprm_post_apply_creds (struct linux_binprm *bprm)
> +static inline void security_bprm_post_apply_creds(struct linux_binprm *bprm)
>  {
>  	return;
>  }
>  
> -static inline int security_bprm_set (struct linux_binprm *bprm)
> +static inline int security_bprm_set(struct linux_binprm *bprm)
>  {
> -	return cap_bprm_set_security (bprm);
> +	return cap_bprm_set_security(bprm);
>  }
>  
> -static inline int security_bprm_check (struct linux_binprm *bprm)
> +static inline int security_bprm_check(struct linux_binprm *bprm)
>  {
>  	return 0;
>  }
>  
> -static inline int security_bprm_secureexec (struct linux_binprm *bprm)
> +static inline int security_bprm_secureexec(struct linux_binprm *bprm)
>  {
>  	return cap_bprm_secureexec(bprm);
>  }
>  
> -static inline int security_sb_alloc (struct super_block *sb)
> +static inline int security_sb_alloc(struct super_block *sb)
>  {
>  	return 0;
>  }
>  
> -static inline void security_sb_free (struct super_block *sb)
> +static inline void security_sb_free(struct super_block *sb)
>  { }
>  
> -static inline int security_sb_copy_data (char *orig, char *copy)
> +static inline int security_sb_copy_data(char *orig, char *copy)
>  {
>  	return 0;
>  }
>  
> -static inline int security_sb_kern_mount (struct super_block *sb, void *data)
> +static inline int security_sb_kern_mount(struct super_block *sb, void *data)
>  {
>  	return 0;
>  }
>  
> -static inline int security_sb_statfs (struct dentry *dentry)
> +static inline int security_sb_statfs(struct dentry *dentry)
>  {
>  	return 0;
>  }
>  
> -static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
> -				    char *type, unsigned long flags,
> -				    void *data)
> +static inline int security_sb_mount(char *dev_name, struct nameidata *nd,
> +				     char *type, unsigned long flags,
> +				     void *data)
>  {
>  	return 0;
>  }
>  
> -static inline int security_sb_check_sb (struct vfsmount *mnt,
> +static inline int security_sb_check_sb(struct vfsmount *mnt,
>  					struct nameidata *nd)
>  {
>  	return 0;
>  }
>  
> -static inline int security_sb_umount (struct vfsmount *mnt, int flags)
> +static inline int security_sb_umount(struct vfsmount *mnt, int flags)
>  {
>  	return 0;
>  }
>  
> -static inline void security_sb_umount_close (struct vfsmount *mnt)
> +static inline void security_sb_umount_close(struct vfsmount *mnt)
>  { }
>  
> -static inline void security_sb_umount_busy (struct vfsmount *mnt)
> +static inline void security_sb_umount_busy(struct vfsmount *mnt)
>  { }
>  
> -static inline void security_sb_post_remount (struct vfsmount *mnt,
> +static inline void security_sb_post_remount(struct vfsmount *mnt,
>  					     unsigned long flags, void *data)
>  { }
>  
> -static inline void security_sb_post_addmount (struct vfsmount *mnt,
> +static inline void security_sb_post_addmount(struct vfsmount *mnt,
>  					      struct nameidata *mountpoint_nd)
>  { }
>  
> -static inline int security_sb_pivotroot (struct nameidata *old_nd,
> +static inline int security_sb_pivotroot(struct nameidata *old_nd,
>  					 struct nameidata *new_nd)
>  {
>  	return 0;
>  }
>  
> -static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
> +static inline void security_sb_post_pivotroot(struct nameidata *old_nd,
>  					       struct nameidata *new_nd)
>  { }
>  static inline int security_sb_get_mnt_opts(const struct super_block *sb,
> @@ -1935,15 +1934,15 @@ static inline int security_sb_parse_opts_str(char *options, struct security_mnt_
>  	return 0;
>  }
>  
> -static inline int security_inode_alloc (struct inode *inode)
> +static inline int security_inode_alloc(struct inode *inode)
>  {
>  	return 0;
>  }
>  
> -static inline void security_inode_free (struct inode *inode)
> +static inline void security_inode_free(struct inode *inode)
>  { }
>  
> -static inline int security_inode_init_security (struct inode *inode,
> +static inline int security_inode_init_security(struct inode *inode,
>  						struct inode *dir,
>  						char **name,
>  						void **value,
> @@ -1951,55 +1950,55 @@ static inline int security_inode_init_security (struct inode *inode,
>  {
>  	return -EOPNOTSUPP;
>  }
> -	
> -static inline int security_inode_create (struct inode *dir,
> +
> +static inline int security_inode_create(struct inode *dir,
>  					 struct dentry *dentry,
>  					 int mode)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_link (struct dentry *old_dentry,
> +static inline int security_inode_link(struct dentry *old_dentry,
>  				       struct inode *dir,
>  				       struct dentry *new_dentry)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_unlink (struct inode *dir,
> +static inline int security_inode_unlink(struct inode *dir,
>  					 struct dentry *dentry)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_symlink (struct inode *dir,
> +static inline int security_inode_symlink(struct inode *dir,
>  					  struct dentry *dentry,
>  					  const char *old_name)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_mkdir (struct inode *dir,
> +static inline int security_inode_mkdir(struct inode *dir,
>  					struct dentry *dentry,
>  					int mode)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_rmdir (struct inode *dir,
> +static inline int security_inode_rmdir(struct inode *dir,
>  					struct dentry *dentry)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_mknod (struct inode *dir,
> +static inline int security_inode_mknod(struct inode *dir,
>  					struct dentry *dentry,
>  					int mode, dev_t dev)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_rename (struct inode *old_dir,
> +static inline int security_inode_rename(struct inode *old_dir,
>  					 struct dentry *old_dentry,
>  					 struct inode *new_dir,
>  					 struct dentry *new_dentry)
> @@ -2007,59 +2006,59 @@ static inline int security_inode_rename (struct inode *old_dir,
>  	return 0;
>  }
>  
> -static inline int security_inode_readlink (struct dentry *dentry)
> +static inline int security_inode_readlink(struct dentry *dentry)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_follow_link (struct dentry *dentry,
> +static inline int security_inode_follow_link(struct dentry *dentry,
>  					      struct nameidata *nd)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_permission (struct inode *inode, int mask,
> +static inline int security_inode_permission(struct inode *inode, int mask,
>  					     struct nameidata *nd)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_setattr (struct dentry *dentry,
> +static inline int security_inode_setattr(struct dentry *dentry,
>  					  struct iattr *attr)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_getattr (struct vfsmount *mnt,
> +static inline int security_inode_getattr(struct vfsmount *mnt,
>  					  struct dentry *dentry)
>  {
>  	return 0;
>  }
>  
> -static inline void security_inode_delete (struct inode *inode)
> +static inline void security_inode_delete(struct inode *inode)
>  { }
>  
> -static inline int security_inode_setxattr (struct dentry *dentry, char *name,
> +static inline int security_inode_setxattr(struct dentry *dentry, char *name,
>  					   void *value, size_t size, int flags)
>  {
>  	return cap_inode_setxattr(dentry, name, value, size, flags);
>  }
>  
> -static inline void security_inode_post_setxattr (struct dentry *dentry, char *name,
> +static inline void security_inode_post_setxattr(struct dentry *dentry, char *name,
>  						 void *value, size_t size, int flags)
>  { }
>  
> -static inline int security_inode_getxattr (struct dentry *dentry, char *name)
> +static inline int security_inode_getxattr(struct dentry *dentry, char *name)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_listxattr (struct dentry *dentry)
> +static inline int security_inode_listxattr(struct dentry *dentry)
>  {
>  	return 0;
>  }
>  
> -static inline int security_inode_removexattr (struct dentry *dentry, char *name)
> +static inline int security_inode_removexattr(struct dentry *dentry, char *name)
>  {
>  	return cap_inode_removexattr(dentry, name);
>  }
> @@ -2094,198 +2093,198 @@ static inline void security_inode_getsecid(const struct inode *inode, u32 *secid
>  	*secid = 0;
>  }
>  
> -static inline int security_file_permission (struct file *file, int mask)
> +static inline int security_file_permission(struct file *file, int mask)
>  {
>  	return 0;
>  }
>  
> -static inline int security_file_alloc (struct file *file)
> +static inline int security_file_alloc(struct file *file)
>  {
>  	return 0;
>  }
>  
> -static inline void security_file_free (struct file *file)
> +static inline void security_file_free(struct file *file)
>  { }
>  
> -static inline int security_file_ioctl (struct file *file, unsigned int cmd,
> -				       unsigned long arg)
> +static inline int security_file_ioctl(struct file *file, unsigned int cmd,
> +				      unsigned long arg)
>  {
>  	return 0;
>  }
>  
> -static inline int security_file_mmap (struct file *file, unsigned long reqprot,
> -				      unsigned long prot,
> -				      unsigned long flags,
> -				      unsigned long addr,
> -				      unsigned long addr_only)
> +static inline int security_file_mmap(struct file *file, unsigned long reqprot,
> +				     unsigned long prot,
> +				     unsigned long flags,
> +				     unsigned long addr,
> +				     unsigned long addr_only)
>  {
>  	return 0;
>  }
>  
> -static inline int security_file_mprotect (struct vm_area_struct *vma,
> -					  unsigned long reqprot,
> -					  unsigned long prot)
> +static inline int security_file_mprotect(struct vm_area_struct *vma,
> +					 unsigned long reqprot,
> +					 unsigned long prot)
>  {
>  	return 0;
>  }
>  
> -static inline int security_file_lock (struct file *file, unsigned int cmd)
> +static inline int security_file_lock(struct file *file, unsigned int cmd)
>  {
>  	return 0;
>  }
>  
> -static inline int security_file_fcntl (struct file *file, unsigned int cmd,
> -				       unsigned long arg)
> +static inline int security_file_fcntl(struct file *file, unsigned int cmd,
> +				      unsigned long arg)
>  {
>  	return 0;
>  }
>  
> -static inline int security_file_set_fowner (struct file *file)
> +static inline int security_file_set_fowner(struct file *file)
>  {
>  	return 0;
>  }
>  
> -static inline int security_file_send_sigiotask (struct task_struct *tsk,
> -						struct fown_struct *fown,
> -						int sig)
> +static inline int security_file_send_sigiotask(struct task_struct *tsk,
> +					       struct fown_struct *fown,
> +					       int sig)
>  {
>  	return 0;
>  }
>  
> -static inline int security_file_receive (struct file *file)
> +static inline int security_file_receive(struct file *file)
>  {
>  	return 0;
>  }
>  
> -static inline int security_dentry_open (struct file *file)
> +static inline int security_dentry_open(struct file *file)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_create (unsigned long clone_flags)
> +static inline int security_task_create(unsigned long clone_flags)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_alloc (struct task_struct *p)
> +static inline int security_task_alloc(struct task_struct *p)
>  {
>  	return 0;
>  }
>  
> -static inline void security_task_free (struct task_struct *p)
> +static inline void security_task_free(struct task_struct *p)
>  { }
>  
> -static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
> -					int flags)
> +static inline int security_task_setuid(uid_t id0, uid_t id1, uid_t id2,
> +				       int flags)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_post_setuid (uid_t old_ruid, uid_t old_euid,
> -					     uid_t old_suid, int flags)
> +static inline int security_task_post_setuid(uid_t old_ruid, uid_t old_euid,
> +					    uid_t old_suid, int flags)
>  {
> -	return cap_task_post_setuid (old_ruid, old_euid, old_suid, flags);
> +	return cap_task_post_setuid(old_ruid, old_euid, old_suid, flags);
>  }
>  
> -static inline int security_task_setgid (gid_t id0, gid_t id1, gid_t id2,
> -					int flags)
> +static inline int security_task_setgid(gid_t id0, gid_t id1, gid_t id2,
> +				       int flags)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
> +static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_getpgid (struct task_struct *p)
> +static inline int security_task_getpgid(struct task_struct *p)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_getsid (struct task_struct *p)
> +static inline int security_task_getsid(struct task_struct *p)
>  {
>  	return 0;
>  }
>  
> -static inline void security_task_getsecid (struct task_struct *p, u32 *secid)
> +static inline void security_task_getsecid(struct task_struct *p, u32 *secid)
>  {
>  	*secid = 0;
>  }
>  
> -static inline int security_task_setgroups (struct group_info *group_info)
> +static inline int security_task_setgroups(struct group_info *group_info)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_setnice (struct task_struct *p, int nice)
> +static inline int security_task_setnice(struct task_struct *p, int nice)
>  {
>  	return cap_task_setnice(p, nice);
>  }
>  
> -static inline int security_task_setioprio (struct task_struct *p, int ioprio)
> +static inline int security_task_setioprio(struct task_struct *p, int ioprio)
>  {
>  	return cap_task_setioprio(p, ioprio);
>  }
>  
> -static inline int security_task_getioprio (struct task_struct *p)
> +static inline int security_task_getioprio(struct task_struct *p)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_setrlimit (unsigned int resource,
> -					   struct rlimit *new_rlim)
> +static inline int security_task_setrlimit(unsigned int resource,
> +					  struct rlimit *new_rlim)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_setscheduler (struct task_struct *p,
> -					      int policy,
> -					      struct sched_param *lp)
> +static inline int security_task_setscheduler(struct task_struct *p,
> +					     int policy,
> +					     struct sched_param *lp)
>  {
>  	return cap_task_setscheduler(p, policy, lp);
>  }
>  
> -static inline int security_task_getscheduler (struct task_struct *p)
> +static inline int security_task_getscheduler(struct task_struct *p)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_movememory (struct task_struct *p)
> +static inline int security_task_movememory(struct task_struct *p)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_kill (struct task_struct *p,
> -				      struct siginfo *info, int sig,
> -				      u32 secid)
> +static inline int security_task_kill(struct task_struct *p,
> +				     struct siginfo *info, int sig,
> +				     u32 secid)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_wait (struct task_struct *p)
> +static inline int security_task_wait(struct task_struct *p)
>  {
>  	return 0;
>  }
>  
> -static inline int security_task_prctl (int option, unsigned long arg2,
> -				       unsigned long arg3,
> -				       unsigned long arg4,
> -				       unsigned long arg5)
> +static inline int security_task_prctl(int option, unsigned long arg2,
> +				      unsigned long arg3,
> +				      unsigned long arg4,
> +				      unsigned long arg5)
>  {
>  	return 0;
>  }
>  
> -static inline void security_task_reparent_to_init (struct task_struct *p)
> +static inline void security_task_reparent_to_init(struct task_struct *p)
>  {
> -	cap_task_reparent_to_init (p);
> +	cap_task_reparent_to_init(p);
>  }
>  
>  static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
>  { }
>  
> -static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
> -					   short flag)
> +static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
> +					  short flag)
>  {
>  	return 0;
>  }
> @@ -2295,98 +2294,98 @@ static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
>  	*secid = 0;
>  }
>  
> -static inline int security_msg_msg_alloc (struct msg_msg * msg)
> +static inline int security_msg_msg_alloc(struct msg_msg *msg)
>  {
>  	return 0;
>  }
>  
> -static inline void security_msg_msg_free (struct msg_msg * msg)
> +static inline void security_msg_msg_free(struct msg_msg *msg)
>  { }
>  
> -static inline int security_msg_queue_alloc (struct msg_queue *msq)
> +static inline int security_msg_queue_alloc(struct msg_queue *msq)
>  {
>  	return 0;
>  }
>  
> -static inline void security_msg_queue_free (struct msg_queue *msq)
> +static inline void security_msg_queue_free(struct msg_queue *msq)
>  { }
>  
> -static inline int security_msg_queue_associate (struct msg_queue * msq, 
> -						int msqflg)
> +static inline int security_msg_queue_associate(struct msg_queue *msq,
> +					       int msqflg)
>  {
>  	return 0;
>  }
>  
> -static inline int security_msg_queue_msgctl (struct msg_queue * msq, int cmd)
> +static inline int security_msg_queue_msgctl(struct msg_queue *msq, int cmd)
>  {
>  	return 0;
>  }
>  
> -static inline int security_msg_queue_msgsnd (struct msg_queue * msq,
> -					     struct msg_msg * msg, int msqflg)
> +static inline int security_msg_queue_msgsnd(struct msg_queue *msq,
> +					    struct msg_msg *msg, int msqflg)
>  {
>  	return 0;
>  }
>  
> -static inline int security_msg_queue_msgrcv (struct msg_queue * msq,
> -					     struct msg_msg * msg,
> -					     struct task_struct * target,
> -					     long type, int mode)
> +static inline int security_msg_queue_msgrcv(struct msg_queue *msq,
> +					    struct msg_msg *msg,
> +					    struct task_struct *target,
> +					    long type, int mode)
>  {
>  	return 0;
>  }
>  
> -static inline int security_shm_alloc (struct shmid_kernel *shp)
> +static inline int security_shm_alloc(struct shmid_kernel *shp)
>  {
>  	return 0;
>  }
>  
> -static inline void security_shm_free (struct shmid_kernel *shp)
> +static inline void security_shm_free(struct shmid_kernel *shp)
>  { }
>  
> -static inline int security_shm_associate (struct shmid_kernel * shp, 
> -					  int shmflg)
> +static inline int security_shm_associate(struct shmid_kernel *shp,
> +					 int shmflg)
>  {
>  	return 0;
>  }
>  
> -static inline int security_shm_shmctl (struct shmid_kernel * shp, int cmd)
> +static inline int security_shm_shmctl(struct shmid_kernel *shp, int cmd)
>  {
>  	return 0;
>  }
>  
> -static inline int security_shm_shmat (struct shmid_kernel * shp, 
> -				      char __user *shmaddr, int shmflg)
> +static inline int security_shm_shmat(struct shmid_kernel *shp,
> +				     char __user *shmaddr, int shmflg)
>  {
>  	return 0;
>  }
>  
> -static inline int security_sem_alloc (struct sem_array *sma)
> +static inline int security_sem_alloc(struct sem_array *sma)
>  {
>  	return 0;
>  }
>  
> -static inline void security_sem_free (struct sem_array *sma)
> +static inline void security_sem_free(struct sem_array *sma)
>  { }
>  
> -static inline int security_sem_associate (struct sem_array * sma, int semflg)
> +static inline int security_sem_associate(struct sem_array *sma, int semflg)
>  {
>  	return 0;
>  }
>  
> -static inline int security_sem_semctl (struct sem_array * sma, int cmd)
> +static inline int security_sem_semctl(struct sem_array *sma, int cmd)
>  {
>  	return 0;
>  }
>  
> -static inline int security_sem_semop (struct sem_array * sma, 
> -				      struct sembuf * sops, unsigned nsops, 
> -				      int alter)
> +static inline int security_sem_semop(struct sem_array *sma,
> +				     struct sembuf *sops, unsigned nsops,
> +				     int alter)
>  {
>  	return 0;
>  }
>  
> -static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
> +static inline void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>  { }
>  
>  static inline int security_getprocattr(struct task_struct *p, char *name, char **value)
> @@ -2399,14 +2398,14 @@ static inline int security_setprocattr(struct task_struct *p, char *name, void *
>  	return -EINVAL;
>  }
>  
> -static inline int security_netlink_send (struct sock *sk, struct sk_buff *skb)
> +static inline int security_netlink_send(struct sock *sk, struct sk_buff *skb)
>  {
> -	return cap_netlink_send (sk, skb);
> +	return cap_netlink_send(sk, skb);
>  }
>  
> -static inline int security_netlink_recv (struct sk_buff *skb, int cap)
> +static inline int security_netlink_recv(struct sk_buff *skb, int cap)
>  {
> -	return cap_netlink_recv (skb, cap);
> +	return cap_netlink_recv(skb, cap);
>  }
>  
>  static inline struct dentry *securityfs_create_dir(const char *name,
> @@ -2484,26 +2483,26 @@ void security_inet_conn_established(struct sock *sk,
>  			struct sk_buff *skb);
>  
>  #else	/* CONFIG_SECURITY_NETWORK */
> -static inline int security_unix_stream_connect(struct socket * sock,
> -					       struct socket * other,
> -					       struct sock * newsk)
> +static inline int security_unix_stream_connect(struct socket *sock,
> +					       struct socket *other,
> +					       struct sock *newsk)
>  {
>  	return 0;
>  }
>  
> -static inline int security_unix_may_send(struct socket * sock, 
> -					 struct socket * other)
> +static inline int security_unix_may_send(struct socket *sock,
> +					 struct socket *other)
>  {
>  	return 0;
>  }
>  
> -static inline int security_socket_create (int family, int type,
> -					  int protocol, int kern)
> +static inline int security_socket_create(int family, int type,
> +					 int protocol, int kern)
>  {
>  	return 0;
>  }
>  
> -static inline int security_socket_post_create(struct socket * sock,
> +static inline int security_socket_post_create(struct socket *sock,
>  					      int family,
>  					      int type,
>  					      int protocol, int kern)
> @@ -2511,77 +2510,77 @@ static inline int security_socket_post_create(struct socket * sock,
>  	return 0;
>  }
>  
> -static inline int security_socket_bind(struct socket * sock, 
> -				       struct sockaddr * address, 
> +static inline int security_socket_bind(struct socket *sock,
> +				       struct sockaddr *address,
>  				       int addrlen)
>  {
>  	return 0;
>  }
>  
> -static inline int security_socket_connect(struct socket * sock, 
> -					  struct sockaddr * address, 
> +static inline int security_socket_connect(struct socket *sock,
> +					  struct sockaddr *address,
>  					  int addrlen)
>  {
>  	return 0;
>  }
>  
> -static inline int security_socket_listen(struct socket * sock, int backlog)
> +static inline int security_socket_listen(struct socket *sock, int backlog)
>  {
>  	return 0;
>  }
>  
> -static inline int security_socket_accept(struct socket * sock, 
> -					 struct socket * newsock)
> +static inline int security_socket_accept(struct socket *sock,
> +					 struct socket *newsock)
>  {
>  	return 0;
>  }
>  
> -static inline void security_socket_post_accept(struct socket * sock, 
> -					       struct socket * newsock)
> +static inline void security_socket_post_accept(struct socket *sock,
> +					       struct socket *newsock)
>  {
>  }
>  
> -static inline int security_socket_sendmsg(struct socket * sock, 
> -					  struct msghdr * msg, int size)
> +static inline int security_socket_sendmsg(struct socket *sock,
> +					  struct msghdr *msg, int size)
>  {
>  	return 0;
>  }
>  
> -static inline int security_socket_recvmsg(struct socket * sock, 
> -					  struct msghdr * msg, int size, 
> +static inline int security_socket_recvmsg(struct socket *sock,
> +					  struct msghdr *msg, int size,
>  					  int flags)
>  {
>  	return 0;
>  }
>  
> -static inline int security_socket_getsockname(struct socket * sock)
> +static inline int security_socket_getsockname(struct socket *sock)
>  {
>  	return 0;
>  }
>  
> -static inline int security_socket_getpeername(struct socket * sock)
> +static inline int security_socket_getpeername(struct socket *sock)
>  {
>  	return 0;
>  }
>  
> -static inline int security_socket_getsockopt(struct socket * sock, 
> +static inline int security_socket_getsockopt(struct socket *sock,
>  					     int level, int optname)
>  {
>  	return 0;
>  }
>  
> -static inline int security_socket_setsockopt(struct socket * sock, 
> +static inline int security_socket_setsockopt(struct socket *sock,
>  					     int level, int optname)
>  {
>  	return 0;
>  }
>  
> -static inline int security_socket_shutdown(struct socket * sock, int how)
> +static inline int security_socket_shutdown(struct socket *sock, int how)
>  {
>  	return 0;
>  }
> -static inline int security_sock_rcv_skb (struct sock * sk, 
> -					 struct sk_buff * skb)
> +static inline int security_sock_rcv_skb(struct sock *sk,
> +					struct sk_buff *skb)
>  {
>  	return 0;
>  }
> @@ -2618,7 +2617,7 @@ static inline void security_req_classify_flow(const struct request_sock *req, st
>  {
>  }
>  
> -static inline void security_sock_graft(struct sock* sk, struct socket *parent)
> +static inline void security_sock_graft(struct sock *sk, struct socket *parent)
>  {
>  }
>  
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
