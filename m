Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3QLawx3017146
 for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2017 17:36:58 -0400
Received: by mail-ua0-f194.google.com with SMTP id 110so1192255uas.1
 for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2017 14:36:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170420153130.8992-1-sds@tycho.nsa.gov>
References: <20170420153130.8992-1-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Apr 2017 17:36:56 -0400
Message-ID: <CAHC9VhRKjNywMFAa5USpPzy1EttiPVx9XyfH4t5EvGY6WDWE3A@mail.gmail.com>
Subject: Re: [PATCH] selinux: only invoke capabilities and selinux for
 CAP_MAC_ADMIN checks
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, casey@schaufler-ca.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Apr 20, 2017 at 11:31 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> SELinux uses CAP_MAC_ADMIN to control the ability to get or set a raw,
> uninterpreted security context unknown to the currently loaded security
> policy. When performing these checks, we only want to perform a base
> capabilities check and a SELinux permission check.  If any other
> modules that implement a capable hook are stacked with SELinux, we do
> not want to require them to also have to authorize CAP_MAC_ADMIN,
> since it may have different implications for their security model.
> Rework the CAP_MAC_ADMIN checks within SELinux to only invoke the
> capabilities module and the SELinux permission checking.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e67a526..1aef63c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3107,6 +3107,18 @@ static int selinux_inode_setotherxattr(struct dentry *dentry, const char *name)
>         return dentry_has_perm(cred, dentry, FILE__SETATTR);
>  }
>
> +static bool has_cap_mac_admin(bool audit)
> +{
> +       const struct cred *cred = current_cred();
> +       int cap_audit = audit ? SECURITY_CAP_AUDIT : SECURITY_CAP_NOAUDIT;
> +
> +       if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, cap_audit))
> +               return false;
> +       if (cred_has_capability(cred, CAP_MAC_ADMIN, cap_audit, true))
> +               return false;
> +       return true;
> +}

Granted, I'm being nitpicky here, but that is one awful function name
IMHO.  What's wrong with current_cap_mac_admin()?

Unless you're really bored don't worry about a respin, the rest of the
patch looks fine to me, I'll queue it up for after the next merge
window.

>  static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>                                   const void *value, size_t size, int flags)
>  {
> @@ -3138,7 +3150,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>
>         rc = security_context_to_sid(value, size, &newsid, GFP_KERNEL);
>         if (rc == -EINVAL) {
> -               if (!capable(CAP_MAC_ADMIN)) {
> +               if (!has_cap_mac_admin(true)) {
>                         struct audit_buffer *ab;
>                         size_t audit_size;
>                         const char *str;
> @@ -3264,13 +3276,8 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
>          * and lack of permission just means that we fall back to the
>          * in-core context value, not a denial.
>          */
> -       error = cap_capable(current_cred(), &init_user_ns, CAP_MAC_ADMIN,
> -                           SECURITY_CAP_NOAUDIT);
> -       if (!error)
> -               error = cred_has_capability(current_cred(), CAP_MAC_ADMIN,
> -                                           SECURITY_CAP_NOAUDIT, true);
>         isec = inode_security(inode);
> -       if (!error)
> +       if (has_cap_mac_admin(false))
>                 error = security_sid_to_context_force(isec->sid, &context,
>                                                       &size);
>         else
> @@ -5918,7 +5925,7 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>                 }
>                 error = security_context_to_sid(value, size, &sid, GFP_KERNEL);
>                 if (error == -EINVAL && !strcmp(name, "fscreate")) {
> -                       if (!capable(CAP_MAC_ADMIN)) {
> +                       if (!has_cap_mac_admin(true)) {
>                                 struct audit_buffer *ab;
>                                 size_t audit_size;
>
> --
> 2.9.3
>



-- 
paul moore
www.paul-moore.com
