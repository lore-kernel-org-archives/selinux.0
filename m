Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M2lAIi032512
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 22:47:10 -0400
Received: by mail-yw1-f68.google.com with SMTP id d193-v6so3098817ywb.3
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:47:07 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com.
 [209.85.219.177])
 by smtp.gmail.com with ESMTPSA id l3-v6sm4861061ywd.98.2018.09.21.19.47.04
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Sep 2018 19:47:04 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id b3-v6so5203045yba.4
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:47:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8ea966f7-924e-b805-56e8-9ad74e7f9d86@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <8ea966f7-924e-b805-56e8-9ad74e7f9d86@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 21 Sep 2018 19:47:03 -0700
Message-ID: <CAGXu5jKRmACSA0kdG1v==zaaNxh=K9ePi4TVFfD3Zq-vOChVfg@mail.gmail.com>
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
Subject: Re: [PATCH v4 07/19] TOMOYO: Abstract use of cred security
 blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 21, 2018 at 5:18 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the cred->security pointer directly.
> Provide helper functions that provide the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
