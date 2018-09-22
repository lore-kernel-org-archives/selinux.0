Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M2haTq032469
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 22:43:38 -0400
Received: by mail-yb1-f195.google.com with SMTP id p74-v6so5667657ybc.9
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:43:21 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com.
 [209.85.161.46])
 by smtp.gmail.com with ESMTPSA id v18-v6sm5992924ywv.9.2018.09.21.19.43.18
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Sep 2018 19:43:19 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id k66-v6so395269ywa.10
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:43:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 21 Sep 2018 19:43:16 -0700
Message-ID: <CAGXu5j+9w-+i2F3-w=5QRzNEC1QaF_nwSZRgdLk+M4LpwmZ2Qg@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v4 04/19] SELinux: Remove cred security blob
 poisoning
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 21, 2018 at 5:17 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> The SELinux specific credential poisioning only makes sense
> if SELinux is managing the credentials. As the intent of this
> patch set is to move the blob management out of the modules
> and into the infrastructure, the SELinux specific code has
> to go. The poisioning could be introduced into the infrastructure
> at some later date.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees


> ---
>  kernel/cred.c            | 13 -------------
>  security/selinux/hooks.c |  6 ------
>  2 files changed, 19 deletions(-)
>
> diff --git a/kernel/cred.c b/kernel/cred.c
> index ecf03657e71c..fa2061ee4955 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -704,19 +704,6 @@ bool creds_are_invalid(const struct cred *cred)
>  {
>         if (cred->magic != CRED_MAGIC)
>                 return true;
> -#ifdef CONFIG_SECURITY_SELINUX
> -       /*
> -        * cred->security == NULL if security_cred_alloc_blank() or
> -        * security_prepare_creds() returned an error.
> -        */
> -       if (selinux_is_enabled() && cred->security) {
> -               if ((unsigned long) cred->security < PAGE_SIZE)
> -                       return true;
> -               if ((*(u32 *)cred->security & 0xffffff00) ==
> -                   (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8))
> -                       return true;
> -       }
> -#endif
>         return false;
>  }
>  EXPORT_SYMBOL(creds_are_invalid);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9d6cdd21acb6..80614ca25a2b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3920,12 +3920,6 @@ static void selinux_cred_free(struct cred *cred)
>  {
>         struct task_security_struct *tsec = selinux_cred(cred);
>
> -       /*
> -        * cred->security == NULL if security_cred_alloc_blank() or
> -        * security_prepare_creds() returned an error.
> -        */
> -       BUG_ON(cred->security && (unsigned long) cred->security < PAGE_SIZE);
> -       cred->security = (void *) 0x7UL;
>         kfree(tsec);
>  }
>
> --
> 2.17.1
>
>



-- 
Kees Cook
Pixel Security
