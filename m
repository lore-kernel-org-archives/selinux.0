Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w91KTXWA017000
 for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2018 16:29:33 -0400
Received: by mail-yb1-f194.google.com with SMTP id 184-v6so6220395ybg.1
 for <selinux@tycho.nsa.gov>; Mon, 01 Oct 2018 13:29:29 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com.
 [209.85.161.46])
 by smtp.gmail.com with ESMTPSA id p128-v6sm6617630ywp.65.2018.10.01.13.29.26
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Oct 2018 13:29:27 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id s73-v6so6066667ywg.11
 for <selinux@tycho.nsa.gov>; Mon, 01 Oct 2018 13:29:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <44210861-2830-2321-911d-8783f5f0b172@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <44210861-2830-2321-911d-8783f5f0b172@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 1 Oct 2018 13:29:25 -0700
Message-ID: <CAGXu5jLrvuhGonjCxUxMXi+HeEb8yWina=31OCvEqOeBBu1pkw@mail.gmail.com>
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
Subject: Re: [PATCH v4 20/19] LSM: Correct file blob free empty blob
 check
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 26, 2018 at 2:57 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Instead of checking if the kmem_cache for file blobs
> has been initialized check if the blob is NULL. This
> allows non-blob using modules to do other kinds of
> clean up in the security_file_free hooks.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

This looks like it should get folded into "LSM: Infrastructure
management of the file security".

-Kees


> ---
>  security/security.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index e7c8506041f1..76f7dc49b63c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1202,14 +1202,13 @@ void security_file_free(struct file *file)
>  {
>         void *blob;
>
> -       if (!lsm_file_cache)
> -               return;
> -
>         call_void_hook(file_free_security, file);
>
>         blob = file->f_security;
> -       file->f_security = NULL;
> -       kmem_cache_free(lsm_file_cache, blob);
> +       if (blob) {
> +               file->f_security = NULL;
> +               kmem_cache_free(lsm_file_cache, blob);
> +       }
>  }
>
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> --
> 2.17.1
>
>



-- 
Kees Cook
Pixel Security
