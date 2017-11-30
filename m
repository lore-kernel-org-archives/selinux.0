Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAUNidEx016322
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 18:44:39 -0500
Received: by mail-it0-f67.google.com with SMTP id z6so519371iti.4
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 15:44:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151206074183.32567.881282052709289967.stgit@chester>
References: <151206074183.32567.881282052709289967.stgit@chester>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 30 Nov 2017 15:44:35 -0800
Message-ID: <CAFftDdp34FQf45OEx+2AaVE62Y=imG2SstMySR9tN__=yoec4g@mail.gmail.com>
To: Paul Moore <pmoore@redhat.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: ensure the context is NULL terminated
 in security_context_to_sid_core()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Nov 30, 2017 at 8:52 AM, Paul Moore <pmoore@redhat.com> wrote:
> From: Paul Moore <paul@paul-moore.com>
>
> The syzbot/syzkaller automated tests found a problem in
> security_context_to_sid_core() during early boot (before we load the
> SELinux policy) where we could potentially feed context strings without
> NULL terminators into the strcmp() function.
>
> We already guard against this during normal operation (after the SELinux
> policy has been loaded) by making a copy of the context strings and
> explicitly adding a NULL terminator to the end.  The patch extends this
> protection to the early boot case (no loaded policy) by moving the context
> copy earlier in security_context_to_sid_core().
>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ss/services.c |   20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 33cfe5d3d6cb..6ec4cdc8af8f 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1413,27 +1413,27 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
>         if (!scontext_len)
>                 return -EINVAL;
>
> +       /* Copy the string to allow changes and ensure a NULL terminator */
> +       scontext2 = kmalloc(scontext_len + 1, gfp_flags);
> +       if (!scontext2)
> +               return -ENOMEM;
> +       memcpy(scontext2, scontext, scontext_len);
> +       scontext2[scontext_len] = 0;

Call me crazy, but can't we use kmemdup_nul() here?

/**
 * kmemdup_nul - Create a NUL-terminated string from unterminated data
 * @s: The data to stringify
 * @len: The size of the data
 * @gfp: the GFP mask used in the kmalloc() call when allocating memory
 */
char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)


> +
>         if (!ss_initialized) {
>                 int i;
>
>                 for (i = 1; i < SECINITSID_NUM; i++) {
> -                       if (!strcmp(initial_sid_to_string[i], scontext)) {
> +                       if (!strcmp(initial_sid_to_string[i], scontext2)) {
>                                 *sid = i;
> -                               return 0;
> +                               goto out;
>                         }
>                 }
>                 *sid = SECINITSID_KERNEL;
> -               return 0;
> +               goto out;
>         }
>         *sid = SECSID_NULL;
>
> -       /* Copy the string so that we can modify the copy as we parse it. */
> -       scontext2 = kmalloc(scontext_len + 1, gfp_flags);
> -       if (!scontext2)
> -               return -ENOMEM;
> -       memcpy(scontext2, scontext, scontext_len);
> -       scontext2[scontext_len] = 0;
> -
>         if (force) {
>                 /* Save another copy for storing in uninterpreted form */
>                 rc = -ENOMEM;
>
>



-- 
Respectfully,

William C Roberts
