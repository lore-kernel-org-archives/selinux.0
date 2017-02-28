Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1SLdmqU006745
 for <selinux@tycho.nsa.gov>; Tue, 28 Feb 2017 16:39:49 -0500
Received: by mail-ua0-f195.google.com with SMTP id 40so3538194uau.2
 for <selinux@tycho.nsa.gov>; Tue, 28 Feb 2017 13:39:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488292508-32506-1-git-send-email-sds@tycho.nsa.gov>
References: <1488292508-32506-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Feb 2017 16:39:47 -0500
Message-ID: <CAHC9VhT4F-6gh=K23rEaje6Aspzp=5OCawx+LEi9HWXvd5tSZQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix kernel BUG on prlimit(..., NULL, NULL)
To: Stephen Smalley <sds@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>
Cc: linux-security-module@vger.kernel.org, jslaby@suse.cz,
 selinux@tycho.nsa.gov, xiaolong.ye@intel.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Feb 28, 2017 at 9:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> commit 79bcf325e6b32b3c ("prlimit,security,selinux: add a security hook
> for prlimit") introduced a security hook for prlimit() and implemented it
> for SELinux.  However, if prlimit() is called with NULL arguments for both
> the new limit and the old limit, then the hook is called with 0 for the
> read/write flags, since the prlimit() will neither read nor write the
> process' limits.  This would in turn lead to calling avc_has_perm() with 0
> for the requested permissions, which triggers a BUG_ON() in
> avc_has_perm_noaudit() since the kernel should never be invoking
> avc_has_perm() with no permissions.  Fix this in the SELinux hook by
> returning immediately if the flags are 0.  Arguably prlimit64() itself
> ought to return immediately if both old_rlim and new_rlim are NULL since
> it is effectively a no-op in that case.
>
> Reported by the lkp-robot based on trinity testing.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)

James,

I was going to merge this patch but upon closer inspection it appears
that you never sent 79bcf325e6b32b3c to Linux, it is sitting in your
next-queue branch.  What is the plan for your next-queue branch, are
you going to merge it into your next branch after the merge window
closes?  If so, feel free to add my ack.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4a80bd8..af1ff15 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3922,6 +3922,8 @@ int selinux_task_prlimit(const struct cred *cred, const struct cred *tcred,
>  {
>         u32 av = 0;
>
> +       if (!flags)
> +               return 0;
>         if (flags & LSM_PRLIMIT_WRITE)
>                 av |= PROCESS__SETRLIMIT;
>         if (flags & LSM_PRLIMIT_READ)
> --
> 2.7.4
>

-- 
paul moore
www.paul-moore.com
