Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8KHuaMG007744
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 13:56:37 -0400
Received: by mail-yw1-f67.google.com with SMTP id 14-v6so4118742ywe.2
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 10:56:34 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com.
 [209.85.161.44])
 by smtp.gmail.com with ESMTPSA id t2-v6sm4829214ywd.99.2018.09.20.10.56.30
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Sep 2018 10:56:31 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id z143-v6so4113697ywa.7
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 10:56:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8ef63a94-c7b6-226d-2d60-a05f79406819@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
 <8ef63a94-c7b6-226d-2d60-a05f79406819@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 20 Sep 2018 10:56:30 -0700
Message-ID: <CAGXu5j+aWyiQ_aGCkeoyvYC7Aj2hfuvKei+SAOMrfOWyfpP8xw@mail.gmail.com>
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
Subject: Re: [PATCH v3 16/16] LSM: Blob sharing support for S.A.R.A
 and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 19, 2018 at 5:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8f3b809d7c26..0156ffea7f8c 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3475,18 +3475,16 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>  {
>         struct smack_known *skp = smk_of_task_struct(p);
>         char *cp;
> -       int slen;
>
> -       if (strcmp(name, "current") != 0)
> +       if (strcmp(name, "current") == 0) {
> +               cp = kstrdup(skp->smk_known, GFP_KERNEL);
> +               if (cp == NULL)
> +                       return -ENOMEM;
> +       } else
>                 return -EINVAL;
>
> -       cp = kstrdup(skp->smk_known, GFP_KERNEL);
> -       if (cp == NULL)
> -               return -ENOMEM;
> -
> -       slen = strlen(cp);
>         *value = cp;
> -       return slen;
> +       return strlen(cp);
>  }

This should be separate: it looks like unrelated refactoring? (I
mentioned this before, I think?)

> diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
> index 0110bebe86e2..f386f92c57c5 100644
> --- a/security/tomoyo/common.h
> +++ b/security/tomoyo/common.h
> @@ -1216,8 +1221,13 @@ static inline struct tomoyo_domain_info **tomoyo_cred(const struct cred *cred)
>   */
>  static inline struct tomoyo_domain_info *tomoyo_domain(void)
>  {
> -       struct tomoyo_domain_info **blob = tomoyo_cred(current_cred());
> +       const struct cred *cred = current_cred();
> +       struct tomoyo_domain_info **blob;
> +
> +       if (cred->security == NULL)
> +               return NULL;
>
> +       blob = tomoyo_cred(cred);
>         return *blob;
>  }

I think this is another lost hunk?

-Kees

-- 
Kees Cook
Pixel Security
