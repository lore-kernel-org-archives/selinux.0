Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBA0MH8u005729
 for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2016 19:22:17 -0500
Received: by mail-ua0-f195.google.com with SMTP id 50so3357632uae.2
 for <selinux@tycho.nsa.gov>; Fri, 09 Dec 2016 16:22:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481206487-544-1-git-send-email-sds@tycho.nsa.gov>
References: <1481206487-544-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 9 Dec 2016 19:22:15 -0500
Message-ID: <CAHC9VhRGMCc5Fjk1AN6-_xjUKEkSKRhnjJ=tFD6CwTm27bUmNA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: allow context mounts on tmpfs, ramfs, devpts
 within user namespaces
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>,
 seth.forshee@canonical.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Dec 8, 2016 at 9:14 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> commit aad82892af261b9903cc11c55be3ecf5f0b0b4f8 ("selinux: Add support for
> unprivileged mounts from user namespaces") prohibited any use of context
> mount options within non-init user namespaces.  However, this breaks
> use of context mount options for tmpfs mounts within user namespaces,
> which are being used by Docker/runc.  There is no reason to block such
> usage for tmpfs, ramfs or devpts.  Exempt these filesystem types
> from this restriction.
>
> Before:
> sh$ userns_child_exec  -p -m -U -M '0 1000 1' -G '0 1000 1' bash
> sh# mount -t tmpfs -o context=system_u:object_r:user_tmp_t:s0:c13 none /tmp
> mount: tmpfs is write-protected, mounting read-only
> mount: cannot mount tmpfs read-only
>
> After:
> sh$ userns_child_exec  -p -m -U -M '0 1000 1' -G '0 1000 1' bash
> sh# mount -t tmpfs -o context=system_u:object_r:user_tmp_t:s0:c13 none /tmp
> sh# ls -Zd /tmp
> unconfined_u:object_r:user_tmp_t:s0:c13 /tmp
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8a90a0b..8fae174 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -834,10 +834,14 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>         }
>
>         /*
> -        * If this is a user namespace mount, no contexts are allowed
> -        * on the command line and security labels must be ignored.
> +        * If this is a user namespace mount and the filesystem type is not
> +        * explicitly whitelisted, then no contexts are allowed on the command
> +        * line and security labels must be ignored.
>          */
> -       if (sb->s_user_ns != &init_user_ns) {
> +       if (sb->s_user_ns != &init_user_ns &&
> +           strcmp(sb->s_type->name, "tmpfs") &&
> +           strcmp(sb->s_type->name, "ramfs") &&
> +           strcmp(sb->s_type->name, "devpts")) {
>                 if (context_sid || fscontext_sid || rootcontext_sid ||
>                     defcontext_sid) {
>                         rc = -EACCES;
> --
> 2.7.4
>



-- 
paul moore
www.paul-moore.com
