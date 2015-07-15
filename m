Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6FLmpUo005696
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 17:48:51 -0400
Date: Wed, 15 Jul 2015 16:48:48 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH 3/7] fs: Ignore file caps in mounts from other user
 namespaces
Message-ID: <20150715214848.GA24204@mail.hallyn.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
Cc: Serge Hallyn <serge.hallyn@canonical.com>, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 15, 2015 at 02:46:04PM -0500, Seth Forshee wrote:
> Capability sets attached to files must be ignored except in the
> user namespaces where the mounter is privileged, i.e. s_user_ns
> and its descendants. Otherwise a vector exists for gaining
> privileges in namespaces where a user is not already privileged.
> 
> Add a new helper function, in_user_ns(), to test whether a user
> namespace is the same as or a descendant of another namespace.
> Use this helper to determine whether a file's capability set
> should be applied to the caps constructed during exec.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Acked-by: Serge Hallyn <serge.hallyn@canonical.com>

I think it's an ok behavior, though let's just go over the
alternatives.

It might actually be ok to simply require that the user_ns be
equal.  If I unshare a new userns in which a different uid is
mapped to root, I may not want file capabilities to be granted
to tasks in that ns.  (On the other hand, I might be creating
a new user_ns specifically to not have a uid 0 mapped into it
at all, and only have file capabilities grant privilege)

Conversely, if I unshare one user_ns with a MS_SHARED mnt_ns, mount
an ext4fs, and then (from the parent shell) unshare another user_ns
with the same mapping, intending it to be a "peer" to the first one
I'd unshared and be able to use the ext4fs it mounted.  This won't
work here.  That's probably best - the appropriate thing to do was
to attach to the existing user_ns.  But it could end up being
limiting in some special cases, so I'm bringing it up here.

Again I think what you have here is the simplest and most sensible
choice, so ack.

> ---
>  include/linux/user_namespace.h |  8 ++++++++
>  kernel/user_namespace.c        | 14 ++++++++++++++
>  security/commoncap.c           |  2 ++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 8297e5b341d8..a43faa727124 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -72,6 +72,8 @@ extern ssize_t proc_projid_map_write(struct file *, const char __user *, size_t,
>  extern ssize_t proc_setgroups_write(struct file *, const char __user *, size_t, loff_t *);
>  extern int proc_setgroups_show(struct seq_file *m, void *v);
>  extern bool userns_may_setgroups(const struct user_namespace *ns);
> +extern bool in_userns(const struct user_namespace *ns,
> +		      const struct user_namespace *target_ns);
>  #else
>  
>  static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
> @@ -100,6 +102,12 @@ static inline bool userns_may_setgroups(const struct user_namespace *ns)
>  {
>  	return true;
>  }
> +
> +static inline bool in_userns(const struct user_namespace *ns,
> +			     const struct user_namespace *target_ns)
> +{
> +	return true;
> +}
>  #endif
>  
>  #endif /* _LINUX_USER_H */
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 4109f8320684..2b043876d5f0 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -944,6 +944,20 @@ bool userns_may_setgroups(const struct user_namespace *ns)
>  	return allowed;
>  }
>  
> +/*
> + * Returns true if @ns is the same namespace as or a descendant of
> + * @target_ns.
> + */
> +bool in_userns(const struct user_namespace *ns,
> +	       const struct user_namespace *target_ns)
> +{
> +	for (; ns; ns = ns->parent) {
> +		if (ns == target_ns)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static inline struct user_namespace *to_user_ns(struct ns_common *ns)
>  {
>  	return container_of(ns, struct user_namespace, ns);
> diff --git a/security/commoncap.c b/security/commoncap.c
> index d103f5a4043d..175ab497e810 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -439,6 +439,8 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
>  
>  	if (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)
>  		return 0;
> +	if (!in_userns(current_user_ns(), bprm->file->f_path.mnt->mnt_sb->s_user_ns))
> +		return 0;
>  
>  	rc = get_vfs_caps_from_disk(bprm->file->f_path.dentry, &vcaps);
>  	if (rc < 0) {
> -- 
> 1.9.1
