Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M2vZoH002128
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 22:57:35 -0400
Received: by mail-yw1-f66.google.com with SMTP id b2-v6so1819074ywe.11
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:57:31 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com.
 [209.85.161.47])
 by smtp.gmail.com with ESMTPSA id f82-v6sm8471688ywf.58.2018.09.21.19.57.28
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Sep 2018 19:57:29 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id b2-v6so1819057ywe.11
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:57:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f8d020ad-2e50-d541-3187-81f63557f667@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <f8d020ad-2e50-d541-3187-81f63557f667@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 21 Sep 2018 19:57:27 -0700
Message-ID: <CAGXu5jL6GAWmCAt1aXdVvr9HqdUUOynJ4Ma1VBGjjdTkyNb+qQ@mail.gmail.com>
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
Subject: Re: [PATCH v4 17/19] Smack: Abstract use of ipc security
 blobs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the ipc->security pointer directly.
> Don't use the msg_msg->security pointer directly.
> Provide helper functions that provides the security blob pointers.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
