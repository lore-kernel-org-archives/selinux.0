Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8KHPatk002281
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 13:25:36 -0400
Received: by mail-yw1-f68.google.com with SMTP id x67-v6so4086194ywg.0
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 10:25:31 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com.
 [209.85.161.49])
 by smtp.gmail.com with ESMTPSA id w207-v6sm11123403yww.17.2018.09.20.10.25.29
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Sep 2018 10:25:30 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id k130-v6so1568399ywe.6
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 10:25:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5b95b037-521f-3402-2097-c0f9c427d235@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
 <5b95b037-521f-3402-2097-c0f9c427d235@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 20 Sep 2018 10:25:28 -0700
Message-ID: <CAGXu5jKUfHAK-cFj0YtqqGXypFGigpWNitVOPJx9SubSbnfkzw@mail.gmail.com>
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
Subject: Re: [PATCH v3 10/16] LSM: Infrastructure management of the
 file security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 19, 2018 at 5:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 01a922856eba..62a22ad8ce92 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -361,6 +361,11 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
>         return cred->security;
>  }
>
> +static inline struct smack_known **smack_file(const struct file *file)
> +{
> +       return file->f_security;
> +}
> +

This (and related) still needs splitting out into it's own refactoring
patch for Smack.

-Kees

-- 
Kees Cook
Pixel Security
