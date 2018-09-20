Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8KHJchD002212
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 13:19:38 -0400
Received: by mail-yw1-f65.google.com with SMTP id j131-v6so4049439ywc.13
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 10:19:16 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com.
 [209.85.161.47])
 by smtp.gmail.com with ESMTPSA id w80-v6sm3877553ywd.55.2018.09.20.10.19.13
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Sep 2018 10:19:13 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id z143-v6so4063723ywa.7
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 10:19:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ea146829-594a-64a5-6e60-427d39aff4bc@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
 <ea146829-594a-64a5-6e60-427d39aff4bc@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 20 Sep 2018 10:13:17 -0700
Message-ID: <CAGXu5jJ0xB+Zh7oUAzk9kDMaFTOcNXFzOxL6mwqsw8KaQ0Ks-g@mail.gmail.com>
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
Subject: Re: [PATCH v3 07/16] TOMOYO: Abstract use of cred security
 blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 19, 2018 at 5:20 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> @@ -539,13 +557,16 @@ DEFINE_SRCU(tomoyo_ss);
>  static int __init tomoyo_init(void)
>  {
>         struct cred *cred = (struct cred *) current_cred();
> +       struct tomoyo_domain_info **blob;
>
>         if (!security_module_enable("tomoyo"))
>                 return 0;
> +
>         /* register ourselves with the security framework */
>         security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
>         printk(KERN_INFO "TOMOYO Linux initialized\n");
> -       cred->security = &tomoyo_kernel_domain;
> +       blob = tomoyo_cred(cred);
> +       *blob = &tomoyo_kernel_domain;
>         tomoyo_mm_init();
>         return 0;
>  }

This is missing "tomoyo_enabled = true;" which is included in the next
patch but should be here.

-Kees

-- 
Kees Cook
Pixel Security
