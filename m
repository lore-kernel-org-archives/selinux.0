Date: Thu, 30 Jul 2015 16:30:59 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
Subject: Re: [PATCH v3 01/11] user_ns: 3 new LSM hooks for user namespace
 operations
Message-ID: <20150730213059.GA13589@mail.hallyn.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
 <1437732285-11524-2-git-send-email-l.pawelczyk@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437732285-11524-2-git-send-email-l.pawelczyk@samsung.com>
Cc: linux-doc@vger.kernel.org, NeilBrown <neilb@suse.de>,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, selinux@tycho.nsa.gov,
 Jonathan Corbet <corbet@lwn.net>, havner@gmail.com,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jiri Slaby <jslaby@suse.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Fabian Frederick <fabf@skynet.be>, Al Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 John Johansen <john.johansen@canonical.com>,
 Greg KH <gregkh@linuxfoundation.org>, Oleg Nesterov <oleg@redhat.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 Zefan Li <lizefan@huawei.com>, Joe Perches <joe@perches.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 24, 2015 at 12:04:35PM +0200, Lukasz Pawelczyk wrote:
> This commit implements 3 new LSM hooks that provide the means for LSMs
> to embed their own security context within user namespace, effectively
> creating some sort of a user_ns related security namespace.
> 
> The first one to take advantage of this mechanism is Smack.
> 
> The hooks has been documented in the in the security.h below.
> 
> Signed-off-by: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h      | 28 ++++++++++++++++++++++++++++
>  include/linux/security.h       | 23 +++++++++++++++++++++++
>  include/linux/user_namespace.h |  4 ++++
>  kernel/user.c                  |  3 +++
>  kernel/user_namespace.c        | 18 ++++++++++++++++++
>  security/security.c            | 28 ++++++++++++++++++++++++++++
>  6 files changed, 104 insertions(+)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 9429f05..228558c 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1261,6 +1261,23 @@
>   *	audit_rule_init.
>   *	@rule contains the allocated rule
>   *
> + * @userns_create:
> + *	Allocates and fills the security part of a new user namespace.
> + *	@ns points to a newly created user namespace.
> + *	Returns 0 or an error code.
> + *
> + * @userns_free:
> + *	Deallocates the security part of a user namespace.
> + *	@ns points to a user namespace about to be destroyed.
> + *
> + * @userns_setns:
> + *	Run during a setns syscall to add a process to an already existing
> + *	user namespace. Returning failure here will block the operation
> + *	requested from userspace (setns() with CLONE_NEWUSER).
> + *	@nsproxy contains nsproxy to which the user namespace will be assigned.
> + *	@ns contains user namespace that is to be incorporated to the nsproxy.
> + *	Returns 0 or an error code.
> + *
>   * @inode_notifysecctx:
>   *	Notify the security module of what the security context of an inode
>   *	should be.  Initializes the incore security context managed by the
> @@ -1613,6 +1630,12 @@ union security_list_options {
>  				struct audit_context *actx);
>  	void (*audit_rule_free)(void *lsmrule);
>  #endif /* CONFIG_AUDIT */
> +
> +#ifdef CONFIG_USER_NS
> +	int (*userns_create)(struct user_namespace *ns);
> +	void (*userns_free)(struct user_namespace *ns);
> +	int (*userns_setns)(struct nsproxy *nsproxy, struct user_namespace *ns);
> +#endif /* CONFIG_USER_NS */
>  };
>  
>  struct security_hook_heads {
> @@ -1824,6 +1847,11 @@ struct security_hook_heads {
>  	struct list_head audit_rule_match;
>  	struct list_head audit_rule_free;
>  #endif /* CONFIG_AUDIT */
> +#ifdef CONFIG_USER_NS
> +	struct list_head userns_create;
> +	struct list_head userns_free;
> +	struct list_head userns_setns;
> +#endif /* CONFIG_USER_NS */
>  };
>  
>  /*
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 79d85dd..1b0eccc 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1584,6 +1584,29 @@ static inline void security_audit_rule_free(void *lsmrule)
>  #endif /* CONFIG_SECURITY */
>  #endif /* CONFIG_AUDIT */
>  
> +#ifdef CONFIG_USER_NS
> +int security_userns_create(struct user_namespace *ns);
> +void security_userns_free(struct user_namespace *ns);
> +int security_userns_setns(struct nsproxy *nsproxy, struct user_namespace *ns);
> +
> +#else
> +
> +static inline int security_userns_create(struct user_namespace *ns)
> +{
> +	return 0;
> +}
> +
> +static inline void security_userns_free(struct user_namespace *ns)
> +{ }
> +
> +static inline int security_userns_setns(struct nsproxy *nsproxy,
> +					struct user_namespace *ns)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_USER_NS */
> +
>  #ifdef CONFIG_SECURITYFS
>  
>  extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 8297e5b..a9400cc 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -39,6 +39,10 @@ struct user_namespace {
>  	struct key		*persistent_keyring_register;
>  	struct rw_semaphore	persistent_keyring_register_sem;
>  #endif
> +
> +#ifdef CONFIG_SECURITY
> +	void *security;
> +#endif
>  };
>  
>  extern struct user_namespace init_user_ns;
> diff --git a/kernel/user.c b/kernel/user.c
> index b069ccb..ce5419e 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -59,6 +59,9 @@ struct user_namespace init_user_ns = {
>  	.persistent_keyring_register_sem =
>  	__RWSEM_INITIALIZER(init_user_ns.persistent_keyring_register_sem),
>  #endif
> +#ifdef CONFIG_SECURITY
> +	.security = NULL,
> +#endif
>  };
>  EXPORT_SYMBOL_GPL(init_user_ns);
>  
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 4109f83..cadffb6 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -22,6 +22,7 @@
>  #include <linux/ctype.h>
>  #include <linux/projid.h>
>  #include <linux/fs_struct.h>
> +#include <linux/security.h>
>  
>  static struct kmem_cache *user_ns_cachep __read_mostly;
>  static DEFINE_MUTEX(userns_state_mutex);
> @@ -108,6 +109,15 @@ int create_user_ns(struct cred *new)
>  
>  	set_cred_user_ns(new, ns);
>  
> +#ifdef CONFIG_SECURITY
> +	ret = security_userns_create(ns);
> +	if (ret) {
> +		ns_free_inum(&ns->ns);
> +		kmem_cache_free(user_ns_cachep, ns);
> +		return ret;
> +	}
> +#endif
> +
>  #ifdef CONFIG_PERSISTENT_KEYRINGS
>  	init_rwsem(&ns->persistent_keyring_register_sem);
>  #endif
> @@ -143,6 +153,9 @@ void free_user_ns(struct user_namespace *ns)
>  #ifdef CONFIG_PERSISTENT_KEYRINGS
>  		key_put(ns->persistent_keyring_register);
>  #endif
> +#ifdef CONFIG_SECURITY
> +		security_userns_free(ns);
> +#endif
>  		ns_free_inum(&ns->ns);
>  		kmem_cache_free(user_ns_cachep, ns);
>  		ns = parent;
> @@ -969,6 +982,7 @@ static int userns_install(struct nsproxy *nsproxy, struct ns_common *ns)
>  {
>  	struct user_namespace *user_ns = to_user_ns(ns);
>  	struct cred *cred;
> +	int err;
>  
>  	/* Don't allow gaining capabilities by reentering
>  	 * the same user namespace.
> @@ -986,6 +1000,10 @@ static int userns_install(struct nsproxy *nsproxy, struct ns_common *ns)
>  	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	err = security_userns_setns(nsproxy, user_ns);
> +	if (err)
> +		return err;

So at this point the LSM thinks current is in the new ns.  If
prepare_creds() fails below, should it be informed of that?
(Or am I over-thinking this?)

> +
>  	cred = prepare_creds();
>  	if (!cred)
>  		return -ENOMEM;
> diff --git a/security/security.c b/security/security.c
> index 595fffa..5e66388 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -25,6 +25,7 @@
>  #include <linux/mount.h>
>  #include <linux/personality.h>
>  #include <linux/backing-dev.h>
> +#include <linux/user_namespace.h>
>  #include <net/flow.h>
>  
>  #define MAX_LSM_EVM_XATTR	2
> @@ -1542,6 +1543,25 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
>  }
>  #endif /* CONFIG_AUDIT */
>  
> +#ifdef CONFIG_USER_NS
> +
> +int security_userns_create(struct user_namespace *ns)
> +{
> +	return call_int_hook(userns_create, 0, ns);
> +}
> +
> +void security_userns_free(struct user_namespace *ns)
> +{
> +	call_void_hook(userns_free, ns);
> +}
> +
> +int security_userns_setns(struct nsproxy *nsproxy, struct user_namespace *ns)
> +{
> +	return call_int_hook(userns_setns, 0, nsproxy, ns);
> +}
> +
> +#endif /* CONFIG_USER_NS */
> +
>  struct security_hook_heads security_hook_heads = {
>  	.binder_set_context_mgr =
>  		LIST_HEAD_INIT(security_hook_heads.binder_set_context_mgr),
> @@ -1886,4 +1906,12 @@ struct security_hook_heads security_hook_heads = {
>  	.audit_rule_free =
>  		LIST_HEAD_INIT(security_hook_heads.audit_rule_free),
>  #endif /* CONFIG_AUDIT */
> +#ifdef CONFIG_USER_NS
> +	.userns_create =
> +		LIST_HEAD_INIT(security_hook_heads.userns_create),
> +	.userns_free =
> +		LIST_HEAD_INIT(security_hook_heads.userns_free),
> +	.userns_setns =
> +		LIST_HEAD_INIT(security_hook_heads.userns_setns),
> +#endif /* CONFIG_USER_NS */
>  };
> -- 
> 2.4.3
