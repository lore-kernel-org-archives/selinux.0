Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M2v8f8032599
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 22:57:08 -0400
Received: by mail-yb1-f194.google.com with SMTP id 5-v6so6264311ybf.3
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:57:00 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com.
 [209.85.219.180])
 by smtp.gmail.com with ESMTPSA id m19-v6sm158880ywh.31.2018.09.21.19.56.56
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Sep 2018 19:56:57 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id o63-v6so6269396yba.2
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:56:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <383f1b1a-3d7c-46d2-a553-3a09f25bc1c4@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <383f1b1a-3d7c-46d2-a553-3a09f25bc1c4@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 21 Sep 2018 19:56:55 -0700
Message-ID: <CAGXu5jJ1dNrxLetD=t=PX3pJNKigjdj+CSHMfNF6cePQmYYwag@mail.gmail.com>
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
Subject: Re: [PATCH v4 16/19] SELinux: Abstract use of ipc security
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
