Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8KHeBtD005010
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 13:40:11 -0400
Received: by mail-yw1-f65.google.com with SMTP id x67-v6so4104826ywg.0
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 10:39:31 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com.
 [209.85.161.42])
 by smtp.gmail.com with ESMTPSA id m82-v6sm11579928ywm.19.2018.09.20.10.39.27
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Sep 2018 10:39:27 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id d193-v6so1212942ywb.3
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 10:39:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6456aa25-6890-6d54-51c5-03c5daf0c6fb@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
 <6456aa25-6890-6d54-51c5-03c5daf0c6fb@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 20 Sep 2018 10:39:26 -0700
Message-ID: <CAGXu5jJ6xF0zvDThL+z9VxH2Y2WZg+0vKw4RUa=c8+dUQOGKpg@mail.gmail.com>
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
Subject: Re: [PATCH v3 14/16] LSM: Infrastructure management of the
 task security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 19, 2018 at 5:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:

> diff --git a/security/security.c b/security/security.c
> index 2501cdcbebff..7e11de7eec21 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -116,7 +116,8 @@ int __init security_init(void)
>  #ifdef CONFIG_SECURITY_LSM_DEBUG
>         pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
>         pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
> -       pr_info("LSM: inode blob size       = %d\n", blob_sizes.lbs_inode);
> +       pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
> +       pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
>  #endif

This alignment adjustment should be moved to the patch that adds the inode line.

(And this patch might want to mention it is changing the only task
blob user, AppArmor, or split that out into a separate patch.)

-Kees

-- 
Kees Cook
Pixel Security
