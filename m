Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M2uRkA032590
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 22:56:27 -0400
Received: by mail-yb1-f194.google.com with SMTP id b3-v6so5207971yba.4
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:56:24 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com.
 [209.85.161.45])
 by smtp.gmail.com with ESMTPSA id w195-v6sm2065048ywa.23.2018.09.21.19.56.21
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Sep 2018 19:56:22 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id n21-v6so5977055ywh.5
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:56:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c3a54353-6208-d234-038b-f538acf2bee5@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <c3a54353-6208-d234-038b-f538acf2bee5@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 21 Sep 2018 19:56:20 -0700
Message-ID: <CAGXu5jLdBRp2vBNxZby6=J4CRU=8jJsUxjGBXj-DLCfZ+Oao6A@mail.gmail.com>
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
Subject: Re: [PATCH v4 15/19] LSM: Infrastructure management of the
 task security
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the task_struct->security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
> The only user of this blob is AppArmor. The AppArmor use
> is abstracted to avoid future conflict.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
